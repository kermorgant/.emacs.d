(use-package yaml-mode
  :mode ((".yaml" . yaml-mode)
         (".yml" . yaml-mode))
  :init (setq yaml-indent-offset 4)
  )

(provide 'mk-yaml)
