(with-eval-after-load 'etags
  (setq tags-add-tables nil))

(require-package 'etags-select)

(with-eval-after-load 'etags-select
  (global-set-key [remap find-tag] 'etags-select-find-tag-at-point)
  (global-set-key [remap xref-find-definitions] 'etags-select-find-tag-at-point))

(require 'etags-select)

(provide 'init-etags)
