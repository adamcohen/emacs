(add-hook 'csv-mode-hook
  (lambda ()
    (setq mode-require-final-newline nil)
    )
  )

(provide 'setup-csv)