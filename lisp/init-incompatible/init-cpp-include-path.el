;; config for init-company.el
(defvar my-c++-path
  (let ((gpp-version)
    (hardware-platform))
    (setq gpp-version
          (with-temp-buffer
            (call-process (executable-find "g++") nil t nil "--version")
            (goto-char (point-min))
            (if (re-search-forward "\\([0-9.]+\\)" nil t)
                (match-string-no-properties 0)
              nil)))
    (setq gpp-version (substring gpp-version 0 3))
    (setq hardware-platform (combine-and-quote-strings (split-string (shell-command-to-string "uname -i"))))
    (when (equal hardware-platform "unknown")
      (setq hardware-platform (combine-and-quote-strings (split-string (shell-command-to-string "uname -m")))))
    (list (concat "/usr/include/c++/" gpp-version)
          (concat "/usr/include/c++/" gpp-version "/backward")
          (concat "/usr/include/" hardware-platform "-linux-gnu/c++/" gpp-version)
          (concat "/usr/lib/gcc/" hardware-platform "-linux-gnu/" gpp-version "/include")
          (concat "/usr/lib/gcc/" hardware-platform "-linux-gnu/" gpp-version "/include-fixed")
          "/usr/include"
          (concat "/usr/include/" hardware-platform "-linux-gnu")
          "/usr/local/include")))

(defvar my-c++-include
  (mapcar (lambda (item) (concat "-I" item))
          my-c++-path))

(provide 'init-cpp-include-path)
