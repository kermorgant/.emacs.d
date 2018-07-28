(use-package php-mode
  :defer t
  :mode ("\\.php\\'" . php-mode)
  :hook
  ((php-mode . mk/company-php))
  :init
  (setq flycheck-phpcs-standard "PSR2")
        ;; php-mode-coding-style "PSR-2")
  :config
  (add-hook 'php-mode-hook
            (evil-define-key '(insert normal) php-mode-map
              (kbd "M-.") 'phpactor-goto-definition
              (kbd "M-/") 'company-phpactor)
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
  (setq company-backends
        '((;; list of backends
           company-phpactor
           company-files          ; files & directory
           ;;company-yasnippet      ; snippets
           ;; company-keywords       ; keywords
           ;;company-dabbrev-code   ; code words
           ;; company-ycmd           ; python ycmd completion
           ;; company-lsp            ; python lsp completion
           ;;company-anaconda       ; python anaconda completion
           ;;company-capf
           ))))

(defun php-class-copy ()
  "Copy a class using phpactor"
  (interactive)
  (setq targetpath (read-file-name "Enter new file name:"))
  (let ((default-directory (projectile-project-root)))
    (start-process "phpactor"
                   (get-buffer-create "*phpactor*")
                   "phpactor"
                   "class:copy"
                   (buffer-file-name (window-buffer (minibuffer-selected-window)))
                   targetpath)))

(defun php-class-move ()
  "Rename a class using phpactor"
  (interactive)
  (setq targetpath (read-file-name "Enter new file name:"))
  (let ((default-directory (projectile-project-root)))
    (start-process "phpactor"
                   (get-buffer-create "*phpactor*")
                   "phpactor"
                   "class:move"
                   (buffer-file-name (window-buffer (minibuffer-selected-window)))
                   targetpath)))

(defun counsel-phpactor (&optional initial-input)
  "Call the \"locate\" shell command.
INITIAL-INPUT can be given as the initial minibuffer input."
  (interactive)
  (ivy-read "class: " #'phpactor-class-search
            :initial-input initial-input
            :dynamic-collection t
            ;; :history 'counsel-locate-history
            :action (lambda (candidate)
                      (message candidate))
            ;; :unwind #'counsel-delete-process
            ;; :caller 'counsel-locate
             ))


(provide 'mk-php)
