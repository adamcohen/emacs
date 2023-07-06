(defun oww-down (arg)
  (interactive "p")
  (if (bolp)
      (progn
        (forward-paragraph arg)
        (forward-line 1))
    (line-move arg)))

(defun oww-up (arg)
  (interactive "p")
  (if (bolp)
      (progn
        (forward-line -1)
        (backward-paragraph arg)
        (forward-line 1))
    (line-move (- arg))))

;; allows you to switch back and forth between frames
(defun frame-bck()
  (interactive)
  (other-window -1)
)

(defun goto-local-line (arg)
  "Type the last two digits of the line number to jump to."
  (interactive (list (read-number "Goto Line: ")) )
  (if (> arg 99)
      (goto-line arg)
    (setq saved-truncate-lines-val truncate-lines)
    (move-to-window-line 0)
    (setq truncate-lines 't)
    (let ((window-start-line-no (line-number-at-pos)))
      (if (< window-start-line-no 100)
          (let ((window-start-num (% (line-number-at-pos) 100)))
            (if (>= arg window-start-num)
                (move-to-window-line (- arg window-start-line-no))
              (move-to-window-line (- (+ arg 100) window-start-num)))
            )
        (let ((window-start-num (% (line-number-at-pos) 100)))
          (if (>= arg window-start-num)
              (move-to-window-line (- arg window-start-num))
            (move-to-window-line (- (+ arg 100) window-start-num)))
          )
        )
      )
    (setq truncate-lines saved-truncate-lines-val)
    )
  )

(defun other-window-or-frame ()
  "If the current frame has two windows, switch to the other window, otherwise, switch to another frame."
  (interactive)
  (if (equal (length (window-list)) 2)
      (other-window 1)
      (other-frame 1)
      )
)

(defun find-spec ()
  "Searches for a directory called 'spec' starting from the directory of the current buffer file."
  (interactive)
  (let (
        (current-dir (file-name-directory (buffer-file-name)))
        (spec-name (concat (file-name-base (buffer-file-name)) "_spec.rb"))
        )
    (while (and current-dir
                (not (file-equal-p current-dir "/"))
                (not (file-directory-p (concat current-dir "spec"))))
      (setq current-dir (file-name-directory (directory-file-name current-dir)))
      )
    (if (string-equal current-dir "/")
        (message "No 'spec' directory found.")
      (find-and-open-file spec-name (concat current-dir "spec"))
      )))

(defun find-and-open-file (filename path)
  "Searches for a file using the 'find' command starting from the given path and opens it in Emacs if found. Displays a message if the file is not found."
  (let* ((result (shell-command-to-string (concat "find " (shell-quote-argument path) " -type f -name " (shell-quote-argument filename) " -print -quit")))
         (filepath (and (not (string-empty-p result)) (file-truename (substring result 0 -1)))))
    (if filepath
        (find-file filepath)
      (message "File '%s' not found." filename))))
