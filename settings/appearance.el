(setq visible-bell t)

;; put line numbers on all buffers
;; for emacs-29
(global-display-line-numbers-mode t)

;; Highlight current line
(global-hl-line-mode 1)
(make-variable-buffer-local 'global-hl-line-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'clarity t)

(let ((base-height (cl-case system-type
                     ((gnu/linux quote) 130)
                     ((darwin quote) 160))))
  ;; Main default face
  (set-face-attribute 'default nil
                      :family "Monaco"
                      :height (round (* base-height 1.6))  ; Convert to integer
                      :weight 'normal)

  ;; Scale UI elements
  (set-face-attribute 'mode-line nil :height (round (* base-height 1.6)))
  (set-face-attribute 'mode-line-inactive nil :height (round (* base-height 1.6)))
  (set-face-attribute 'minibuffer-prompt nil :height (round (* base-height 1.6)))
  (set-face-attribute 'header-line nil :height (round (* base-height 1.6))))

;; (set-face-attribute 'default nil
;;                   :family "Monaco" :height (cl-case system-type
;;                                            ((gnu/linux quote) 130)
;;                                            ((darwin quote) 160)) :weight 'normal)
(font-lock-add-keywords
 'js2-mode `(("\\(function *\\)("
              (0 (progn (compose-region (match-beginning 1) (match-end 1) "ƒ")
                        nil)))))

(toggle-fullscreen)

(provide 'appearance)


;;

(setq visible-bell t)

;; put line numbers on all buffers
;; for emacs-29
(global-display-line-numbers-mode t)

;; Highlight current line
(global-hl-line-mode 1)
(make-variable-buffer-local 'global-hl-line-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'clarity t)

;; Detect if we're on a 6K display (height > 3000 pixels)
(defun is-6k-display-p ()
  "Return t if the display height suggests 6K resolution."
  (let ((height (display-pixel-height)))
    (> height 3000)))  ; 6K is 3384, 4K is 2160

(let* ((is-6k (and (eq system-type 'darwin) (is-6k-display-p)))
       (base-height (cond
                     (is-6k 160)  ; 6K on macOS
                     ((eq system-type 'darwin) 130)  ; 4K on macOS
                     ((eq system-type 'gnu/linux) 130)  ; Linux
                     (t 130))))  ; Default
  ;; Main default face
  (set-face-attribute 'default nil
                      :family "Monaco"
                      :height (if is-6k
                                  (round (* base-height 1.6))
                                base-height)
                      :weight 'normal)

  ;; Scale UI elements only on 6K
  (when is-6k
    (set-face-attribute 'mode-line nil :height (round (* base-height 1.6)))
    (set-face-attribute 'mode-line-inactive nil :height (round (* base-height 1.6)))
    (set-face-attribute 'minibuffer-prompt nil :height (round (* base-height 1.6)))
    (set-face-attribute 'header-line nil :height (round (* base-height 1.6)))))

(font-lock-add-keywords
 'js2-mode `(("\\(function *\\)("
              (0 (progn (compose-region (match-beginning 1) (match-end 1) "ƒ")
                        nil)))))

(toggle-fullscreen)

(provide 'appearance)
