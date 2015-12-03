(require-package 'zenburn-theme)

(defun ydark ()
  "Activate another dark color theme."
  (interactive)

  (load-theme 'zenburn t)
  (custom-theme-set-faces
   'zenburn
   `(ace-jump-face-foreground
     ((t (:foreground "red" )))))

  (zenburn-with-color-variables
  ;; set color for company clang insert args..
  (custom-theme-set-faces
   'zenburn
   `(company-template-field
     ((t (:foreground nil :background ,zenburn-bg-1))))))
  )


(add-hook 'after-init-hook 'ydark)

(provide 'init-themes)