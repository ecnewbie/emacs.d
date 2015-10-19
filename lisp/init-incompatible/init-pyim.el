(require-package 'chinese-pyim)
(require 'chinese-pyim)
(setq default-input-method "chinese-pyim")

(setq pyim-dicts
      '((:name "dict1" :file "~/.emacs.d/dicts/pyim-bigdict.txt" :coding utf-8-unix)))

(provide 'init-pyim)
