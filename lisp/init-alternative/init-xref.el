(with-eval-after-load 'xref
  (global-set-key (kbd "M-*") 'xref-pop-marker-stack)
  (global-set-key (kbd "M-,") nil))

(provide 'init-xref)
