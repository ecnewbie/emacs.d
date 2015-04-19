(defvar new-window-size-vertically 8)
(defvar new-window-size-horizontally 50)

(defun select-window-to-split()
  (when (eq (minibuffer-window) (selected-window))
    (select-window (window-in-direction 'above))))

(defun window-lines ()
  (count-lines (buffer-end -1) (buffer-end 1)))

(defun more-than-one-window-vertically-p ()
  (and (> (count-windows) 1)
       (> (frame-height) (window-height (window-in-direction 'below)))))

(defun split-window-below-or-replace ()
  (if (more-than-one-window-vertically-p)
      (if (window-live-p (window-in-direction 'below))
          (window-in-direction 'below)
        (selected-window))
    (split-window-below)))

(defun resize-buffer-window-vertically (buffer-name &optional size); &optional autofit)
  (when (not (get-buffer-window buffer-name))
    (save-selected-window
      (save-excursion
        (when (not size)
          (setq size new-window-size-vertically))
        ;(select-window-to-split)
        (when (not (eq (minibuffer-window) (selected-window)))
          (let* ((win (split-window-below-or-replace))
                 (h (window-height win)))
            (select-window win)
            (switch-to-buffer buffer-name)
            (let* ((cut-height (- h size)))
              (when (> cut-height 0)
                (shrink-window cut-height)))))))))


(defun resize-buffer-window-horizontally (buffer-name &optional size)
  (when (not (get-buffer-window buffer-name))
    (save-selected-window
      (save-excursion
        (when (not size)
          (setq size new-window-size-horizontally))
        (select-window-to-split)
        (when (eq (minibuffer-window) (selected-window))
          (let* ((win (split-window-horizontally))
                 (w (window-width win)))
            (select-window win)
            (switch-to-buffer buffer-name)
            (let* ((cut-width (- w size)))
              (when (> cut-width 0)
                (shrink-window-horizontally cut-width)))))))))


(add-hook 'compilation-mode-hook (lambda () (resize-buffer-window-vertically "*compilation*")))
(add-hook 'ggtags-global-mode-hook (lambda () (resize-buffer-window-vertically "*ggtags-global*")))
(add-hook 'message-mode-hook (lambda () (resize-buffer-window-vertically "*Messages*")))
(add-hook 'occur-mode-hook (lambda () (resize-buffer-window-vertically "*Occur*")))
(add-hook 'help-mode-hook (lambda () (resize-buffer-window-vertically "*Help*" 15)))
(add-hook 'apropos-mode-hook (lambda () (resize-buffer-window-vertically "*Apropos*" 15)))
;;(add-hook 'completion-mode-hook (lambda () (resize-buffer-window-vertically "*Completions*" 20))) ;; this works bad.
(temp-buffer-resize-mode 1)


(provide 'init-layout)
