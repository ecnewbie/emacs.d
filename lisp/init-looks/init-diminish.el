(require-package 'diminish)
(require 'diminish)

(with-eval-after-load 'linum-relative (diminish 'linum-relative-mode))

(with-eval-after-load 'smart-cursor-color (diminish 'smart-cursor-color-mode))

(with-eval-after-load 'paredit (diminish 'paredit-mode " Par"))

(with-eval-after-load 'anzu (diminish 'anzu-mode))

(with-eval-after-load 'undo-tree (diminish 'undo-tree-mode))

(with-eval-after-load 'highlight-symbol (diminish 'highlight-symbol-mode))

(with-eval-after-load 'page-break-lines (diminish 'page-break-lines-mode))

(with-eval-after-load 'whole-line-or-region (diminish 'whole-line-or-region-mode))

(with-eval-after-load 'guide-key (diminish 'guide-key-mode))

(with-eval-after-load 'subword (diminish 'subword-mode))

(with-eval-after-load 'hideshow (diminish 'hs-minor-mode))

(with-eval-after-load 'git-gutter (diminish 'git-gutter-mode))

(with-eval-after-load 'whitespace-cleanup-mode (diminish 'whitespace-cleanup-mode))

(with-eval-after-load 'yasnippet (diminish 'yas-minor-mode))

(with-eval-after-load 'hungry-delete (diminish 'hungry-delete-mode))

;; (with-eval-after-load 'company (diminish 'company-mode))
(with-eval-after-load 'autorevert (diminish 'auto-revert-mode))

(with-eval-after-load 'highlight-parentheses (diminish 'highlight-parentheses-mode))

(with-eval-after-load 'eldoc (diminish 'eldoc-mode))

(with-eval-after-load 'flyspell (diminish 'flyspell-mode))

(with-eval-after-load 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))

(with-eval-after-load 'anaconda-mode (diminish 'anaconda-mode))

;; use spaceline now.
(with-eval-after-load 'flycheck (diminish 'flycheck-mode))

(provide 'init-diminish)
