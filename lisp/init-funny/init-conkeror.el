(require-package 'conkeror-minor-mode)

(autoload 'conkeror-minor-mode "conkeror-minor-mode")

(add-hook 'js-mode-hook (lambda ()
                          (when (string-match "conkeror" (buffer-file-name))
                            (conkeror-minor-mode 1))))

(provide 'init-conkeror)
