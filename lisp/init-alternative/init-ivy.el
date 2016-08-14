(require-package 'ivy)

(require 'ivy)
;; try ivy completing every where.
(setq completing-read-function 'ivy-completing-read)

;; emacs like key bindings.
;; minibuffer
(define-key ivy-minibuffer-map (kbd "C-;") 'ivy-avy)
(define-key ivy-minibuffer-map (kbd "M-%") 'ivy-toggle-regexp-quote)
(define-key ivy-minibuffer-map (kbd "C-t") 'ivy-toggle-regexp-quote)
(define-key ivy-minibuffer-map (kbd "C-w") 'ivy-yank-word)
(define-key ivy-minibuffer-map (kbd "C-o") 'ivy-occur)
(define-key ivy-minibuffer-map (kbd "C-S-o") 'hydra-ivy/body) ; it's less use
(define-key ivy-minibuffer-map (kbd "M-o") 'ivy-dispatching-done)

;; occur
(define-key ivy-occur-mode-map (kbd "n") 'ivy-occur-next-line)
(define-key ivy-occur-mode-map (kbd "p") 'ivy-occur-previous-line)
(define-key ivy-occur-mode-map (kbd "b") 'backward-char)
(define-key ivy-occur-mode-map (kbd "f") 'forward-char)
(define-key ivy-occur-mode-map (kbd "j") 'ivy-occur-press)
(define-key ivy-occur-mode-map (kbd "q") 'quit-window)

(provide 'init-ivy)
