(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
  :defer t
  :commands (lsp lsp-deferred)
  :custom
  (lsp-eldoc-render-all t)
  (lsp-phpactor-path "/usr/local/bin/phpactor")
  ;; (lsp-intelephense-server-command "intelephense --stdio")
  ;; (lsp-intelephense-trace-server t)
  :hook (
         (php-mode . lsp)
         (go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  )

(use-package lsp-ui
  :defer t
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable nil
        lsp-ui-peek-enable t
        lsp-ui-doc-enable t
        lsp-ui-imenu-enable t
        lsp-ui-flycheck-enable t
        lsp-ui-imenu-enable t)
  :custom
  (lsp-ui-peek-always-show t))

(use-package lsp-ivy
  :defer t
  :commands lsp-ivy-workspace-symbol)

(use-package company-lsp
  :disabled
  :config (push 'company-lsp company-backends))

(provide 'mk-lsp)
