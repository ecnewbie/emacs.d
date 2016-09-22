(when (eq system-type 'windows-nt)
  ;; reverse PATH to make emacs find gnu exe first.
  ;; see https://lists.gnu.org/archive/html/bug-gnu-emacs/2016-05/msg00363.html
  (let ((paths (split-string (getenv "PATH") ";"))
        (reverse-path ""))
    (dolist (v paths)
      (setq reverse-path (concat v ";" reverse-path)))
    (setenv "PATH" reverse-path)))

(provide 'init-windows-env)
