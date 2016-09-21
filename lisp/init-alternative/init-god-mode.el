(require-package 'god-mode)

;;; from https://github.com/chrisdone/god-mode
(with-eval-after-load 'god-mode
  (add-to-list 'god-exempt-major-modes 'speedbar-mode)

  (define-key god-local-mode-map (kbd "z") 'repeat)
  (define-key god-local-mode-map (kbd "i") 'god-mode-all)
  (defun my-update-cursor ()
    (setq cursor-type (if god-local-mode
                          'hbar
                        'box)))

  (add-hook 'god-mode-enabled-hook 'my-update-cursor)
  (add-hook 'god-mode-disabled-hook 'my-update-cursor)

  (let ((toggle-god-mode-key "C-z"))
    (require 'god-mode-isearch)
    (define-key isearch-mode-map (kbd toggle-god-mode-key) 'god-mode-isearch-activate)
    (define-key god-mode-isearch-map (kbd toggle-god-mode-key) 'god-mode-isearch-disable)

    (global-set-key (kbd toggle-god-mode-key) 'god-mode-all)))

(require 'god-mode)

(provide 'init-god-mode)
