(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:weight extra-bold))))
 '(idle-highlight ((t (:background "dark magenta"))))
 '(magit-item-highlight ((t (:weight extra-bold)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-buffer-maximum-size 1000)       ; max length of the buffer in lines
 '(comint-completion-addsuffix t)         ; insert space/slash after file completion
 '(comint-get-old-input (lambda () ""))   ; what to run when i press enter on a
                                          ; line above the current prompt
 '(comint-input-ignoredups t)             ; no duplicates in command history
 '(comint-input-ring-size 5000)           ; max shell history size
 '(comint-move-point-for-output nil)
 '(comint-prompt-read-only nil)           ; if this is t, it breaks shell-command
 '(comint-scroll-show-maximum-output t)   ; scroll to show max possible output
 '(comint-scroll-to-bottom-on-input t)    ; always insert at the bottom
 '(comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
 '(js2-basic-offset 2)
 '(js2-strict-missing-semi-warning nil)
 '(protect-buffer-bury-p nil)
 '(warning-minimum-level :error)
 ;; '(comint-completion-autolist t)     ; show completion list when ambiguous
 )
