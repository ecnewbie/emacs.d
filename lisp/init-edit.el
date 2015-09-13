(require 'init-fonts)							;; setting for fonts, from redguardtoo.
(require 'init-pyim)							;; pinyin input method.

(require-package 'pointback)
(require-package 'saveplace)
(require-package 'fic-mode)
(require-package 'maxframe)
(require-package 'browse-kill-ring)
(require 'init-misc-redguardtoo)					;; cut from redguardtoo. not display fic at modeline.

;;; only don't record these files.
(setq recentf-exclude '("/tmp/"
                        "/ssh:"
                        "/sudo:"))
(global-unset-key (kbd "C-c c"))
(define-key global-map (kbd "C-@") 'set-mark-command)
(define-key global-map (kbd "M-g m") 'pop-to-mark-command)

(require 'init-editing-utils)						;; editing utils from purcell, cancel guide-key.
;(when window-system
;  (add-hook 'prog-mode-hook 'sanityinc/prog-mode-fci-settings))	;; fci-mode confilcts with company in xterm, also confilcts with dropdown-list.
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C-M-=") 'er/contract-region)

(require-package 'workgroups2)
(require 'init-workgroups2)						;; setting for workgroup2. from redguardtoo.
;;(add-hook 'after-init-hook 'workgroups-mode)

(defun my-workgroups-undo ()
  (interactive)
  (if (wg-current-workgroup-p (wg-current-workgroup (selected-frame)))
      (wg-undo-wconfig-change)
    (winner-undo)))

(defun my-workgroups-redo ()
  (interactive)
    (if (wg-current-workgroup-p (wg-current-workgroup (selected-frame)))
      (wg-redo-wconfig-change)
    (winner-redo)))

(defun my-make-workgroups-mode-map ()
  (define-key workgroups-mode-map [remap wg-undo-wconfig-change] 'my-workgroups-undo)
  (define-key workgroups-mode-map [remap wg-redo-wconfig-change] 'my-workgroups-redo)
  (define-key workgroups-mode-map (kbd "C-c <left>") 'my-workgroups-undo)
  (define-key workgroups-mode-map (kbd "C-c <right>") 'my-workgroups-redo))

(add-hook 'workgroups-mode-hook 'my-make-workgroups-mode-map)

;;(global-set-key [remap cua-paste-pop] 'yank-pop)			;; not work.

(provide 'init-edit)
