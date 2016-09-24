(require-package 'operate-on-number)

(use-package operate-on-number
  :config
  (add-to-list 'operate-on-number-at-point-alist '(?= (1) +))
  (add-to-list 'operate-on-number-at-point-alist '(?_ (1) +)))

(provide 'init-operate-on-number)
