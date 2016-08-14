;; mpc music player.

(autoload 'mingus "mingus" "mpc frontend" t)
(with-eval-after-load 'mingus
  (require 'libmpdee))

(provide 'init-mpc)
