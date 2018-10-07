(use-package vue-mode
  :config
(setq vue-modes
  '((:type template :name nil :mode web-mode)
    (:type template :name html :mode web-mode)
    (:type template :name jade :mode jade-mode)
    (:type template :name pug :mode pug-mode)
    (:type template :name slm :mode slim-mode)
    (:type template :name slim :mode slim-mode)
    (:type script :name nil :mode js-mode)
    (:type script :name js :mode js-mode)
    (:type script :name es6 :mode js-mode)
    (:type script :name babel :mode js-mode)
    (:type script :name coffee :mode coffee-mode)
    (:type script :name ts :mode typescript-mode)
    (:type script :name typescript :mode typescript-mode)
    (:type style :name nil :mode css-mode)
    (:type style :name css :mode css-mode)
    (:type style :name stylus :mode stylus-mode)
    (:type style :name less :mode less-css-mode)
    (:type style :name postcss :mode css-mode)
    (:type style :name scss :mode css-mode)
    (:type style :name sass :mode ssass-mode)))
  ;; (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
  ;; (setq vue-modes
  ;;       '((:type template :name nil :mode web-mode)))
;; (custom-set-variables '(vue-modes
;;                         '((:type template :name html :mode vue-html-mode)

;;  '(vue-modes
;;    (quote
;;     ((:type template :name nil :mode vue-html-mode)
;;      ;; more default modes...
;;      (:type style :name sass :mode ssass-mode)
;;      (:type i18n :name nil :mode json-mode))))
  )

(provide 'mk-vue)
