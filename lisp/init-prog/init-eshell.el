(require-package 'eshell-z)
(require-package 'eshell-git-prompt)
(require-package 'multi-eshell)
(require-package 'pcmpl-args)

(with-eval-after-load 'eshell
  (require 'eshell-z)
  (require 'eshell-git-prompt)
  (require 'pcmpl-args)
  (setenv "PAGER" "cat")
  (eshell-git-prompt-use-theme 'git-radar)
  (setq eshell-cmpl-expand-before-complete t)
  (setq eshell-cmpl-cycle-completions nil)
  (setq eshell-scroll-to-bottom-on-input t)
  (require 'em-term)
  (add-to-list 'eshell-visual-subcommands '("git" "log" "diff" "show"))
  (add-to-list 'eshell-visual-commands "ssh")
  (add-to-list 'eshell-visual-commands "tail"))

(with-eval-after-load 'multi-eshell
  (setq multi-eshell-shell-function '(eshell))
  (setq multi-eshell-name "*eshell*"))

(defun newbie/eshell-setup ()
  ;; For better performance.
  (if (featurep 'auto-mark)
      (auto-mark-mode -1))
  ;; (setq mode-line-format nil)
  (setq eshell-buffer-maximum-lines 10000)
  (setq show-trailing-whitespace nil)
  (linum-mode -1)
  (eshell-smart-initialize))

(add-hook 'eshell-mode-hook 'newbie/eshell-setup)

(require 'eshell)
(require 'em-smart)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

(provide 'init-eshell)
