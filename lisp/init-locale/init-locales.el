(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a utf-8 locale."
  (and v (string-match "utf-8" v)))

(defun locale-is-utf8-p ()
  "Return t if the \"locale\" command or environment variables prefer utf-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (locale-is-utf8-p)
  (set-default-coding-systems 'utf-8)
  (unless (eq system-type 'windows-nt)
    (setq locale-coding-system 'utf-8)
    (set-selection-coding-system 'utf-8))
  (prefer-coding-system 'utf-8))

(provide 'init-locales)
