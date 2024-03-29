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
  "Insert puts message containing clipboard contents."
  (interactive)
  (setq logmsg
       (cl-case major-mode
         (sh-mode (concat "echo \"XXXXXXXXXXXXXXXX "
                           (upcase (car kill-ring))
                           ": ${" (car kill-ring)
                           "} XXXXXXXXXXXXXXXX\"")
                   )
         (ruby-mode (concat "puts \"XXXXXXXXXXXXXXXX\", " "(%|"
                             (upcase (car kill-ring))
                             ": #{" (car kill-ring)
                             ".inspect}|), \"XXXXXXXXXXXXXXXX\"")
                     )
         (js2-mode (concat "console.log('\\nXXXXXXXXXXXXXXXX\\n"
                             (upcase (car kill-ring))
                             ":', (() => { try { return JSON.stringify("
                             (car kill-ring)
                             ", null, 2) } catch(_) { return "
                             (car kill-ring) " }})(), '\\nXXXXXXXXXXXXXXXX\\n');")
                     )
         (js-mode (concat "console.log('\\nXXXXXXXXXXXXXXXX\\n"
                             (upcase (car kill-ring))
                             ":', JSON.stringify("
                             (car kill-ring)
                             ", null, 2), '\\nXXXXXXXXXXXXXXXX\\n');")
                     )
         ((go-mode go-ts-mode)
          (format "pretty.Printf(\"\\nXXXXXXXXXXXXXXXX\\n %s:\\n \
%%# v \\nXXXXXXXXXXXXXXXX\\n\", %s)" (car kill-ring) (car kill-ring))
          )
         )
       )
  (insert logmsg)
  )

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal)q)

;; $GOPATH/src/github.com/wrsinc/protobuf/identity/service/partyrelationship
(defun resolve-proto ()
  "open protobuf file"
  (interactive)
  (save-excursion
    (re-search-backward "&\\|\\*\\| " nil t)
    (forward-char)

    (let ((beg (point)))
      (re-search-forward ",\\|{\\|$\\|)\\| " nil t)
      (backward-char)

      (let ((str (buffer-substring-no-properties beg (point))))
        (print str)
        (let ((package-name (car (split-string str "\\."))))
          (let ((message-name (car (cdr (split-string str "\\.")))))
            (beginning-of-buffer)
            (re-search-forward (concat package-name  " \"github\.com/wrsinc/gogenproto/"))
            (let ((proto-path-start (point)))
              (re-search-forward "\"")
              (backward-char)
              (let ((proto-path (buffer-substring-no-properties proto-path-start (point))))
                (switch-to-buffer
                 (find-file-noselect
                  (concat "/Users/adam/golang/src/github.com/wrsinc/protobuf/"
                          proto-path
                          "/" (replace-regexp-in-string (regexp-quote "_") "." package-name nil 'literal))))
                (beginning-of-buffer)
                (re-search-forward (concat "message " message-name))
                )
              )
            )
          )
        )
      )
    )
  )

;; (string-match "party_relationship_service_type \"github.com/wrsinc/gogenproto/" (buffer-string) 0)
;; URL ENCODING/DECODING
(defun func-region (start end func)
  "run a function over the region between START and END in current buffer."
  (save-excursion
    (let ((text (delete-and-extract-region start end)))
      (insert (funcall func text)))))

(defun hex-region (start end)
  "urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-hexify-string))

(defun unhex-region (start end)
  "de-urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-unhex-string))

(defun unhex-region (start end)
  "de-urlencode the region between START and END in current buffer."
  (interactive "r")
  (func-region start end #'url-unhex-string))

(defun mr-for-line ()
  "copies the Merge Request for the current line"
  (interactive)
  (let* (
        (sha (shell-command-to-string (format "git blame -L%s,%s %s | cut -f 1 -d ' ' | tr -d '\n'"  (line-number-at-pos) (line-number-at-pos) (buffer-file-name))))
        (merge (shell-command-to-string (format "(git rev-list %s..HEAD --ancestry-path | cat -n; git rev-list %s..HEAD --first-parent | cat -n) | sort -k2 -s | uniq -f1 -d | sort -n | tail -1 | cut -f2" sha sha)))
        (merge_commit (shell-command-to-string (format "git show %s" merge)))
        )
    (save-match-data
      (and (string-match "See merge request \\(.*\\)" merge_commit)
           (let* (
                  (mr_url_or_path (match-string 1 merge_commit))
                  )
             (if (string-prefix-p "https://" mr_url_or_path)
                 (progn
                   ;; mr_url_or_path was a URL
                   (kill-new mr_url_or_path)
                   (browse-url mr_url_or_path)
                   )
               ;; mr_url_or_path was not a URL, need to convert it to a URL
               (progn
                 (let* (
                        (mr_url (replace-regexp-in-string "!" "/-/merge_requests/" (format "https://gitlab.com/%s" (match-string 1 merge_commit))))
                        )
                   (kill-new mr_url)
                   (browse-url mr_url)
                   ))
               )
             )
           )
      )
    )
  )

(defun git-url-to-file ()
  "copies the git URL to the current version of the buffer file"
  (interactive)
  (let* ((git-remote (shell-command-to-string "git remote -v | grep 'origin.*fetch' | cut -f 2 | sed 's/ (fetch)//' | tr -d '\n'"))
         (most-recent-sha (substring (shell-command-to-string "git rev-parse --short HEAD") 0 -1))
         (root-project-dir (substring (shell-command-to-string "git rev-parse --show-toplevel") 0 -1))
         (project-and-file-path (replace-regexp-in-string root-project-dir "" buffer-file-name))
         (beg (if (region-active-p) (line-number-at-pos (region-beginning)) (line-number-at-pos (line-beginning-position))))
         (end (if (region-active-p) (line-number-at-pos (region-end)) (line-number-at-pos (line-end-position))))
         (url-to-file (if (string-match-p "gitlab\.com" git-remote)
                         (format "https://gitlab.com/%s/blob/%s%s#L%d-%d"
                                 (string-trim-right (string-trim-left (string-trim-left git-remote "git@gitlab.com:") "https://gitlab.com/") ".git")
                                 most-recent-sha project-and-file-path beg end)
                       (format "%s/blob/%s%s#L%d-%d"
                               (string-trim-right git-remote ".git")
                               most-recent-sha project-and-file-path beg end))))
    (kill-new url-to-file)
    url-to-file))


(defun git-url-to-file-with-text ()
  "creates a markdown link to the git URL using the clipboard contents as the link name"
  (interactive)
  (kill-new (format "[%s](%s)" (car kill-ring) (git-url-to-file)))
  (deactivate-mark)
  )

(defun module-and-method-name ()
  "copies the current module name and method"
  (interactive)
  (let (
        (current-context (robe-context))
        )
    (kill-new (format "%s#%s" (car current-context) (car (last current-context))))
    (deactivate-mark)
    )
  )

(defun git-url-to-file-with-module ()
  "creates a makrdown link to the git URL using the module and method name as the link name"
  (interactive)
  (let (
        (current-context (robe-context))
        )
    (kill-new (format "[%s#%s](%s)" (car current-context) (car (last current-context)) (git-url-to-file)))
    (deactivate-mark)
    )
  )

(defun godef-describe-and-copy ()
  "runs godef-describe at point and saves result to kill ring"
  (interactive)
  (kill-new (godef-describe (point)))
  )

(defun imgfy ()
  "convert a GitLab image string to the HTML equivalen"
  (interactive)
  (kill-new (replace-regexp-in-string "!\\[.*?\\](\\(.*?\\))" "<img src=\"\\1\" width=\"50%\" height=\"50%\" />" (car kill-ring)))
  )

;; (defun labelfy ()
;;   "adds gitlab labels to the text in the clipboard"
;;   (interactive)
;;   (insert (shell-command-to-string (concat "ruby /Users/adam/bin/labelfy.rb " (concat (concat "\"" (car kill-ring)) "\""))))
;;   )
