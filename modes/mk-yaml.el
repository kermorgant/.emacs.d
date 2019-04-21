(use-package yaml-mode
  :defer t
  :mode ((".yaml" . yaml-mode)
         (".yml" . yaml-mode))
  :init (setq yaml-indent-offset 4)
  )

(provide 'mk-yaml)
