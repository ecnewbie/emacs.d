(require 'init-cmake)

(defun newbie/cmake-ide-setup()
  (require 'cmake-ide nil 'noerror)
  (when (featurep 'cmake-ide)
    (require 'rtags nil 'noerror)
    (cmake-ide-setup)))

(add-hook 'c-mode-hook 'newbie/cmake-ide-setup)
(add-hook 'c++-mode-hook 'newbie/cmake-ide-setup)

(when (daemonp)
  (newbie/cmake-ide-setup))

(provide 'init-setup-cmake-ide)
