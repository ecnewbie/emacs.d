; config for init-company.el
(defvar my-c++-path
      (let (gpp-version)
         (setq gpp-version
           (with-temp-buffer
             (call-process (executable-find "g++") nil t nil "--version")
             (goto-char (point-min))
             (if (re-search-forward "\\([0-9.]+\\)" nil t)
               (match-string-no-properties 0)
              nil
             )))
      (setq gpp-version (substring gpp-version 0 3))
         (list (concat "/usr/include/c++/" gpp-version)
               (concat "/usr/include/c++/" gpp-version "/backward")
               (concat "/usr/include/x86_64-linux-gnu/c++/" gpp-version)
               (concat "/usr/lib/gcc/x86_64-linux-gnu/" gpp-version "/include")
               (concat "/usr/lib/gcc/x86_64-linux-gnu/" gpp-version "/include-fixed")
               "/usr/include"
               "/usr/include/x86_64-linux-gnu"
               "/usr/local/include"
         )))

(defvar my-c++-include
      (mapcar (lambda (item) (concat "-I" item))
	my-c++-path
))

(provide 'init-cpp-include-path)
