(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
n    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

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

;; from http://lists.gnu.org/archive/html/emacs-devel/2010-05/msg00972.html
(defun isearch-kill-found ()
  "Kills the region that isearch has found."
  (interactive)
  (isearch-exit)
  (kill-region isearch-other-end (point)))
;; END COPYING LINES WITHOUT SELECTING THEM

;; DUPLICATING LINES AND COMMENTING THEM
;; http://emacs-fu.blogspot.com/
;; Someone on the Emacs Help mailing list asked for an easy way to duplicate a line
;; and, optionally, comment-out the first one.

;; I hacked up something quickly to solve both questions, and it has evolved a
;; little bit since – to answer both of the questions. The bit of weirdness in
;; the end is because of the special case of the last line in a buffer. It
;; defines key bindings C-c y for duplicating a line, and C-c c for
;; duplicating + commenting – but of course you can change those.
(defun djcb-duplicate-line (&optional commentfirst)
  "comment line at point; if COMMENTFIRST is non-nil, comment the original"
  (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
    (comment-region (region-beginning) (region-end)))
    (insert-string
      (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))
;; END DUPLICATING LINES AND COMMENTING THEM

;; copies a line from the given line number and inserts it
;; at the current point
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
