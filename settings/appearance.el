(setq visible-bell t)

;; put line numbers on all buffers
(global-linum-mode t)

;; Highlight current line
(global-hl-line-mode 1)
(make-variable-buffer-local 'global-hl-line-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'clarity t)

(set-face-attribute 'default nil
                    :family "Monaco" :height (case system-type
                                             ('gnu/linux 130)
                                             ('darwin 160)) :weight 'normal)


(toggle-fullscreen)

(provide 'appearance)
