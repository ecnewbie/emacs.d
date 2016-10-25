(require-package 'fm)

(with-eval-after-load 'fm
  (setq fm-modes
        (append fm-modes
                '((ivy-occur-grep-mode compile-goto-error)
                  (grep-mode compile-goto-error)))))

(autoload 'fm-start "fm" "" t)

(dolist (mode '("ivy-occur-grep-mode"
                "grep-mode"))
  (add-hook (intern (concat mode "-hook"))
              `(lambda ()
                (define-key ,(intern (concat mode "-map")) (kbd "f") 'fm-start))))

(provide 'init-fm)
