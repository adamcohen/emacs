(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1)

  ;; configure javascript-tide checker to run after your default javascript checker
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
  )

(add-hook 'js2-mode-hook
  (lambda ()
    (helm-gtags-mode)
    (hs-minor-mode)
    (setup-tide-mode)
    )
  )

(add-hook 'javascript-mode-hook
  (lambda ()
    (helm-gtags-mode)
    (hs-minor-mode)
    (setup-tide-mode)
    )
  )

(add-hook 'json-mode-hook
  (lambda ()
    (helm-gtags-mode)
    (hs-minor-mode)
    (flycheck-mode +1)
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
