(require-package 'spaceline)
(add-hook 'after-init-hook (lambda ()
                             (require 'spaceline-config)
                             (spaceline-spacemacs-theme)
                             (spaceline-toggle-anzu-off)
                             (spaceline-helm-mode t)
                             (spaceline-info-mode t)
                             (spaceline-speedbar-mode t)))

(require 'spaceline)
(spaceline-define-segment speedbar-directory-name
  "Show the speedbar directory name"
  (when  (featurep 'speedbar)
    (let ((directory (directory-file-name
                      (car speedbar-shown-directories))))
      (substring directory (string-match "[^/\]*$" directory)))))

(spaceline-define-segment speedbar-files
  "Speedbar files and directories count."
  (when (featurep 'speedbar)
    (let ((contents
           (speedbar-file-lists (car speedbar-shown-directories)))
          (dirs nil)
          (files nil))
      (when contents
          (setq dirs (nth 0 contents))
          (setq files (nth 1 contents)))

      (let ((file-count
             (if files (length files) 0)))
        (unless (or speedbar-show-unknown-files
                    (null files))
          (setq file-count 0)
          (dolist (v files)
            (when (string-match speedbar-file-regexp v)
              (setq file-count (1+ file-count)))))
        (format "(D:%d F:%d)"
                (if dirs (length dirs) 0)
                file-count)))))

(define-minor-mode spaceline-speedbar-mode
  "Customize the mode-line in speedbar."
  :init-value nil
  :global t
  (if spaceline-speedbar-mode
      (progn
        (spaceline-install 'speedbar
                           `((window-number
                              :face highlight-face)
                             (speedbar-directory-name
                              :when t)
                             (speedbar-files
                              :when t))
                           nil)
        (defadvice speedbar-set-mode-line-format (after spaceline-speedbar)
          "Set up a custom speedbar modeline."
          (setq mode-line-format '("%e" (:eval (spaceline-ml-speedbar)))))
        (ad-activate 'speedbar-set-mode-line-format))
    (ad-deactivate 'speedbar-set-mode-line-format)))

;; @see http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html
;; But I need global-mode-string,
;; @see http://www.delorie.com/gnu/docs/elisp-manual-21/elisp_360.html
;; use setq-default to set it for /all/ modes

;; (require-package 'modeline-posn)
;; (require 'modeline-posn)
;; (size-indication-mode 1)

;; (setq-default mode-line-format
;;               (list
;;                (propertize "%e" 'face nil)
;;                '(:eval (powerline-default-theme))))

;; (setq-default mode-line-format
;;               (list
;;                (propertize "%e" 'face nil) " "
;;                ;; the buffer name; the file name as a tool tip
;;                '(:eval (propertize "%b " 'face (if (window-system)
;;                                                    'font-lock-keyword-face
;;                                                  nil)
;;                                    'help-echo (concat (format "Coding system: %s\n" buffer-file-coding-system)
;;                                                       (or (buffer-file-name) "Temp buffer"))))

;;                mode-line-position

;;                ;; the current major mode for the buffer.
;;                "["

;;                '(:eval (propertize "%m" 'face nil))
;;                "] "

;;                "[" ;; insert vs overwrite mode, input-method in a tooltip
;;                '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
;;                                    'face (if (window-system)
;;                                              'font-lock-string-face
;;                                            nil)
;;                                    'help-echo (concat "Buffer is in "
;;                                                       (if overwrite-mode "overwrite" "insert") " mode")))

;;                ;; was this buffer modified since the last save?
;;                '(:eval (when (buffer-modified-p)
;;                          (concat ","  (propertize "Mod"
;;                                                   'face (if (window-system)
;;                                                             'font-lock-warning-face
;;                                                           nil)
;;                                                   'help-echo "Buffer has been modified"))))

;;                ;; is this buffer read-only?
;;                '(:eval (when buffer-read-only
;;                          (concat ","  (propertize "RO"
;;                                                   'face (if (window-system)
;;                                                             'font-lock-type-face
;;                                                           nil)
;;                                                   'help-echo "Buffer is read-only"))))
;;                "] "

;;                mode-line-misc-info
;;                "---"
;;                '(:propertize ("" minor-mode-alist) 'face nil)
;;                ;;"%-" ;; fill with '-'
;;                ))

(provide 'init-modeline)
