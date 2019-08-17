;;; Code:
(require 'polymode)

(define-hostmode poly-block-html-hostmode
  :mode 'html-mode
  :indent-offset 'sgml-basic-offset
  :protect-font-lock t
  :protect-syntax t)

(define-innermode block-tpl-innermode
  :mode 'block-mode
  :head-matcher (eval-when-compile
                  (rx (: "<%" word-end)))
  :tail-matcher (eval-when-compile
                  (rx "%>"))
  :can-overlap t
  :head-mode 'body
  :tail-mode 'body)

(define-innermode block-html-innermode
  :mode 'mhtml-mode
  :protect-font-lock t
  :head-matcher (eval-when-compile
                  (rx "<" (any "a-z" "A-Z")))
  :tail-matcher (eval-when-compile
                  (rx "<%"))
  :head-mode 'body
  :tail-mode 'block-mode)

(define-polymode poly-block-html-mode
  :hostmode 'poly-block-html-hostmode
  :innermodes '(block-tpl-innermode))

;;;###autoload
(autoload 'poly-block-html-mode "poly-block")

(provide 'poly-block)
;;; poly-block.el ends here
