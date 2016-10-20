;; Use cperl-mode instead of the default perl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(with-eval-after-load 'cperl-mode
  (define-key cperl-mode-map "\t" nil)
  (define-key cperl-mode-map (kbd "<DEL>") nil))

(provide 'init-cperl-mode)
