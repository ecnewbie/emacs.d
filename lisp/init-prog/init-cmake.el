(require-package 'cmake-mode)
(require-package 'cmake-ide)

(defvar newbie/system-header-cache nil)

(with-eval-after-load 'cmake-ide
  (when (executable-find "rdm")
    (require-package 'rtags)
    (require 'rtags))
  (setq cmake-ide-build-dir "build")
  (defadvice cmake-ide-set-compiler-flags
      (after newbie/append-system-include-path activate)
    (let ((sysroot nil))
      (dolist (flag flags)
        (when (string-match "--sysroot=.*" flag)
          (setq sysroot t)))
      (unless sysroot
        (setq sys-includes (append sys-includes (newbie/guess-c++-header-path)))
        (when (featurep 'company-c-headers)
          (setq company-c-headers-path-system sys-includes))))
    (setq newbie/system-header-cache sys-includes)
    (add-hook 'ff-pre-find-hook
              '(lambda ()(when newbie/system-header-cache
                 (dolist (path newbie/system-header-cache)
                   (add-to-list 'cc-search-directories path)))))))

(provide 'init-cmake)
