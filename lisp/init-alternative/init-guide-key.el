(require-package 'guide-key)

(guide-key-mode 1)
(setq guide-key/guide-key-sequence t)   ; enable any key sequence.
(setq guide-key/popup-window-position 'bottom)
(diminish 'guide-key-mode)

(provide 'init-guide-key)
