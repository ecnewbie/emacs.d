(require-package 'zenburn-theme)

(defun ydark ()
  "Activate another dark color theme."
  (interactive)

  (load-theme 'zenburn t)
  (custom-theme-set-faces
   'zenburn
   `(ace-jump-face-foreground
     ((t (:foreground "red" ))))))


(add-hook 'after-init-hook 'ydark)

(provide 'init-themes)