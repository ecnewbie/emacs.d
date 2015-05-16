(require-package 'google-c-style)
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style t)      ;; add hook at last.
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;-----------------------------------------------------------------------------------
(eval-after-load 'flycheck
  '(progn
     (require-package 'flycheck-google-cpplint)
     (require 'flycheck-google-cpplint)
     ;; Add Google C++ Style checker.
     ;; In default, syntax checked by Clang and Cppcheck.
     (flycheck-add-next-checker 'c/c++-clang
                                'c/c++-googlelint 'append)))


(add-hook 'c++-mode-hook (lambda ()
			   (flycheck-mode)))

(provide 'init-google-cc-style)
