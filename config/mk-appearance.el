(when (member "Source Code Pro" (font-family-list)) (set-frame-font "Source Code Pro" t t))

(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(show-paren-mode 1)
(save-place-mode t)

(when window-system
  (global-hl-line-mode))

(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))


(use-package doom-themes
  :config
  (load-theme 'doom-one t))

;; All The Icons
(use-package all-the-icons)


(use-package doom-modeline
  :defer t
  :hook (after-init . doom-modeline-init))

(provide 'mk-appearance)
;;; mk-appearance ends here
