(require-package 'idle-require)
(require 'idle-require)

(defun newbie/get-init-files (dir)
  "Get all Files in directory which is in `'load-path,
Return a list of file name, no directory, no extension."
  (let ((count 0) (file-path) (init-files))
    (dolist (path load-path)
      (when (string-equal dir (file-name-base path))
        (setq file-path path)
        (setq count (+ 1 count))))
    (if (not (equal count 1))
        (warn "no one or more than one dir match, return nil for %s." dir)
      (dolist (file (directory-files file-path))
        (unless (or (file-directory-p (expand-file-name file))
                    (string-match "^[.]*#+" (file-name-base file))
                    (string-match "~+$" (expand-file-name file)))
          (push (file-name-base file) init-files)))
      init-files)))

(setq idle-require-idle-delay 3)
(setq idle-require-symbols (newbie/get-init-files "init-idle"))
(idle-require-mode t) ;; starts loading

(when (daemonp)
  (setq idle-require-symbols nil)
  (require-dir "init-idle"))

(provide 'init-idle-require)
