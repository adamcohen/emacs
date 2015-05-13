(setq cua-enable-cua-keys nil) ;; only for rectangles
(cua-mode t)

;remove annoying "Buffer `buffername' still has clients; kill it?" message
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; Save a list of recent files visited.
(recentf-mode 1)

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(require 'ido)
(ido-mode t)

(defun my-coding-hook ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t)
  (if window-system (hl-line-mode t))
  (idle-highlight-mode t)
  ;; TODO: re-enable
  ;; (define-key js2-mode-map (kbd "C-,") (sp-restrict-to-pairs-interactive "{" 'sp-down-sexp))
  ;; (define-key js2-mode-map (kbd "C-.") (sp-restrict-to-pairs-interactive "{" 'sp-up-sexp))
)

(add-hook 'emacs-lisp-mode-hook 'my-coding-hook)
(add-hook 'ruby-mode-hook 'my-coding-hook)

;; BEGIN JS2 MODE
(add-hook 'js2-mode-hook 'my-coding-hook)
(setq js-indent-level 2)

(eval-after-load 'js2-mode
  `(progn
     ;; BUG: self is not a browser extern, just a convention that needs checking
     (setq js2-browser-externs (delete "self" js2-browser-externs))

     ;; Consider the chai 'expect()' statement to have side-effects, so we don't warn about it
     (defun js2-add-strict-warning (msg-id &optional msg-arg beg end)
       (if (and js2-compiler-strict-mode
                (not (and (string= msg-id "msg.no.side.effects")
                          (string= (buffer-substring-no-properties beg (+ beg 7)) "expect("))))
           (js2-report-warning msg-id msg-arg beg
                               (and beg end (- end beg)))))))

;; Add support for some mocha testing externs
(setq-default js2-additional-externs
              (mapcar 'symbol-name
                      '(after afterEach before beforeEach describe it)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; END JS2 MODE

;intelligently use hypen or space with smex 
(require 'ido-complete-space-or-hyphen)

(subword-mode 1)
(setq-default indent-tabs-mode nil)

;; don't want ido to ask me if I really want to create a new buffer
(setq ido-create-new-buffer 'always)

(setq 
  comment-auto-fill-only-comments t
  tags-revert-without-query 1      ; automatically reload the TAGS
                                   ; table if it changes
  auto-mode-alist (cons '("README" . text-mode) auto-mode-alist)
  auto-mode-alist (cons '("\\.pp$" . puppet-mode) auto-mode-alist)
  auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist)
  ;; when using ido, the confirmation is rather annoying...
  warning-suppress-types nil
  confirm-nonexistent-file-or-buffer nil
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
     "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
  ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
  ido-case-fold  t                 ; be case-insensitive
  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30   ; should be enough
  ido-max-work-file-list      50   ; remember many
  ido-use-filename-at-point nil    ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ; don't use url at point (annoying)
;  ido-enable-regexp t              ; use regexp matching
  ido-enable-flex-matching t
  ido-max-prospects 8              ; don't spam my minibuffer
  ido-confirm-unique-completion t  ; wait for RET, even with unique completion
  )


; enable tramp to open files using sudo on a remote machine by
; doing C-x C-f /sudo:root@host[#port]:/path/to/file
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))

;; increase minibuffer size when ido completion is active
(add-hook 'ido-minibuffer-setup-hook 
  (function
    (lambda ()
      (make-local-variable 'resize-minibuffer-window-max-height)
      (setq resize-minibuffer-window-max-height 1))))

(setq initial-scratch-message nil)
(setq scroll-in-place t)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir "~/tmp/emacs_autosaves/")
(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir "~/tmp/emacs_autosaves/")
(setq backup-directory-alist (list (cons "." backup-dir)))

;; allow us to copy between emacs and other x programs
(setq x-select-enable-clipboard t)

;; SLIME
(setq inferior-lisp-program (executable-find "sbcl"))
(setq slime-contribs '(slime-fancy slime-repl slime-js))

;; COPYING LINES WITHOUT SELECTING THEM
;; http://emacs-fu.blogspot.com/2009/11/copying-lines-without-selecting-them.html
;; When I'm programming, I often need to copy a line. Normally, this requires me to first select ('mark') the line I want to copy. That does not seem like a big deal, but when I'm in the 'flow' I want to avoid any little obstacle that can slow me down.

;; So, how can I copy the current line without selection? I found a nice trick by MacChan on EmacsWiki to accomplish this. It also adds ta function to kill (cut) the current line (similar to kill-line (C-k), but kills the whole line, not just from point (cursor) to the end.

;; The code below simply embellishes the normal functions with the functionality 'if nothing is selected, assume we mean the current line'. The key bindings stay the same (M-w, C-w).

;; To enable this, put the following in your .emacs:

(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end)) (message
  "Copied line") (list (line-beginning-position) (line-beginning-position
  2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))

;; END COPYING LINES WITHOUT SELECTING THEM

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) 

(global-set-key "\M-n"  (lambda () (interactive) (scroll-up   1)) )
(global-set-key "\M-p"  (lambda () (interactive) (scroll-down 1)) )
(global-set-key "\M-g"  'goto-line)
(global-set-key [f5] 'call-last-kbd-macro)

(global-set-key (kbd "<f9>")  ;make F9 switch to *scratch*     
  (lambda()(interactive)(switch-to-buffer "*scratch*")))

(defun xacohen-save-current-directory ()
  "Save the current directory to the file ~/.emacs.d/acohen/current-directory"
  (interactive)
  (let ((dir default-directory))
    (with-current-buffer (find-file-noselect "~/.emacs.d/acohen/current-directory")
      (delete-region (point-min) (point-max))
      (insert (concat dir "\n"))
      (save-buffer)
      (kill-buffer (current-buffer)))))
(global-set-key [(super f10)] 'xacohen-save-current-directory)

(setq debug-on-error t)

;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
;(setq desktop-save 'if-exists)
(desktop-save-mode 1)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))


;; use only one desktop
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")

(defun lw ()
  (interactive)
  "insert log message containing clipboard contents"
  (set 'logmsg (concat "(%|\\n\\n[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]\\n"))
  (set 'logmsg (concat logmsg (concat "[" (car (last (split-string buffer-file-name "/"))) "]\\n")))
  (set 'logmsg (concat logmsg ( upcase (car kill-ring)) ": #{" (car kill-ring) ".inspect}\\n"))
  (set 'logmsg (concat logmsg "[XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]\\n\\n|)" "\n"))
  (insert (concat "Rails.logger.debug" logmsg))
  (insert (concat "puts" logmsg))
  )

(defun lp ()
  (interactive)
  "insert puts message containing clipboard contents"

(set 'logmsg
  (case major-mode
    ('ruby-mode (concat "puts \"XXXXXXXXXXXXXXXX\", " "(%|" ( upcase (car kill-ring)) ": #{" (car kill-ring) ".inspect}|), \"XXXXXXXXXXXXXXXX\""))
    ('js2-mode  (concat "console.log('" ( upcase (car kill-ring)) "', JSON.stringify(" (car kill-ring) ", null, 2))"))
    )
  )

(insert logmsg)
)

(global-set-key (kbd "C-c C-j") 'lw)
(global-set-key (kbd "C-c C-p") 'lp)

(defun cln (arg)
  "Prompt user to enter a string, with input history support."
  (interactive (list (read-number "Line number to copy: ")) )
  ;; (bookmark-set "my-book-mark")
  (push-mark)
  (goto-char (point-min))
  (forward-line (1- arg))
  (beginning-of-line)
  (push-mark)
  (end-of-line)

  (let ((str (buffer-substring (region-beginning) (region-end))))
    ;; (bookmark-jump "my-book-mark")
    (pop-mark)
    (jump-to-mark)
    (insert-string str)
    (beginning-of-line)
    ;; (forward-line 1)
    )
  )

(defun clear-shell ()
   (interactive)
   (let ((comint-buffer-maximum-size 0))
     (comint-truncate-buffer)))

;; reclaim some binding used by shell mode and shell-command.
;; the shell mode and associated mode and commands use keys in comint-mode-map.
(add-hook 'shell-mode-hook
 (lambda ()
   (define-key shell-mode-map (kbd "C-c C-f") 'find-file-at-point)
   (define-key shell-mode-map [f1] 'clear-shell)
   (setq global-hl-line-mode nil)
))

;; might be called sql-interactive-mode-hook
(add-hook 'sql-interactive-mode-hook
          '(lambda ()
             (define-key sql-interactive-mode-map [f1] 'clear-shell)
             (define-key sql-interactive-mode-map (kbd "M-R") 'comint-history-isearch-backward-regexp)
             (setq global-hl-line-mode nil)
))

;; remove P (ibuffer-do-print) in ibuffer mode, since it's
;; way too easy to print a shitload of buffers!
(add-hook 'ibuffer-mode-hook
 (lambda ()
   (define-key ibuffer-mode-map (kbd "P") 'ibuffer-backward-line)
))

;; Remove completion buffer when done
(add-hook 'minibuffer-exit-hook 
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
            (kill-buffer buffer)))))

;; originally from http://sites.google.com/site/steveyegge2/my-dot-emacs-file
;; adapted from http://stackoverflow.com/questions/384284/can-i-rename-an-open-file-in-emacs
;; to support moving to a new directory
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive
   (progn
     (if (not (buffer-file-name))
         (error "Buffer '%s' is not visiting a file!" (buffer-name)))
     (list (read-file-name (format "Rename %s to: " (file-name-nondirectory
                                                     (buffer-file-name)))))))
  (if (equal new-name "")
      (error "Aborted rename"))
  (setq new-name (if (file-directory-p new-name)
                     (expand-file-name (file-name-nondirectory
                                        (buffer-file-name))
                                       new-name)
                   (expand-file-name new-name)))
  ;; If the file isn't saved yet, skip the file rename, but still update the
  ;; buffer name and visited file.
  (if (file-exists-p (buffer-file-name))
      (rename-file (buffer-file-name) new-name 1))
  (let ((was-modified (buffer-modified-p)))
    ;; This also renames the buffer, and works with uniquify
    (set-visited-file-name new-name)
    (if was-modified
        (save-buffer)
      ;; Clear buffer-modified flag caused by set-visited-file-name
      (set-buffer-modified-p nil))
  (message "Renamed to %s." new-name)))

 (defun my-ido-project-files ()
      "Use ido to select a file from the project."
      (interactive)
      (let (my-project-root project-files tbl)
      (unless project-details (project-root-fetch))
      (setq my-project-root (cdr project-details))
      ;; get project files
      (setq project-files 
	    (split-string 
	     (shell-command-to-string 
	      (concat "find "
		      my-project-root
		      " \\( -name \"*.svn\" -o -name \"*.git\" \\) -prune -o -type f -print | grep -E -v \"\.(pyc)$\""
		      )) "\n"))
      ;; populate hash table (display repr => path)
      (setq tbl (make-hash-table :test 'equal))
      (let (ido-list)
      (mapc (lambda (path)
	      ;; format path for display in ido list
	      (setq key (replace-regexp-in-string "\\(.*?\\)\\([^/]+?\\)$" "\\2|\\1" path))
	      ;; strip project root
	      (setq key (replace-regexp-in-string my-project-root "" key))
	      ;; remove trailing | or /
	      (setq key (replace-regexp-in-string "\\(|\\|/\\)$" "" key))
	      (puthash key path tbl)
	      (push key ido-list)
	      )
	    project-files
	    )
      (find-file (gethash (ido-completing-read "project-files: " ido-list) tbl)))))
    ;; bind to a key for quick access
    (define-key global-map [f6] 'my-ido-project-files)

(global-set-key [f7] 'search-all-buffers)

(defun my-ido-find-tag ()
    "Find a tag using ido"
    (interactive)
    (tags-completion-table)
    (let (tag-names)
      (mapc (lambda (x)
              (unless (integerp x)
                (push (prin1-to-string x t) tag-names)))
            tags-completion-table)
      (find-tag (ido-completing-read "Tag: " tag-names))))

(defun ido-find-file-in-tag-files ()
      (interactive)
      (save-excursion
        ;; flex matching is too slow to be used with such a large file list
        (setq ido-enable-flex-matching nil
              ido-enable-regexp t)
        (let ((enable-recursive-minibuffers t))
          (visit-tags-table-buffer))
        (find-file
         (expand-file-name
          (ido-completing-read
           "Project file: " (tags-table-files) nil t)))))


(defun wrap-html-tag (tagName)
  "Add a tag to beginning and ending of current word or text selection."
  (interactive "sEnter tag name: ")
  (let (p1 p2 inputText)
    (if (use-region-p)
        (progn 
          (setq p1 (region-beginning) )
          (setq p2 (region-end) )
          )
      (let ((bds (bounds-of-thing-at-point 'symbol)))
        (setq p1 (car bds) )
        (setq p2 (cdr bds) ) ) )

    (goto-char p2)
    (insert "</" tagName ">")
    (goto-char p1)
    (insert "<" tagName ">")
    ))

(defun my-tag-lines (b e tag)
  "'tag' every line in the region with a tag"
  (interactive "r\nMTag for line: ")
  (save-restriction
    (narrow-to-region b e)
    (save-excursion
      (goto-char (point-min))
      (while (< (point) (point-max))
        (beginning-of-line)
        (insert (format "<%s>" tag))
        (end-of-line)
        (insert (format "</%s>" tag))
        (forward-line 1)))))

(global-set-key [f8] 'ido-find-file-in-tag-files)

  ;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

(defvar my-local-shells
  '("*shell0*" "*shell1*" "*shell2*" "*shell3*"))

(defvar my-shells (append my-local-shells))

(custom-set-variables
 '(comint-scroll-to-bottom-on-input t)  ; always insert at the bottom
 '(comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
 '(comint-scroll-show-maximum-output t) ; scroll to show max possible output
 ;; '(comint-completion-autolist t)     ; show completion list when ambiguous
 '(comint-input-ignoredups t)           ; no duplicates in command history
 '(comint-completion-addsuffix t)       ; insert space/slash after file completion
 '(comint-buffer-maximum-size 1000)    ; max length of the buffer in lines
 '(comint-prompt-read-only nil)         ; if this is t, it breaks shell-command
 '(comint-get-old-input (lambda () "")) ; what to run when i press enter on a
                                        ; line above the current prompt
 '(comint-input-ring-size 5000)         ; max shell history size
 '(protect-buffer-bury-p nil)
)

(setenv "PAGER" "cat")

;; truncate buffers continuously
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

(defun make-my-shell-output-read-only (text)
  "Add to comint-output-filter-functions to make stdout read only in my shells."
  (if (member (buffer-name) my-shells)
      (let ((inhibit-read-only t)
            (output-end (process-mark (get-buffer-process (current-buffer)))))
        (put-text-property comint-last-output-start output-end 'read-only t))))
(add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)

(defun my-dirtrack-mode ()
  "Add to shell-mode-hook to use dirtrack mode in my shell buffers."
  (when (member (buffer-name) my-shells)
    (shell-dirtrack-mode 0)
    (set-variable 'dirtrack-list '("^.*[^ ]+:\\(.*\\)>" 1 nil))
    (dirtrack-mode 1)))
(add-hook 'shell-mode-hook 'my-dirtrack-mode)

; interpret and use ansi color codes in shell output windows
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))
(add-hook 'shell-mode-hook 'set-scroll-conservatively)

(defun enter-again-if-enter ()
  "Make the return key select the current item in minibuf and shell history isearch.
An alternate approach would be after-advice on isearch-other-meta-char."
  (when (and (not isearch-mode-end-hook-quit)
             (equal (this-command-keys-vector) [13])) ; == return
    (cond ((active-minibuffer-window) (minibuffer-complete-and-exit))
          ((member (buffer-name) my-shells) (comint-send-input)))))
(add-hook 'isearch-mode-end-hook 'enter-again-if-enter)

(defadvice comint-previous-matching-input
    (around suppress-history-item-messages activate)
  "Suppress the annoying 'History item : NNN' messages from shell history isearch.
If this isn't enough, try the same thing with
comint-replace-by-expanded-history-before-point."
  (let ((old-message (symbol-function 'message)))
    (unwind-protect
      (progn (fset 'message 'ignore) ad-do-it)
    (fset 'message old-message))))

(defadvice comint-send-input (around go-to-end-of-multiline activate)
  "When I press enter, jump to the end of the *buffer*, instead of the end of
the line, to capture multiline input. (This only has effect if
`comint-eol-on-send' is non-nil."
  (flet ((end-of-line () (end-of-buffer)))
    ad-do-it))

;if a file is already open in read only mode, use this to re-open the
;file with sudo access
(defun find-alternative-file-with-sudo ()
  (interactive)
  (let ((fname (or buffer-file-name
		   dired-directory)))
    (when fname
      (if (string-match "^/sudo:root@localhost:" fname)
	  (setq fname (replace-regexp-in-string
		       "^/sudo:root@localhost:" ""
		       fname))
	(setq fname (concat "/sudo:root@localhost:" fname)))
      (find-alternate-file fname))))

(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c C-e") 'eval-and-replace)

(toggle-fullscreen)

(require 'dired-x)
(require 'wdired)
(setq wdired-allow-to-change-permissions 'advanced)
(define-key dired-mode-map (kbd "r") 'wdired-change-to-wdired-mode)

;;; to fix "void function inf-ruby-keys" error
(defalias 'inf-ruby-keys 'inf-ruby-setup-keybindings)

;; Projectile mode
(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(setq projectile-enable-caching t)
;; Projectile mode

;;; load my custom yas snippets
(yas/load-directory (concat dotfiles-dir "snippets/"))

;;; It turns out that global-set-key can be overridden by minors modes.
;;; To prevent minor modes from overriding our keybindings, we have to
;;; place them into a minor-mode, as follows:
;;; BEGIN MINOR MODE KEYBINDINGS
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

;;; place keybindings here that you want to be used globally and not overridden
(define-key my-keys-minor-mode-map (kbd "M-r") 'replace-regexp)
(define-key my-keys-minor-mode-map (kbd "C-c y") 'djcb-duplicate-line)
(define-key my-keys-minor-mode-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key my-keys-minor-mode-map (kbd "M-t") 'toggle-truncate-lines)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(defadvice load (after give-my-keybindings-priority)
  "Try to ensure that my keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'my-keys-minor-mode))
      (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))
(ad-activate 'load)

(my-keys-minor-mode 1)
;;; END MINOR MODE KEYBINDINGS

;; disable auto fill in text mode, 'cause it's annoying
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

;; make C-n insert newlines if the point is at the end of the buffer
(setq next-line-add-newlines t)

(global-set-key (kbd "M-i") 'imenu)

;; KEYBOARD MACROS
(fset 'copy_columns
   [?\C-x ?b ?m ?y ?_ ?t ?e ?m ?p ?_ ?b ?u ?f ?f ?e ?r return ?\C-y ?\M-< C-return ?\M-> ?\C-s ?| ?\C-u ?2 ?\C-b ?\C-w ?\C-  ?\M-> ?\C-y ?\M-< ?\C-  ?\M-> ?\M-r ?^ ?  return return ?\M-< ?\C-  ?\M-> ?\M-r tab return return return ?\C-  ?\M-< ?\M-r ?  ?$ return return ?\M-< ?\C-  ?\M-> ?\M-r ?\\ ?\( ?. ?* ?\\ ?\) ?\C-q ?\C-j return ?\" ?\\ ?1 ?| backspace ?\" ?, ?  return backspace backspace ?\] ?\C-a ?\[ ?\C-a ?\C-  ?\M-> ?\M-w ?\C-x ?k return ?\C-y ?\C-a])

(fset 'kb
      [?\C-a ?\C-  ?\C-  ?\C-e ?\C-b ?\C-\M-f ?\C-w ?\M-\' ?\C-w])

(fset 'keb
      [?\C-  ?\C-e ?\C-b ?\C-\M-f ?\C-e ?\C-w])
