(require 'expand-region-core)

(defvar er/lua-block-re
  '(("while .* do" "end")
    ("for .* do" "end")
    ("if .* then" "else")
    ("if .* then" "end")
    ("else" "end")
    ("function .*\(.*?\)" "end"))
  "Lua blocks.")

(defun er/lua-concat-block-end-re ()
  (let ((block-end-re ""))
    (dolist (val er/lua-block-re)
      (setq block-end-re
            (concat block-end-re
                    (if (string-equal block-end-re "") "" "\\|")
                    (car (cdr val)))))
    block-end-re))

(defun er/lua-concat-block-begin-re ()
  (let ((block-begin-re ""))
    (dolist (val er/lua-block-re)
      (setq block-begin-re
            (concat block-begin-re
                    (if (string-equal block-begin-re "") "" "\\|")
                    (car val))))
    block-begin-re))

(defun er/lua-top-block-level ()
  "Check whether block has reach top level."
  (save-excursion
    (let ((region-begin (point))
          (this-block-begin)
          (prev-block-end))
      (when (region-active-p)
        (setq region-begin (region-beginning)))
      (goto-char region-begin)
      (setq this-block-begin (search-backward-regexp (er/lua-concat-block-begin-re) nil t))
      (goto-char region-begin)
      (setq prev-block-end (search-backward-regexp (er/lua-concat-block-end-re) nil t))
      (if (or (null this-block-begin)
              (and prev-block-end
                   (< prev-block-end this-block-begin)))
          nil
        t))))

(defun er/mark-lua-inside-block ()
  "Mark lua block inside."
  (interactive)
  (unless (er/lua-top-block-level)
    (let ((backward-re "")
          (forward-re "")
          (region-begin (point))
          (region-end (point))
          (nearest-point (point-min)))

      (when (region-active-p)
        (setq region-begin (region-beginning))
        (setq region-end (region-end)))

      (dolist (val er/lua-block-re)
        (goto-char region-begin)
        (when (>= (or (search-backward-regexp (car val) nil t) 0)
                  nearest-point)
          (setq nearest-point (point))
          (setq backward-re (car val))
          (goto-char region-end)
          (when (search-forward-regexp (car (cdr val)) nil t)
            (setq forward-re (car (cdr val))))))

      (unless (equal forward-re "")
        (goto-char nearest-point)
        (search-forward-regexp backward-re nil t)
        (set-mark (point))
        (goto-char region-end)
        (search-forward-regexp forward-re nil t)
        (search-backward-regexp forward-re nil t)
        (exchange-point-and-mark)))))

(defun er/mark-lua-outside-block ()
  "Mark lua block outside."
  (interactive)
  (unless (er/lua-top-block-level)
    (let ((forward-re "")
          (region-begin (point))
          (region-end (point))
          (nearest-point (point-min)))

      (when (region-active-p)
        (setq region-begin (region-beginning))
        (setq region-end (region-end)))

      (dolist (val er/lua-block-re)
        (goto-char region-begin)
        (when (>= (or (search-backward-regexp (car val) nil t) 0)
                  nearest-point)
          (setq nearest-point (point))
          (goto-char region-end)
          (when (search-forward-regexp (car (cdr val)) nil t)
            (setq forward-re (car (cdr val))))))

      (unless (equal forward-re "")
        (goto-char nearest-point)
        (set-mark (point))
        (goto-char region-end)
        (search-forward-regexp forward-re nil t)
        (exchange-point-and-mark)))))

(defun er/add-lua-mode-expansions ()
  "Adds Lua-specific expansions for buffers in lua-mode"
  (set (make-local-variable 'er/try-expand-list)
       '(er/mark-word
         er/mark-symbol
         er/mark-inside-quotes
         er/mark-outside-quotes
         er/mark-inside-pairs
         er/mark-outside-pairs
         er/mark-lua-inside-block
         er/mark-lua-outside-block)))

(er/enable-mode-expansions 'lua-mode 'er/add-lua-mode-expansions)
(provide 'lua-mode-expansions)
