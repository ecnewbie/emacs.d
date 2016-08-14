;; based on https://github.com/redguardtoo/emacs.d/init.el


;; -*- coding: utf-8 -*-
(setq emacs-load-start-time (current-time))
;(setq debug-on-error t)

;----------------------------------------------------------------------------
; config load path
;----------------------------------------------------------------------------
(defun add-path (dir)
  "Add all directories in dir to load-path."
  (when (file-directory-p dir)
    (add-to-list 'load-path (expand-file-name dir))
      (dolist (file (directory-files dir t "\\w+"))
        (when (file-directory-p file)
          (add-path file)))))

(add-path "~/.emacs.d/lisp")
(add-path "~/.emacs.d/site-lisp")

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *macbook-pro-support-enabled* t)
(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(setq *win32* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs23* (and (not *xemacs*) (or (>= emacs-major-version 23))) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)
                   ))


;----------------------------------------------------------------------------

;;----------------------------------------------------------------------------
;; Less GC, more memory
;;----------------------------------------------------------------------------
;; By default Emacs will initiate GC every 0.76 MB allocated
;; (gc-cons-threshold == 800000).
;; we increase this to 1GB (gc-cons-threshold == 100000000)
;; @see http://www.gnu.org/software/emacs/manual/html_node/elisp/Garbage-Collection.html
(setq-default gc-cons-threshold 100000000
              gc-cons-percentage 0.5)

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-elpa)             ; setting for package-archives.
(require-dir "init-defuns")      ; functions for utils.
(require-dir "init-looks")       ; setting for frames, windows and theme.
(require-dir "init-alternative") ; some usable package to replace default key-binding.
(require-dir "init-editing")     ; setting for edit utils.

(require-dir "init-project")     ; project management

(require-dir "init-text-modes")  ; setting for modes.
(require-dir "init-prog")        ; setting for programing.

(require-dir "init-funny")       ; some funny usage.

(require-dir "init-custom")      ; custom settings.

(require 'init-idle-require)     ; load some package when idle.

;; ;;----------------------------------------------------------------------------
;; ;; Locales (setting them earlier in this file doesn't work in X)
;; ;;----------------------------------------------------------------------------
(require-dir "init-locale")      ; internationalization
(provide 'init)
