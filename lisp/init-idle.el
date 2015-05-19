(require-package 'visual-regexp)
(require 'visual-regexp)
(require 'init-misc-lazy)                           ;; misc setup. cut from redguardtoo.

;;; make tooltip beautiful. has effect here.
(when (window-system)
(require 'color)
  (let ((bg (face-attribute 'default :background)))
    (custom-set-faces
     `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
     `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
     `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
     `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
     `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))))

(require 'init-helm-company)
(require 'server)
(when (not (server-running-p server-name))
      (server-mode t))

(require-package 'flyspell-lazy)
(if *emacs24* (require-package 'yasnippet '(0 9 0 1) nil))
(if (not (file-exists-p (expand-file-name "~/.emacs.d/snippets")))
    (make-directory (expand-file-name "~/.emacs.d/snippets"))
    )
(require-package 'dropdown-list)
(require 'init-yasnippet)                           ;; setting for yasnippet. from redguardtoo. cancel yasnippet-autoloads.
(yas-global-mode 1)

(setq flyspell-auto-correct-binding [(control \.)]) ;; default key binding conflict with ace-jump-mode.
(require 'init-spelling)                            ;; setting for spell checking. from redguardtoo.

(provide 'init-idle)
