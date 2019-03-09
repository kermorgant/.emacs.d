;;; mk-web --- essentially web-mode

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.html\\.twig\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 4
        web-mode-enable-css-colorization t
        web-mode-enable-current-element-highlight t
        web-mode-css-indent-offset 4
        web-mode-code-indent-offset 4
        web-mode-comment-style 2 ;server comments
        web-mode-enable-auto-pairing nil
        web-mode-enable-current-element-highlight t
        web-mode-enable-current-column-highlight t)
  :init
  (add-to-list 'company-backends 'company-web-html)
  (add-hook 'web-mode-hook
            (general-define-key
             :states '(normal visual)
             :prefix "SPC"
             :keymaps 'web-mode-map
             "mrc" '(web-mode-element-clone :wk "element-clone")
             "mrd" '(web-mode-element-vanish :wk "element-vanish")
             "mrk" '(web-mode-element-kill :wk "element-kill")
             "mrr" '(web-mode-element-rename :wk "element-rename")
             "mrw" '(web-mode-element-wrap :wk "element-wrap")
             "mz" '(web-mode-fold-or-unfold :wk "element-fold")
             ))
  (electric-indent-mode +1)
:config
  (add-hook 'web-mode-hook (lambda()
                             (cond ((equal web-mode-content-type "html")
                                    (my/web-html-setup))
                                   ((member web-mode-content-type '("vue"))
                                    (my/web-vue-setup))
                                   )))
  )

(use-package company-web
  :defer t
  :after company)

(use-package restclient)

;; inspired from https://github.com/jerryhsieh/Emacs-config/blob/master/custom/web.el
(defun my/web-html-setup()
  "Setup for web-mode html files."
  (message "web-mode use html related setup")
  ;(flycheck-add-mode 'html-tidy 'web-mode)
  ;(flycheck-select-checker 'html-tidy)
  (add-to-list (make-local-variable 'company-backends)
               '(company-web-html company-files company-css company-capf company-dabbrev))
;  (add-hook 'before-save-hook #'sgml-pretty-print)

  )

(defun my/web-vue-setup()
  "Setup for js related."
  (message "web-mode use vue related setup")
  (setup-tide-mode)
  (prettier-js-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-select-checker 'javascript-eslint)
  ;; (my/use-eslint-from-node-modules)
  (add-to-list (make-local-variable 'company-backends)
               '(comany-tide company-web-html company-css company-files))
  )

(use-package prettier-js
  :hook ((js2-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode)
         (css-mode . prettier-js-mode)
         ;; (web-mode . prettier-js-mode)
         )
  :config
  (setq prettier-js-args '(
                           "--trailing-comma" "es5"
                           "--bracket-spacing" "false"
                           "--tab-width" "4"
                           ))
  )

(defun setup-tide-mode ()
  "Setup tide mode for other mode."
  (interactive)
  (message "setup tide mode")
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode))
  ;;(before-save . tide-format-before-save))
  :config
  (setq tide-completion-enable-autoimport-suggestions t)
  )

(provide 'mk-web)
;;; mk-web.el ends here
