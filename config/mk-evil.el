;; load evil
(use-package evil
  :init ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search
        evil-ex-complete-emacs-commands nil
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-shift-round nil
        evil-want-C-u-scroll t
        evil-want-integration nil)
  :config ;; tweak evil after loading it
  (evil-mode)
  (evil-define-text-object evil-inner-buffer (count &optional beg end type)
    (list (point-min) (point-max)))

  ;; example how to map a command in normal mode (called 'normal state' in evil)
  (define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package evil-surround
  :config
  (global-evil-surround-mode))

(use-package evil-nerd-commenter
  :commands evilnc-comment-operator
  :init
  (progn
    (defun mk/comment-or-uncomment-lines (&optional arg)
      (interactive "p")
      (let ((evilnc-invert-comment-line-by-line nil))
        (evilnc-comment-or-uncomment-lines arg)))
    ))

(use-package evil-iedit-state
  :config (setq iedit-toggle-key-default nil))

(use-package evil-smartparens
  :after smartparens
  :init
  (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))

(provide 'mk-evil)
;;; mk-evil ends here
