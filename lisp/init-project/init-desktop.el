(defun newbie/desktop-remove ()
  ;; desktop-remove clears desktop-dirname
  (setq desktop-dirname-tmp desktop-dirname)
  (desktop-remove)
  (setq desktop-dirname desktop-dirname-tmp))

(with-eval-after-load 'desktop
  ;; see https://www.emacswiki.org/emacs?action=browse;oldid=DeskTop;id=Desktop
  ;; use only one desktop
  (setq desktop-path '("~/.emacs.d/"))
  (setq desktop-dirname "~/.emacs.d/")
  (setq desktop-base-file-name "emacs-desktop")
  ;; do not load locked desktop
  (setq desktop-load-locked-desktop nil)
  ;; do not save desktop
  (setq desktop-save nil)

  ;; remove desktop after it's been read
  (add-hook 'desktop-after-read-hook 'newbie/desktop-remove))

(require 'desktop)

(defun newbie/save-desktop ()
  "Save desktop when desktop file not exist, otherwise ask if overwrite it."
  (let ((exists (file-exists-p (desktop-full-file-name))))
    (unless (and exists
                 (not (y-or-n-p "Overwirte exist desktop file?")))
      (newbie/desktop-remove)
      (when desktop-dirname
        (desktop-save desktop-dirname)))))

(add-hook 'kill-emacs-hook 'newbie/save-desktop)
(desktop-save-mode t)

(provide 'init-desktop)
