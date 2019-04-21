(use-package dockerfile-mode
  :defer t
  :mode (("Dockerfile" . dockerfile-mode)))

(use-package docker-compose-mode
  :defer t
  :mode (("docker-compose.yml" . docker-compose-mode))
  :init (flycheck-add-mode 'yaml-ruby 'docker-compose-mode))

(use-package groovy-mode
  :defer t
  :mode (("Jenkinsfile" . groovy-mode)))

(provide 'mk-docker)
