(defun mk/indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (evil-indent (point-min) (point-max))
        (message "Indented buffer.")))
    (whitespace-cleanup)))

(defun mk/indent-new-comment-line ()
  "break line at point using c-indent-new-comment-line + indents"
  (interactive)
  (c-indent-new-comment-line)
  (indent-according-to-mode))

(provide 'mk-editing-defuns)
