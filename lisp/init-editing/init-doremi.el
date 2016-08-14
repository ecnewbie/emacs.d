(require-package 'doremi)
(require-package 'doremi-cmd)
(require-package 'doremi-frm)
(require-package 'doremi-mac)
(require-package 'frame-cmds)

(with-eval-after-load 'doremi
  (setq doremi-up-keys '(?- ?, up))
  (setq doremi-down-keys '(?= ?. down)))

;; Cycle buffers
(defvar newbie/doremi-current-buffer nil)
(defun newbie/doremi-buffers+ ()
  "Change default behavior of doremi-buffers+."
  (interactive)
  (require 'doremi-cmd)
  (unless (and newbie/doremi-current-buffer
             (eq last-command 'newbie/doremi-buffers+))
    (setq newbie/doremi-current-buffer (current-buffer)))
  (condition-case nil
      (newbie/doremi-buffers-1)
    (quit (switch-to-buffer newbie/doremi-current-buffer))))

(defun newbie/doremi-buffers-1 ()
  "Helper-function for `newbie/doremi-buffers+'."
  (doremi (lambda (newval) (switch-to-buffer newval 'norecord) newval)
          (previous-buffer)
          nil                           ; ignored
          nil                           ; ignored
          (buffer-list)))

(require 'auto-mark)
(global-auto-mark-mode 1)

(require 'cl)
;; Cycle mark ring
(defvar newbie/doremi-current-pos nil)
(defvar newbie/doremi-marker-index 0)
(defun newbie/doremi-marks+ ()
  "Change default behavior of doremi-marks+."
  (interactive)
  (require 'doremi-cmd)
  (unless mark-ring
    (error "No marks in this buffer"))
  (unless (and newbie/doremi-current-pos
               (eq last-command 'newbie/doremi-marks+))
    (setq newbie/doremi-current-pos (point-marker))
    (setq newbie/doremi-marker-index 1))
  (setq newbie/doremi-marker-index (1+ newbie/doremi-marker-index))
  (unless (nth newbie/doremi-marker-index mark-ring)
    (setq newbie/doremi-marker-index 0))
  (unwind-protect
      (condition-case nil
          (newbie/doremi-marks-1)
        (quit (goto-char newbie/doremi-current-pos)))
    (when (fboundp 'crosshairs-unhighlight)
      (crosshairs-unhighlight 'even-if-frame-switch))))

(defun newbie/doremi-marks-1 ()
  "Helper function for `newbie/doremi-marks+'."
  (doremi (lambda (newval)
            (goto-char newval)
            (when (fboundp 'crosshairs-unhighlight)
              (when (fboundp 'crosshairs-highlight) (crosshairs-highlight)))
            newval)
          (goto-char (nth newbie/doremi-marker-index mark-ring))
          nil                           ; ignored
          nil                           ; ignored
          mark-ring))

(provide 'init-doremi)
