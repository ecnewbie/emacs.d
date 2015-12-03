(require-package 'company)
(require-package 'company-statistics)
(require-package 'company-c-headers)

(add-hook 'prog-mode-hook 'global-company-mode)
(add-hook 'cmake-mode-hook 'global-company-mode)

(if (fboundp 'evil-declare-change-repeat)
    (mapc #'evil-declare-change-repeat
          '(company-complete-common
            company-select-next
            company-select-previous
            company-complete-selection
            company-complete-number
            )))

(global-unset-key (kbd "M-/"))
(eval-after-load 'company
  '(progn
     ;; @see https://github.com/company-mode/company-mode/issues/348
     (require 'company-statistics)
     (company-statistics-mode)

     (add-to-list 'company-backends 'company-cmake)
     (add-to-list 'company-backends 'company-c-headers)
     ;; can't work with TRAMP
     (setq company-backends (delete 'company-ropemacs company-backends))
     ;; (setq company-backends (delete 'company-capf company-backends))

     ;; I don't like the downcase word in company-dabbrev
     ;; for languages use camel case naming convention
     ;; company should be case sensitive
     (setq company-dabbrev-downcase nil)

     (setq company-show-numbers t)
     (setq company-begin-commands '(self-insert-command))
     (setq company-idle-delay 0.2)
     (setq company-require-match nil)
     (setq company-etags-ignore-case t)

     ;; press SPACE will accept the highlighted candidate and insert a space
     ;; `M-x describe-variable company-auto-complete-chars` for details
     ;; That's BAD idea.
     (setq company-auto-complete nil)

     ;; NOT to load company-mode for certain major modes.
     ;; Ironic that I suggested this feature but I totally forgot it
     ;; until two years later.
     ;; https://github.com/company-mode/company-mode/issues/29
     (setq company-global-modes
           '(not
             eshell-mode comint-mode org-mode erc-mode gud-mode))
     (global-set-key (kbd "M-/ c") 'company-complete)
     ))

(provide 'init-company)
