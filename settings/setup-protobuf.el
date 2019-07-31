(defun my-protobuf-mode-hook ()
  ;; make sure protobuf treats CamelCase letters as word boundaries for forward-word and backward-word
  (c-subword-mode t)
  )

(add-hook 'protobuf-mode-hook 'my-protobuf-mode-hook)

(provide 'setup-protobuf)
