(add-hook 'js2-mode-hook
  (lambda ()
    (helm-gtags-mode)
    )
  )

(add-hook 'javascript-mode-hook
  (lambda ()
    (helm-gtags-mode)
    )
  )

(provide 'setup-javascript)
