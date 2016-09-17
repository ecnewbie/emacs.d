(defun browse-file-directory ()
  "Open the current file's directory however the OS would."
  (interactive)
  (if default-directory
      (browse-url-of-file (expand-file-name default-directory))
    (error "No `default-directory' to open")))

(when (eq system-type 'windows-nt)
  (require-package 'w32-browser))

(when (eq system-type 'mac)
  (require-package 'reveal-in-osx-finder))

(require 'dired)
(defun show-this-file-external ()
  "Show current file in OS explorer."
  (interactive)
  (let ((current-file (or (buffer-file-name)
                          (expand-file-name (dired-file-name-at-point))
                          (default-directory))))
    (case system-type
              ('windows-nt
               (w32explore current-file))
              ('mac
               (reveal-in-osx-finder))
              (t
               (browse-file-directory)))
      ))

(provide 'init-file-explorer)
