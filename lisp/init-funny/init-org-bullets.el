(require-package 'org-bullets)

(defun newbie/org-bullets-setup ()
  (org-bullets-mode t))

(add-hook 'org-mode-hook 'newbie/org-bullets-setup)

(provide 'init-org-bullets)
