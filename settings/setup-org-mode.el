;; enable org-mode github-flavoured-markdown
;; can also use M-x org-gfm-export-to-markdown
(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; https://orgmode.org/manual/Clean-view.html
;; use only one star and indents text to line with the heading
(setq org-startup-indented 't)

;; When Emacs first visits an Org file, the global state is set to OVERVIEW,
;; i.e., only the top level headlines are visible. A nil value here will
;; change the startup to `showeverything`
;; https://orgmode.org/manual/Initial-visibility.html#Initial-visibility
(setq org-startup-folded nil)

;; format bold/italic without displaying the markers
(setq org-hide-emphasis-markers t)

(custom-theme-set-faces 'user `(org-level-4 ((t (:foreground "#FF00FF")))))

(provide 'setup-org-mode)
