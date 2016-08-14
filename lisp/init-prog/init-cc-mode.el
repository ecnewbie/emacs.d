;; avoid default "gnu" style, use more popular one
(setq c-default-style "linux")

(defun fix-c-indent-offset-according-to-syntax-context (key val)
  ;; remove the old element
  (setq c-offsets-alist (delq (assoc key c-offsets-alist) c-offsets-alist))
  ;; new value
  (add-to-list 'c-offsets-alist '(key . val)))

(defun my-common-cc-mode-setup ()
  "setup shared by all languages (java/groovy/c++ ...)"
  (setq c-basic-offset 4)
  ;; give me NO newline automatically after electric expressions are entered
  (setq c-auto-newline nil)

  ;; @see http://xugx2007.blogspot.com.au/2007/06/benjamin-rutts-emacs-c-development-tips.html
  (setq compilation-window-height 8)
  (setq compilation-finish-function
        (lambda (buf str)
          (if (string-match "exited abnormally" str)
              ;;there were errors
              (message "compilation errors, press C-x ` to visit")
            ;;no errors, make the compilation window go away in 0.5 seconds
            (when (string-match "*compilation*" (buffer-name buf))
              ;; @see http://emacswiki.org/emacs/ModeCompile#toc2
              (bury-buffer "*compilation*")
              (winner-undo)
              (message "NO COMPILATION ERRORS!")))))

  ;; syntax-highlight aggressively
  ;; (setq font-lock-support-mode 'lazy-lock-mode)
  (setq lazy-lock-defer-contextually t)
  (setq lazy-lock-defer-time 0)

  ;; indent
  (fix-c-indent-offset-according-to-syntax-context 'inline-open 0)
  (fix-c-indent-offset-according-to-syntax-context 'innamespace 0))

(defun my-c-mode-setup ()
  "C/C++ only setup"
  (local-set-key (kbd "C-x C-o") 'ff-find-other-file)

  ;; make a #define be left-aligned
  (setq c-electric-pound-behavior (quote (alignleft)))

  (when buffer-file-name
    ;; c-eldoc (https://github.com/mooz/c-eldoc)
    (c-turn-on-eldoc-mode)

    (flymake-mode 1)))

;; donot use c-mode-common-hook or cc-mode-hook because many major-modes use this hook
(add-hook 'c-mode-common-hook
          (lambda ()
            (my-common-cc-mode-setup)
            (unless (or (derived-mode-p 'java-mode) (derived-mode-p 'groovy-mode))
              (my-c-mode-setup))))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(provide 'init-cc-mode)
