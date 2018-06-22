(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; need to require Common Lisp to enable certain functions, such as the case statement
;; see https://www.emacswiki.org/emacs/CommonLispForEmacs
(require 'cl)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")  t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")  t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
;; (defvar my-packages '(ace-jump-mode ack coffee-mode feature-mode projectile projectile-rails find-file-in-project idle-highlight-mode magit markdown-mode smartparens puppet-mode rainbow-delimiters rainbow-mode rspec-mode yasnippet popup auto-complete multiple-cursors smex edit-server ido-complete-space-or-hyphen haml-mode json-mode json-snatcher js2-mode expand-region yaml-mode rhtml-mode fill-column-indicator browse-kill-ring rinari websocket git-timemachine rubocop reveal-in-osx-finder protobuf-mode exec-path-from-shell go-autocomplete go-guru gorepl-mode mocha rust-mode go-mode)
;;    "A list of packages to ensure are installed at launch.")

(defvar my-packages '(ace-jump-mode ack coffee-mode feature-mode projectile projectile-rails find-file-in-project idle-highlight-mode magit markdown-mode smartparens puppet-mode rainbow-delimiters rainbow-mode rspec-mode company company-go popup auto-complete multiple-cursors smex edit-server ido-complete-space-or-hyphen haml-mode json-mode json-snatcher js2-mode expand-region yaml-mode rhtml-mode fill-column-indicator browse-kill-ring rinari websocket git-timemachine rubocop reveal-in-osx-finder protobuf-mode exec-path-from-shell go-guru gorepl-mode mocha rust-mode go-mode)
   "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;(require 'edit-server)
;(edit-server-start)

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))
(if (file-exists-p user-specific-config) (load user-specific-config))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; Set up appearance early
(require 'appearance)

(require 'setup-desktop)

(require 'keyboard-macros)
(require 'setup-smartparens)

;; Setup key bindings
(require 'key-bindings)

;; Map files to modes
(require 'mode-mappings)

(require 'setup-ido)

;; Fill column indicator
(require 'fill-column-indicator)
(setq fci-rule-color "#FF00FF")

;; Browse kill ring
(require 'browse-kill-ring)
(setq browse-kill-ring-quit-action 'save-and-restore)

(when is-mac (require 'mac))

;start the emacsclient server unless it's already running
(require 'server)
(or (server-running-p)
    (server-start))

;; for autocomplete
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Lets start with a smattering of sanity
(require 'sane-defaults)

(require 'setup-ruby-rails)

(require 'setup-golang)

(require 'setup-rust)

(add-to-list 'load-path (concat user-emacs-directory "/plugins/realtime-emacs-markdown-view/" ))
(require 'realtime-emacs-markdown-view)

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
