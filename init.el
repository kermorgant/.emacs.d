(setq gc-cons-threshold (* 500 1024 1024)) ; increase the threshold for gc - 100 MB

(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t )		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )               ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq initial-scratch-message nil) ; print a default message in the empty scratch buffer opened at startup
(setq use-package-always-ensure t)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq show-paren-delay 0)
(setq-default indent-tabs-mode nil)
(setq use-dialog-box nil)
(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
;; the following lines tell emacs where on the internet to look up
;; for new packages.
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")))
(put 'narrow-to-region 'disabled nil)

(package-initialize) ; guess what this one does ?
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package
(require 'use-package)
(use-package auto-compile
  :config (auto-compile-on-load-mode))
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

(use-package which-key)

(require 'mk-appearance)

(require 'mk-keybindings)

(use-package avy
  :commands (avy-goto-word-1))

(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-extra-directories nil
        ivy-use-virtual-buffers t)
  (bind-key "C-c C-r" 'ivy-resume))

(define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)

(use-package prescient
  :config (prescient-persist-mode t))
(use-package ivy-prescient
  :config (ivy-prescient-mode t))

(use-package ivy-xref
  :init (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

;; use ripgrep configured to avoid lines longer than arbitrary limit
(use-package counsel
  :config
  (setq counsel-grep-base-command "rg -i -M 240 --no-heading --line-number --color never '%s' %s"
        counsel-rg-base-command "rg -S -M 240 --no-heading --line-number --color never %s ."))

;; projectile and persp-mode configuration
(require 'mk-project)

;; evil configuration
(require 'mk-evil)

;; editing configuration
(require 'mk-editing)

(use-package eyebrowse                  ; Easy workspaces creation and switching
  :config
  (setq eyebrowse-mode-line-separator " "
        eyebrowse-new-workspace t)
  (eyebrowse-mode t))

(use-package magit
  :init
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
  :config (setq magit-completing-read-function 'ivy-completing-read))

(use-package magit-gitflow)

(use-package magit-todos
  :after magit
  :init
  (setq magit-todos-require-colon nil)
  (magit-todos-mode t)
  :config
  (with-eval-after-load 'magit-todos (require 'evil-collection-magit-todos))
 )

(use-package evil-magit
  :after magit
  :init (setq evil-magit-want-horizontal-movement nil))

(use-package diff-hl                 ; Show changes in fringe
  :ensure t
  :hook ((prog-mode          . diff-hl-mode)
         ;; (dired-mode         . diff-hl-dired-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

(use-package git-timemachine)

;; NeoTree
(use-package neotree
  :config
  (with-eval-after-load 'neotree (require 'evil-collection-neotree))
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; editing defuns
(require 'mk-editing-defuns)

;; display defuns
(require 'mk-display-defuns)

;; general programming tools
(require 'mk-general)

;; auto completion
(require 'mk-complete)

;; php
(require 'mk-php)

;; vue
(require 'mk-vue)

;; lsp
(require 'mk-lsp)

;; web
(require 'mk-web)

;; react
(require 'mk-react)

;; yaml
(require 'mk-yaml)

;; docker
(require 'mk-docker)

;; behat
(require 'mk-cucumber)

;; tools
(require 'mk-tools)

(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 1 1024 1024))))
;;; init ends here
