(defun generic-prog-mode-hook-setup ()
  ;; enable for all programming modes
  ;; http://emacsredux.com/blog/2013/04/21/camelcase-aware-editing/
  (subword-mode)
  (electric-pair-mode 1)
  ;; eldoc, show API doc in minibuffer echo area
  (turn-on-eldoc-mode)
  ;; show trailing spaces in a programming mode
  (setq show-trailing-whitespace t)

  (require-package 'highlight-numbers)
  (highlight-numbers-mode t)

  (require-package 'highlight-parentheses)
  (require 'highlight-parentheses)
  (highlight-parentheses-mode))

(add-hook 'prog-mode-hook 'generic-prog-mode-hook-setup)

;; execute editing buffer, support many program language.
(require-package 'quickrun)

(provide 'init-prog-mode)
