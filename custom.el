(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-buffer-directory ((t (:foreground "turquoise2"))))
 '(helm-buffer-file ((t (:foreground "gray64"))))
 '(helm-ff-directory ((t (:foreground "turquoise2"))))
 '(helm-ff-file ((t (:foreground "gray64"))))
 '(helm-ff-symlink ((t (:foreground "DarkOrchid1"))))
 '(hl-line ((t (:weight extra-bold))))
 '(idle-highlight ((t (:background "dark magenta"))))
 '(magit-item-highlight ((t (:weight extra-bold))))
 '(org-level-4 ((t (:foreground "yellow")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(asdf-binary "/usr/local/opt/asdf/bin/asdf")
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
 '(debug-ignored-errors
   '("^Exit the snippet first!$" beginning-of-line beginning-of-buffer end-of-line
     end-of-buffer end-of-file buffer-read-only file-supersession mark-inactive
     user-error "Command attempted to use minibuffer"))
 '(flycheck-go-vet-shadow t)
 '(helm-boring-file-regexp-list
   '("^\\..*$" "\\.o$" "~$" "\\.bin$" "\\.lbin$" "\\.so$" "\\.a$" "\\.ln$"
     "\\.blg$" "\\.bbl$" "\\.elc$" "\\.lof$" "\\.glo$" "\\.idx$" "\\.lot$"
     "\\.svn\\(/\\|$\\)" "\\.hg\\(/\\|$\\)" "\\.git\\(/\\|$\\)"
     "\\.bzr\\(/\\|$\\)" "CVS\\(/\\|$\\)" "_darcs\\(/\\|$\\)" "_MTN\\(/\\|$\\)"
     "\\.fmt$" "\\.tfm$" "\\.class$" "\\.fas$" "\\.lib$" "\\.mem$" "\\.x86f$"
     "\\.sparcf$" "\\.dfsl$" "\\.pfsl$" "\\.d64fsl$" "\\.p64fsl$" "\\.lx64fsl$"
     "\\.lx32fsl$" "\\.dx64fsl$" "\\.dx32fsl$" "\\.fx64fsl$" "\\.fx32fsl$"
     "\\.sx64fsl$" "\\.sx32fsl$" "\\.wx64fsl$" "\\.wx32fsl$" "\\.fasl$"
     "\\.ufsl$" "\\.fsl$" "\\.dxl$" "\\.lo$" "\\.la$" "\\.gmo$" "\\.mo$"
     "\\.toc$" "\\.aux$" "\\.cp$" "\\.fn$" "\\.ky$" "\\.pg$" "\\.tp$" "\\.vr$"
     "\\.cps$" "\\.fns$" "\\.kys$" "\\.pgs$" "\\.tps$" "\\.vrs$" "\\.pyc$"
     "\\.pyo$"))
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style 'relative)
 '(js2-basic-offset 2)
 '(js2-strict-missing-semi-warning nil)
 '(nodejs-repl-command "/usr/local/opt/nvm/versions/io.js/v2.2.1/bin/node")
 '(org-export-backends '(ascii html icalendar latex md odt confluence))
 '(org-src-preserve-indentation t)
 '(org-support-shift-select nil)
 '(package-selected-packages
   '(ac-ispell ace-jump-mode ace-window ack activity-watch-mode all-the-icons async
               auto-yasnippet browse-kill-ring coffee-mode company css-eldoc
               csv-mode dash dired-sidebar dired-subtree dockerfile-mode
               edit-server exec-path-from-shell expand-region feature-mode
               fill-column-indicator find-file-in-project flycheck
               flycheck-golangci-lint flycheck-inline flycheck-mode
               flycheck-pos-tip flymake-ruby git-timemachine go-autocomplete
               gorepl-mode gradle-mode graphql-mode groovy-mode haml-mode helm
               helm-core helm-gtags helm-projectile htmlize idle-highlight-mode
               ido-complete-space-or-hyphen inf-mongo inheritenv iy-go-to-char
               js2-mode json-mode kotlin-mode lineno lsp-treemacs lsp-ui magit
               mermaid-mode mise mocha multiple-cursors org-bullets org-roam
               ox-gfm posframe projectile projectile-rails protobuf-mode
               puppet-mode rainbow-delimiters rainbow-mode rake
               reveal-in-osx-finder rhtml-mode rinari robe rspec-mode rubocop
               rust-mode scala-mode sideline sideline-flycheck sideline-lsp
               slime-js smartparens smex swift-mode tide treemacs tuareg
               use-package utop vscode-icon vterm vue-mode w3 websocket xref
               yafolding yaml-mode yasnippet-snippets))
 '(protect-buffer-bury-p nil)
 '(redis-cli-executable "/usr/local/bin/redis-cli")
 '(sideline-flycheck-max-lines 1)
 '(sort-fold-case t)
 '(warning-minimum-level :error))
