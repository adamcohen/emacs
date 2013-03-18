(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")  t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/")  t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings ace-jump-mode ack feature-mode find-file-in-project idle-highlight-mode magit markdown-mode paredit puppet-mode rainbow-delimiters rainbow-mode rspec-mode yas-jit yasnippet-bundle starter-kit-ruby popup auto-complete starter-kit-js multiple-cursors smex)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; unobtrusive auto-complete mode (http://cx4a.org/software/auto-complete/)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(require 'edit-server)
(edit-server-start)


(set-face-attribute 'default nil
                    :family "Monaco" :height (case system-type
                                             ('gnu/linux 130)
                                             ('darwin 160)) :weight 'normal)

;intelligently use hypen or space with smex 
(require 'ido-complete-space-or-hyphen)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-item-highlight ((t (:weight extra-bold)))))
