(require 'init-markdown)			;; setting for markdown from redguardtoo.
(require 'init-org)					;; setting org-mode from redguardtoo.
(require 'init-org-mime)            ;; send HTML email using Org-mode HTML export. from redguardtoo.
(require 'init-org-agenda)

(require-package 'ggtags)
(require-package 'cpputils-cmake)
(require 'init-cc-mode)             ;; setting for cc-mode. copy from redguardtoo. 
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(require-package 'cmake-mode)
(require 'init-cmake-mode)          ;; cmake-mode. from redguardtoo.
(require 'init-hs-minor-mode) 		;; setting for hide/show block. from redguardtoo.

(require 'init-recentf)             ;; setting for recentf-mode. from redguardtoo.

(provide 'init-modes)
