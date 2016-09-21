(require-package 'lua-mode)

(require-package 'auto-complete)
(autoload 'lua-eldoc-mode "lua-eldoc-mode" "" t)

(defun my-lua-mode-setup ()
  (interactive)
  (setq-local imenu-generic-expression '(("Variable" "^ *\\([a-zA-Z0-9_.]+\\) *= *{ *[^ ]*$" 1)
                                         ("Function" "function +\\([^ (]+\\).*$" 1)
                                         ("Module" "^ *module +\\([^ ]+\\) *$" 1)
                                         ("Variable" "^ *local +\\([^ ]+\\).*$" 1)))
  (setq lua-indent-level 4)
  (lua-eldoc-mode)
  (when (featurep 'indent-guide)
    (indent-guide-mode t)))

(add-hook 'lua-mode-hook 'my-lua-mode-setup)

(with-eval-after-load 'lua-mode
  (require 'lua-mode-expansions))

(provide 'init-lua)
