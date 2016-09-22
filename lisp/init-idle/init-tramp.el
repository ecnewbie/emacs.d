(with-eval-after-load 'tramp
  ;; If you tramp is hanging, you can uncomment below line.
  ;; (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
  (if (eq system-type 'windows-nt)
      (setq tramp-default-method "plink")
    (setq tramp-default-method "ssh")))

(defun remote-eshell (username host)
  (interactive "sUsername: \nsHost: ")
  (let ((default-directory (format "/%s@%s:" username host)))
    (eshell host)))

(when (daemonp)
  (require 'tramp))

(provide 'init-tramp)
