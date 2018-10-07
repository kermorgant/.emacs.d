;;; essentially web-mode

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.html\\.twig\\'" . web-mode)
         ;; ("\\.vue\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :init
  (add-to-list 'company-backends 'company-web-html)
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 4
        web-mode-code-indent-offset 4
        web-mode-comment-style 2 ;server comments
        web-mode-enable-auto-pairing nil
        web-mode-enable-current-element-highlight t
        web-mode-enable-current-column-highlight t)
  (electric-indent-mode +1))

(use-package company-web
  :defer t
  :after company)

(use-package restclient)

(provide 'mk-web)
;;; mk-web.el ends here
