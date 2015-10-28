(global-set-key (kbd "M-/ /") 'dabbrev-expand)
(global-set-key (kbd "M-/ M-/") 'dabbrev-expand)

(global-set-key (kbd "M-g ;") 'ace-jump-mode)
(global-set-key (kbd "M-g f") 'find-file-in-project)
(global-set-key (kbd "M-g b") 'previous-buffer)
(global-set-key (kbd "M-g u") 'up-list)
(global-set-key (kbd "M-g d") 'down-list)
(global-set-key (kbd "M-g j") 'jump-to-char)
(global-set-key (kbd "M-g s") 'swiper)
(global-set-key (kbd "M-g i") 'ido-imenu)
(global-set-key (kbd "M-g o") 'helm-occur)

(global-set-key (kbd "M-/ s") 'ispell-word)

(global-set-key (kbd "C-x o") 'switch-window)

(global-set-key [remap comment-dwim] 'my-comment-or-uncomment-region)

(global-set-key (kbd "M-s s") 'swiper)
(global-set-key (kbd "M-s d") 'youdao-dictionary-search)
(global-set-key (kbd "M-s v") 'youdao-dictionary-play-voice-from-input)

(provide 'init-hotkey)
