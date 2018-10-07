(use-package lsp-mode
  :ensure t
  :defer t
  :config (progn
            ;; (add-hook 'vue-mode-hook 'lsp-mode)
            (set-face-attribute 'lsp-face-highlight-textual nil
                                :background "#666" :foreground "#ffffff"
                                )
            ))

(use-package lsp-ui
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
