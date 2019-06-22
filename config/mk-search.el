;;; Code:

;; this is a hacky solution to define mk-search-menu after transient is loaded
;; using use-package :defer + :after options
(use-package mk-search
  :ensure nil
  :after transient
  :config
  (define-transient-command mk-search-menu ()
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
      ]
     ["folder"
      ("c" "Current" search-current-dir)
      ("d" "Choose" search-custom-dir)
      ]
     ]
    )
  )

(use-package rg
  :defer t
  :ensure-system-package rg
  :init
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
   '(("tmpl" .    "*.html.tmpl *.txt.tmpl") )))

(use-package ag
  :defer 1)

(provide 'mk-search)
;;; mk-search ends here
