(when (not (file-exists-p (file-truename "~/.emacs.d/tags")))
    (make-directory (file-truename "~/.emacs.d/tags"))
    )
(gtags-ext-add-gtagslibpath (file-truename "~/.emacs.d/tags"))

(provide 'init-gtagslibpath)
