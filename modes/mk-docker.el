(use-package dockerfile-mode
  :mode (("Dockerfile" . dockerfile-mode)))

(use-package docker-compose-mode
  :mode (("docker-compose.yml" . docker-compose-mode))
  :init (flycheck-add-mode 'yaml-ruby 'docker-compose-mode))

(use-package groovy-mode
  :mode (("Jenkinsfile" . groovy-mode)))

(provide 'mk-docker)
