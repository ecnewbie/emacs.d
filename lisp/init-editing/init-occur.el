(define-key occur-mode-map (kbd "C-x C-q") 'occur-edit-mode)
(define-key occur-edit-mode-map (kbd "C-x C-q") 'occur-cease-edit)


(require-package 'color-moccur)

(provide 'init-occur)
