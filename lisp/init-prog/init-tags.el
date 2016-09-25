(require-package 'rtags)
;; https://github.com/Andersbakken/rtags
(defun use-rtags (&optional useFileManager)
  (and (featurep 'rtags)
       (rtags-executable-find "rc")
       (cond ((and (not (eq major-mode 'c++-mode))
                   (not (eq major-mode 'c-mode))) (rtags-has-filemanager))
             (useFileManager (rtags-has-filemanager))
             (t (rtags-is-indexed)))))

(defun tags-find-symbol-at-point (&optional prefix)
  (interactive "P")
  (if (or (not (rtags-find-symbol-at-point prefix)) rtags-last-request-not-indexed)
      (etags-select-find-tag-at-point)))
(defun tags-find-references-at-point (&optional prefix)
  (interactive "P")
  (if (or (not (rtags-find-references-at-point prefix)) rtags-last-request-not-indexed)
      (xref-find-references)))
(defun tags-find-symbol ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-symbol 'etags-select-find-tag)))
(defun tags-find-references ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-references '(lambda () (xref-find-references t)))))
(defun tags-find-file ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-find-file 'find-file)))
(defun tags-imenu ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-imenu 'ido-imenu-anywhere)))

(defun newbie/tags-search ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-next-match 'tags-search)))

;; ggtags
(require-package 'ggtags)

(custom-set-variables '(ggtags-oversize-limit (* 20 1024 1024))) ; larger gtags file.
(setenv "GTAGSFORCECPP" "")                                      ; always treat .h as c++ header.

(defun newbie/ggtags-setup ()
  (setq-local eldoc-documentation-function 'ggtags-eldoc-function)
  (setq-local imenu-create-index-function 'ggtags-build-imenu-index)
  (make-local-variable 'hippie-expand-try-functions-list)
  (add-to-list 'hippie-expand-try-functions-list 'ggtags-try-complete-tag))

(with-eval-after-load 'cc-mode
  (define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-]") (function tags-find-references-at-point))
  (define-key c-mode-base-map (kbd "C-u M-.") (function tags-find-symbol))
  (define-key c-mode-base-map (kbd "C-u M-]") (function tags-find-references))
  (define-key c-mode-base-map (kbd "M-,") (function newbie/tags-search)))

(with-eval-after-load 'ggtags
  (setq ggtags-sort-by-nearness t)
  (newbie/ggtags-setup))

(provide 'init-tags)
