(require-package 'wgrep)
(require-package 'wgrep-ag)
(require-package 'wgrep-helm)

;; restart emacs when change fonts.
;; see https://github.com/tumashu/chinese-fonts-setup for more details.
;; (require-package 'chinese-fonts-setup)
;; (add-hook 'org-mode-hook
;;          (progn
;;            (require 'chinese-fonts-setup)
;;            (define-key global-map (kbd "C-+") 'cfs-increase-fontsize)
;;            (define-key global-map (kbd "C--") 'cfs-decrease-fontsize)))

(add-hook 'org-mode-hook
          '(lambda ()
            (set-face-attribute 'default nil :font "WenQuanYi Zen Hei Mono-12:weight=normal")
            (setq face-font-rescale-alist (list (cons "DejaVu Sans Mono" 1.2)))
            (print (face-attribute 'default ':font))))

(provide 'init-simple)
