;;; mk-web --- essentially web-mode

;;; Code:

;; (add-to-list 'auto-mode-alist '("\\.html.tmpl\\'" . bt-web-mode))
(add-to-list 'auto-mode-alist '("\\.sql.tmpl\\'" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.pgsqlin\\'" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.pgsql\\'" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist
             '("\\.json.tmpl\\'" . (lambda ()
                                     (json-mode)
                                     (setq flycheck-disabled-checkers  (append '(json-python-json) flycheck-disabled-checkers))
                                     )))
(add-hook 'sql-mode-load-hook
          (function (lambda () (sql-highlight-postgres-keywords))))

(use-package web-mode
  ;; :after (company-web prettier-js)
  ;; :defer 1
  :mode (("\\.html\\'" . web-mode)
         ("\\.html\\.twig\\'" . web-mode)
         ("\\.html.tmpl\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ;; ("\\.jsx\\'" . web-mode)
         )
  :custom
  ;; (web-mode-markup-indent-offset 4)
  (web-mode-enable-css-colorization t)
  (web-mode-enable-current-element-highlight t)
  ;; (web-mode-css-indent-offset 4)
  ;; (web-mode-code-indent-offset 4)
  (web-mode-comment-style 2) ;server comments
  (web-mode-enable-auto-pairing nil)
  (web-mode-enable-current-element-highlight t)
  (web-mode-enable-current-column-highlight t)
  (web-mode-engines-alist '(("asp"    . "\\.html.tmpl\\'")))
  :general
  (:keymaps 'web-mode-map
            :states '(normal visual)
            :prefix "SPC"
            "mrc" '(web-mode-element-clone :wk "element-clone")
            "mrd" '(web-mode-element-vanish :wk "element-vanish")
            "mrk" '(web-mode-element-kill :wk "element-kill")
            "mrr" '(web-mode-element-rename :wk "element-rename")
            "mrw" '(web-mode-element-wrap :wk "element-wrap")
            "mz" '(web-mode-fold-or-unfold :wk "element-fold"))
  ;; :config
  ;; (add-hook 'web-mode-hook (lambda()
  ;;                            (cond ((equal web-mode-content-type "html")
  ;;                                   (my/web-html-setup))
  ;;                                  ((member web-mode-content-type '("vue"))
  ;;                                   (my/web-vue-setup))
  ;;                                  )))
  :init
  ;; (add-to-list 'company-backends 'company-web-html)
  ;; (web-mode-use-tabs)
  (add-hook 'web-mode-hook
            (lambda ()
              (when (member  (file-name-extension buffer-file-name) '("tsx"))
                (prettier-js-mode)
                (setup-tide-mode))))
  (electric-indent-mode +1)
  )

(use-package company-web
  :defer t
  :after company)

(use-package restclient
  :defer t)

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

(use-package prettier-js
  :defer t
  :hook ((js2-mode . prettier-js-mode)
         (js-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode)
         (css-mode . prettier-js-mode)
         ;; (web-mode . prettier-js-mode)
         )
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

(use-package typescript-mode
  :init
  (add-hook 'setup-tide-mode #'typescript-mode))

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)

(use-package tide
  :after editorconfig
  :defer t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode))
  ;;(before-save . tide-format-before-save))
  :config
  (setq tide-completion-enable-autoimport-suggestions t)
  )

(provide 'mk-web)
;;; mk-web.el ends here
