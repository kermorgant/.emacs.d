
;;; Code:
(use-feature mk-search
  :commands (mk-search-menu my-grep)
  :config
  (transient-define-prefix mk-search-menu ()
    "Search"
    [["Project"
      ("a" "AG" projectile-ag)
      ("r" "AG" rg-project)
      ("g" "Grep" projectile-grep)
      ("o" "multi-occur" projectile-multi-occur)
      ]
     ["Buffer"
      ("s" "Swiper" swiper)
      ("e" "Iedit" evil-iedit-state/iedit-mode)
      ("*" "Symbol" symbol-overlay-put)
      ]
     ["folder"
      ("c" "Current" search-current-dir)
      ("d" "Choose" search-custom-dir)
      ]
     ]
    )
  (transient-define-prefix my-grep ()
    ["Matcher Selection"
     ("-E" "Extended RegExp" "--extended-regexp")
     ("-G" "Basic RegExp" "--basic-regexp")
     ("-P" "Perl RegExp" "--perl-regexp")
     ("-F" "Fixed Strings" "--fixed-strings")]
    ["Matching Control"
     ("-e" "Pattern" "--regexp=")
     ("-f" "Pattern from file" "--file=" my-grep:-f)
     ("-i" "Ignore case" "--ignore-case")
     ("-v" "Invert match" "--invert-match")
     ("-w" "Word regexp" "--word-regexp")
     ("-x" "Line regexp" "--line-regexp")]
    ["General Output Control"
     ("-c" "Display a count of matching lines" "--count")
     ("-o" "Display only match part" "--only-matching")]
    ["Output Line Prefix Control"
     ("-n" "Line number" "--line-number")]
    [("g" "grep" my-grep-do)])

  (transient-define-argument my-grep:-f ()
    :description "File"
    :class 'transient-files
    :argument "-f"
    :reader 'my-grep-read-file)

  (transient-define-suffix my-grep-do (file &rest args)
    (interactive (cons (read-file-name "File: ") (transient-args)))
    (grep (mapconcat #'identity (cons "grep" (cons file args)) " ")))
  )

(use-package rg
  :defer t
  :commands (rg-read-pattern rg-run)
  :config
  (rg-define-search search-current-dir
    "Search in current dir"
    :query ask
    ;; :format literal
    :files "everything"
    :dir current)
  (rg-define-search search-custom-dir
    "Search in current dir"
    :query ask
    ;; :format literal
    :files "everything"
    :dir ask)
  :custom
  (rg-custom-type-aliases
   '(("tmpl" .    "*.html.tmpl *.txt.tmpl *.sql.tmpl")
     ("bconf" .    "bconf.txt.*"))))

(use-package ag
  :defer 1)


(defun my-grep-read-file (&rest _)
  (expand-file-name (read-file-name "File: ")))

(provide 'mk-search)
;;; mk-search ends here
