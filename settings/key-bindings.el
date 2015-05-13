;; CUSTOM DEFUNS
(global-set-key (kbd "M-C-m") 'isearch-kill-found)
(global-set-key (kbd "M-P") 'move-line-up)
(global-set-key (kbd "M-N") 'move-line-down)

;; duplicate a line
(global-set-key (kbd "C-c y") 'djcb-duplicate-line)

;; duplicate a line and comment the first
(global-set-key (kbd "C-c c") (lambda()(interactive)(djcb-duplicate-line t)))
;; END CUSTOM DEFUNS

;; setting the mark
(global-set-key (kbd "M-'") 'jump-to-mark)
(global-set-key (kbd "C-'") 'push-mark-no-activate)

(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;; misc
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key [f11] 'toggle-fullscreen)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(autoload 'magit-status "magit")

;; Experimental multiple-cursors
(global-set-key (kbd "C-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; smex
;;; hack to ensure that flex matching is enabled for smex, since
;;; I disabled flex matching for ido-find-file-in-tag-files because it's
;;; too slow
(global-set-key (kbd "M-x") (lambda ()
                             (interactive)
                             (setq ido-enable-flex-matching t
                                   ido-enable-regexp nil)
                             (smex)))

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "M-S-<backspace>") 'subword-backward-kill)


(provide 'key-bindings)
