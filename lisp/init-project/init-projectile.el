(require-package 'projectile)

(require 'projectile)
(projectile-global-mode)
(setq projectile-use-git-grep t)
;; (setq projectile-enable-caching nil) ; caching mixed ignored files.

(when (featurep 'sr-speedbar)
  (require-package 'projectile-speedbar)
  (require 'projectile-speedbar)
  (setq projectile-speedbar-enable nil))

(require-package 'ibuffer-projectile)

(require-package 'counsel-projectile)
(autoload 'counsel-projectile-find-file "counsel-projectile" nil t)

(defun newbie/find-file-in-current-directory (&optional arg)
  "Find file in current directory with option -maxdepth 3."
  (interactive)
  (unless (and arg (> arg 0))
    (setq arg 3))
  (let* ((cmd (concat "find * -type f -print0 -maxdepth " (number-to-string arg))))
    (ivy-read "Find file: "
              (split-string (shell-command-to-string cmd) "\0" t)
              :require-match t
              :action
              (lambda (x)
                (with-ivy-window
                  (find-file x))))))

(require-package 'nameframe-projectile)
(nameframe-projectile-mode t)

(provide 'init-projectile)
