(require-package 'anaconda-mode)
(require-package 'company-anaconda)
(require-package 'flycheck-pyflakes)

(defun newbie/python-setup()
  (anaconda-mode t)
  (anaconda-eldoc-mode t))

(add-hook 'python-mode-hook 'newbie/python-setup)

(with-eval-after-load 'anaconda-mode
  ;; shell: pip install autoflake
  (require 'flycheck-pyflakes)
  (when (featurep 'company)
    (add-to-list 'company-backends 'company-anaconda)))


;; pylookup
;; load pylookup when compile time
(eval-when-compile (require 'pylookup))
(with-eval-after-load 'pylookup
  (let ((pylookup-dir
         (file-name-directory (locate-library "pylookup"))))

    ;; set executable file and db file
    (setq pylookup-program (concat pylookup-dir "/pylookup.py"))
    (setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))

    ;; set search option if you want
    ;; (setq pylookup-search-options '("--insensitive" "0" "--desc" "0"))
    ))

;; to speedup, just load it on demand
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup"
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

(provide 'init-python)
