;; customize
(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t)) ; this needs helm-mode enabled in the current buffer

(setenv "GTAGSLABEL" "new-ctags")

(provide 'setup-helm-gtags)
