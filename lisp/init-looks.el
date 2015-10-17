(require 'init-gui-frames)         ;; setting for frame. from purcell.
(require 'init-frame-hooks)        ;; frame hooks, for add hook after make frame. from purcell.
(require 'init-xterm)              ;; setting for virtual terminal. from redguardtoo.
(require 'init-themes)             ;; use zenburn now.
(require 'init-windows)            ;; setting for switch window, winner and split window... from redguardtoo.
(setq switch-window-shortcut-style 'alphabet)

(require-package 'switch-window)
(require-package 'window-numbering)
(require-package 'buffer-move)
(require 'init-gui)                ;; setting for frame. highlight cur-line and line num...

(require-package 'sr-speedbar)
(require 'init-sr-speedbar)        ;; setting for sr-speedbar. from redguardtoo.

;;(require 'init-layout)           ;; setting for new temp buffer. It works bad sometimes.

;;; it seems that cursor color is always black in some environment.
(setq default-frame-alist '((cursor-color . "white")))

(provide 'init-looks)
