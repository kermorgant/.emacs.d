;; load evil

;;; Code:
(use-package evil
  :init ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search
        evil-ex-complete-emacs-commands nil
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-shift-round nil
        evil-want-C-u-scroll t
        evil-want-integration t
        evil-want-keybinding nil
        evil-undo-system 'undo-fu)
  :config ;; tweak evil after loading it
  (evil-mode)
  (evil-define-text-object evil-inner-buffer (count &optional beg end type)
    (list (point-min) (point-max)))

  ;; example how to map a command in normal mode (called 'normal state' in evil)
  (define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit)

  ;; https://demonastery.org/2013/04/emacs-evil-narrow-region/
  (evil-define-operator evil-narrow-indirect (beg end type)
    "Indirectly narrow the region from BEG to END."
    (interactive "<R>")
    (evil-normal-state)
    (mk/narrow-to-region-indirect beg end))
  )

(use-package evil-collection
  :after (evil)
  :config
  (evil-collection-init))

(use-package evil-surround
  :defer 3
  :config
  (global-evil-surround-mode))

(use-package evil-nerd-commenter
  :commands evilnc-comment-operator
  :init
  (progn
    (defun mk/comment-or-uncomment-lines (&optional arg)
      (interactive "p")
      (let ((evilnc-invert-comment-line-by-line nil))
        (evilnc-comment-or-uncomment-lines arg)))))

(use-package evil-iedit-state
  :config (setq iedit-toggle-key-default nil))

(use-package evil-smartparens
  :after smartparens
  :init
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

(use-package evil-owl
  :defer t
  :straight (evil-owl :host github :type git :repo "mamapanda/evil-owl"))

(provide 'mk-evil)
;;; mk-evil ends here
