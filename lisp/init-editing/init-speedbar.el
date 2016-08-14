(require-package 'sr-speedbar)
(use-package sr-speedbar
  :config
  (setq sr-speedbar-max-width 30)
  (setq sr-speedbar-width 30)
  (setq sr-speedbar-auto-refresh nil)
  (setq speedbar-use-images nil)
  (setq speedbar-show-unknown-files t)
  (setq sr-speedbar-right-side nil))

(defadvice delete-window (after kill-sr-speedbar-buffer activate)
  "Kill speedbar buffer if it's window deleted."
  (when (get-buffer sr-speedbar-buffer-name)
    (kill-buffer sr-speedbar-buffer-name)))

(defun newbie/speedbar-setup()
  (linum-mode -1)

  ;; make speedbar can't resize
  (with-current-buffer sr-speedbar-buffer-name
    (setq window-size-fixed 'width)))

(add-hook 'speedbar-mode-hook 'newbie/speedbar-setup)

(provide 'init-speedbar)
