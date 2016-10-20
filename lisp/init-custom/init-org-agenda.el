(if (not (file-exists-p (expand-file-name "~/todo")))
     (make-directory (expand-file-name "~/todo") t))
(setq org-agenda-files (list "~/todo/"))

(provide 'init-org-agenda)
