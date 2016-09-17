(setq-default initial-scratch-message
              (concat ";; Happy hacking " (or user-login-name "") " - Emacs loves you!\n\n"))

;; todo
;; scheme setup
(setq scheme-program-name "guile")
(with-eval-after-load 'scheme-mode
  (require-package 'quack)
  (require 'quack))

(require-package 'rainbow-delimiters)
(require-package 'elisp-slime-nav)

;; Enable desired features for all lisp modes
(defun sanityinc/lisp-setup ()
  "Enable features useful in any Lisp mode."
  (when (featurep 'paredit)
    (enable-paredit-mode))
  (rainbow-delimiters-mode t)
  (turn-on-eldoc-mode)
  (turn-on-elisp-slime-nav-mode))

(let* ((lispy-hooks '(emacs-lisp-mode-hook
                      lisp-mode-hook
                      inferior-lisp-mode-hook
                      lisp-interaction-mode-hook)))
  (dolist (hook lispy-hooks)
    (add-hook hook 'sanityinc/lisp-setup)))

(require 'elisp-slime-nav)

(provide 'init-lisp)
