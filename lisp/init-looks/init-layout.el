(require-package 'window-numbering)
(winner-mode 1)
(defvar new-window-size-vertically 10)
(defvar new-window-size-horizontally 50)

(defun window-lines ()
  (count-lines (buffer-end -1) (buffer-end 1)))

(defun more-than-one-window-vertically-p ()
  (and (> (count-windows) 1)
       (> (frame-height) (window-height (window-in-direction 'below)))))

(defun split-window-below-or-newest ()
  "return the window split below when only one window, otherwise newest window"
  (if (one-window-p t)
      (split-window-below)
    (newest-window)))

(defun resize-buffer-window-vertically (buffer-name &optional size)
  (when (not size)
    (setq size new-window-size-vertically))
  (let* ((h (window-height (selected-window)))
         (cut-height (- h size)))
    (when (> cut-height 0)
      (shrink-window cut-height))))

(defun resize-buffer-window-horizontally (buffer-name &optional size)
  (when (not size)
    (setq size new-window-size-horizontally))
  (let* ((w (window-width (selected-window)))
         (cut-width (- w size)))
    (when (> cut-width 0)
      (shrink-window-horizontally cut-width))))

(defvar buffer-names-to-ignore-all (list "*Packages*")
  "list for buffer names that will not be deleted on delete-window-and-show-in-last-temp-window")
(defvar buffer-names-to-ignore-vertically nil
  "list for buffer names that will not be deleted on delete-window-and-show-in-last-temp-window")
(defvar buffer-names-to-ignore-horizontally nil
  "list for buffer names that will not be deleted on delete-window-and-show-in-last-temp-window")

(defun buffer-names-in-list (buffer-name buffer-names-list)
  "return whether BUFFER-NAME in BUFFER-NAMES-LIST."
  (let* ((buffer-exist nil))
    (dolist (buffer-name-i buffer-names-list)
      (when (equal buffer-name buffer-name-i)
        (setq buffer-exist t)))
    buffer-exist))

(defun split-window-vertically-and-resize (buffer-name &optional size quit-func)
  (when (not (get-buffer-window buffer-name))
    (save-selected-window
      (save-excursion
        (when (window-minibuffer-p)
          (select-window (newest-window)))
        (select-window (split-window-below-or-newest))
        (switch-to-buffer buffer-name)
        (resize-buffer-window-vertically buffer-name size)
        (when quit-func
          (funcall quit-func))))))

(defun split-window-horizontally-and-resize (buffer-name &optional size quit-func)
  (when (not (get-buffer-window buffer-name))
    (save-selected-window
      (save-excursion
        (when (window-minibuffer-p)
          (select-window (newest-window)))
        (select-window (split-window-horizontally))
        (switch-to-buffer buffer-name)
        (resize-buffer-window-horizontally buffer-name size)
        (when quit-func
          (funcall quit-func))))))

(defun delete-temp-window-and-show-in-last-temp-window ()
  "Delete selected window if it is temp window and show its content in last temp window. Use the same order as window-numbering."
  (interactive)
  (when (is-temp-window (selected-window))
    (let* ((window-split-func))
      (when (not (buffer-names-in-list (buffer-name) buffer-names-to-ignore-all))
        (when (not (buffer-names-in-list (buffer-name) buffer-names-to-ignore-horizontally))
          (setq window-split-func 'split-window-horizontally-and-resize))
        (when (not (buffer-names-in-list (buffer-name) buffer-names-to-ignore-vertically))
          (setq window-split-func 'split-window-vertically-and-resize))
        ;; actual things.
        (let* ((buffer-name (buffer-name)))
          (if (one-window-p t)
              (previous-buffer)
            (delete-window (selected-window)))
          (if (or (one-window-p t) (not (last-temp-window)))
              (funcall window-split-func buffer-name)
            (select-window (last-temp-window))
            (switch-to-buffer buffer-name)))))))

(defun last-temp-window ()
  "return last window which buffer is temp buffer."
  (require 'window-numbering)
  (let* ((window)
         (wini))
    (dotimes (i 10)
      (setq wini (aref window-numbering-windows i))
      (when (and wini (is-temp-window wini))
        (setq window wini)))
    window))

(defun is-temp-window (window)
  (and (string-match "^\*.*\*$" (buffer-name (window-buffer window)))
       (not (window-minibuffer-p window))
       (window-live-p window)))

(defvar last-window-change-time nil)

(defun select-newest-window-and-delete-if-temp ()
  "select newest window and then call delete-temp-window-and-show-in-last-temp-window"
  (interactive)
  (when (or (not last-window-change-time)
            (> (float-time) (+ last-window-change-time 1)))
    (setq last-window-change-time (float-time))
    (save-selected-window
      (select-window (newest-window))
      (delete-temp-window-and-show-in-last-temp-window))
    (setq last-window-change-time (float-time))))

(defun newer-than (win1 win2)
  "return t if win1 newer than win2"
  (let* ((s1 (with-output-to-string
               (print win1)))
         (s2 (with-output-to-string
               (print win2)))
         n1 n2)
    (require 's)
    (setq n1 (string-to-number (nth 0 (s-match "[0-9]+" s1))))
    (setq n2 (string-to-number (nth 0 (s-match "[0-9]+" s2))))
    (message "%s, %s" win1 win2)
    (message "%d > %d?" n1 n2)
    (message "%s > %s?" (window-use-time win1) (window-use-time win2))
    (and (> n1 n2) (> (window-use-time win1) (window-use-time win2)))))

(defun not-newer-than (win1 win2)
  "not newer than."
  (not (newer-than win1 win2)))

(defun newest-window ()
  "return newest window exclude minibuf"
  (let* ((window (selected-window)))
    (dolist (wini (sort (window-list-1) 'not-newer-than))
      (when (and wini (not (window-minibuffer-p wini)))
        (setq window wini)))
    (message "%s" window)
    window))

(add-hook 'temp-buffer-show-hook 'select-newest-window-and-delete-if-temp)
(add-hook 'temp-buffer-window-show-hook 'select-newest-window-and-delete-if-temp)

(add-hook 'compilation-mode-hook (lambda () (split-window-vertically-and-resize "*compilation*" 8)))
(add-hook 'ggtags-global-mode-hook (lambda () (split-window-vertically-and-resize "*ggtags-global*")))
(add-hook 'message-mode-hook (lambda () (split-window-vertically-and-resize "*Messages*")))
(add-hook 'occur-mode-hook (lambda () (split-window-vertically-and-resize "*Occur*")))
(add-hook 'grep-mode-hook (lambda () (split-window-vertically-and-resize "*grep*")))
(add-hook 'helm-moccur-mode-hook (lambda () (split-window-vertically-and-resize "*hmoccur*")))
(add-hook 'apropos-mode-hook (lambda () (split-window-vertically-and-resize "*Apropos*")))
;;(add-hook 'Man-mode-hook (lambda () (split-window-vertically-and-resize "*Man*" 10 'Man-mode)))
;;(add-hook 'w3m-mode-hook (lambda () (split-window-vertically-and-resize "*w3m*" 10 'w3m-mode)))
;;(add-hook 'help-mode-hook (lambda () (split-window-vertically-and-resize "*Help*" 15))) ;; works bad when completions.
;;(add-hook 'completion-mode-hook (lambda () (split-window-vertically-and-resize "*Completions*" 20))) ;; this works bad.

(temp-buffer-resize-mode 1)

(defun default-layout-v ()
  "default layout vertically, a large window above and a small below."
  (interactive)
  (when (one-window-p t)
    (split-window-vertically-instead))
  (let* ((buffer-name (buffer-name (window-buffer (previous-window)))))
    (delete-other-windows)
    (split-window-vertically-and-resize buffer-name)))

(defun default-layout-h ()
  "default layout horizontally, a large window left and a small right."
  (interactive)
  (when (one-window-p t)
    (split-window-horizontally-instead))
  (let* ((buffer-name (buffer-name (window-buffer (previous-window)))))
    (delete-other-windows)
    (split-window-horizontally-and-resize buffer-name)))

(provide 'init-layout)
