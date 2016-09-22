(require-package 'golden-ratio)
(require 'golden-ratio)

(defun newbie/maybe-golden-ratio ()
  (when golden-ratio-mode
    (golden-ratio)))

(add-hook 'buffer-list-update-hook #'newbie/maybe-golden-ratio)
(add-hook 'focus-in-hook           #'newbie/maybe-golden-ratio)
(add-hook 'focus-out-hook          #'newbie/maybe-golden-ratio)

(provide 'init-golden-ratio)
