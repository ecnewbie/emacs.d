(require 'tramp)

(setq tramp-default-method "ssh")

;; If you tramp is hanging, you can uncomment below line.
;; (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")

(defun remote-eshell (username host)
  (interactive "sUsername: \nsHost: ")
  (let ((default-directory (format "/%s@%s:" username host)))
    (eshell host)))

(provide 'init-tramp)
