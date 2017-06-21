;; CUSTOM DEFUNS
(global-set-key (kbd "M-C-m") 'isearch-kill-found)
(global-set-key (kbd "M-P") 'move-line-up)
(global-set-key (kbd "M-N") 'move-line-down)
(global-set-key (kbd "C-c C-j") 'lw)
(global-set-key (kbd "C-c C-p") 'lp)

;make F9 switch to *scratch*
(global-set-key (kbd "<f9>")
  (lambda()(interactive)(switch-to-buffer "*scratch*")))

;; duplicate a line
(global-set-key (kbd "C-c y") 'djcb-duplicate-line)

;; duplicate a line and comment the first
(global-set-key (kbd "C-c c") (lambda()(interactive)(djcb-duplicate-line t)))
;; END CUSTOM DEFUNS

;; setting the mark
(global-set-key (kbd "M-'") 'jump-to-mark)
(global-set-key (kbd "C-'") 'push-mark-no-activate)

;; Should be able to eval-and-replace anywhere.
(global-set-key (kbd "C-c C-e") 'eval-and-replace)

;; misc
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key [f11] 'toggle-fullscreen)
(global-set-key (kbd "M-i") 'imenu)
(global-set-key [f5] 'call-last-kbd-macro)

;; moving around in a file
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-n"  (lambda () (interactive) (scroll-up   1)) )
(global-set-key "\M-p"  (lambda () (interactive) (scroll-down 1)) )

;; file searching
(global-set-key [f8] 'ido-find-file-in-tag-files)
(global-set-key [f7] 'search-all-buffers)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; remap M-g to goto-line
(eval-after-load 'ibuffer
  '(define-key ibuffer-mode-map (kbd "M-g") 'goto-line))

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
(autoload 'magit-status "magit")

;; eww navigation
(defun oleh-eww-hook ()
  (define-key eww-mode-map "j" 'oww-down)
  (define-key eww-mode-map "k" 'oww-up)
  (define-key eww-mode-map "l" 'forward-char)
  (define-key eww-mode-map "L" 'eww-back-url)
  (define-key eww-mode-map "h" 'backward-char)
  (define-key eww-mode-map "v" 'recenter-top-bottom)
  (define-key eww-mode-map "V" 'eww-view-source)
  (define-key eww-mode-map "m" 'eww-follow-link)
  (define-key eww-mode-map "a" 'move-beginning-of-line)
  (define-key eww-mode-map "e" 'move-end-of-line)
  (define-key eww-mode-map "o" 'ace-link-eww)
  (define-key eww-mode-map "y" 'eww)
  (define-key eww-mode-map "\M-n" (lambda () (interactive) (scroll-up 1)) )
  (define-key eww-mode-map "\M-p" (lambda () (interactive) (scroll-down 1)) ))
(add-hook 'eww-mode-hook 'oleh-eww-hook)

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
(global-set-key (kbd "C--") 'er/contract-region)
(global-set-key (kbd "M-S-<backspace>") 'subword-backward-kill)

(define-key (current-global-map) (kbd "M-o") 'other-window)
(define-key (current-global-map) (kbd "M-O") 'frame-bck)

;;; It turns out that global-set-key can be overridden by minors modes.
;;; To prevent minor modes from overriding our keybindings, we have to
;;; place them into a minor-mode, as follows:
;;; TODO: might be able to use current-global-map instead
;;; BEGIN MINOR MODE KEYBINDINGS
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

;;; place keybindings here that you want to be used globally and not overridden
(define-key my-keys-minor-mode-map (kbd "M-r") 'replace-regexp)
(define-key my-keys-minor-mode-map (kbd "C-c y") 'djcb-duplicate-line)
(define-key my-keys-minor-mode-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key my-keys-minor-mode-map (kbd "M-t") 'toggle-truncate-lines)

(define-key my-keys-minor-mode-map (kbd "C-s") 'isearch-forward-regexp)
(define-key my-keys-minor-mode-map (kbd "C-r") 'isearch-backward-regexp)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(defadvice load (after give-my-keybindings-priority)
  "Try to ensure that my keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'my-keys-minor-mode))
      (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))
(ad-activate 'load)

(my-keys-minor-mode 1)
;;; END MINOR MODE KEYBINDINGS


(provide 'key-bindings)
