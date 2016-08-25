;; setting for ido. smart completion on switch buffer, find file and
;; so on.

(require-package 'flx-ido)
(require-package 'ido-ubiquitous)
(require-package 'imenu-anywhere)
(require-package 'ido-vertical-mode)

;; Use C-f during file selection to switch to regular find-file
(require 'ido-ubiquitous)
(require 'flx-ido)
(ido-mode t)  ; use 'buffer rather than t to use only buffer switching
(ido-everywhere t)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
(setq ido-use-filename-at-point nil)
;; disable switch to another directory when no one matched.
(setq ido-auto-merge-work-directories-length -1)
(setq ido-use-virtual-buffers t)
;; @see https://github.com/lewang/flx
(setq flx-ido-threshold 10000)
;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)
(ido-vertical-mode t)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

;; dired rename, use C-j to select dir.
(put 'dired-do-rename 'ido 'find-file)
(put 'dired-do-copy 'ido 'find-file)

(defun newbie/ido-jump-to-recently-dir ()
    "Use ido to select a dir from the `ido-work-directory-list'"
  (interactive)
  (dired (ido-completing-read "Dired: " ido-work-directory-list nil t)))

(defun newbie/jump-to-recently-dir ()
    "Use ivy to select a dir from the `ido-work-directory-list'"
  (interactive)
  (dired (completing-read "Dired: " ido-work-directory-list nil t nil nil
                          (car-safe ido-work-directory-list))))


;; keybindings
;; completion
(define-key ido-common-completion-map "\C-a" nil) ; fall back to use move begin of line
(define-key ido-common-completion-map "\C-e" nil)
(define-key ido-common-completion-map "\C-i" 'ido-toggle-ignore)
(define-key ido-common-completion-map "\C-c" 'ido-toggle-case)
(define-key ido-common-completion-map "\C-p" 'ido-toggle-prefix)
(define-key ido-common-completion-map [?\C-/] 'ido-undo-merge-work-directory)

;; file
(define-key ido-file-dir-completion-map "\C-w" 'ido-copy-current-word)
(define-key ido-file-dir-completion-map [(meta ?w)] 'ido-copy-current-file-name)

;; buffer
(define-key ido-buffer-completion-map [?\C-\]] 'ido-toggle-virtual-buffers)
(define-key ido-buffer-completion-map [?\C->] 'ido-toggle-virtual-buffers)
(define-key ido-buffer-completion-map [?\C-v] 'ido-toggle-virtual-buffers)

(provide 'init-ido)
