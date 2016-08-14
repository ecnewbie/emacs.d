;; Paredit
(require-package 'paredit)
(autoload 'enable-paredit-mode "paredit")

(setq-default initial-scratch-message
              (concat ";; Happy hacking " (or user-login-name "") " - Emacs loves you!\n\n"))

;; todo
;; scheme setup
(setq scheme-program-name "guile")
(with-eval-after-load 'scheme-mode
  (require-package 'quack)
  (require 'quack))

;; Use paredit in the minibuffer
;;(add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)

(defvar paredit-minibuffer-commands '(eval-expression
                                      pp-eval-expression
                                      eval-expression-with-eldoc
                                      ibuffer-do-eval
                                      ibuffer-do-view-and-eval)
  "Interactive commands for which paredit should be enabled in the minibuffer.")

(defun conditionally-enable-paredit-mode ()
  "Enable paredit during lisp-related minibuffer commands."
  (if (memq this-command paredit-minibuffer-commands)
      (enable-paredit-mode)))

(require-package 'rainbow-delimiters)
;; Enable desired features for all lisp modes
(defun sanityinc/lisp-setup ()
  "Enable features useful in any Lisp mode."
  ;; I don't like paredit, as it change too many basic key binding.
  ;; (enable-paredit-mode)
  (rainbow-delimiters-mode t)
  (turn-on-eldoc-mode)
  (turn-on-elisp-slime-nav-mode))

(let* ((lispy-hooks '(emacs-lisp-mode-hook
                      lisp-mode-hook
                      inferior-lisp-mode-hook
                      lisp-interaction-mode-hook)))
  (dolist (hook lispy-hooks)
    (add-hook hook 'sanityinc/lisp-setup)))

(require-package 'elisp-slime-nav)
(require 'elisp-slime-nav)

(provide 'init-lisp)
