;;; Code:
(defun mk/company-php ()
  "Add backends for php completion in company mode."
  (require 'company)
  (require 'company-phpactor)
  (set (make-local-variable 'company-backends) '(
                                                 company-phpactor
                                                 company-files
                                                 )))

(defun mk/php-smartparens ()
  "Smartparens settings for PHP."
  (sp-with-modes '(php-mode)
    ;; https://github.com/Fuco1/smartparens/wiki/Permissions#insertion-specification
    (sp-local-pair "{" nil :post-handlers '(:add ("||\n[i]" "RET")))
    (sp-local-pair "/**" "*/" :post-handlers '(:add (" [i]* ||\n[i]" "RET")))
    ))

(defun mk/phpactor ()
  "Phpactor tweaks."
  ;; (make-local-variable 'eldoc-documentation-function)
  ;; (setq eldoc-documentation-function 'phpactor-hover)
  (add-hook 'phpactor-after-update-file-hook
            (lambda () (save-buffer))))

(defun mk/phpactor-xref ()
  "Activates xref backend using phpactor."
  (make-local-variable 'xref-prompt-for-identifier)
  (setq xref-prompt-for-identifier nil)
  (add-hook 'xref-backend-functions #'phpactor-xref-backend nil t))

(defun mk/cs-fix-on-save ()
  "Run php-cs-fixer when saving a php buffer."
  (add-hook 'php-mode-hook
            (lambda () (add-hook 'before-save-hook #'php-cs-fixer--fix nil 'local))))

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

(use-feature mk-php
  ;; :after (magit)
  :commands (mk-php-menu)
  :config
  (defvar mk-php-menu)
  (define-transient-command mk-php-menu ()
    "Php"
    [["Class"
      ("cc" "Copy" phpactor-copy-class)
      ("cn" "New" phpactor-create-new-class)
      ("cr" "Move" phpactor-move-class)
      ("ci" "Inflect" phpactor-inflect-class)
      ("n"  "Namespace" phpactor-fix-namespace)]
     ["Properties"
      ("a"  "Accessor" phpactor-generate-accessors)
      ("pc" "Constructor" phpactor-complete-constructor)
      ("pm" "Add missing props" phpactor-complete-properties)
      ("C"  "Extract const" phpactor-extract-constant)
      ("r" "Rename var locally" phpactor-rename-variable-local)
      ("R" "Rename var in file" phpactor-rename-variable-file)]
     ["Methods"
      ("i" "Implement Contracts" phpactor-implement-contracts)
      ("m"  "Generate method" phpactor-generate-method)]
     ["Navigate"
      ("x" "List refs" xref-find-references)
      ("X" "Replace refs" phpactor-replace-references)
      ("."  "Goto def" phpactor-goto-definition)]
     ["Phpactor"
      ("s" "Status" phpactor-status)
      ("u" "Install" phpactor-install-or-update)]])
  )

(defun mk/legacy-style ()
  "Add specific legacy style and activate it."
  (php-set-style "legacy"))

(use-package php-mode
  :defer 1
  :after (general smart-jump smartparens);; php-cs-fixer)
  :mode ("\\.php\\'" . php-mode)
  :hook ((php-mode . mk/company-php)
         (php-mode . mk/phpactor)
         ;(php-mode . mk/phpactor-xref)
         (php-mode . hs-minor-mode)
         (php-mode . mk/cs-fix-on-save)
         (php-mode . mk/smartjump-php)
         ;(php-mode . php-enable-symfony2-coding-style)
         )
  :custom
  (flycheck-phpcs-standard "PSR2")

  :init
  (mk/php-smartparens)
  (add-to-list 'magic-mode-alist `(,(rx "<?php") . php-mode))

  :general
  (:keymaps 'php-mode-map :states 'normal
            "," 'mk-php-menu)
  (:keymaps 'php-mode-map :states '(insert normal)
            "M-." 'smart-jump-go)

  :config
  ;; (add-hook 'php-mode-hook
  ;;           (setq-local flycheck-php-phpstan-executable
  ;;                       (concat (php-project-get-root-dir) "/vendor/bin/phpstan"))
  ;;           (require 'flycheck-phpstan)
  ;;           (flycheck-mode t))
  )

(use-package phpactor
  :straight (phpactor
             :host github
             :type git
             :repo "emacs-php/phpactor.el"
             :branch "master"
             :files ("*.el" "composer.json" "composer.lock" (:exclude "*test.el"))
             )
  :custom (phpactor-use-native-json nil)
  )

;; (use-package company-phpactor ; :ensure nil
;;   :load-path "~/src/phpactor.el"
;;   )

(use-package php-cs-fixer
  :defer t
  :straight (php-cs-fixer :host github :type git :repo "kermorgant/php-cs-fixer.el" :branch "master")
  :commands php-cs-fixer--fix
  :config (setq php-cs-fixer--enable nil))

(use-package flycheck-phpstan
  :defer t
  :after (php-mode flycheck)
  :custom (phpstan-level 4)
  :config (setq phpstan-executable "~/bin/phpstan"))

(use-package geben
  :defer t
  :custom
  (geben-pause-at-entry-line nil)
  :general
  (:keymaps 'geben-mode-map :states 'normal :prefix "SPC d"
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
            "w" '(geben-display-window-function :wk "window")))

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
