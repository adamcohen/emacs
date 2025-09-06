(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (dolist (var '("NVM_DIR" "NODE_PATH"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

;; Typescript major mode
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . (lambda ()
                             (eglot-ensure)
                             (setq typescript-indent-level 2)
                             (setq tab-width 2)
                             (setq flymake-show-diagnostics-at-end-of-line t)
                             (setq indent-tabs-mode nil))))

;; Eglot (built-in in Emacs 29, use package for older versions)
(use-package eglot
  :ensure t
  :hook ((typescript-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)))

;; Completion (Corfu + Orderless = modern, fast)
(use-package corfu
  :init
  (global-corfu-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

;; Prettier on save (via Apheleia), but only for JS/TS/JSON
(use-package apheleia
  :ensure t
  :config
  ;; Define which formatter to use for each major mode
  (setq apheleia-mode-alist
        '((js-mode . prettier)
          (js-ts-mode . prettier)
          (typescript-mode . prettier)
          (json-mode . prettier)
          ;; Don't run any formatter on Emacs Lisp
          (emacs-lisp-mode . nil)))

  ;; Enable global Apheleia mode
  (apheleia-global-mode +1)
  )

(provide 'setup-typescript)
