(require 'init-markdown)	  ;; setting for markdown from redguardtoo.
(require 'init-org)			  ;; setting org-mode from redguardtoo.
(require 'init-org-mime)      ;; send HTML email using Org-mode HTML export. from redguardtoo.
(require 'init-org-table)
(require 'init-org-agenda)

(require 'org)
(set org-link-file-path-type 'adaptive)
(require 'init-hs-minor-mode) ;; setting for hide/show block. from redguardtoo.

(require 'init-shell)

(require-package 'lua-mode)
(require-package 'flymake-lua)
(require 'init-lua-mode)      ;; setting for lua-mode from redguardtoo.

(provide 'init-modes)
