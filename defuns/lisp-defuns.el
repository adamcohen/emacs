(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun region-to-shell-command ()
  "Executes the code in the region and appends the result."
  (interactive)
  (if (y-or-n-p "Run this command?")
      (insert (concat "\n\n" (shell-command-to-string
                              (buffer-substring (mark) (point)))))
    'no))
