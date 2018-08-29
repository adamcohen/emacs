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

(add-to-list 'ido-ignore-files "package-lock.json")

(provide 'setup-javascript)
