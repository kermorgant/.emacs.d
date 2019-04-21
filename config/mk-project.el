;;; Commentary:
;;; Code:
(use-package projectile
  :defer t
  :config
  (projectile-mode)
  (setq projectile-project-search-path '("~/src/" "~/workspace/")
        projectile-completion-system 'ivy
        projectile-switch-project-action #'projectile-find-file-dwim
        projectile-enable-caching t))

(use-package counsel-projectile
  :defer t)

(use-package perspective
  :init (persp-mode)
  )

(use-package persp-projectile
  :after (perspective projectile)
  :init
  (require 'persp-projectile))

(use-package rg
  :defer t)

(provide 'mk-project)
;;; mk-project ends here
