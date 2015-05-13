(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")  t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")  t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(ace-jump-mode ack coffee-mode feature-mode projectile projectile-rails find-file-in-project idle-highlight-mode magit markdown-mode smartparens puppet-mode rainbow-delimiters rainbow-mode rspec-mode yas-jit yasnippet-bundle popup auto-complete multiple-cursors smex edit-server ido-complete-space-or-hyphen haml-mode json-mode js2-mode expand-region)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; unobtrusive auto-complete mode (http://cx4a.org/software/auto-complete/)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

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

;; Set up appearance early
(require 'appearance)

(require 'setup-smartparens)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; Setup key bindings
(require 'key-bindings)

;start the emacsclient server unless it's already running
(require 'server)
(or (server-running-p)
    (server-start))

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
