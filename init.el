;; based on https://github.com/redguardtoo/emacs.d/init.el


;; -*- coding: utf-8 -*-
(setq emacs-load-start-time (current-time))
(setq debug-on-error t)

;----------------------------------------------------------------------------
; config load path
;----------------------------------------------------------------------------
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(defun add-path (file)
  "documentation..."
  (if (file-directory-p file)
      (dolist (file2 (directory-files file t "\\w+"))
	  (when (file-directory-p file2)
         	(add-to-list 'load-path (expand-file-name file2)))
       (add-path file2))
     nil))

(add-path "~/.emacs.d")

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
(require 'init-defuns)                 	;; fuctions for utils.
(require 'init-elpa)              		;; setting for package-archives. from purcell.
(require 'init-looks)                   ;; setting for frames, windows and theme.
(require 'init-alternative)             ;; some usable package to replace default key-binding.

(require 'init-edit)                    ;; setting for edit utils.
(require 'init-modes)                   ;; setting for modes.

(require 'init-prog)                    ;; setting for programing.
(require 'init-simple)                	;; provide some packages with default setting.

(require 'init-idle-require)    		;; load some package when idle.

;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)                 ;; setting for locales, utf-8. from redguardtoo.
(provide 'init)