(use-package lsp-mode :defer t)

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable nil
        lsp-ui-doc-enable nil
        lsp-ui-flycheck-enable t
        lsp-ui-imenu-enable t)
  :custom
  (lsp-ui-peek-always-show t))

(use-package company-lsp
  :config (push 'company-lsp company-backends))

(provide 'mk-lsp)
