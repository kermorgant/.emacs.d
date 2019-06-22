;;; mk-complete --- configuration of completion

;;; Commentary:
;;; global configuration of company-mode

;;; Code:
(use-package company-prescient
  :after (company prescient)
  :config (company-prescient-mode 1))

(use-package company
  :demand t
  :hook ((prog-mode-hook . global-company-mode)
         (text-mode-hook . global-company-mode)
         (org-mode-hook . global-company-mode)
         (markdown-mode-hook . global-company-mode))
  :init
  (setq company-minimum-prefix-length 3
        company-require-match 0
        company-selection-wrap-around t
        company-tooltip-limit 10
        company-show-numbers t
        company-idle-delay 0.05)
  (setq company-dabbrev-ignore-buffers "\\.pdf\\'"
        company-dabbrev-downcase nil
        company-dabbrev-code-modes t
        company-dabbrev-code-other-buffers 'all
        company-dabbrev-other-buffers 'all
        company-dabbrev-code-everywhere t)

  :bind* (("M-/"	. company-complete)
          )
  ;;        ("C-j f"	. company-files)
  ;;        ("C-j s"	. company-ispell)
  ;;        ("C-j e"	. company-elisp)
  ;;        ("C-j y"	. company-yasnippet)
  ;;        ("C-j c"	. company-dabbrev-code)
  ;;        ("C-j d"	. company-dabbrev))
  ;; :bind (:map prog-mode-map
  ;;      ("C-d" . company-dabbrev-code))
  ;; :bind (:map text-mode-map
  ;;      ("C-d" . company-dabbrev))
  :bind (:map company-active-map
              ([return] . company-complete-selection))
  ;;      ("C-n"    . company-select-next)
  ;;      ("C-p"    . company-select-previous)
  ;;      ([tab]    . yas-expand)
  ;;      ("TAB"    . yas-expand)
  ;;      ("C-w"    . backward-kill-word)
  ;;      ("C-c"    . company-abort)
  ;;      ("C-c"    . company-search-abort))
  :diminish (company-mode . " ς")

  :config
  ;; set default backends and list all possible backends
  (setq company-backends
        '((;; generic backends
           company-files          ; files & directory
           company-keywords       ; keywords
           company-dabbrev-code   ; code words
           company-dabbrev        ; words
           ;; code backends
           ;; company-elisp          ; emacs-lisp code
           ;; company-shell       ; shell
           ;; company-rtags          ; rtags
           ;; company-ycmd           ; ycmd
           ;; tag backends
           ;; company-etags          ; etags
           ;; company-gtags          ; gtags
           ;; completion at point
           company-capf)))
  (global-company-mode))

;; ;; use a child frame
;; (use-package company-childframe
;;   :ensure t
;;   :diminish company-childframe-mode
;;   :after company
;;   :config
;;   (company-childframe-mode 1)
;;   (require 'desktop)
;;   (push '(company-childframe-mode . nil)
;;       desktop-minor-mode-table))


;; provide the config
(provide 'mk-complete)
