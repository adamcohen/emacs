;; key bindings

(setq mac-option-modifier 'alt)
(setq mac-command-modifier 'meta)

;; sets fn-delete to be right-delete
(global-set-key [kp-delete] 'delete-char)

;; Ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

(provide 'mac)
