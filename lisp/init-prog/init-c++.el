;; expand member functions.
(autoload 'expand-member-functions "member-functions" "Expand C++ member function declarations" t)

;; doc
(require 'doxymacs nil 'noerror)
(defun newbie/doxymacs-font-lock-hook ()
  (when (featurep 'doxymacs)
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock))))

(add-hook 'font-lock-mode-hook 'newbie/doxymacs-font-lock-hook)

(defun newbie/c++-setup ()
  (local-set-key "\C-cm" #'expand-member-functions)
  (when (featurep 'doxymacs)
    (doxymacs-mode t)))

(add-hook 'c++-mode-hook 'newbie/c++-setup)

(provide 'init-c++)
