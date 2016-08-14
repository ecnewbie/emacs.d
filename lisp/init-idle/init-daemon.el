(require 'server)
(unless (or (daemonp) (server-running-p))
  (server-start))

(provide 'init-daemon)
