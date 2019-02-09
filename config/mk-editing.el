
(use-package which-key)

(use-package highlight-indentation
  :hook
  ((yaml-mode . highlight-indentation-mode)
   (yaml-mode . highlight-indentation-current-column-mode)
   (docker-compose-mode . highlight-indentation-mode)
   (docker-compose-mode . highlight-indentation-current-column-mode)))

(use-package rainbow-mode
  :delight)

(use-package flycheck
  :init (global-flycheck-mode))

(use-package expand-region
  :commands er/expand-region)

(use-package wakatime-mode
  :init (global-wakatime-mode))

(use-package ace-window
  :init
  (setq aw-scope 'frame
        aw-ignore-on t
        aw-dispatch-when-more-than 3
        aw-keys '(?h ?j ?k ?l ?u ?i ?o ?p)
        aw-ignored-buffers '("*NeoTree*")))

(use-package smartparens
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (setq smartparens-strict-mode t)
    (smartparens-global-mode 1)))

(use-package wgrep)

(global-subword-mode 1)
(winner-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package dist-file-mode)

(provide 'mk-editing)
;;; mk-editing ends here
