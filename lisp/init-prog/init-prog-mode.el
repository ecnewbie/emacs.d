(require-package 'highlight-numbers)
(require-package 'highlight-parentheses)
(defun generic-prog-mode-hook-setup ()
  ;; enable for all programming modes
  ;; http://emacsredux.com/blog/2013/04/21/camelcase-aware-editing/
  (subword-mode)
  (electric-pair-mode 1)
  ;; eldoc, show API doc in minibuffer echo area
  (turn-on-eldoc-mode)

  (highlight-numbers-mode t)

  (require 'highlight-parentheses)
  (highlight-parentheses-mode))

(add-hook 'prog-mode-hook 'generic-prog-mode-hook-setup)

;; execute editing buffer, support many program language.
(require-package 'quickrun)

(provide 'init-prog-mode)
