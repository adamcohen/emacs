(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:weight extra-bold))))
 '(idle-highlight ((t (:background "dark magenta"))))
 '(magit-item-highlight ((t (:weight extra-bold)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-buffer-maximum-size 1000)
 '(comint-completion-addsuffix t)
 '(comint-get-old-input (lambda nil "") t)
 '(comint-input-ignoredups t)
 '(comint-input-ring-size 5000)
 '(comint-move-point-for-output nil)
 '(comint-prompt-read-only nil)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(comint-scroll-to-bottom-on-output nil)
 '(js2-basic-offset 2)
 '(js2-strict-missing-semi-warning nil)
 '(nodejs-repl-command "/usr/local/opt/nvm/versions/io.js/v2.2.1/bin/node")
 '(package-selected-packages
   (quote
    (ggtags helm-gtags inf-mongo auto-yasnippet yasnippet-snippets hydra helm-swoop magit-gh-pulls yasnippet linum-relative helm flycheck flycheck-golangci-lint company company-go go-autocomplete magit rust-mode go-dlv mocha js2-mode gorepl-mode go-guru lineno exec-path-from-shell protobuf-mode solidity-mode rails-log-mode reveal-in-osx-finder iy-go-to-char restclient yaml-mode websocket w3 smex smartparens slime-js rvm rubocop rspec-mode rinari rhtml-mode redis rainbow-mode rainbow-delimiters puppet-mode projectile-rails nodejs-repl multiple-cursors markdown-mode json-mode ido-complete-space-or-hyphen idle-highlight-mode haml-mode go-mode git-timemachine find-file-in-project fill-column-indicator feature-mode expand-region edit-server coffee-mode browse-kill-ring ack ace-jump-mode ac-ispell)))
 '(protect-buffer-bury-p nil)
 '(redis-cli-executable "/usr/local/bin/redis-cli")
 '(sort-fold-case t t)
 '(warning-minimum-level :error))
