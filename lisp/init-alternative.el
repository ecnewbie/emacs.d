(require-package 'diminish)
(require-package 'flx-ido)
(require-package 'ido-ubiquitous)
(require-package 'idomenu)
(require 'init-ido)       ;; setting for ido. smart completion on switch buffer, find file and so on. from redguardtoo.

(require-package 'smex)
(require 'init-smex)      ;; setting for smex. smart M-x use ido. from redguardtoo.
(require 'init-ibuffer)   ;; setting for ibuffer. bind to C-x C-b. from redguardtoo.
(require 'init-isearch)   ;; setting for isearch. from purcell.

(require-package 'helm)
(require-package 'helm-gtags)
(require-package 'helm-c-yasnippet)
(require 'init-helm)      ;; setting for helm. a alternative choice of ido. from redguardtoo.

(require 'init-writting)  ;; changing key-binding M-c, M-l, M-u. from redguardtoo.


;;(when (window-system)
(require-package 'guide-key)
(guide-key-mode 1)
(setq guide-key/guide-key-sequence t)   ; enable any key sequence.
(diminish 'guide-key-mode)

(require-package 'simpleclip)
(require 'init-clipboard) ;; setting for clipboard. from redguardtoo.

;; Setting local key M-y will cause calc works bad.
(remove-hook 'minibuffer-setup-hook 'my/paste-in-minibuffer)

;;(require-package 'w3m)
;;(require 'init-emacs-w3m) ;; setting for w3m. a browser. from redguardtoo.

(require 'init-smarter-commands) ;; some smarter commands.

(require 'control-lock)
;;  Make C-z turn on control lock
(control-lock-keys)

(require-package 'comment-dwim-2)
(global-set-key [remap comment-dwim] 'comment-dwim-2)

(provide 'init-alternative)
