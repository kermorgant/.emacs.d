
(defun mk/company-php ()
  "Add backends for php completion in company mode."
  (require 'company)
  (require 'company-phpactor)
  (set (make-local-variable 'company-backends) '(company-phpactor company-files)))

(use-package php-mode
  :defer 1
  :after (php-cs-fixer smart-jump smartparens)
  :mode ("\\.php\\'" . php-mode)
  :hook ((php-mode . mk/company-php)
         ;; (php-mode . mk/smartjump-php)
         (php-mode . php-enable-symfony2-coding-style))
  :init
  (add-to-list 'magic-mode-alist `(,(rx "<?php") . php-mode))
  (setq flycheck-phpcs-standard "PSR2"
        geben-pause-at-entry-line nil)
  :general
  (:keymaps 'php-mode-map :states 'normal :prefix ","
            "m" '(phpactor-context-menu :wk "context menu")
            ;; "cc" '(phpactor-copy-class :wk "class copy")
            "cn" '(phpactor-create-new-class :wk "class new")
            "ci" '(phpactor-inflect-class :wk "class inflect")
            "cr" '(phpactor-move-class :wk "class rename")
            "ec" '(phpactor-extract-constant :wk "extract constant")
            "f"  '(phpactor-fix-namespace :wk "fix namespace")
            "ga" '(phpactor-generate-accessors :wk "generate accessor")
            "gc" '(phpactor-complete-constructor :wk "constructor complete")
            "gm" '(phpactor-generate-method :wk "generate method"))
  (:keymaps 'php-mode-map :states '(insert normal)
            "M-/" 'company-phpactor
            "M-." 'smart-jump-go)
  (:keymaps 'php-mode-map :states 'normal :prefix "SPC d"
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
  :config
  (add-hook 'php-mode-hook
            (lambda () (add-hook 'before-save-hook #'php-cs-fixer--fix nil 'local)))
  (add-hook 'php-mode-hook
            (lambda ()
              (make-local-variable 'eldoc-documentation-function)
              (setq eldoc-documentation-function
                    'phpactor-hover)))
  (add-hook 'phpactor-after-update-file-hook
            (lambda () (save-buffer)))
  (add-hook 'php-mode-hook
            (sp-with-modes '(php-mode)
              ;;TODO  https://github.com/Fuco1/.emacs.d/commit/9f24b9ceb03b2ef2fbd40ac6c5f4bd39c0719f80
              ;; https://github.com/Fuco1/smartparens/wiki/Permissions#insertion-specification
              (sp-local-pair "{" nil :post-handlers '(:add ("||\n[i]" "RET")))
              ;; (sp-local-pair "/**" "*/" :post-handlers '(:add ("||\n [i]" "RET")))
              (sp-local-pair "/**" "*/" :post-handlers '(:add (" [i]* ||\n[i]" "RET")))
              )

            ;; TODO compare with https://github.com/Fuco1/.emacs.d/commit/a4c83a10a959e3ce1d572cc48429d41632b5768e
            (require 'flycheck-phpstan)
            (flycheck-mode t))
  )

;; (use-package composer :ensure nil
;;   :load-path "~/src/composer.el")

(use-package phpactor
  :load-path "~/src/phpactor.el"
  )

(use-package company-phpactor ; :ensure nil
  :load-path "~/src/phpactor.el"
  )

(use-package php-cs-fixer :ensure nil
  :defer t
  :commands php-cs-fixer--fix
  :load-path "~/src/php-cs-fixer.el"
  :config (setq php-cs-fixer--enable nil))

(use-package flycheck-phpstan
  :defer t
  :after (php-mode flycheck)
  :config (setq phpstan-executable "~/bin/phpstan"))

(defvar smart-jump-phpactor-current-point nil "The current point.")

(defun smart-jump-phpactor-available-p ()
  "Return whether or not `phpmode' is available."
  (bound-and-true-p php-mode))

(defun smart-jump-phpactor-save-state ()
  "Save some state for `smart-jump'."
  (setq smart-jump-phpactor-current-point (point)))

(defun smart-jump-phpactor-find-references-succeeded-p ()
  "Return whether or not `phpactor-find-references' succeeded."
  (cond
   ((not (eq smart-jump-phpactor-current-point (point)))
    :succeeded)
   ((and (get-buffer "*Phpactor references*")
         (get-buffer-window (get-buffer "*Phpactor references*")))
    :succeeded)
   (:default nil)))

(defun mk/smartjump-php ()
  "Registers smartjump function for php."
  (smart-jump-register :modes '(php-mode yaml-mode)
                       :jump-fn 'phpactor-goto-definition
                       ;; :pop-fn 'ggtags-prev-mark
                       :refs-fn 'phpactor-find-references
                       ;; :before-jump-fn #'smart-jump-phpactor-save-state
                       ;; :should-jump #'smart-jump-phpactor-available-p
                       :should-jump t
                       :heuristic 'point
                       ;; :refs-heuristic #'smart-jump-phpactor-find-references-succeeded-p
                       :async nil
                       :order 1))

;; (use-package lsp-php :ensure nil
;;   :load-path "~/src/lsp-php"
;;   :demand
;;   :config
;;   (setq lsp-php-show-file-parse-notifications t)
;;   (setq extra-init-params '(:index 2))
;;   (setq lsp-php-language-server-command '(
;;                                           "php"
;;                                           "/home/mikael/src/phpactor.el/vendor/bin/phpactor"
;;                                           "server:start"
;;                                           "--stdio"
;;                                           "-vvv"
;;                                           ))
;;   (setq lsp-php-workspace-root-detectors '(lsp-php-root-projectile lsp-php-root-composer-json "index.php" "robots.txt")))

(use-package geben
  :defer t)

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
