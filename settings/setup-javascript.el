;;; setup-javascript.el --- JavaScript/TypeScript setup -*- lexical-binding: t; -*-

;; Requires: Emacs 29+, npm, tree-sitter-cli
;; make sure to install all necessary packages:
;;
;; npm install --save-dev prettier eslint globals chai chai-subset chai-as-promised nock sinon csv-parse sinon-chai
;; npm install -g tree-sitter-cli

(require 'use-package)
(require 'project)

;; -----------------------------
;; Tree-sitter
;; -----------------------------
(use-package treesit
  :ensure nil ;; built-in in Emacs 29+
  :commands (treesit-install-language-grammar nf/treesit-install-all-languages)
  :init
  (setq treesit-language-source-alist
        '((javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
          (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "typescript/src" "typescript"))
          (json . ("https://github.com/tree-sitter/tree-sitter-json"))))
  :config
  )

;; -----------------------------
;; Use project-local eslint
;; -----------------------------
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (dolist (var '("PATH" "NVM_DIR" "NODE_PATH"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(defun my/use-local-eslint ()
  "Use the nearest project's local eslint if available."
  (when-let* ((root (locate-dominating-file default-directory "package.json"))
              (local-eslint (expand-file-name "node_modules/.bin/eslint" root)))
    (when (file-executable-p local-eslint)
      (setq-local flycheck-javascript-eslint-executable local-eslint)
      (message "Using local eslint: %s" local-eslint))))

;; -----------------------------
;; Flycheck
;; -----------------------------
(use-package flycheck
  :ensure t
  :hook ((js-ts-mode . flycheck-mode)
         (ts-ts-mode . flycheck-mode))
  :config
  ;; Use project eslint when available
  (add-hook 'flycheck-mode-hook #'my/use-local-eslint)
  (flycheck-add-mode 'javascript-eslint 'js-ts-mode)
  (flycheck-add-mode 'javascript-eslint 'ts-ts-mode))

;; -----------------------------
;; Tide
;; -----------------------------
(use-package tide
  :ensure t
  :after (typescript-mode)
  :hook ((js-ts-mode . tide-setup)
         (js-ts-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)
         (ts-ts-mode . tide-setup)
         (ts-ts-mode . tide-hl-identifier-mode)))

;; -----------------------------
;; js-ts-mode setup
;; -----------------------------
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . ts-ts-mode))

(defun my/setup-js-ts-mode ()
  "Custom setup for js-ts-mode buffers."
  (subword-mode 1)
  (setq js-indent-level 2)
  (setq typescript-indent-level 2)
  (hs-minor-mode 1))

(add-hook 'js-ts-mode-hook #'my/setup-js-ts-mode)
(add-hook 'ts-ts-mode-hook #'my/setup-js-ts-mode)

(provide 'setup-javascript)
