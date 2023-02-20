(setq visible-bell t)

;; put line numbers on all buffers
;; for emacs-29
(global-display-line-numbers-mode t)

;; Highlight current line
(global-hl-line-mode 1)
(make-variable-buffer-local 'global-hl-line-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'clarity t)

(set-face-attribute 'default nil
                  :family "Monaco" :height (cl-case system-type
                                           ('gnu/linux 130)
                                           ('darwin 160)) :weight 'normal)
(font-lock-add-keywords
 'js2-mode `(("\\(function *\\)("
              (0 (progn (compose-region (match-beginning 1) (match-end 1) "ƒ")
                        nil)))))

(toggle-fullscreen)

(provide 'appearance)
