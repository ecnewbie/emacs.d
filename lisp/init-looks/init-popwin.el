(require-package 'popwin)

(with-eval-after-load 'popwin
  (setq popwin:special-display-config
        (append '(("*json-path*" :height 5 :noselect t)
                  ("*Org Agenda(.*)*" :height 15 :noselect t :regexp t)
                  (help-mode :noselect t)
                  (anaconda-mode-view-mode :noselect t)
                  ("*Flycheck errors*" :noselect t)
                  ("*RTags*" :noselect t)
                  (ggtags-global-mode :noselect t)
                  ("*quickrun*" :noselect t)
                  ("*Compile-Log*" :noselect t))
                popwin:special-display-config)))

(require 'popwin)
(popwin-mode 1)

(provide 'init-popwin)
