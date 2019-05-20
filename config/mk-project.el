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
  :defer t
  :init
  (setq rg-custom-type-aliases
        '(("tmpl" .    "*.html.tmpl *.txt.tmpl") )))

(defvar mk:created-property-string "
  :PROPERTIES:
  :CREATED: %U
  :END:")

(use-package org-projectile
  :defer 1
  :after (projectile)
  :bind (("C-c n p" . org-projectile-project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (progn
    ;; (org-projectile-per-project)
    (setq org-projectile-projects-file "~/projects.org"
          org-projectile-capture-template
          (format "%s%s"
                  "* TODO [[file://%F::%(with-current-buffer (org-capture-get :original-file-nondirectory) (number-to-string (line-number-at-pos)))][%^{Link Text}]]\n"
                  mk:created-property-string))
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-character "l"
                  :capture-heading "Linked Project TODO"))
    (add-to-list 'org-capture-templates
                 (org-projectile-project-todo-entry
                  :capture-template (format "%s%s" "* TODO %?" mk:created-property-string)
                  :capture-character "p"))
    ))

(defun my-linked-capture-for-current-project ()
  (interactive)
  (org-projectile-capture-for-current-project
   :capture-template "put your capture template here"))


(use-package eyebrowse                  ; Easy workspaces creation and switching
  :ensure nil
  :defer t
  :config
  (setq eyebrowse-mode-line-separator " "
        eyebrowse-new-workspace t)
  (eyebrowse-mode t))

;; NeoTree
(use-package neotree
  :defer t
  :config
  (with-eval-after-load 'neotree (require 'evil-collection-neotree))
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter))

(provide 'mk-project)
;;; mk-project ends here
