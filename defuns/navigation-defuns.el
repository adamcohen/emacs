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
  (move-to-window-line 0)
  (toggle-truncate-lines 1)
  (let ((window-start-line-no (line-number-at-pos)))
    (let ((window-start-num (string-to-number (substring (number-to-string window-start-line-no) -2 nil))))
      (if (> arg window-start-num)
          (move-to-window-line (- arg window-start-num))
        (move-to-window-line (- (+ arg 100) window-start-num)))
      )
    )
  (toggle-truncate-lines nil)
)
