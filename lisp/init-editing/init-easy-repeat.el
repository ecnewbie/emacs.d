(require-package 'easy-repeat)

(with-eval-after-load 'easy-repeat
  (setq easy-repeat-command-list
        (append easy-repeat-command-list
                '(forward-paragraph
                backward-paragraph))))

(require 'easy-repeat)
;; FIXME: It seems that easy-repeat-mode will cause "fill-paragraph: Wrong
;; type argument: numberp, nil" when call describe-mode.
(easy-repeat-mode)

(provide 'init-easy-repeat)
