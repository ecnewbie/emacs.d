(defvar newbie/guess-cmd-c++ "gcc -Wp,-v -xc++ /dev/null -fsyntax-only")

(defun newbie/guess-c++-header-path ()
  (let ((cmd-output (shell-command-to-string newbie/guess-cmd-c++)))
    (string-all-matches "/usr/.*[^\"]$" cmd-output)))

(defun newbie/guess-c++-system-flags ()
  (let ((system-paths (newbie/guess-c++-header-path))
        (flags))
    (dolist (path system-paths)
      (push (concat "-I" path) flags))
    flags))

(provide 'init-guess-c-header-path)
