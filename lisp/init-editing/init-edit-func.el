(defun align-repeat (start end regexp)
  "Repeat alignment with respect to
     the given regular expression."
      (interactive "r\nsAlign regexp: ")
      (align-regexp start end
                    (concat "\\(\\s-*\\)" regexp) 1 1 t))

(defun jump-to-char (arg char)
  "Like Zap-to-char, but not kill."
  (interactive (list (prefix-numeric-value current-prefix-arg)
             (read-char "Jump to char: " t)))
  ;; Avoid "obsolete" warnings for translation-table-for-input.
  (with-no-warnings
    (if (char-table-p translation-table-for-input)
    (setq char (or (aref translation-table-for-input char) char))))
  (search-forward (char-to-string char) nil nil arg))

(defun copy-to-char (arg char)
  "Like Zap-to-char, but not kill, default is copy to end of line."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (read-char "Copy to char(default to end of line): " t)))
  ;; Avoid "obsolete" warnings for translation-table-for-input.
  (with-no-warnings
    (if (char-table-p translation-table-for-input)
        (setq char (or (aref translation-table-for-input char) char))))

  (if (= char 13)
      (save-excursion
        (copy-region-as-kill (point) (point-at-eol))
        (message "copied to end of line."))
    (save-excursion
      (copy-region-as-kill (point) (search-forward (char-to-string char) nil nil arg)))
    (message "copied to %dth %s" arg (char-to-string char))))

(defun copy-to-end-of-line ()
  "Copy to end of line."
  (interactive)
  (save-excursion
    (copy-region-as-kill (point) (point-at-eol))
    (message "copied to end of line.")))

(defun insert-date (prefix)
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "%Y-%m-%d")
                   ((equal prefix '(4)) "%d.%m.%Y")
                   ((equal prefix '(16)) "%d %B %Y")))
          )
      (insert (format-time-string format))))

(defun insert-line (&optional arg)
  "Insert string in current line and then make newline."
  (interactive "P")
  (when (not arg)
    (setq arg 1))
  (let* ((s (read-from-minibuffer "insert string : ")))
    (dotimes (v arg)
      (insert s)
      (newline-and-indent))))

;; Random line sorting
(defun sort-lines-random (beg end)
  "Sort lines in region randomly."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr nil 'forward-line 'end-of-line nil nil
                   (lambda (s1 s2) (eq (random 2) 0)))))))

(defun shuffle-buffer ()
  "Shuffle lines in current buffer"
  (interactive)
  (sort-lines-random (point-min) (point-max)))


(provide 'init-edit-func)
