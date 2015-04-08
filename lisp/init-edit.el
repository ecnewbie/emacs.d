(require 'init-fonts)                           ;; setting for fonts, from redguardtoo.
(require 'init-pyim)                            ;; pinyin input method.

(require-package 'pointback)
(require-package 'saveplace)
(require-package 'fic-mode)
(require-package 'maxframe)
(require-package 'browse-kill-ring)
(require 'init-misc-redguardtoo)                ;; cut from redguardtoo. not display fic at modeline.
(global-unset-key (kbd "C-c c"))

(require 'init-editing-utils)                   ;; editing utils from purcell, cancel guide-key.
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C-M-=") 'er/contract-region)

(provide 'init-edit)
