(require-package 'zenburn-theme)

(defun zenburn-setup ()
  "Activate another dark color theme."
  (interactive)

  (load-theme 'zenburn t)
  (custom-theme-set-faces
   'zenburn
   `(show-paren-match ((t (:underline "Springgreen3" :foreground "Springgreen3" :weight bold))))
   `(ace-jump-face-foreground
     ((t (:foreground "red" )))))

  ;; dired-k bold is annoying
  (with-eval-after-load 'dired-k
    (setq dired-k-size-colors
          '((0 . "#DC8CC3")           ; zenburn-magenta
            (5120 . "#7F9F7F")        ; zenburn-green
            (40960 . "#F0DFAF")       ; zenburn-yellow
            (102400 . "#DFAF8F")      ; zenburn-orange
            (10485760 . "#CC9393")))  ; zenburn-red

    (setq dired-k-date-colors
          '((3600 . "#DC8CC3")        ; zenburn-magenta
            (604800 . "#CC9393")      ; zenburn-red
            (5184000 . "#8C5353")     ; zenburn-red-4
            (26899200 . "grey50"))))

  (with-eval-after-load 'highlight-parentheses
    (setq hl-paren-colors '("Springgreen3" "IndianRed1" "IndianRed3" "IndianRed4")))

  (zenburn-with-color-variables
  ;; set color for company clang insert args..
  (custom-theme-set-faces
   'zenburn
   ;; default
   `(fringe ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
   ;; linum-relative
   `(linum-relative-current-face ((t (:foreground "#CAE682" :background ,zenburn-bg :weight bold))))
   `(company-template-field
     ((t (:foreground nil :background ,zenburn-bg-1))))
   ;; dired
   `(diredp-dir-name ((t (:foreground ,zenburn-blue))))
   `(diredp-file-name ((t (:foreground ,zenburn-fg))))
   ;; dired-k
   `(dired-k-directory ((t (:foreground ,zenburn-blue))))
   `(dired-k-ignored ((t (:foreground nil))))
   `(dired-k-untracked ((t (:foreground ,zenburn-red))))
   `(dired-k-added ((t (:foreground ,zenburn-green))))
   `(dired-k-modified ((t (:foreground ,zenburn-orange))))
   `(dired-k-commited ((t (:foreground nil))))
   ;; wgrep
   `(wgrep-face ((t (:background ,zenburn-bg-1 :foreground ,zenburn-yellow))))
   `(wgrep-delete-face ((t (:background ,zenburn-bg-1 :foreground ,zenburn-red-2))))
   `(wgrep-file-face ((t (:background ,zenburn-bg-1 :foreground ,zenburn-yellow-2))))
   `(wgrep-reject-face ((t (:foreground ,zenburn-red))))
   `(wgrep-done-face ((t (:foreground ,zenburn-green))))
   ;; modeline-posn
   `(modelinepos-column-warning ((t (:foreground ,zenburn-red))))
   `(persp-selected-face ((t (:foreground ,zenburn-blue))))
   ;; spaceline
   `(spaceline-highlight-face ((t (:background ,zenburn-blue-5 :foreground "#3E3D31" :inherit 'mode-line))))
   ;; rtags
   `(rtags-argument-face ((t (:background ,zenburn-blue-5))))
   ;;;FIXME: pangu-spacing
   `(pangu-spacing-separator-face ((t (:inherit 'default))))
   )))


(add-hook 'after-init-hook 'zenburn-setup)

(with-eval-after-load 'helm
  ;; set color for helm's "->".
  (set-face-attribute 'helm-header-line-left-margin nil
                      :background nil
                      :foreground (face-attribute 'font-lock-type-face :foreground)))

;; this is default now.
;; ;;; make company popup beautiful.
;; (when (window-system)
;;   (require 'color)
;;   (let ((bg (face-attribute 'default :background)))
;;     (custom-set-faces
;;      `(company-tooltip ((t (:inherit default :background ,(color-lighten-name bg 2)))))
;;      `(company-scrollbar-bg ((t (:background ,(color-lighten-name bg 10)))))
;;      `(company-scrollbar-fg ((t (:background ,(color-lighten-name bg 5)))))
;;      `(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
;;      `(company-tooltip-common ((t (:inherit font-lock-constant-face)))))))

(provide 'init-themes)
