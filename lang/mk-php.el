(use-package php-mode
  :defer t
  :mode ("\\.php\\'" . php-mode)
  :hook
  ((php-mode . mk/company-php)
   (php-mode . php-enable-symfony2-coding-style))
  :init
  (setq flycheck-phpcs-standard "PSR2")
  :config
  (add-hook 'php-mode-hook
            (sp-with-modes '(php-mode)
              ;; https://github.com/Fuco1/smartparens/wiki/Permissions#insertion-specification
              (sp-local-pair "{" nil :post-handlers '(:add ("||\n[i]" "RET")))
              (sp-local-pair "/**" "*/" :post-handlers '(:add ("||\n [i]" "RET"))))
            (evil-define-key '(insert normal) php-mode-map
              (kbd "M-.") 'phpactor-goto-definition
              (kbd "M-/") 'company-phpactor
              (kbd "s-,") 'phpactor-context-menu)
            (require 'flycheck-phpstan)
            (flycheck-mode t)
            (flycheck-select-checker 'phpstan)))

(use-package phpactor :ensure nil
  :load-path "~/src/phpactor.el")

(use-package company-phpactor :ensure nil
  :load-path "~/src/phpactor.el")

(use-package flycheck-phpstan
  :config
  (setq phpstan-executable "~/bin/phpstan"))

(defun mk/company-php ()
  "Add backends for php completion in company mode"
  (interactive)
  (require 'company)
  (set (make-local-variable 'company-backends)
       '(;; list of backends
         company-phpactor
         company-files
         ;; company-keywords       ; keywords
         ;;company-dabbrev-code   ; code words
         ;; company-lsp            ; lsp completion
         ;;company-capf
         )))

(use-package geben)

;; (defun counsel-phpactor (&optional initial-input)
;;   "Call the \"locate\" shell command.
;; INITIAL-INPUT can be given as the initial minibuffer input."
;;   (interactive)
;;   (ivy-read "class: " #'phpactor-class-search
;;             :initial-input initial-input
;;             :dynamic-collection t
;;             ;; :history 'counsel-locate-history
;;             :action (lambda (candidate)
;;                       (message candidate))
;;             ;; :unwind #'counsel-delete-process
;;             ;; :caller 'counsel-locate
;;             ))

(provide 'mk-php)
;;; mk-php ends here
