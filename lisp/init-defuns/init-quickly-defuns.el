(defvar quickly-cpp-command
  "g++"
  "default command for quickly-compile when makefile not exists.")

(defvar quickly-run-command
  "x-terminal-emulator --hold -e"
  "default command to call for quickly-run.")

;;; compile func.
(defun compile-cmake ()
  "call cmake at cppcm-build-dir"
  (interactive)
  (shell-command (concat "cd " cppcm-build-dir " && cmake " cppcm-src-dir) "*compilation*")
  (cppcm-compile-in-root-build-dir))

(defun quickly-compile ()
    "quickly call compile-cmake or compile
or g++ when makefile not exist and in c++ mode."
    (interactive)
    (when buffer-file-name
      (if (and cppcm-src-dir
               (string-prefix-p cppcm-src-dir (file-name-sans-extension buffer-file-name)))
          (progn
            (when (not (file-exists-p cppcm-build-dir))
              (make-directory cppcm-build-dir))
            (message "quickly-compile call compile-cmake")
            (compile-cmake))

        (if (or (file-exists-p "makefile")
                (file-exists-p "Makefile")
                (file-exists-p "GNUMakefile"))
            (compile compile-command)

          (if (eq 'c++-mode major-mode)
              (compile
               (concat quickly-cpp-command " "
                       (buffer-file-name) " "
                       "-o" " "
                       (file-name-sans-extension (buffer-file-name))))

            ;; call compile for other mode.
            (message "call compile for no one matched.")
            (compile compile-command))))))

(defun quickly-get-keyword (PROMPT INITIAL-DIR INITIAL-FILENAME)
      (ido-read-file-name (concat PROMPT " : ") INITIAL-DIR INITIAL-FILENAME))

(defun quickly-run ()
  "quickly run executable file in cppcm-build-dir
or current directory."
  (interactive)
  (if (file-exists-p (format "%s" cppcm-build-dir))
      (call-process-shell-command
       (concat quickly-run-command " "
               (quickly-get-keyword
                "exe name"
                cppcm-build-dir
                (file-name-sans-extension (buffer-file-name))))
       nil nil)

    (call-process-shell-command
     (concat quickly-run-command " "
             (quickly-get-keyword
              "exe name"
              (file-name-directory buffer-file-name)
              (file-name-sans-extension (buffer-file-name))))
     nil nil)
    ))

(provide 'init-quickly-defuns)
