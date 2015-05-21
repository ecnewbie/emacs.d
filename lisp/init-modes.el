(require 'init-markdown)	  ;; setting for markdown from redguardtoo.
(require 'init-org)			  ;; setting org-mode from redguardtoo.
(require 'init-org-mime)      ;; send HTML email using Org-mode HTML export. from redguardtoo.
(require 'init-org-agenda)

(require-package 'ggtags)
(require-package 'cpputils-cmake)
(require-package 'c-eldoc)
(require 'init-cc-mode)       ;; setting for cc-mode. from redguardtoo. fix indent.
(require 'init-flymake)       ;; for flymake. from redguardtoo.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(require-package 'cmake-mode)
(require 'init-hs-minor-mode) ;; setting for hide/show block. from redguardtoo.

(provide 'init-modes)
