(require-package 'etags-select)

(with-eval-after-load 'etags-select
  (global-set-key [remap find-tag] 'etags-select-find-tag))

(provide 'init-etags)
