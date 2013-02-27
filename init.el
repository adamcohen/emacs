(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings ace-jump-mode ack feature-mode find-file-in-project idle-highlight-mode magit markdown-mode paredit puppet-mode rainbow-delimiters rainbow-mode rspec-mode yas-jit yasnippet-bundle starter-kit-ruby popup auto-complete starter-kit-js multiple-cursors)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(set-face-attribute 'default nil
                    :family "Monaco" :height (case system-type
                                             ('gnu/linux 130)
                                             ('darwin 160)) :weight 'normal)
