
;; Highlight current sexp
;; Prevent flickery behaviour due to hl-sexp-mode unhighlighting before each command
(require-package 'hl-sexp)
(with-eval-after-load 'hl-sexp
  (defadvice hl-sexp-mode (after unflicker (turn-on) activate)
     (when turn-on
       (remove-hook 'pre-command-hook #'hl-sexp-unhighlight))))

(require-package 'hl-todo)
(require-package 'highlight-numbers)

(require-package 'indent-guide)
(require 'indent-guide)
(setq indent-guide-recursive t)

(global-hl-todo-mode t)

(provide 'init-highlight)

