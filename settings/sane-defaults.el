;; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; enable SSL mode
(setenv "PGSSLMODE" "require")
(setq sql-postgres-program "/usr/local/bin/psql")
;; this needs to be changed on an app by app basis, should
;; make a function that parses the sql connect string for us
(setq sql-mysql-login-params (append sql-mysql-login-params '(5642)))

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; don't drop me into the debugger on an error
(setq debug-on-error nil)

;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; Show active region
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Remove trailing whitespace from the entire buffer
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Only auto-fill inside comments.
(setq comment-auto-fill-only-comments t)

;; Save minibuffer history
(savehist-mode 1)
(setq history-length 1000)

;; Never insert tabs
(set-default 'indent-tabs-mode nil)

;; Searches and matches should ignore case
(setq case-fold-search t)

;; Don't be so stingy on the memory, we have lots now. It's the distant future.
(setq gc-cons-threshold 20000000)

;; Don't request confirmation before visiting a new file or buffer.
(setq confirm-nonexistent-file-or-buffer nil)

; automatically reload the TAGS table if it changes
(setq tags-revert-without-query 1)

;; List of warning types not to display immediately
;; when using ido, the confirmation is rather annoying...
(setq warning-suppress-types nil)

;; use cua mode only for rectangles
(setq cua-enable-cua-keys nil)
(cua-mode t)

(setenv "PAGER" "cat")

;remove annoying "Buffer `buffername' still has clients; kill it?" message
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

(setq initial-scratch-message nil)
(setq scroll-in-place t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Represent undo-history as an actual tree (visualize with C-x u)
;; (setq undo-tree-mode-lighter "")
;; (require 'undo-tree)
;; (global-undo-tree-mode)

;; disable auto fill in text mode, 'cause it's annoying
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

;; make C-n insert newlines if the point is at the end of the buffer
(setq next-line-add-newlines t)

;; allow us to copy between emacs and other x programs
(setq x-select-enable-clipboard t)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(provide 'sane-defaults)
