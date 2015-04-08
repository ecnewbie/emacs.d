(require 'init-themes)

(require-package 'zenburn-theme)

(defun ydark ()
  "Activate another dark color theme."
  (interactive)
  (load-theme 'zenburn t))

(when (not (window-system))
(add-hook 'after-init-hook 'ydark))

(provide 'init-my-themes)