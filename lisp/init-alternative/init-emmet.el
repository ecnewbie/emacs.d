(require-package 'emmet-mode)

;; turn on emmet preview for training.
(with-eval-after-load 'emmet-mode
  (setq emmet-preview-default t))

(require 'emmet-mode)
;; @see https://github.com/rooney/zencoding for original tutorial
;; @see https://github.com/smihica/emmet for new tutorial
;; C-j or C-return to expand the line
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)

(provide 'init-emmet)
