(require-package 'eval-in-repl)

;; require the main file containing common functions
(require 'eval-in-repl)

;; Uncomment if no need to jump after evaluating current line
;; (setq eir-jump-after-eval nil)

;; Uncomment if you want to always split the script window into two.
;; This will just split the current script window into two without
;; disturbing other windows.
;; (setq eir-always-split-script-window t)

;; Uncomment if you always prefer the two-window layout.
;; (setq eir-delete-other-windows t)

;; Place REPL on the right of the script window when splitting.
(setq eir-repl-placement 'right)


;;; ielm support (for emacs lisp)
(require 'eval-in-repl-ielm)
;; for .el files
(define-key emacs-lisp-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for *scratch*
(define-key lisp-interaction-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)
;; for M-x info
(define-key Info-mode-map (kbd "<C-return>") 'eir-eval-in-ielm)

;;; cider support (for Clojure)
(with-eval-after-load 'cider
  (require 'eval-in-repl-cider)
  (define-key clojure-mode-map (kbd "<C-return>") 'eir-eval-in-cider))

;;; SLIME support (for Common Lisp)
(with-eval-after-load 'slime
  (require 'eval-in-repl-slime)
  (add-hook 'lisp-mode-hook
            '(lambda ()
               (local-set-key (kbd "<C-return>") 'eir-eval-in-slime))))

;;; Geiser support (for Racket and Guile Scheme)
;; When using this, turn off racket-mode and scheme supports
(with-eval-after-load 'geiser
  (require 'eval-in-repl-geiser)
  (add-hook 'geiser-mode-hook
            '(lambda ()
               (local-set-key (kbd "<C-return>") 'eir-eval-in-geiser))))

;;; Hy support
(with-eval-after-load 'hy-mode
  (require 'eval-in-repl-hy)
  (define-key hy-mode-map (kbd "<C-return>") 'eir-eval-in-hy))


;;; Python support
(with-eval-after-load 'python
  (require 'eval-in-repl-python)
  (add-hook 'python-mode-hook
            '(lambda ()
               (local-set-key (kbd "<C-return>") 'eir-eval-in-python))))

;;; Ruby support
(with-eval-after-load 'ruby-mode
  (require 'inf-ruby)
  (require 'eval-in-repl-ruby)
  (define-key ruby-mode-map (kbd "<C-return>") 'eir-eval-in-ruby))

;;; SML support
(with-eval-after-load 'sml-mode
  (require 'eval-in-repl-sml)
  (define-key sml-mode-map (kbd "<C-return>") 'eir-eval-in-sml)
  (define-key sml-mode-map (kbd "C-;") 'eir-send-to-sml-semicolon))

;;; OCaml support
(with-eval-after-load 'tuareg
  (require 'eval-in-repl-ocaml)
  (define-key tuareg-mode-map (kbd "<C-return>") 'eir-eval-in-ocaml)
  ;; function to send a semicolon to OCaml REPL
  (define-key tuareg-mode-map (kbd "C-;") 'eir-send-to-ocaml-semicolon))

;;; Javascript support
(with-eval-after-load 'js3-mode
  (require 'eval-in-repl-javascript)
  (define-key js3-mode-map (kbd "<C-return>") 'eir-eval-in-javascript))
(with-eval-after-load 'js2-mode
  (require 'eval-in-repl-javascript)
  (define-key js2-mode-map (kbd "<C-return>") 'eir-eval-in-javascript))


;; Shell support
(with-eval-after-load 'shell
  (require 'eval-in-repl-shell)
  (add-hook 'sh-mode-hook
            '(lambda()
               (local-set-key (kbd "C-<return>") 'eir-eval-in-shell)))
  ;; Version with opposite behavior to eir-jump-after-eval configuration
  (defun eir-eval-in-shell2 ()
    "eval-in-repl for shell script (opposite behavior)

This version has the opposite behavior to the eir-jump-after-eval
configuration when invoked to evaluate a line."
    (interactive)
    (let ((eir-jump-after-eval (not eir-jump-after-eval)))
      (eir-eval-in-shell)))
  (add-hook 'sh-mode-hook
            '(lambda()
               (local-set-key (kbd "C-M-<return>") 'eir-eval-in-shell2))))

(provide 'init-eval)
