(when window-system
(global-hl-line-mode 1))				; 高亮当前行
(global-linum-mode 1)				; 显示行号
(which-function-mode t)                 	;在状态条上显示当前光标在哪个函数体内部

;;; --- 在 Mode-line 显示当前Buffer的大小
(size-indication-mode 1)
(when (not window-system)
(menu-bar-mode -1))

;(global-set-key [f11] 'fullscreen)
;全屏
(defun fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;最大化
;; (defun my-maximized ()
;;   (interactive)
;;   (x-send-client-message
;;    nil 0 nil "_NET_WM_STATE" 32
;;    '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;;   (interactive)
;;   (x-send-client-message
;;    nil 0 nil "_NET_WM_STATE" 32
;;    '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
										;(my-maximized)
                                        ;(require 'init-maxframe)
(add-hook 'after-make-frame-functions 'maximize-frame t)

(provide 'init-gui)
