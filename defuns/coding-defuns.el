(defun westfield-email-address ()
  (interactive)
  "copy testing email address to clipboard"
  (kill-new (concat "westfieldlabsdemo+" (number-to-string (truncate (time-to-seconds))) "@gmail.com"))
  )

(defun mailinator-email-address ()
  (interactive)
  "copy testing email address to clipboard"
  (kill-new (concat "westfieldlabsdemo" (number-to-string (truncate (time-to-seconds))) "@mailinator.com"))
  )

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
         ('ruby-mode (concat "puts \"XXXXXXXXXXXXXXXX\", " "(%|"
                             (upcase (car kill-ring))
                             ": #{" (car kill-ring)
                             ".inspect}|), \"XXXXXXXXXXXXXXXX\"")
                     )
         ('js2-mode  (concat "console.log('\\nXXXXXXXXXXXXXXXX\\n"
                             (upcase (car kill-ring))
                             ":', (() => { try { return JSON.stringify("
                             (car kill-ring)
                             ", null, 2) } catch(_) { return "
                             (car kill-ring) " }})(), '\\nXXXXXXXXXXXXXXXX\\n');")
                     )
         ('js-mode  (concat "console.log('\\nXXXXXXXXXXXXXXXX\\n"
                             (upcase (car kill-ring))
                             ":', JSON.stringify("
                             (car kill-ring)
                             ", null, 2), '\\nXXXXXXXXXXXXXXXX\\n');")
                     )
         ('go-mode
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
  (interactive)
  "open protobuf file"
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

(defun git-url-to-file ()
  "copies the git URL to the current version of the buffer file"
  (interactive)
  (let ((git-remote (shell-command-to-string "git remote -v | grep 'origin.*fetch' | cut -f 2 | sed 's/ (fetch)//' | tr -d '\n'")))
    (let ((most-recent-sha
           (shell-command-to-string
            (format "git ls-remote %s | head -n 1 | cut -f 1 | tr -d '\n'" git-remote))))
      (let ((project-name (file-name-nondirectory (replace-regexp-in-string "\.git$" "" git-remote))))
        (let ((project-and-file-path (replace-regexp-in-string (format ".*?%s/" project-name) "" buffer-file-name)))
          (let (beg end)
            (if (region-active-p)
                (setq beg (line-number-at-pos (region-beginning)) end (line-number-at-pos (region-end)))
              (setq beg (line-number-at-pos (line-beginning-position)) end (line-number-at-pos (line-end-position))))
            ;; github uses L%d-L%d, while gitlab uses L%d-%d
            (kill-new (format "%s/blob/%s/%s#L%d-%d" (replace-regexp-in-string "^git@gitlab\.com:\\(.*?\\)\.git$" "https://gitlab.com/\\1" git-remote) most-recent-sha project-and-file-path beg end))
            )
          )
        )
      )
    )
  )

(defun godef-describe-and-copy ()
  "runs godef-describe at point and saves result to kill ring"
  (interactive)
  (kill-new (godef-describe (point)))
  )

;; (defun labelfy ()
;;   "adds gitlab labels to the text in the clipboard"
;;   (interactive)
;;   (insert (shell-command-to-string (concat "ruby /Users/adam/bin/labelfy.rb " (concat (concat "\"" (car kill-ring)) "\""))))
;;   )
