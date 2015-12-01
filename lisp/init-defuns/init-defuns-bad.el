;;; search funcs.
(defun get-keyword (TIP)
  (let* ((key-word))
      (setq key-word (read-from-minibuffer (concat TIP " : ") (current-word)))
      (when (equal key-word "")
        (setq key-word (current-word)))
      key-word
      ))

(defun sync-browse-url (URL)
  (let* ((current-window) (current-buffer) (new-window))
    (setq current-buffer (current-buffer))
    (setq current-window (selected-window))

    (with-help-window "*w3m*" nil) ;; show result in a help window.
    (setq new-window (previous-window))
    (if (one-window-p t)
        (setq new-window (split-window-sensibly)))
    (select-window new-window)
    (w3m-mode)
    (w3m-browse-url URL nil)
    (help-mode)

    ;; restore
    (select-window current-window)
    (switch-to-buffer current-buffer)
    ))

(defvar last-url)
(defun async-browse-url (URL)
  (setq last-url URL)
  (async-start
   (sync-browse-url last-url))
  nil)

(defun search-cppreference ()
  "search http://en.cppreference.com."
  (interactive)
  (async-browse-url
   (concat "http://en.cppreference.com/mwiki/index.php?search="
           (get-keyword "search-cppreference"))))

(defun search-boost ()
  "search boost."
  (interactive)
  (async-browse-url
   (concat "http://www.google.com.hk/search?hl=zh-CN&q="
           (get-keyword "search-boost") "+site:boost.org")))

(defun search-wiki ()
  "search en wiki."
  (interactive)
  (async-browse-url
   (concat "https://en.wikipedia.org/w/index.php?search="
           (get-keyword "search-wiki"))))

(defun search-archwiki ()
  "search archwiki."
  (interactive)
  (async-browse-url
   (concat "https://wiki.archlinux.org/index.php?search="
           (get-keyword "search-archwiki"))))

(defun search-stackoverflow ()
  "search stackoverflow."
  (interactive)
  (async-browse-url
   (concat "http://www.google.com.hk/search?hl=zh-CN&q="
           (get-keyword "search-stackoverflow") "+site:stackoverflow.com")))

(defun man2 ()
  "man 2 [key-word]."
  (interactive)
  (manual-entry
   (concat "2 " (completing-read "Man 2: " 'Man-completion-table nil nil
                                 (concat "2 " (current-word))))))


;;; comment funcs.
(defun c-uncomment-region-p (BEG END)
  (unless (= BEG END)
    (let* (word)
      (setq word (buffer-substring-no-properties BEG END))
      (delete-region BEG END)
      (if (string-match "/\\*\\(.*\\(?:\n.*\\)*?\\)\\*/" word)
          (insert (substring word 2 -2))
        (insert word)))))

(defun c-comment-or-uncomment-region-p (BEG END &optional remark)
  (unless (= BEG END)
    (let* (word)
      (setq word (buffer-substring-no-properties BEG END))
      (delete-region BEG END)
      (if (string-match "/\\*\\(.*\\(?:\n.*\\)*?\\)\\*/" word)
          (progn
            (insert (substring word 2 -2))
            (setq END (- END 4)))
        (insert (concat "/*" word "*/")))
      (setq END (+ END 4))
      (when remark
        (goto-char BEG)
        (set-mark-command nil)
        (goto-char END)
        (setq deactivate-mark nil)))))

(defun call-comment-dwim-2 (&optional arg)
  (setq last-command 'comment-dwim-2)
  (if arg
      (comment-dwim-2 arg)
    (comment-dwim-2)))

(defun my-comment-or-uncomment-region (&optional arg)
  "If not c-mode or c++-mode, call `comment-dwim-2'.
Else,
First call : If the region is active, call `c-comment-or-uncomment-region'.
Else, call `c-comment-or-uncomment-region' on current word.
More call : call `comment-dwim-2' with arg."
  (interactive)
  (if (or (eq 'c-mode major-mode) (eq 'c++-mode major-mode))
      (if (use-region-p)
          (if (eq last-command 'c-comment-or-uncomment-region)
              (progn
                (c-uncomment-region-p (region-beginning) (region-end))
                (call-comment-dwim-2 arg))
            (c-comment-or-uncomment-region-p (region-beginning) (region-end) t))
        (let* ((start) (pos (point)) (end))
          (beginning-of-line)
          (setq start (point))
          (end-of-line)
          (setq end (point))
          (goto-char pos)

          (skip-chars-backward "^ .,;()\t" start)
          (setq start (point))
          (skip-chars-forward "^ .,;()\t" end)
          (setq end (point))

          (if (or (eq last-command 'c-comment-or-uncomment-region) (eq start end))
              (progn
                (c-uncomment-region-p start end)
                (call-comment-dwim-2 arg))
            (c-comment-or-uncomment-region-p start end))))
    (call-comment-dwim-2 arg)))

;;; others
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
