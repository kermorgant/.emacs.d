;;; mk-tools --- some independent tools

(use-package polymode
  :defer t)

(use-package wsd-mode
  :defer 2)

(use-package jq-mode
  :defer 2)

(use-package string-inflection
  :defer t)

(use-package crontab-mode
  :defer t)

(use-package systemd-mode
  :defer t
  :straight (
             systemd-mode
             :host github
             :type git
             :repo "holomorph/systemd-mode"
             :files( "*.el" "*.txt"))
  )

(provide 'mk-tools)
;;; mk-tools ends here
