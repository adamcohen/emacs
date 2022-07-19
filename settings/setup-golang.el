(provide 'setup-golang)

(require 'lsp-mode)

;; settings for company-mode
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(setenv "GOPATH" "/Users/adam/golang")

(add-to-list 'exec-path "/Users/adam/golang/bin")
(setq gofmt-command "goimports")
(setq gofmt-args (list "-local" "gitlab.com/gitlab-org"))

;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(add-hook 'go-mode-hook
  (lambda ()
    ;; (company-mode)
    ; Customize compile command to run go build
    (if (not (string-match "go" compile-command))
        (set (make-local-variable 'compile-command)
             "go generate && go build -v && go test -v && go vet"))
    (push '("func" . ?ƒ) prettify-symbols-alist)
    (prettify-symbols-mode)
    ;; (add-hook 'go-mode-hook #'lsp-deferred)
    (lsp-deferred)
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
  )

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
