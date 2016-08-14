(require-package 'counsel)
(require-package 'ivy-hydra)

(with-eval-after-load 'swiper
  (require-package 'avy)
  (require 'avy)
  (define-key swiper-map (kbd "C-;") 'swiper-avy)
  (define-key swiper-map (kbd "C->") 'swiper-mc))

(defun newbie/swiper-the-thing ()
  (interactive)
  (swiper (if (region-active-p)
              (progn
                (deactivate-mark)
                (buffer-substring-no-properties (region-beginning) (region-end)))
            nil)))

(provide 'init-swiper)
