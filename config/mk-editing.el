(global-subword-mode 1)
(winner-mode 1)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

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
  :init (global-flycheck-mode))

(use-package expand-region
  :defer t
  :commands er/expand-region)

(use-package wakatime-mode
  :defer 3
  :init
  (if (file-exists-p "~/.wakatime.cfg")
      (global-wakatime-mode)))

(use-package ace-window
  :defer t
  :init
  (setq aw-scope 'frame
	aw-ignore-on t
	aw-dispatch-when-more-than 3
	aw-keys '(?h ?j ?k ?l ?u ?i ?o ?p)
	aw-ignored-buffers '("*NeoTree*")))

(use-package smartparens
  ;; :defer 1
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (setq smartparens-strict-mode t)
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
  :commands smart-jump-register
  :config
  (smart-jump-setup-default-registers))

(recentf-mode 1)
(setq recentf-max-menu-items 25
      recentf-max-saved-items 25)


(use-package beacon
  :defer 1
  :init (beacon-mode 1))

;; Whitespace butler - clean up whitespace
(use-package ws-butler
  :config
  (ws-butler-global-mode t))

(provide 'mk-editing)
;;; mk-editing ends here
