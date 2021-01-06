(setq gc-cons-threshold (* 500 1024 1024)) ; increase the threshold for gc - 100 MB

(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t )		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )               ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
;; (setq coding-system-for-read 'utf-8)	; use utf-8 by default
;; (setq coding-system-for-write 'utf-8 )
;; (setq buffer-file-coding-system 'utf-8)
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq initial-scratch-message nil) ; print a default message in the empty scratch buffer opened at startup
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq show-paren-delay 0)
(setq-default indent-tabs-mode nil)
(setq use-dialog-box nil)
(setq iedit-toggle-key-default nil)
(setq dired-dwim-target t) ;;  If non-nil, Dired tries to guess a default target directory
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(defalias 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(eval-when-compile
  (require 'use-package)
  (defmacro use-feature (name &rest args)
  "Like `use-package', but with `no-require' active."
  (declare (indent defun))
  `(use-package ,name
     :defer t
     :straight nil
     :ensure nil
     :no-require t
     ,@args))
  )

(use-package diminish)
(require 'diminish)
(require 'bind-key)

(setq load-prefer-newer t)

;; configurations
(add-to-list 'load-path
             (expand-file-name "config" user-emacs-directory))

;; modes
(add-to-list 'load-path
             (expand-file-name "modes" user-emacs-directory))

;; language specific setup
(add-to-list 'load-path
             (expand-file-name "lang" user-emacs-directory))

;; custom functions
(add-to-list 'load-path
             (expand-file-name "defuns" user-emacs-directory))

(use-package exec-path-from-shell
  :init
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  :config
  (setq exec-path-from-shell-arguments nil)
  (exec-path-from-shell-initialize))

(require 'mk-appearance)

(require 'mk-keybindings)

(use-package avy
  :defer t
  :commands (avy-goto-word-1))

(use-package ivy
  :straight t
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-extra-directories nil
        ivy-use-virtual-buffers t)
  (bind-key "C-c C-r" 'ivy-resume))

(use-package hydra
  :defer t)

(use-package ivy-hydra
  :defer t
  :after (ivy hydra))

(define-key ivy-minibuffer-map (kbd "C-o") 'hydra-ivy/body)
(define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)

(use-package prescient
  :defer t
  :config (prescient-persist-mode t))
(use-package ivy-prescient
  :config (ivy-prescient-mode t))

(use-package ivy-xref
  :defer t
  :init (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

;; use ripgrep configured to avoid lines longer than arbitrary limit
(use-package counsel
  :defer t
  :config
  (setq counsel-grep-base-command "rg -i -M 240 --no-heading --line-number --color never '%s' %s"
        counsel-rg-base-command "rg -S -M 240 --no-heading --line-number --color never %s ."))

;; evil configuration
(require 'mk-evil)

;; projectile and persp-mode configuration
(require 'mk-project)

;; editing configuration
(require 'mk-editing)

(require 'mk-search)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'mk-git)

;; editing defuns
(require 'mk-editing-defuns)

;; display defuns
(require 'mk-display-defuns)

;; general programming tools
(require 'mk-general)

(require 'mk-org)

;; auto completion
(require 'mk-complete)

;; configs
(require 'mk-configs)

(require 'mk-go)

(require 'mk-php)

(require 'mk-python)

(require 'mk-misc)

;; vue
(require 'mk-vue)

;; lsp
(require 'mk-lsp)

;; web
(require 'mk-web)

;(require 'mk-react)

(require 'mk-yaml)

(require 'mk-docker)

;; behat
(require 'mk-cucumber)

;(require 'mk-scala)

;; tools
(require 'mk-tools)

;; local customizations
(if (not (require 'mk-localhost nil t))
    (message "no local customizations found"))

(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 1 1024 1024))))
;;; init ends here
