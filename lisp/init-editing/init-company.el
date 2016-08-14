(require-package 'company)
(require-package 'company-statistics)
(require-package 'company-c-headers)
(require-package 'company-lua)

(defvar newbie/company-backend-alist
  '((lua-mode-hook (company-lua company-dabbrev-code company-yasnippet))
    (c-mode-hook company-c-headers
                 (company-clang company-dabbrev-code company-yasnippet))
    (c++-mode-hook company-c-headers
                   (company-clang company-dabbrev-code company-yasnippet))
    ))

(defun newbie/company-backends-setup()
  (dolist (v newbie/company-backend-alist)
    (add-hook (car v)
              `(lambda ()
                (set (make-local-variable 'company-backends)
                     ',(cdr v))))))

(with-eval-after-load 'company
  ;; @see https://github.com/company-mode/company-mode/issues/348
  (require 'company-statistics)
  (company-statistics-mode)

  (add-to-list 'company-backends 'company-cmake)
  (add-to-list 'company-backends 'company-c-headers)
  ;; can't work with TRAMP
  (setq company-backends (delete 'company-ropemacs company-backends))

  (newbie/company-backends-setup)

  (setq company-show-numbers t)
  (setq company-begin-commands '(self-insert-command))
  (setq company-idle-delay 0.4)
  (setq company-minimum-prefix-length 3)
  (setq company-require-match nil)
  (setq company-etags-ignore-case t)

  (define-key company-mode-map (kbd "<tab>") 'newbie/tab-indent-or-complete)

  ;; occur
  (define-key company-active-map (kbd "C-o") 'company-filter-candidates)

  ;; press SPACE will accept the highlighted candidate and insert a space
  ;; `M-x describe-variable company-auto-complete-chars` for details
  ;; That's BAD idea.
  (setq company-auto-complete nil)

  ;; NOT to load company-mode for certain major modes.
  ;; https://github.com/company-mode/company-mode/issues/29
  (setq company-global-modes
        '(not
          eshell-mode comint-mode erc-mode gud-mode rcirc-mode
          minibuffer-inactive-mode)))

(defun newbie/company-setup ()
  (company-mode 1))

(add-hook 'prog-mode-hook 'newbie/company-setup)
(add-hook 'text-mode-hook 'newbie/company-setup)
(add-hook 'cmake-mode-hook 'newbie/company-setup)

(defun newbie/check-expansion ()
  (save-excursion
    (backward-char 1)
    (if (looking-at "[.:]") t
      (backward-char 1)
      (if (looking-at "->") t nil))))

;; todo maybe other better choice
(defvar newbie/word-regexp "[a-z-_0-9]")

(defun newbie/check-len (&optional len)
  (save-excursion
    (if (looking-at newbie/word-regexp) nil
      (let* ((num company-minimum-prefix-length)
             (point (point)))
        (if len
            (setq num len))
        (skip-chars-backward newbie/word-regexp)
        (if (>= (- point (point))
               num) t nil)))))

(defun newbie/do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

(defun newbie/do-yas-fallback ()
  (company-mode -1) ; turn off company to call other tab commmand
  (let ((yas-fallback-behavior 'call-other-command))
    (yas--fallback))
  (company-mode t))

(defun newbie/tab-indent-or-complete ()
  (interactive)
  (if (or (minibufferp)
          (region-active-p))
      (newbie/do-yas-fallback)
    (unless (and (newbie/check-expansion)
                 (newbie/check-len)
                 (company-complete-common))
      (unless (and (newbie/check-len 1)
                   yas/minor-mode
                   (newbie/do-yas-expand))
        (newbie/do-yas-fallback)))))

(provide 'init-company)
