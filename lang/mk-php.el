(use-package php-mode
  :defer t
  :after (php-cs-fixer)
  :mode ("\\.php\\'" . php-mode)
  :hook
  ((php-mode . mk/company-php)
   (php-mode . php-enable-symfony2-coding-style))
  :init
  (setq flycheck-phpcs-standard "PSR2"
        geben-pause-at-entry-line nil)
  :config
  (add-hook 'php-mode-hook
            (lambda () (add-hook 'before-save-hook #'php-cs-fixer--fix nil 'local)))
  (add-hook 'php-mode-hook
            (sp-with-modes '(php-mode)
              ;; https://github.com/Fuco1/smartparens/wiki/Permissions#insertion-specification
              (sp-local-pair "{" nil :post-handlers '(:add ("||\n[i]" "RET")))
              (sp-local-pair "/**" "*/" :post-handlers '(:add ("||\n [i]" "RET"))))
            (evil-define-key '(insert normal) php-mode-map
              (kbd "M-.") 'phpactor-goto-definition
              (kbd "M-/") 'company-phpactor
              (kbd "s-,") 'phpactor-context-menu)

            (general-define-key
              :states 'normal
              :prefix "SPC d"
              :keymaps 'php-mode-map
              "b" '(geben-add-current-line-to-predefined-breakpoints :wk "add breakpoint")
              "c" '(geben-clear-predefined-breakpoints :wk "clear breakpoints")
              "d" '(geben :wk "start debugging")
              "q" '(geben-end :wk "quit debugging")
              "r" '(geben-run :wk "run")
              "x" '(geben-stop :wk "stop")
              "o" '(geben-step-over :wk "step over")
              "i" '(geben-step-into :wk "step into")
              "u" '(geben-step-out :wk "step out")
              "v" '(geben-display-context :wk "context")
              "w" '(geben-display-window-function :wk "window"))

            (general-define-key
              :states 'normal
              :prefix ","
              :keymaps 'php-mode-map
              "sc" '(phpactor-move-class :wk "rename class")
              ;; "sv" '(phpactor-move-class :wk "rename variable")
              "cc" '(phpactor-complete-constructor :wk "complete constructor"))

            (require 'flycheck-phpstan)
            (flycheck-mode t)
            (flycheck-select-checker 'phpstan)))

;; (use-package composer :ensure nil
;;   :load-path "~/src/composer.el")

(use-package phpactor
  :load-path "~/src/phpactor.el")

(use-package company-phpactor :ensure nil
  :load-path "~/src/phpactor.el")

(use-package php-cs-fixer :ensure nil
  :load-path "~/src/php-cs-fixer.el"
  :config (setq php-cs-fixer--executable "~/.config/composer/vendor/bin/php-cs-fixer"))


(use-package flycheck-phpstan
  :after (php-mode flycheck)
  :config (setq phpstan-executable "~/bin/phpstan"))

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
