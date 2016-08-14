(require-package 'dired+)
(require-package 'dired-quick-sort)
(require-package 'diff-hl)

(defun diredext-exec-git-command-in-shell (command &optional arg file-list)
  "Run a shell command `git COMMAND`' on the marked files.
if no files marked, always operate on current line in dired-mode
"
  (interactive
   (let ((files (dired-get-marked-files t current-prefix-arg)))
     (list
      ;; Want to give feedback whether this file or marked files are used:
      (dired-read-shell-command "git command on %s: " current-prefix-arg files)
      current-prefix-arg
      files)))
  (unless (string-match "[*?][ \t]*\\'" command)
    (setq command (concat command " *")))
  (setq command (concat "git " command))
  (dired-do-shell-command command arg file-list)
  (message command))

;; @see http://blog.twonegatives.com/post/19292622546/dired-dwim-target-is-j00-j00-magic
;; op open two new dired buffers side-by-side and give your new-found automagic power a whirl.
;; Now combine that with a nice window configuration stored in a register and you’ve got a pretty slick work flow.
(setq dired-dwim-target t)

(with-eval-after-load 'dired
  (define-key dired-mode-map "/" 'dired-isearch-filenames)
  (define-key dired-mode-map "\\" 'diredext-exec-git-command-in-shell)

  ;; from 24.4, dired+ can show/hide dired details by press "("
  (setq diredp-hide-details-initially-flag nil)
  (require 'dired+)

  (define-key dired-mode-map (kbd "<backspace>") 'diredp-up-directory)
  ;; M-g is used to goto anywhere, and dir's grep is useless.
  ;; I use M-s g for grep.
  (define-key dired-mode-map (kbd "M-g") nil)
  (autoload 'hydra-dired-quick-sort/lambda-t "dired-quick-sort" nil t)
  (define-key dired-mode-map (kbd "S") 'hydra-dired-quick-sort/lambda-t)

  (setq dired-recursive-deletes 'always)
  (dolist (file `(((if *linux* "xdg-open" "open") "pdf" "dvi" "pdf.gz" "ps" "eps"
                   "avi" "mpg" "rmvb" "rm" "flv" "wmv" "mkv" "mp4" "m4v" "webm"
                   "list" "pls"
                   "gif" "jpeg" "jpg" "tif" "png")))
    (add-to-list 'dired-guess-shell-alist-default
                 (list (concat "\\." (regexp-opt (cdr file) t) "$")
                       (car file)))))

(defun newbie/dired-setup()
  (diff-hl-dired-mode)
  (hungry-delete-mode -1))

(add-hook 'dired-mode-hook 'newbie/dired-setup)

(provide 'init-dired)
