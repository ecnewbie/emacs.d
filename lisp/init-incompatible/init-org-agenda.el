(if (not (file-exists-p (expand-file-name "~/Documents/todo")))
     (make-directory (expand-file-name "~/Documents/todo") t))
(setq org-agenda-files (list "~/Documents/todo/"
                           ))

(provide 'init-org-agenda)
