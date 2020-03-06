
;;; Code:
(global-subword-mode 1)
(winner-mode 1)
(global-linum-mode)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

(recentf-mode 1)
(setq recentf-max-menu-items 100
      recentf-max-saved-items 100)

(use-package which-key
  :defer t)

(use-package highlight-indentation
  :defer t
  :hook
  ((yaml-mode . highlight-indentation-mode)
   (yaml-mode . highlight-indentation-current-column-mode)
   (docker-compose-mode . highlight-indentation-mode)
   (docker-compose-mode . highlight-indentation-current-column-mode)))

(use-package rainbow-mode
  :defer t
  :delight)

(use-package flycheck
  :defer t
  :custom
  (flycheck-checker-error-threshold 1000)
  :init (global-flycheck-mode))

(use-package expand-region
  :defer t
  :commands er/expand-region)

(when (file-exists-p "~/.wakatime.cfg")
  (use-package wakatime-mode
    :defer 3
    :init (global-wakatime-mode)))

(use-package ace-window
  :defer t
  :init
  (bind-key* "M-p" 'ace-window)
  (global-set-key (kbd "M-p") 'ace-window)
  :custom
  (aw-scope 'frame)
  (aw-ignore-on t)
  (aw-dispatch-when-more-than 3)
  (aw-keys '(?h ?j ?k ?l ?u ?i ?o ?p))
  (aw-ignored-buffers '("*NeoTree*")))

(use-package smartparens
  ;; :defer 1
  :diminish smartparens-mode
  :config
  (progn
    (setq smartparens-strict-mode t)
    ;; (setq sp-ignore-modes-list
    ;;       (delete 'minibuffer-inactive-mode sp-ignore-modes-list))
    (require 'smartparens-config)
    (smartparens-global-mode 1)))

(use-package wgrep
  :defer t)

(use-package symbol-overlay
  :defer t
  :general
  (:keymaps 'symbol-overlay-mode-map
            "r" 'symbol-overlay-rename))

(use-package dist-file-mode
  :defer t)

(use-package json-mode
  :defer t)

(use-package smart-jump
  :defer t
  :commands (smart-jump-register smart-jump-go)
  :config
  (smart-jump-setup-default-registers))

(use-package dumb-jump
  :custom
  (dumb-jump-selector 'ivy)
  (dumb-jump-aggressive nil))

(use-package beacon
  :defer 1
  :init (beacon-mode 1))

(use-package editorconfig
  ;; :defer t
  :config
  (editorconfig-mode 1)
  :custom
  (editorconfig-trim-whitespaces-mode 'ws-butler-mode)
  (editorconfig-exclude-modes '(fundamental-mode))
  :init
  (add-hook 'editorconfig-after-apply-functions
            (lambda (props) (setq web-mode-block-padding 0)))
  )

;; Whitespace butler - clean up whitespace
(use-package ws-butler
  :config
  (ws-butler-global-mode t))

(provide 'mk-editing)
;;; mk-editing ends here
