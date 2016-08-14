(with-eval-after-load 'desktop
  ;; see https://www.emacswiki.org/emacs?action=browse;oldid=DeskTop;id=Desktop
  ;; use only one desktop
  (setq desktop-path '("~/.emacs.d/"))
  (setq desktop-dirname "~/.emacs.d/")
  (setq desktop-base-file-name "emacs-desktop")

  ;; remove desktop after it's been read
  (add-hook 'desktop-after-read-hook
            '(lambda ()
               ;; desktop-remove clears desktop-dirname
               (setq desktop-dirname-tmp desktop-dirname)
               (desktop-remove)
               (setq desktop-dirname desktop-dirname-tmp))))

(require 'desktop)
(desktop-save-mode)

(provide 'init-desktop)
