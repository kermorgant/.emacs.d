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
  :init (persp-mode))

(use-package persp-projectile
  :after (perspective projectile)
  :init
  (require 'persp-projectile))

(use-package rg
  :defer t)

(use-package org-projectile
  :defer t
  :after (projectile)
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (progn
    (org-projectile-per-project)
    (setq org-projectile-projects-file "todo.org")
    ;; (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
    (push (org-projectile-project-todo-entry) org-capture-templates)))

(provide 'mk-project)
;;; mk-project ends here
