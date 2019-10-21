;;; Commentary:
;;; Code:

(use-feature mk-project
  :commands (mk-projectile-cache mk-projectile)
  :config
  (define-transient-command mk-projectile-cache ()
    "Cache"
    [["Cache"
      ("c" "Invalidate" projectile-invalidate-cache)
      ("d" "Remove Known Project" projectile-remove-known-project)
      ("k" "Cache Current File" projectile-cache-current-file)
      ("s" "Cleanup Known Projects" projectile-cleanup-known-projects)]])

  (define-transient-command mk-projectile ()
    "Projectile"
    [["Find"
      ("f" "File" projectile-find-file)
      ("F" "File Other Window" projectile-find-file-other-window)
      ("l" "File DWIM" projectile-find-file-dwim)
      ("L" "File DWIM Other Window" projectile-find-file-dwim-other-window)
      ("o" "Other File" projectile-find-other-file)
      ("O" "Other file Other Window" projectile-find-other-file-other-window)
      ("e" "Recent File" projectile-recentf)
      ("u" "Test File" projectile-find-test-file)]
     ["Search"
      ("a" "AG" projectile-ag)
      ("r" "RG" rg-project)
      ("A" "Grep" projectile-grep)
      ("s" "Multi Occur" projectile-multi-occur)
      ("t" "Find Tag" projectile-find-tag)
      ("T" "Regenerate Tags" projectile-regenerate-tags)]

     ["Actions"
      ("R" "Replace Regexp" projectile-replace-regexp)
      ("S" "Replace" projectile-replace)
      ;; ("U" "Run Tests" projectile-test-project)
      ;; ("m" "Compile Project" projectile-compile-project)
      ("c" "Run Async Shell Command" projectile-run-async-shell-command-in-root)
      ("C" "Run Command" projectile-run-command-in-root)]]
    [["Buffers & Directories"
      ("b" "Buffer" counsel-projectile-switch-to-buffer)
      ("B" "Buffer Other Window" projectile-switch-to-buffer-other-window)
      ("d" "Directory" projectile-find-dir)
      ("D" "Directory Other Window" projectile-find-dir-other-window)]
     ["Manage"
      ("p" "Switch Project" projectile-persp-switch-project)
      ("I" "Project Info" projectile-project-info)
      ("K" "Kill Project Buffers" projectile-kill-buffers)
      ("k" "Cache..." mk-projectile-cache)]
     ["Modes"
      ("h" "Dired" projectile-dired)
      ("i" "IBuffer" projectile-ibuffer)]])
  )

(use-package projectile
  :config
  (projectile-mode)
  :custom
  (projectile-project-search-path '("~/src/" "~/workspace/"))
  (projectile-completion-system 'ivy)
  (projectile-switch-project-action #'projectile-find-file-dwim)
  (projectile-enable-caching t))

(use-package counsel-projectile
  :defer t)

(use-package perspective)

(use-package persp-projectile
  :after (perspective)
  :init
  (require 'persp-projectile)
  (persp-mode))

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

(use-package doom-todo-ivy
  :straight (doom-todo-ivy :host github :type git :repo "jsmestad/doom-todo-ivy" :branch "master")
  :defer t
  :config (map-put doom/ivy-task-tags '"@todo" "warning"))

(provide 'mk-project)
;;; mk-project ends here
