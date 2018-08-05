(use-package which-key
  :defer 10
  :config (which-key-mode t))

(use-package general
  :config
  (general-override-mode)

  (general-define-key
   :states '(visual)
   "ig" 'evil-inner-buffer)

  (general-define-key
   :states '(normal visual insert emacs)
   :keymaps 'override
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; simple command
   ;; "" '(nil :which-key "my lieutenant general prefix")
   "'"   '(iterm-focus :which-key "iterm")
   "?"   '(iterm-goto-filedir-or-home :which-key "iterm - goto dir")
   "/"   'counsel-ag
   "TAB" '(switch-to-other-buffer :which-key "prev buffer")
   "SPC" '(counsel-M-x  :which-key "M-x")


   ;; Applications
   "a" '(:ignore t :which-key "Applications")
   "ad" 'dired

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
   "g" '(:ignore t :which-key "Git")
   "gs" 'magit-status
   "gt" 'git-timemachine

   "jj" '(avy-goto-word-or-subword-1  :which-key "go to char")
   "j=" 'mk/indent-region-or-buffer

   "ll" 'persp-switch
   "lc" 'persp-add-new
   "ln" 'persp-next
   "lp" 'persp-prev

   ;; Projects
   "p" '(:ignore t :which-key "Projects")
   "pf" 'counsel-projectile-find-file
   "pp" 'counsel-projectile-switch-project
   "pl" 'persp-window-switch

   "nf" 'narrow-to-defun
   "nr" 'narrow-to-region
   "nw" 'widen

   "s" '(:ignore t :which-key "Search")
   "se" 'evil-iedit-state/iedit-mode
   "sgp" 'counsel-git-grep
   "ss" 'swiper

   "v" 'er/expand-region

   "wF" 'make-frame
   "wm" 'delete-other-windows
   "wu" 'winner-undo
   "w/" 'split-window-right-and-focus
   "w-" 'split-window-below
   )

  (general-define-key
   :states '(normal visual insert)
   :prefix "s-SPC"
   "A"  '(sp-add-to-previous-sexp :wk "sp-add-to-previous-sexp")
   ;; "a"  '(sp-add-to-next-sexp :wk sp-add-to-next-sexp)
   ;; "B"  '(sp-backward-barf-sexp :wk sp-backward-barf-sexp)
   ;; "b"  '(sp-forward-barf-sexp :wk sp-forward-barf-sexp)
   ;; "M"  '(sp-backward-slurp-sexp :wk sp-backward-slurp-sexp)
   "l"  '(sp-forward-slurp-sexp :wk "sp-forward-slurp-sexp")
   ;; "c"  '(sp-convolute-sexp :wk sp-convolute-sexp)
   ;; "D"  '(sp-backward-kill-sexp :wk sp-backward-kill-sexp)
   "d"  '(sp-kill-sexp :wk "sp-kill-sexp")
   ;; "e"  '(sp-emit-sexp :wk sp-emit-sexp)
   ;; "l"  '(sp-end-of-sexp :wk sp-end-of-sexp)
   ;; "h"  '(sp-beginning-of-sexp :wk sp-beginning-of-sexp)
   ;; "j"  '(sp-join-sexp :wk sp-join-sexp)
   ;; "K"  '(sp-splice-sexp-killing-backward :wk )
   ;; "k"  '(sp-splice-sexp-killing-forward :wk )
   ;; "n"  '(sp-next-sexp :wk )
   ;; "p"  '(sp-previous-sexp :wk )
   ;; "r"  '(sp-raise-sexp :wk )
   ;; "s"  '(sp-splice-sexp-killing-around :wk )
   ;; "t"  '(sp-transpose-sexp :wk )
   "U"  '(sp-backward-unwrap-sexp :wk "backward-unwrap")
   "u"  '(sp-unwrap-sexp :wk "unwrap")
   "w"  '(sp-rewrap-sexp :wk "rewrap" )
   ","  '(sp-split-sexp :wk "sp-split-sexp")
   ;; "Y"  '(sp-backward-copy-sexp :wk )
   ;; "y"  '(sp-copy-sexp :wk )
   ;; ","  '(sp-previous-sexp :wk )
   ;; "."  '(sp-next-sexp :wk )
   ;; "<"  '(sp-backward-down-sexp :wk )
   ;; ">"  '(sp-down-sexp :wk )
   "("  '(sp-wrap-round :wk "wrap-round")
   "["  '(sp-wrap-square :wk "wrap-square")
   ))

;; ace-window-switching keybinding
(global-set-key (kbd "M-p") 'ace-window)
(progn (setq aw-scope 'frame))

;; move easily to previous or next buffer
(global-set-key (kbd "M-h") 'previous-buffer)
(global-set-key (kbd "M-l") 'next-buffer)
(global-set-key (kbd "M-v") 'er/contract-region)

(provide 'mk-keybindings)
