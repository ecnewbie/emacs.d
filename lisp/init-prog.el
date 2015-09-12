(require-package 'company)
(require-package 'company-c-headers)
(require 'init-company)                                          ;; for auto complete. cut from redguardtoo.
(eval-after-load 'company
  '(progn
     (add-to-list 'company-backends 'company-cmake)
     (add-to-list 'company-backends 'company-c-headers)
     ;;; can't work with TRAMP
     (setq company-backends (delete 'company-ropemacs company-backends))
     (setq company-dabbrev-downcase nil)
     (setq company-show-numbers t)
     (setq company-begin-commands '(self-insert-command))
     (setq company-idle-delay 0.2)
     (global-set-key (kbd "M-/ c") 'company-complete)
     ))

(require 'init-cpp-include-path)
(setq company-clang-arguments my-c++-include)
(setq company-c-headers-path-system my-c++-path)
(setq c-eldoc-includes my-c++-include)

(require 'init-flycheck)                                         ;; for syntax checking. from purcell.
(add-hook 'flycheck-mode-hook
	  (lambda ()
	    (when (not (display-graphic-p))
	      (setq-local flycheck-indication-mode nil))) t)         ;; fix flycheck conflicts with company mode in xterm.

(require-package 'ibuffer-vc)
(require-package 'projectile)
(require 'init-projectile)                                       ;; for project from redguardtoo.
(require 'init-gtags)                                            ;; for tags. from redguardtoo.
(custom-set-variables '(ggtags-global-abbreviate-filename nil))  ;; don't show abbreviate filename in global result.
(custom-set-variables '(ggtags-oversize-limit (* 20 1024 1024))) ;; larger gtags file.
(setenv "GTAGSFORCECPP" "")                                      ;; always treat .h as c++ header.

(require 'init-gtagslibpath)

(require 'init-doxygen)                                          ;; insert doxygen style comment. from redguardtoo.

(require-package 'cmake-mode)
;;(require 'init-google-cc-style)                                ;; google coding style.

(require-package 'magit '(1 2 0) nil)
(require-package 'git-commit-mode)
(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)
(when *emacs24*
  (require-package 'git-gutter '(0 71) nil))
(require 'init-git)                                              ;; setting for git. from redguardtoo.

(require-package 'paredit)
(require-package 'quack)
(require-package 'hl-sexp)
(require-package 'rainbow-delimiters)
(require 'init-lisp)                                             ;; setting for lisp. from redguardtoo.

;;; set global key M-[ will conflict with xterm-mouse-mode.
;;; Note: Long press on left mouse button works bad.
(eval-after-load 'paredit
  '(when (not window-system)
   (global-unset-key (kbd "M-["))))

(provide 'init-prog)
