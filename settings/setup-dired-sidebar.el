(use-package dired-sidebar
  :bind (
         ("C-x C-n" . dired-sidebar-toggle-sidebar)
         (:map dired-sidebar-mode-map
               ("i" . dired-sidebar-subtree-toggle)
               ("j" . dired-next-line)
               ("k" . dired-previous-line)
               ([tab] . dired-subtree-toggle)
               ([backtab] . dired-subtree-remove) ; S-TAB
               )
         )

  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "  ")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(provide 'setup-dired-sidebar)
