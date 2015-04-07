(require-package 'idle-require)
(require 'idle-require)

(require-package 'dropdown-list)
(setq idle-require-idle-delay 1)
(setq idle-require-symbols '(init-idle))
(idle-require-mode 1) ;; starts loading

(when (require 'time-date nil t)
   (message "Emacs startup time: %d seconds."
    (time-to-seconds (time-since emacs-load-start-time)))
   )

(provide 'init-idle-require)
