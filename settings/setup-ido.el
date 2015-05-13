;; Interactively Do Things
(require 'ido)
(ido-mode t)

;intelligently use hypen or space with smex 
(require 'ido-complete-space-or-hyphen)

(setq
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"
  ido-ignore-buffers ;; ignore these guys
  '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
     "^\*compilation" "^\*GTAGS" "^session\.*" "^\*")
  ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
  ido-case-fold  t                    ; be case-insensitive
  ido-create-new-buffer 'always       ; don't want ido to ask me if I really want to create a new buffer
  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30      ; should be enough
  ido-max-work-file-list      50      ; remember many
  ido-use-filename-at-point nil       ; don't use filename at point (annoying)
  ido-use-url-at-point nil            ; don't use url at point (annoying)
                                      ;  ido-enable-regexp t              ; use regexp matching
  ido-enable-flex-matching t
  ido-max-prospects 8                 ; don't spam my minibuffer
  ido-confirm-unique-completion t     ; wait for RET, even with unique completion
  )

(add-to-list 'ido-ignore-directories "target")
(add-to-list 'ido-ignore-directories "node_modules")

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

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

;; bind to a key for quick access
(define-key global-map [f6] 'my-ido-project-files)

(provide 'setup-ido)
