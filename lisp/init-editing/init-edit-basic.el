(setq-default buffers-menu-max-size 30
              bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
              make-backup-files nil
              scroll-preserve-screen-position 'always
              show-trailing-whitespace nil
              blink-cursor-interval 0.4
              case-fold-search t
              compilation-scroll-output t
              ediff-split-window-function 'split-window-horizontally
              ediff-window-setup-function 'ediff-setup-windows-plain
              save-interprogram-paste-before-kill t
              grep-highlight-matches t
              grep-scroll-output t
              indent-tabs-mode nil
              line-spacing 0.2
              mouse-yank-at-point t
              set-mark-command-repeat-pop t
              tooltip-delay 1.5
              ;; void problems with crontabs, etc.
              ;; require-final-newline t ; bad idea, could accidentally edit others' code
              truncate-lines nil
              truncate-partial-width-windows nil
              ;; visible-bell has some issue
              ;; @see https://github.com/redguardtoo/mastering-emacs-in-one-year-guide/issues/9#issuecomment-97848938
              visible-bell nil)

;; recentf
(require-package 'sync-recentf)
(require 'sync-recentf)
(setq recentf-auto-cleanup 60)

;; only don't record these files.
(setq recentf-exclude '("/tmp/"
                        "/ssh:"
                        "/sudo:"
                        "autoloads.el$")
      recentf-max-saved-items 1000
      recentf-keep '(file-remote-p file-readable-p))
(recentf-mode 1)

;;;-------------------------------------------

(require-package 'unfill)

;; type text replaces the selection
(delete-selection-mode t)
;; many commands will change their behavior, such as undo changes within current region.
(transient-mark-mode t)

;;; Whitespace
(defun sanityinc/no-trailing-whitespace ()
  "Turn off display of trailing whitespace in this buffer."
  (setq show-trailing-whitespace nil))

;; But don't show trailing whitespace in SQLi, inf-ruby etc.
(dolist (hook '(special-mode-hook
                Info-mode-hook
                eww-mode-hook
                term-mode-hook
                comint-mode-hook
                compilation-mode-hook
                twittering-mode-hook
                minibuffer-setup-hook))
  (add-hook hook #'sanityinc/no-trailing-whitespace))

;; auto revert when disk files changed.
(global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

;; @see http://www.emacswiki.org/emacs/SavePlace
(require-package 'saveplace)
(require 'saveplace)
(setq-default save-place t)

(require-package 'browse-kill-ring)
;; {{ https://github.com/browse-kill-ring/browse-kill-ring
(require 'browse-kill-ring)
;; no duplicates
(setq browse-kill-ring-display-duplicates nil)
;; preview is annoying
(setq browse-kill-ring-show-preview nil)
(browse-kill-ring-default-keybindings)
;; hotkeys:
;; n/p => next/previous
;; s/r => search
;; l => filter with regex
;; g => update/refresh
;; }}

(fset 'yes-or-no-p 'y-or-n-p)

;; some project prefer tab, so be it
;; @see http://stackoverflow.com/questions/69934/set-4-space-indent-in-emacs-in-text-mode
(setq-default tab-width 4)

;; NO automatic new line when scrolling down at buffer bottom
(setq next-line-add-newlines nil)

;; auto insert the corresponding closing parenthesis
(when (fboundp 'electric-pair-mode)
  (electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
  (electric-indent-mode 1))

(require-package 'undo-tree)
(with-eval-after-load 'undo-tree (define-key undo-tree-map (kbd "C-_") nil))
;; C-/, C-?  undo, redo
(global-undo-tree-mode)

;; savehist
(savehist-mode 1)

;; highlight-symbol
(require-package 'highlight-symbol)
(dolist (hook '(prog-mode-hook html-mode-hook css-mode-hook))
  (add-hook hook 'highlight-symbol-mode)
  (add-hook hook 'highlight-symbol-nav-mode))
(add-hook 'org-mode-hook 'highlight-symbol-nav-mode)
(setq highlight-symbol-idle-delay 0)

(defun sanityinc/maybe-suppress (orig-fun &rest args)
  "Suppress symbol highlighting while isearching."
  (unless isearch-mode
    (apply orig-fun args)))

(with-eval-after-load 'highlight-symbol
  (advice-add 'highlight-symbol-temp-highlight :around #'sanityinc/maybe-suppress))

(require-package 'whitespace-cleanup-mode)
(global-whitespace-cleanup-mode t)

;; Show matching parens
(show-paren-mode 1)
(require-package 'smartparens)
(smartparens-mode 1)

;; Cut/copy the current line if no region is active
(require-package 'whole-line-or-region)
(whole-line-or-region-mode t)
(make-variable-buffer-local 'whole-line-or-region-mode)

(require-package 'page-break-lines)
(global-page-break-lines-mode)

;; Fill column indicator
(when (eval-when-compile (> emacs-major-version 23))
  (require-package 'fill-column-indicator)
  (defun sanityinc/prog-mode-fci-settings ()
    (turn-on-fci-mode)
    (when show-trailing-whitespace
      (set (make-local-variable 'whitespace-style) '(face trailing))
      (whitespace-mode 1)))

  (defun sanityinc/fci-enabled-p ()
    (and (boundp 'fci-mode) fci-mode))

  (defvar sanityinc/fci-mode-suppressed nil)
  (defadvice popup-create (before suppress-fci-mode activate)
    "Suspend fci-mode while popups are visible"
    (let ((fci-enabled (sanityinc/fci-enabled-p)))
      (when fci-enabled
        (set (make-local-variable 'sanityinc/fci-mode-suppressed) fci-enabled)
        (turn-off-fci-mode))))
  (defadvice popup-delete (after restore-fci-mode activate)
    "Restore fci-mode when all popups have closed"
    (when (and sanityinc/fci-mode-suppressed
               (null popup-instances))
      (setq sanityinc/fci-mode-suppressed nil)
      (turn-on-fci-mode)))

  ;; Regenerate fci-mode line images after switching themes
  (defadvice enable-theme (after recompute-fci-face activate)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (sanityinc/fci-enabled-p)
          (turn-on-fci-mode))))))

;; view large files
(require-package 'vlf)
(require 'vlf-setup)
(setq vlf-batch-size 2000000) ; nearly 2M

;; license
(require-package 'lice)

;; Don't disable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; Ctrl-X, u/l  to upper/lowercase regions without confirm
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; midnight mode purges buffers which haven't been displayed in 3 days
(require 'midnight)
(setq midnight-mode t)

(autoload 'vr/replace "visual-regexp")
(autoload 'vr/query-replace "visual-regexp")
;; if you use multiple-cursors, this is for you:
(autoload 'vr/mc-mark "visual-regexp")

(require-package 'goto-last-change)
(autoload 'goto-last-change "goto-last-change" nil t)

;; these hotkeys are good
(require-package 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(with-eval-after-load 'expand-region
  (setq-default er/try-expand-list
        '(er/mark-word
          er/mark-symbol
          er/mark-method-call
          er/mark-comment
          er/mark-comment-block
          er/mark-inside-quotes
          er/mark-outside-quotes
          er/mark-inside-pairs
          er/mark-outside-pairs
          er/mark-url
          er/mark-email
          er/mark-defun)))

;; Zap *up* to char is a handy pair for zap-to-char
(autoload 'zap-up-to-char "misc" "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-Z") 'zap-up-to-char)

(require-package 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)

;; avy, jump between texts
;; @see http://emacsredux.com/blog/2015/07/19/ace-jump-mode-is-dead-long-live-avy/ for more tips
(require-package 'avy)
(with-eval-after-load 'avy (setq avy-all-windows nil))
(with-eval-after-load 'dired (define-key dired-mode-map (kbd ";") 'avy-goto-word-1))
(global-set-key (kbd "C-;") 'avy-goto-word-1)
(global-set-key (kbd "C-:") 'avy-goto-subword-1)

(require-package 'ace-link)
(use-package ace-link)

;; Shift lines up and down with M-up and M-down. When paredit is enabled,
;; it will use those keybindings.
(require-package 'move-dup)
(global-set-key [M-up] 'md/move-lines-up)
(global-set-key [M-down] 'md/move-lines-down)
(global-set-key [M-S-up] 'md/duplicate-up)
(global-set-key [M-S-down] 'md/duplicate-down)


;; @see http://stackoverflow.com/questions/4222183/emacs-how-to-jump-to-function-definition-in-el-file
(global-set-key (kbd "C-h C-f") 'find-function)

;; M-x without meta
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; A quick way to jump to the definition of a function given its key binding
(global-set-key (kbd "C-h K") 'find-function-on-key)

(provide 'init-edit-basic)
