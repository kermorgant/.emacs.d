(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
  :after (which-key)
  :defer t
  :commands (lsp lsp-deferred)
  :custom
  (lsp-eldoc-render-all t)
  ;; (lsp-phpactor-path "/usr/local/bin/phpactor")
  ;; (lsp-intelephense-server-command "/home/mikael/.config/nvm/12.21.0/bin/intelephense --stdio")
  (lsp-intelephense-trace-server t)
  :hook (
         (php-mode . lsp-deferred)
         (go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         ;; (c-mode          ; clangd
         (js-mode . lsp-deferred)         ; ts-ls (tsserver wrapper)
         (js-jsx-mode . lsp-deferred)         ; ts-ls (tsserver wrapper)
         (typescript-mode . lsp-deferred)         ; ts-ls (tsserver wrapper)
         ;;  web-mode
         ;;  ) . lsp
         )
  :config
  (setq lsp-auto-guess-root t)
  ;; (setq lsp-diagnostic-package :none)             ; disable flycheck-lsp for most modes
  ;; (add-hook 'web-mode-hook #'lsp-flycheck-enable) ; enable flycheck-lsp for web-mode locally
  (setq lsp-enable-symbol-highlighting nil
        lsp-enable-on-type-formatting nil
        lsp-signature-auto-activate nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-enable-folding nil
        lsp-enable-imenu nil
        lsp-enable-snippet nil
        lsp-enable-completion-at-point nil
        lsp-enable-file-watchers nil
        read-process-output-max (* 1024 1024) ;; 1mb
        lsp-idle-delay 0.5
        ;; lsp-completion-provider :capf
        )
  ;; (setq lsp-prefer-capf t) ; prefer lsp's company-capf over company-lsp
  (add-to-list 'lsp-language-id-configuration '(js-jsx-mode . "javascriptreact"))
  )

(use-package lsp-ui
  :defer t
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-enable t
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
