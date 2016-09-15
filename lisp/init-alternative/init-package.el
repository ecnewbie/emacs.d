(require-package 'async)

(defvar async-current-window nil)

(defun async-list-packages()
  (interactive)
  (setq async-current-window (selected-window))
  (async-start
   (lambda ()
     (list-packages))
   (lambda (result)
     (save-excursion
       (when async-current-window
         (select-window async-current-window))
       (package-list-packages-no-fetch)))))

(provide 'init-package)

