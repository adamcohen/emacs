
(setq
 ;; ignore uninteresting files from helm-find-files. Add exclusion patterns to helm-boring-file-regexp-list
 helm-ff-skip-boring-files t

 ;; not sure which one of these is actually used, but one of them changes the behaviour
 ;; of helm so that when there's only a single available option in a list, it automatically
 ;; selects that option
 ff-auto-update-initial-value t
 helm-ff-auto-update-initial-value t
 helm-buffer-max-length 50
  )

(provide 'setup-helm)
