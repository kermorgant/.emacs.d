
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package go-mode
  :custom
  (lsp-gopls-staticcheck t)
  (lsp-gopls-complete-unimported t)
  :hook ((go-mode) . lsp-go-install-save-hooks)
)

(provide 'mk-go)
;;; mk-go.el ends here
