;;; Code:


(use-package org
  :mode ("\\.org\\'" . org-mode)
  :after ob-restclient

  :config
  (org-babel-do-load-languages
   'org-babel-load-languages '((C . t)(shell . t)(python . t)(jq . t)(restclient . t)))
  )

(use-package evil-org
  :defer t)

(use-package ob-restclient
     :defer t
     :after (restclient))

(setq org-capture-templates
      '(("t" "TIL" entry (file+headline "~/Documents/til.org" "Today I learnt")
         "* %?\n  %i\n  %a")
        ("j" "Journal" entry (file+olp+datetree "~/Documents/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ("i" "Ideas" entry (file+olp+datetree "~/Documents/ideas.org")
         "* %?\nEntered on %U\n  %i\n  %a")
        ))


(provide 'mk-org)
;;; mk-org ends here
