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

(provide 'mk-appearance)
;;; mk-appearance ends here
