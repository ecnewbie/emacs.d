(defun smarter-move-beginning-of-line (&optional arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)
;; }

(defun smarter-mark-current-line (&optional arg)
  "Mark current line."
  (interactive "P")
  (push-mark (point) nil t)
  (smarter-move-beginning-of-line)
  (push-mark nil nil)
  (end-of-line (prefix-numeric-value arg)))

(defalias 'mark-line 'smarter-mark-current-line "Mark current line.")

(defun smarter-zap-up-to-char (arg char)
  "Smarter zap up to char, to support mc."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (read-char "Zap up to char: " t)))
  ;; Avoid "obsolete" warnings for translation-table-for-input.
  (with-no-warnings
    (if (char-table-p translation-table-for-input)
        (setq char (or (aref translation-table-for-input char) char))))
  (let ((direction (if (>= arg 0) 1 -1)))
    (kill-region (point)
                 (progn
                   (forward-char direction)
                   (unwind-protect
                       (search-forward (char-to-string char) nil nil arg)
                     (backward-char direction))
                   (point)))))

(global-set-key [remap zap-up-to-char] 'smarter-zap-up-to-char)

(provide 'init-smarter-commands)
