
(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-project-search-path '("~/src/" "~/workspace/")
        projectile-completion-system 'ivy
        projectile-switch-project-action #'projectile-dired
        projectile-enable-caching t))

(use-package counsel-projectile)

(use-package persp-mode
  :init
  (setq persp-autokill-buffer-on-remove 'kill
        persp-kill-foreign-buffer-behaviour 'kill
        persp-auto-save-opt 0
        persp-auto-resume-time -1)
  :config    (persp-mode t))

(use-package persp-mode-projectile-bridge
  :config
  (add-hook 'persp-mode-projectile-bridge-mode-hook
            #'(lambda ()
                (if persp-mode-projectile-bridge-mode
                    (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                  (persp-mode-projectile-bridge-kill-perspectives))))
  (persp-mode-projectile-bridge-mode t))

;;https://gist.github.com/Bad-ptr/1aca1ec54c3bdb2ee80996eb2b68ad2d#file-persp-ivy-el
(with-eval-after-load "persp-mode"
  (with-eval-after-load "ivy"
    (add-hook 'ivy-ignore-buffers
              #'(lambda (b)
                  (when persp-mode
                    (let ((persp (get-current-persp)))
                      (if persp
                          (not (persp-contain-buffer-p b persp))
                        nil)))))

    (setq ivy-sort-functions-alist
          (append ivy-sort-functions-alist
                  '((persp-kill-buffer   . nil)
                    (persp-remove-buffer . nil)
                    (persp-add-buffer    . nil)
                    (persp-switch        . nil)
                    (persp-window-switch . nil)
                    (persp-frame-switch  . nil))))))

;; https://github.com/Bad-ptr/persp-mode-projectile-bridge.el
;; (with-eval-after-load "persp-mode-projectile-bridge-autoloads"
;;   (add-hook 'persp-mode-projectile-bridge-mode-hook
;;             #'(lambda ()
;;                 (if persp-mode-projectile-bridge-mode
;;                     (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
;;                   (persp-mode-projectile-bridge-kill-perspectives))))
;;   (add-hook 'after-init-hook
;;             #'(lambda ()
;;                 (persp-mode-projectile-bridge-mode 1))
;;             t))

(provide 'mk-project)
;;; mk-project ends here
