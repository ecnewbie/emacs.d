;;----------------------------------------------------------------------------
;; Suppress GUI features
;;----------------------------------------------------------------------------
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;;----------------------------------------------------------------------------
;; Show a marker in the left fringe for lines not in the buffer
;;----------------------------------------------------------------------------
(setq indicate-empty-lines t)

;effective emacs item 7; no scrollbar, no menubar, no toolbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (unless window-system
                (set-frame-parameter nil 'menu-bar-lines 0)))))

(when window-system
  (global-hl-line-mode 1)) ;;; 高亮当前行
(global-linum-mode 1)	 ;;; 显示行号
(which-function-mode t)  ;;; 在状态条上显示当前光标在哪个函数体内部
(column-number-mode t)

;; from RobinH, Time management
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time-mode t)    ;;; 显示时间

;;; --- 在 Mode-line 显示当前Buffer的大小
(size-indication-mode 1)

(menu-bar-mode -1)                      ; menu bar is not need now.

(defun fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))


(add-hook 'after-make-frame-functions 'maximize-frame t)

(require-package 'linum-relative)
(require 'linum-relative)
(setq linum-relative-current-symbol "")
(add-hook 'find-file-hook
          (lambda ()
            (if (< (line-number-at-pos (point-max))
                   5000)
                (linum-relative-mode t)
              (linum-mode -1))))

;; set frame title.
(setq-default frame-title-format
              '(buffer-file-name
                "%f"
                (dired-directory dired-directory "%b")))


(provide 'init-gui-frames)
