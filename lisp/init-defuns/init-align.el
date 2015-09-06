(defun align-repeat (start end regexp)
  "Repeat alignment with respect to
     the given regular expression."
      (interactive "r\nsAlign regexp: ")
      (align-regexp start end
                    (concat "\\(\\s-*\\)" regexp) 1 1 t))

(defun replace-string-from-to (from to)
  (goto-char 0)
  (while (search-forward from nil t)
    (replace-match to)))

(defun change-to-en-punctuation ()
  "change punctuation from Chinese style to English style."
  (interactive)
  (save-window-excursion
    (replace-string-from-to "（" "(")
    (replace-string-from-to "）" ")")
    (replace-string-from-to "，" ", ")
    (replace-string-from-to "。" ". ")
    (replace-string-from-to "：" ": ")
    (replace-string-from-to "／" "/")
    (whitespace-cleanup)))

(provide 'init-align)
