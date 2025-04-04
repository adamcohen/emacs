(provide 'setup-golang)

(require 'lsp-mode)

;; settings for company-mode
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-variables '("PATH"
                                    "MANPATH"
                                    "TMPDIR"))
  (exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-debug nil)

  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; (setenv "GOPATH" "/Users/adam/golang")

(add-to-list 'exec-path "/Users/adam/golang/bin")

(setq gofmt-command "goimports")
;; (setq gofmt-command "/Users/adam/golang/bin/goimports")
(setq gofmt-args (list "-local" "gitlab.com/gitlab-org"))

;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(defun my-go-mode-hook ()
    ;; (company-mode)
    ; Customize compile command to run go build
    (if (not (string-match "go" compile-command))
        (set (make-local-variable 'compile-command)
             "go generate && go build -v && go test -v && go vet"))
    (push '("func" . ?ƒ) prettify-symbols-alist)
    (prettify-symbols-mode)
    ;; (add-hook 'go-mode-hook #'lsp-deferred)

    ; don't load lsp for the following directory, because it's too large
    (unless (string-prefix-p "/Users/adam/Documents/programming/testing/go"
                             (expand-file-name (buffer-file-name)))
      (lsp-deferred))

    (add-hook 'before-save-hook 'gofmt-before-save)
    (subword-mode)
    (helm-gtags-mode)
    (gorepl-mode)
    (flycheck-mode)
    (setq tab-width 2)
    (setq indent-tabs-mode 1)
    (hs-minor-mode)
    ; Godef jump key binding
    (local-set-key (kbd "M-.") 'lsp-ui-peek-find-definitions)
    (local-set-key (kbd "M-*") 'pop-tag-mark)
    ;; hs mode key bindings
    (local-set-key (kbd "C-c s") 'hs-show-block)
    (local-set-key (kbd "C-c h") 'hs-hide-block)
    (local-set-key (kbd "C-c a") 'hs-show-all)
    (local-set-key (kbd "C-c t") 'hs-toggle-hiding)
  )

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'go-ts-mode-hook 'my-go-mode-hook)

(use-package flycheck-golangci-lint
  :ensure t
  :hook (go-mode . flycheck-golangci-lint-setup))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]tmp\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]vrange/php\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]untracked\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]qa\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]fixtures\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]testdata\\'")
)
