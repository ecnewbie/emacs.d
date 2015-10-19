(defun search-cpp-reference()
  "search http://en.cppreference.com."
  (interactive)
  (progn
    (let* ((key-word))
      (setq key-word (read-from-minibuffer (concat "search " (current-word) "?")))
      (when (equal key-word "")
        (setq key-word (current-word)))
      (eww-browse-url
       (concat "http://en.cppreference.com/mwiki/index.php?search=" key-word)))))

(defun man2()
  "man 2 [key-word]."
  (interactive)
  (progn
    (let* ((key-word))
      (setq key-word (read-from-minibuffer (concat "man 2 " (current-word) "?")))
      (when (equal key-word "")
        (setq key-word (current-word)))
      (manual-entry (concat "2 " key-word)))))

(defun toggle-comment-c++-word()
  "use /* word */ style to comment current word"
  (interactive)
  (let* ((start) (pos (point)) (end))
    (beginning-of-line)
    (setq start (point))
    (end-of-line)
    (setq end (point))
    (goto-char pos)

    (skip-chars-backward "^ ,;()\t" start)
    (setq start (point))
    (skip-chars-forward "^ ,;()\t" end)
    (setq end (point))

    (unless (= start end)
      (let* (word)
        (setq word (buffer-substring-no-properties start end))
        (delete-region start end)
        (if (string-match "/\\*.*\\*/" word)
            (insert (substring word 2 -2))
          (insert (concat "/*" word "*/")))))))

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

(provide 'init-defuns-bad)
