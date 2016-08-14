(auto-insert-mode 1)
(setq auto-insert-query nil)
(require-package 'yatemplate)
;; templates with file name like "00:.*.cpp" in yatemplate-dir.
(yatemplate-fill-alist)

(provide 'init-auto-insert)
