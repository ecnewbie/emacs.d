;; edit grep result.
(require-package 'wgrep)
(require-package 'wgrep-ag)
(require-package 'wgrep-helm)
(require-package 'scf-mode)
(require-package 'ag)

(with-eval-after-load 'grep
  (dolist (v '("auto"
               "target"
               "node_modules"
               "bower_components"
               ".sass_cache"
               ".cache"
               ".git"
               ".cvs"
               ".svn"
               ".hg"
               "elpa"))
    (add-to-list 'grep-find-ignored-directories v))
  (add-hook 'grep-mode-hook 'newbie/grep-setup)
  (require 'wgrep)
  (define-key grep-mode-map [(s)] 'scf-mode))

(defun newbie/grep-setup()
  (toggle-truncate-lines 1)
  (scf-mode)
  (linum-mode -1))

(with-eval-after-load 'wgrep
    (define-key wgrep-mode-map (kbd "C-k") 'wgrep-mark-deletion)
    (define-key wgrep-mode-map "\C-c\C-q" 'wgrep-toggle-readonly-area)
    (define-key wgrep-mode-map "\C-x\C-q" 'wgrep-change-to-wgrep-mode))

(with-eval-after-load 'scf-mode
  ;;;FIXME: scf-mode partly work with large output.
  (setq scf-minimum-hide-length 1))

;; http://stackoverflow.com/questions/16122801/remove-header-information-from-rgrep-grep-output-in-emacs
(defun delete-grep-header ()
  (save-excursion
    (with-current-buffer grep-last-buffer
      (goto-line 5)
      (narrow-to-region (point) (point-max)))))

(defvar delete-grep-header-advice
  (ad-make-advice
   'delete-grep-header nil t
   '(advice lambda () (delete-grep-header))))

(defun add-delete-grep-header-advice (function)
  (ad-add-advice function delete-grep-header-advice 'after 'first)
  (ad-activate function))

(mapc 'add-delete-grep-header-advice
      '(grep lgrep grep-find rgrep zrgrep projectile-grep))

(provide 'init-grep)
