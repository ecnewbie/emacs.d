(defun align-repeat (start end regexp)
  "Repeat alignment with respect to
     the given regular expression."
      (interactive "r\nsAlign regexp: ")
      (align-regexp start end
                    (concat "\\(\\s-*\\)" regexp) 1 1 t))

(require 'package)
(defun package-upgrade-all ()
  "Upgrade all package."
  (interactive)
  (list-packages)
  (package-menu-mark-upgrades)
  (package-menu-execute t)
  (kill-buffer "*Packages*"))

(provide 'init-defuns-good)
