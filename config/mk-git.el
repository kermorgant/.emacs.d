(defun my-truncate-lines ()
  (setq truncate-lines nil))

;; invalidate projectile cache upon some git events
;; see https://emacs.stackexchange.com/questions/26266/projectile-and-magit-branch-checkout
(defun run-projectile-invalidate-cache (&rest _args)
  (projectile-invalidate-cache nil))

(use-package magit
  :defer 1
  :after (transient)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (magit-completing-read-function 'ivy-completing-read)
  :init
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
  (add-hook 'magit-revision-mode-hook 'my-truncate-lines)
  (advice-add 'magit-checkout :after #'run-projectile-invalidate-cache)
  (advice-add 'magit-branch-and-checkout ; This is `b c'.
              :after #'run-projectile-invalidate-cache)
  :config
  (setq-default magit-diff-refine-hunk 'all)
  )

(evil-define-key 'normal magit-status-mode-map (kbd "p") 'winner-undo)

(with-eval-after-load 'magit-status
  (define-key magit-status-mode-map (kbd "p") nil))

(use-package magit-gitflow
  :after magit
  :defer t)

(use-package evil-magit
  :after magit
  :custom (evil-magit-want-horizontal-movement nil))

(use-package diff-hl                 ; Show changes in fringe
  :defer t
  :hook ((prog-mode          . diff-hl-mode)
         ;; (dired-mode         . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(use-package forge
  :defer t
  :after magit)

(use-package git-timemachine
  :defer t
  :config
  ;; @see https://bitbucket.org/lyro/evil/issue/511/let-certain-minor-modes-key-bindings
  (eval-after-load 'git-timemachine
    '(progn
       (evil-make-overriding-map git-timemachine-mode-map 'normal)
       ;; force update evil keymaps after git-timemachine-mode loaded
       (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps))))

(use-package gitconfig-mode
  :mode "\\.?gitconfig.?.*\\'")

(use-package gitignore-mode
  :mode "\\.?gitignore.?.*\\'")

(provide 'mk-git)
;;; mk-git ends here
