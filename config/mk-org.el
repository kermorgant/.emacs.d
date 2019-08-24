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

(provide 'mk-org)
;;; mk-org ends here
