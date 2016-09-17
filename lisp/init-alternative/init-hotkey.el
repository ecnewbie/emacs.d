;; goto anywhere.
(global-set-key (kbd "M-g f") 'counsel-projectile-find-file)
(global-set-key (kbd "M-g F") 'newbie/find-file-in-current-directory)
(global-set-key (kbd "M-g r") 'ivy-recentf)
(global-set-key (kbd "M-g R") 'newbie/jump-to-recently-dir)
(global-set-key (kbd "M-g L") 'counsel-locate)

(global-set-key (kbd "M-g b") 'newbie/doremi-buffers+)
(global-set-key (kbd "M-g e") 'show-this-file-external)
(global-set-key (kbd "M-g d") 'dired-jump)

(global-set-key (kbd "M-g j") 'jump-to-char)
(global-set-key (kbd "M-g l") 'ace-link)
(global-set-key (kbd "M-g i") 'tags-imenu)

(global-set-key (kbd "M-g s") 'newbie/swiper-the-thing)

(global-set-key (kbd "M-g o") 'counsel-git-grep)
(global-set-key (kbd "M-g O") 'counsel-ag)

(global-set-key (kbd "M-g h") 'popwin:popup-last-buffer)
(global-set-key (kbd "M-g y") 'yas-visit-snippet-file)
(global-set-key (kbd "M-g !") 'flycheck-list-errors)

(global-set-key (kbd "M-g w") 'w3m-browse-url)

;; search.
(global-set-key (kbd "M-s d") 'youdao-dictionary-search)
(global-set-key (kbd "M-s v") 'youdao-dictionary-play-voice-from-input)
(global-set-key (kbd "M-s r") 'anzu-query-replace-regexp)
(global-set-key (kbd "M-s p") 'prog-doc)
(global-set-key (kbd "M-s a") 'projectile-ag)
(global-set-key (kbd "M-s A") 'ag-regexp)

;; do what i mean.
(global-set-key (kbd "C-c d n") 'narrow-or-widen-dwim)
(global-set-key (kbd "C-c s") 'flyspell-auto-correct-word)

;; other keys
(global-set-key (kbd "<f5>") 'quickrun)

(global-set-key (kbd "C--") 'newbie/doremi-marks+)
(global-set-key (kbd "C-_") 'doremi-global-marks+)
(global-set-key (kbd "C-+") 'doremi-frame-font-size+)

(global-set-key (kbd "C-c c c") 'copy-to-char)
(global-set-key (kbd "C-c c e") 'copy-to-end-of-line)

(provide 'init-hotkey)
