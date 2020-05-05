(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
   :hook (
         (go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  )

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package lsp-ui
  :defer t
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-imenu-enable t)
  :custom
  (lsp-ui-peek-always-show t))

(use-package lsp-ivy
  :defer t
  :commands lsp-ivy-workspace-symbol)

(use-package company-lsp
  :defer t
  :config (push 'company-lsp company-backends))

(provide 'mk-lsp)
