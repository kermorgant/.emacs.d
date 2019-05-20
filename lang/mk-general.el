(use-package helpful
  :defer t
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)))

(use-package smart-jump
  :defer 1)

(add-to-list 'auto-mode-alist '("\\(/\\|\\`\\)bconf.txt" . conf-mode))

(provide 'mk-general)
;;; mk-general ends here
