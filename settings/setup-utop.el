(setq utop-command "opam config exec -- utop -emacs")

(defun my-utop-mode-hook ()
  (define-key utop-mode-map [S-return] 'utop-eval-input-auto-end))
(add-hook 'utop-mode-hook 'my-utop-mode-hook)

(autoload 'utop-minor-mode "utop" "Minor mode for utop" t)
(add-hook 'tuareg-mode-hook 'utop-minor-mode)

(provide 'setup-utop)
