;; for autocomplete
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-j") (lambda () (interactive) (company-complete-common-or-cycle 1)))
  (define-key company-active-map (kbd "C-k") (lambda () (interactive) (company-complete-common-or-cycle -1))))

(provide 'setup-company)
