;;; inspired by https://www.emacswiki.org/emacs/ModeTutorial

;;; Code:
(defvar block-mode-hook nil)

(defvar block-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for BLOCK major mode")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.wpd\\'" . block-mode))

;;; setup font locking using this : http://www.modernemacs.com/post/major-mode-part-1/
(defconst block--kwds-constants
  '("f" "t")
  "Block constant keywords.")

(defconst block--function-defs
  '("area_descr" "attr" "callable" "car_brand_lookup" "cat_type_name" "chk_err" "clean_qs" "clean_url_qs" "clear_cookie" "coord_sweref99_to_rt90"
    "coord_sweref99_to_rt90" "define_list" "define" "define_split" "define_month_days" "dictsort" "dump_timers" "eat" "equalto" "errorlog" "escape"
    "even" "fcmp" "first" "float" "fmultiply" "format_date" "format_price" "format_price" "format_weeks" "format_zipcode" "get_cookie" "get_price_lowered" "friendly"
    "has_cookie" "ifnull" "index" "in_list" "int" "in_vtree_list" "isnumber" "isodate" "isstring" "last" "linkshelf_split" "list" "maxint"
    "mime_inline_file" "mime_type" "minint" "nice_date" "node_join" "node_random" "node_sort" "now" "numpad" "odd" "percent"
    "multiply" "divide" "modulo" "replace"
    "substring")
  "Block definition keywords.")

(defconst block--filters-defs
  '(
    "clean_qs"
    "include"
    "replace"
    )
  "Block definition keywords.")


(defconst block--kwds-operators
  '("!=" "==" "=~" "&&" "|" "<%" "%>" "::")
  "Block operator keywords.")

(defconst block--font-lock-kwds-constants
  (list
   (rx-to-string
    `(: (or ,@block--kwds-constants)))
   '(0 font-lock-constant-face))
  "Block constant keywords.")

(defconst block--font-lock-kwds-operators
  (list
   (rx-to-string
    `(: (or ,@block--kwds-operators)))
   '(0 font-lock-constant-face))
  "Block constant keywords.")

(defconst block--font-lock-kwds-definitions
  (list
   (rx-to-string
    `(: (or ,@block--function-defs)))
   '(0 font-lock-function-name-face))
  "Block constant keywords.")

(defconst block--font-lock-filters-definitions
  (list
   (rx-to-string
    `(: (or ,@block--filters-defs)))
   '(0 font-lock-builtin-face))
  "Block constant keywords.")

(defconst block-font-lock--variables-definitions
  (list
   (rx-to-string
    `(: (group (any "%" "?" "@") (1+  (any alnum "_"))))
    ;; `(: (any "%" "?" "@") (one-or-more "0-9A-Za-z_"))
    )

   '(1 font-lock-variable-name-face))
  "Hy variables keywords.")

(defconst block-font-lock-kwds
  (list
        block--font-lock-kwds-definitions
        block--font-lock-filters-definitions
        block-font-lock--variables-definitions
        block--font-lock-kwds-operators
        )
  "All Block font lock keywords.")

;; (defvar block-test-highlights nil "first element for `font-lock-defaults'")

;; (defconst block-test-highlights
;;       '(
;;         ;; ((rx-to-string `(: (or "define"))) . font-lock-function-name-face)
;;         ;; ("define" . font-lock-function-name-face)
;;         ("clean_qs" . (1 font-lock-constant-face)))
;; "some const."
;;       )

(defun block-mode--setup-font-lock ()
  "Setup `font-lock-defaults' and others for `block-mode.'"
  (setq font-lock-defaults
        ;; '(block-test-highlights)
       '(block-font-lock-kwds
        ;;   nil nil
        ;;   (("+-*/.<>=!?$%_&~^:@" . "w"))  ; syntax alist
        ;;   nil
        ;;   (font-lock-mark-block-function . mark-defun)
        ;;   )
        )))

(defvar block-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\_ "_" st)
    ;; (modify-syntax-entry ?\@ "'" st)
    ;; (modify-syntax-entry ?\% "'" st)
    st)
  "Syntax table for block-mode.")

(defun block-mode--setup-syntax ()
  "Setup syntax, indentation, and other core components of major modes."
  ;; We explictly set it for tests that only call this setup-fn
  (set-syntax-table block-mode-syntax-table)
  )

;;;###autoload
(define-derived-mode block-mode prog-mode "blk"
  "Major mode for editing Hy files."
  (block-mode--setup-font-lock)
  (block-mode--setup-syntax)
  )

;; (defun block-mode ()
;;   "Major mode for editing Workflow Process Description Language files."
;;   (interactive)
;;   (kill-all-local-variables)
;;   (set-syntax-table block-mode-syntax-table)
;;   (use-local-map block-mode-map)
;;   (set (make-local-variable 'font-lock-defaults) '(block-font-lock-keywords))
;;   (setq major-mode 'block-mode)
;;   (setq mode-name "BLOCK")
;;   (run-hooks 'block-mode-hook))

(provide 'block-mode)
;;; block-mode.el ends here
