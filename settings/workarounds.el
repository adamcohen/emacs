;; this is needed because the cursor becomes set to black if a new frame is
;; created after emacs is already open. See
;; https://github.com/NicolasPetton/zerodark-theme/issues/3
(add-hook 'after-make-frame-functions
(lambda (frame)
(with-selected-frame frame
(set-cursor-color "yellow"))))

(provide 'workarounds)
