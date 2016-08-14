;; bongo music player
(require-package 'bongo)
(require-package 'volume)

(with-eval-after-load 'bongo
  (require 'volume)
  (setq bongo-display-header-icons nil)
  (setq bongo-display-track-icons nil)
  (setq bongo-enabled-backends '(mpg123)) ;  mplayer vlc mpg123 order has no effect.
  (setq bongo-prefer-library-buffers nil)
  (setq bongo-default-playlist-buffer-name "default.bongo-playlist")
  (setq bongo-logo nil))

(defun newbie/bongo-setup ()
  (unless (buffer-file-name (get-buffer bongo-default-playlist-buffer-name))
    (when (get-buffer bongo-default-playlist-buffer-name)
      (kill-buffer bongo-default-playlist-buffer-name))
    (find-file (expand-file-name
                (concat "~/.emacs.d/" bongo-default-playlist-buffer-name)))
    (setq buffer-save-without-query t)
    (bongo-random-playback-mode 1)
    (bongo-play-random)))

(defun newbie/bongo-save ()
  (when (featurep 'bongo)
    (bongo-playlist)
    (write-file (expand-file-name
                 (concat "~/.emacs.d/" bongo-default-playlist-buffer-name)))))

(defun newbie/bongo-open-and-play-random ()
  "Open bongo default playlist and then play random."
  (interactive)
  (require 'bongo)
  (newbie/bongo-setup)
  (bongo-playlist)
  (bongo-recenter))

(add-hook 'kill-emacs-hook 'newbie/bongo-save)

(provide 'init-bongo)
