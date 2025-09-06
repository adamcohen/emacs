(defun my/format-elisp-buffer ()
  "Auto-indent entire buffer for Emacs Lisp."
  (when (eq major-mode 'emacs-lisp-mode)
    (indent-region (point-min) (point-max))))

(add-hook 'before-save-hook #'my/format-elisp-buffer)

(provide 'setup-elisp)
