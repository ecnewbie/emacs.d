(require-package 'wgrep)
(require-package 'wgrep-ag)
(require-package 'wgrep-helm)

(require-package 'linum-relative)
(require 'linum-relative)
(setq linum-relative-current-symbol "")
(linum-relative-global-mode)

(require-package 'zlc)
(require 'zlc)
(zlc-mode t)

;;; vlf
(require-package 'vlf)
(require 'vlf-setup)

(require-package 'lice)

(require-package 'youdao-dictionary)

(require-package 'projectile-speedbar)
(require 'projectile-speedbar)
(setq projectile-speedbar-enable nil)

(require-package 'helm-projectile)

(provide 'init-simple)
