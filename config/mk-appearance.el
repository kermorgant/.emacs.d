(when (member "Source Code Pro" (font-family-list)) (set-frame-font "Source Code Pro-10" t t))

;(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(show-paren-mode 1)
(save-place-mode t)
(toggle-scroll-bar -1)
(setq split-height-threshold nil)
(setq split-width-threshold 120)

(when window-system
  (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (global-hl-line-mode))

(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(use-package doom-themes
  :config
  (load-theme 'doom-one t)
  ;; (load-theme 'doom-material t)
  ;; (load-theme 'doom-solarized-light t)
  ;; (load-theme 'doom-one-light t)
  ;; (load-theme 'doom-tomorrow-day t)
  )

;; All The Icons
(use-package all-the-icons
  :defer t)

(use-package doom-modeline
  :defer t
  :hook (after-init . doom-modeline-mode))

(use-package default-text-scale
  :defer t
  :init (default-text-scale-mode 1))

(provide 'mk-appearance)
;;; mk-appearance ends here
