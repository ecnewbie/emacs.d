;; C#
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

;; {{ groovy-mode
 (add-to-list 'auto-mode-alist '("\\.groovy\\'" . groovy-mode))
 (add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode))
;; }}

;; {{ crontab
(add-to-list 'auto-mode-alist '("crontab.*\\'" . crontab-mode))
;; }}

;; cmake
(setq auto-mode-alist (append '(("CMakeLists\\.txt\\'" . cmake-mode))
                              '(("\\.cmake\\'" . cmake-mode))
                              auto-mode-alist))

;; java
(add-to-list 'auto-mode-alist '("\\.aj\\'" . java-mode))

(add-to-list 'auto-mode-alist '("archive-contents\\'" . emacs-lisp-mode))
;; makefile
(add-to-list 'auto-mode-alist '("\\.ninja$" . makefile-gmake-mode))

;; gitignore
(require-package 'gitignore-mode)

(add-to-list 'auto-mode-alist '("Portfile\\'" . tcl-mode))

;;  conf
(add-to-list 'auto-mode-alist '("\\.[^b][^a][a-zA-Z]*rc$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.aspell\\.en\\.pws\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.meta\\'" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.ctags\\'" . conf-mode))

;; shell
(add-to-list 'auto-mode-alist '("\\.bash_profile\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bash_history\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.sh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bash\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc.local\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zshrc\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc\\'" . sh-mode))

;; bongo
(add-to-list 'auto-mode-alist
             '("\\.bongo-library$" . bongo-library-mode))
(add-to-list 'auto-mode-alist
             '("\\.bongo-playlist$" . bongo-playlist-mode))

;; ivy
(add-to-list 'auto-mode-alist '("\*ivy-occur.*\*$" . ivy-occur-grep-mode))

;; csv
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode" "Major mode for comma-separated value files." t)


;; edit confluence wiki
(autoload 'confluence-edit-mode "confluence-edit" "enable confluence-edit-mode" t)
(add-to-list 'auto-mode-alist '("\\.wiki\\'" . confluence-edit-mode))

;; vimrc
(autoload 'vimrc-mode "vimrc-mode")
(add-to-list 'auto-mode-alist '("\\.?vim\\(rc\\)?$" . vimrc-mode))

(add-to-list 'auto-mode-alist '("\\.yasnippet\\'" . snippet-mode))

;; conkerorrc
(add-to-list 'auto-mode-alist '("\\.conkerorrc\\'" . js-mode))

(provide 'init-modes)
