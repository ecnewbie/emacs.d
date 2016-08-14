(require-package 'readline-complete)
(require 'readline-complete)

(setq explicit-shell-file-name "bash")
(setq explicit-bash-args '("-c" "export EMACS=; stty echo; bash"))
(setq comint-process-echoes t)

;;; turn off yas-minor-mode, company-mode and flyspell-mode.
(defun newbie/turn-off-yas-company-flyspell ()
  (when yas-minor-mode
    (yas-minor-mode -1))
  (when company-mode
    (company-mode -1))
  (when flyspell-mode
    (flyspell-mode -1)))

(require 'multi-term)

(setq term-bind-key-alist
      '(
        ("C-c C-c" . term-interrupt-subjob)
        ("C-c C-j" . term-line-mode)
        ("C-c C-k" . term-char-mode)
        ("C-m" . term-send-return)
        ("C-y" . term-paste))
      )

(setq term-unbind-key-list
      '("C-z" "C-x" "C-c" "C-h" "C-y"
        "M-x" "<tab>"))

(defun newbie/term-setup ()
  (setq term-buffer-maximum-size 10000)
  (setq show-trailing-whitespace nil)
  (setq comint-move-point-for-output nil)
  (setq multi-term-scroll-show-maximum-output t)
  (setq multi-term-scroll-to-bottom-on-output t)
  (setq mode-line-format nil))

(add-hook 'term-mode-hook 'newbie/term-setup)

(provide 'init-shell)
