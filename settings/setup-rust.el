(provide 'setup-rust)

;; (add-to-list 'load-path "/path/to/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(add-to-list 'exec-path "/Users/adam/.cargo/bin")

(setq rust-format-on-save t)
