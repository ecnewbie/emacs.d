;; loading yasnippet will slow the startup
;; but it's necessary cost
(if *emacs24* (require-package 'yasnippet '(0 9 0 1) nil))
;; (if (not (file-exists-p (expand-file-name "~/.emacs.d/snippets")))
;;     (make-directory (expand-file-name "~/.emacs.d/snippets")))

(with-eval-after-load 'yasnippet
     (define-key yas-minor-mode-map (kbd "TAB") nil)
     (define-key yas-minor-mode-map [(tab)] nil)
     ;; http://stackoverflow.com/questions/7619640/emacs-latex-yasnippet-why-are-newlines-inserted-after-a-snippet
     (setq-default mode-require-final-newline nil)
     (setq yas-snippet-dirs (list (file-truename "~/.emacs.d/snippets")))

     ;; use yas-completing-prompt when ONLY when `M-x yas-insert-snippet'
     ;; thanks to capitaomorte for providing the trick.
     (defadvice yas-insert-snippet (around use-completing-prompt activate)
       "Use `yas-completing-prompt' for `yas-prompt-functions' but only here..."
       (let ((yas-prompt-functions '(yas-completing-prompt)))
         ad-do-it)))

(require 'yasnippet)

(yas-reload-all)

(autoload 'snippet-mode "yasnippet" "")

(defun newbie/yasnippet-setup ()
  (yas-minor-mode 1))

(add-hook 'prog-mode-hook 'newbie/yasnippet-setup)
(add-hook 'text-mode-hook 'newbie/yasnippet-setup)
(add-hook 'cmake-mode-hook 'newbie/yasnippet-setup)

(defun newbie/yas-new-snippet ()
  (interactive)
  (yas-new-snippet)
  (setq default-directory (car yas-snippet-dirs)))

(provide 'init-yasnippet)
