(require-package 'ibuffer-vc)

(setq vc-handled-backends '(Git SVN Hg))

;; Donot make backups of files, not safe
;; @see https://github.com/joedicastro/dotfiles/tree/master/emacs
(setq vc-make-backup-files nil)


;; git

(require-package 'magit '(1 2 0) nil)
(when *emacs24*
  (require-package 'git-gutter '(0 71) nil))

(with-eval-after-load 'magit
	(setq vc-handled-backends (delq 'Git vc-handled-backends))
	(setq magit-refresh-status-buffer nil)
	(setq magit-revision-insert-related-refs nil))

;; git-gutter
(require 'git-gutter)

;; If you enable global minor mode
(global-git-gutter-mode t)

;; kill revert buffer after delete window as M-g p/n confit.
(defadvice delete-window (after kill-git-gutter-popup-buffer activate)
  "Kill speedbar buffer if it's window deleted."
  (when (get-buffer git-gutter:popup-buffer)
    (kill-buffer git-gutter:popup-buffer)))


;; nobody use bzr
;; people are forced use subversion or hg, so they take priority
(custom-set-variables '(git-gutter:handled-backends '(svn hg git)))

(git-gutter:linum-setup)

(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk
(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

;; git end

;; svn

(require-package 'magit-svn)

(provide 'init-vc)
