(use-package magit
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
  :config (setq magit-completing-read-function 'ivy-completing-read))

(use-package magit-gitflow)

(use-package magit-todos
  :after magit
  :init
  (setq magit-todos-require-colon nil)
  (magit-todos-mode t)
  :config
  (with-eval-after-load 'magit-todos (require 'evil-collection-magit-todos))
  )

(use-package evil-magit
  :after magit
  :init (setq evil-magit-want-horizontal-movement nil))

(use-package diff-hl                 ; Show changes in fringe
  :ensure t
  :hook ((prog-mode          . diff-hl-mode)
         ;; (dired-mode         . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(use-package git-timemachine)

;; invalidate projectile cache upon some git events
;; see https://emacs.stackexchange.com/questions/26266/projectile-and-magit-branch-checkout
(defun run-projectile-invalidate-cache (&rest _args)
  (projectile-invalidate-cache nil))

(advice-add 'magit-checkout
            :after #'run-projectile-invalidate-cache)
(advice-add 'magit-branch-and-checkout ; This is `b c'.
            :after #'run-projectile-invalidate-cache)

(provide 'mk-git)
;;; mk-git ends here
