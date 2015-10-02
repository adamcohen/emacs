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
