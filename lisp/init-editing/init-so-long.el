(defun newbie/long-line-setup ()
  (linum-mode -1)
  (toggle-truncate-lines 1)
  (setq buffer-read-only t))

(defun newbie/detected-long-line ()
  (when (so-long-line-detected-p)
    (newbie/long-line-setup)))

(when (require 'so-long nil :noerror)
  ;; (setq so-long-target-modes (append so-long-target-modes '()))
  (so-long-enable)
  (add-hook 'so-long-hook 'newbie/long-line-setup))

(add-hook 'grep-setup-hook 'newbie/long-line-setup)

(provide 'init-so-long)
