(add-hook 'prog-mode-hook 'global-company-mode)
(add-hook 'cmake-mode-hook 'global-company-mode)

(setq company-require-match nil)
;; press SPACE will accept the highlighted candidate and insert a space
;; `M-x describe-variable company-auto-complete-chars` for details
;; That's BAD idea.
(setq company-auto-complete nil)

(if (fboundp 'evil-declare-change-repeat)
    (mapc #'evil-declare-change-repeat
          '(company-complete-common
            company-select-next
            company-select-previous
            company-complete-selection
            company-complete-number
            )))

(provide 'init-company)
