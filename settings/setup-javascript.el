(add-hook 'js2-mode-hook
  (lambda ()
    (helm-gtags-mode)
    (hs-minor-mode)
    )
  )

(add-hook 'javascript-mode-hook
  (lambda ()
    (helm-gtags-mode)
    (hs-minor-mode)
    )
  )


;; make the mocha output buffer smaller
(add-hook 'mocha-compilation-mode-hook
          (lambda ()
            (setq buffer-face-mode-face '(:family "Monaco" :height 130))
            (buffer-face-mode)
            ))

(add-to-list 'ido-ignore-files "package-lock.json")

(provide 'setup-javascript)
