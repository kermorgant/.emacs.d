(setq py-python-command "python3"
      flycheck-python-pycompile-executable "python3"
      flycheck-python-pylint-executable "python3")

(defcustom python-shell-interpreter "python3"
  "Default Python interpreter for shell."
  :type 'string
  :group 'python)

(use-package pyvenv)

(provide 'mk-python)
;;; mk-python ends here
