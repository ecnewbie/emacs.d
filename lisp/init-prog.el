(require 'init-company)                                          ;; for code completion.

(require 'init-cc-mode)                                          ;; setting for cc-mode. fix indent.

(require 'init-cpp-include-path)
(setq company-clang-arguments my-c++-include)
(setq company-c-headers-path-system my-c++-path)
(setq flycheck-clang-args my-c++-include)
(setq c-eldoc-includes my-c++-include)

(require 'init-flymake)                                          ;; for flymake.

(add-hook 'cppcm-reload-all-hook
          '(lambda ()
             (setq company-clang-arguments (append company-clang-arguments my-c++-include))
             (setq company-c-headers-path-system (append company-c-headers-path-system my-c++-path))
             (setq flycheck-clang-args company-clang-arguments)
             (message "flycheck-clang-args = %s" flycheck-clang-args)
             (setq c-eldoc-includes
                   (combine-and-quote-strings company-clang-arguments))
             (setq c-eldoc-cpp-normal-arguments
                   (combine-and-quote-strings cppcm-preprocess-defines))
             (setq c-eldoc-cpp-macro-arguments
                   (combine-and-quote-strings cppcm-preprocess-defines))
             ))

(require 'init-flycheck)                                         ;; for syntax checking.
(add-hook 'flycheck-mode-hook
          (lambda ()
	    (when (not (display-graphic-p))
	      (setq-local flycheck-indication-mode nil))) t)         ;; fix flycheck conflicts with company mode in xterm.

(require 'init-projectile)                                       ;; for project Management.

(require-package 'find-file-in-project)

(require 'init-gtags)                                            ;; for tags.

(require 'init-gtagslibpath)

(require 'init-doxygen)                                          ;; insert doxygen style comment.

;;(require 'init-google-cc-style)                                ;; google coding style.

(require 'init-git)                                              ;; setting for git.

(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook
          (lambda () (rainbow-delimiters-mode t)))
(require 'init-lisp)                                             ;; setting for lisp.

;;; set global key M-[ will conflict with xterm-mouse-mode.
;;; Note: Long press on left mouse button works bad.
(eval-after-load 'paredit
  '(when (not window-system)
     (global-unset-key (kbd "M-["))))


(provide 'init-prog)
