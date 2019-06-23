;;; Code:
(use-package transient
  :demand t
  ;; :functions (define-transient-command define-infix-argument define-suffix-command)
  :config
  (transient-bind-q-to-quit))

(use-package which-key
  ;; :defer 10
  :config (which-key-mode t))

(use-feature mk-keybindings
  :config
  (define-transient-command mk-sexp-menu ()
    "sexp"
    [[:description "wrapping"
                   ("u" "unwrap" sp-unwrap-sexp)
                   ("U" "b-unwrap" sp-backward-unwrap-sexp)
                   ("s" "split" sp-split-sexp)
                   ]
     ["actions"
      ("d" "kill" sp-kill-sexp)
      ("D" "b-kill" sp-backward-kill-sexp )
      ]
     ["move"
      ("<" "prev" sp-beginning-of-previous-sexp)
      (">" "next" sp-beginning-of-next-sexp)
      ]
     ]
    )
  (define-transient-command mk-git-menu ()
    "git"
    [[:description "magit"
                   ("s" "status" magit-status)
                   ("b" "blame" magit-blame)
                   ("l" "log file" magit-log-buffer-file)
                   ("F" "fetch all" magit-fetch-all)
                   ]
     ["others"
      ("t" "time-machine" git-timemachine)
      ;; ("f" "git-flow" magit-gitflow-popup)
      ]])
  (define-transient-command mk-narrow-menu ()
    "narrow"
    [["narrow"
      ("f" "function" narrow-to-defun)
      ("r" "region" narrow-to-region)
      ("p" "page" narrow-to-page)
      ("w" "widen" widen)
      ]])
  )

(use-package general
  :config
  (general-override-mode)

  (general-define-key
   :states '(visual)
   "ig" 'evil-inner-buffer)

  (general-define-key
   :states '(normal visual emacs)
   "*"   'symbol-overlay-put
   "m"   'evil-narrow-indirect
   "TAB" 'evil-indent)

  (general-define-key
   :keymaps '(compilation-mode-map ag-mode-map)
   "M-p"   'ace-window)

  (general-define-key
   :keymaps '(magit-status-mode-map)
   "q"   'winner-undo)

  (general-define-key
   :states '(normal visual insert)
   "s-SPC" 'mk-sexp-menu)

  (general-define-key
   :states '(normal visual insert emacs motion)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; simple command
   ;; "" '(nil :which-key "my lieutenant general prefix")
   "'"   '(iterm-focus :which-key "iterm")
   "?"   '(iterm-goto-filedir-or-home :which-key "iterm - goto dir")
   "/"   'counsel-git-grep
   ;; "TAB" '(switch-to-other-buffer :which-key "prev buffer")
   "SPC" '(counsel-M-x  :which-key "M-x")

   "bb" 'ivy-switch-buffer
   "bd" 'mk/kill-this-buffer

   "cl" 'mk/comment-or-uncomment-lines

   ;; Files
   "f" '(:ignore t :which-key "Files")
   "ff" 'counsel-find-file
   "fj" 'dired-jump
   "fr" 'counsel-recentf
   "fs" 'save-buffer

   ;; GIT
   "g"  '(mk-git-menu :wk "git")

   "jj" '(avy-goto-word-or-subword-1 :which-key "go to char")
   "j=" 'mk/indent-region-or-buffer :wk "indent region or buffer"

   "ll" 'persp-switch
   "lc" 'persp-add-new
   "ln" 'persp-next
   "lp" 'persp-prev

   ;; Projects
   "p" '(mk-projectile :wk "project")

   "n" '(mk-narrow-menu :wk "narrowing")

   "s" '(mk-search-menu :which-key "Search")

   "v" 'er/expand-region

   "wF" 'make-frame
   "wm" 'delete-other-windows
   "wu" 'winner-undo
   "w/" 'split-window-right-and-focus
   "w-" 'split-window-below
   )
  )

;; ace-window-switching keybinding
;; move easily to previous or next buffer
(global-set-key (kbd "M-h") 'previous-buffer)
(global-set-key (kbd "M-j") 'mk/indent-new-comment-line)
(global-set-key (kbd "M-l") 'next-buffer)
(global-set-key (kbd "M-v") 'er/contract-region)
(global-set-key (kbd "M-y") 'counsel-yank-pop)

;; mac keys behaviour
(when (eq system-type 'darwin)
  (setq ns-use-native-fullscreen t)
  (global-set-key [kp-delete] 'delete-char)
  (setq mac-option-modifier 'super)
  (setq mac-command-modifier 'meta)
  (setq mac-right-option-modifier 'none)
  ;; temp hack while using finnish layout
  (global-set-key "\M-(" (lambda () (interactive) (insert "{")))
  (global-set-key "\M-)" (lambda () (interactive) (insert "}")))
  (global-set-key "\M-8" (lambda () (interactive) (insert "[")))
  (global-set-key "\M-9" (lambda () (interactive) (insert "]"))))

(provide 'mk-keybindings)
;;; mk-keybindings ends here
