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
(require-package 'smart-cursor-color)
(smart-cursor-color-mode 1)

(eval-after-load 'helm
  ;; set color for helm's "->".
  '(set-face-attribute 'helm-header-line-left-margin nil
		      :background nil
		      :foreground (face-attribute 'font-lock-type-face :foreground)))

(provide 'init-looks)
