(require-package 'diminish)
(require-package 'flx-ido)
(require-package 'ido-ubiquitous)
(require-package 'idomenu)
(require 'init-ido)                             ;; setting for ido. smart completion on switch buffer, find file and so on. from redguardtoo.
(global-set-key "\M-gi" 'ido-goto-symbol)
(global-unset-key (kbd "M-/"))
(global-set-key (kbd "M-/ /") 'dabbrev-expand)

(require-package 'smex)
(require 'init-smex)                            ;; setting for smex. smart M-x use ido. from redguardtoo.
(require 'init-ibuffer)                         ;; setting for ibuffer. bind to C-x C-b. from redguardtoo.
(require 'init-isearch)                         ;; setting for isearch. from purcell.

(require-package 'helm)
(require-package 'helm-gtags)
(require-package 'helm-c-yasnippet)
(require 'init-helm)                            ;; setting for helm. a alternative choice of ido. from redguardtoo.

(require 'init-writting)                         ;; changing key-binding M-c, M-l, M-u. from redguardtoo.


;(when (window-system)
(require-package 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c" "C-x 4" "C-x 5" "C-c ;" "C-c ; f" "C-c ' f" "C-x n" "C-x C-r" "C-x r" "C-x c" "C-x v" "C-x a" "M-g" "C-c p" "C-c c"))
(guide-key-mode 1)
(diminish 'guide-key-mode)

(provide 'init-alternative)
