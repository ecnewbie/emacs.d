(require 'init-gui-frames)				;; setting for frame. from purcell.
(require 'init-frame-hooks)				;; frame hooks, for add hook after make frame. from purcell.
(require 'init-xterm)					;; setting for virtual terminal. from redguardtoo.
(require 'init-themes)					;; use zenburn now.
(require 'init-windows)					;; setting for switch window, winner and split window... from purcell.

(require-package 'window-numbering)	
(require-package 'buffer-move)
(require 'init-move-window-buffer)		;; window-numbering and buffer-move. copy from redguardtoo.
(require 'init-gui)						;; setting for frame. highlight cur-line and line num...

(require-package 'sr-speedbar)
(require 'init-sr-speedbar)            ;; setting for sr-speedbar. from redguardtoo.

(provide 'init-looks)
