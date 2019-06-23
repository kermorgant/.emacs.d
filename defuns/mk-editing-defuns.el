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
  "Break line at point using c-indent-new-comment-line + indent."
  (interactive)
  (c-indent-new-comment-line)
  (indent-according-to-mode))

;; comes herefrom : https://demonastery.org/2013/04/emacs-evil-narrow-region/
(defun mk/narrow-to-region-indirect (start end)
  "Restrict editing in this buffer to the current region, indirectly."
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
      (switch-to-buffer buf)))

(provide 'mk-editing-defuns)
;;; mk-editing-defuns ends here
