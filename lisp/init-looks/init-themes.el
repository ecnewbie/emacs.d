(require-package 'zenburn-theme)

(defun ydark ()
  "Activate another dark color theme."
  (interactive)
  (load-theme 'zenburn t))

(add-hook 'after-init-hook 'ydark)

(provide 'init-themes)