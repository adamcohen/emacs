;;; Compiled snippets and support files for `go-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'go-mode
                     '(("jbe" "JustBeforeEach(\"$1\", func() {\n  $0\n})\n" "justbeforeeach" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/justbeforeeach" nil nil)
                       ("it" "It(\"$1\", func() {\n  $0\n})\n" "it" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/it" nil nil)
                       ("ene" "Expect(err).NotTo(HaveOccurred())\n$0" "expectnoerr" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/expectnoerr" nil nil)
                       ("ee" "Expect($1).To(Equal($0))" "expectequals" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/expectequals" nil nil)
                       ("ex" "Expect($1).To($0)" "expect" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/expect" nil nil)
                       ("ds" "Describe(\"$1\", func() {\n  $0\n})\n" "describe" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/describe" nil nil)
                       ("ct" "Context(\"$1\", func() {\n  $0\n})\n" "context" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/context" nil nil)
                       ("be" "BeforeEach(\"$1\", func() {\n  $0\n})\n" "beforeeach" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/beforeeach" nil nil)))


;;; Do not edit! File generated at Sat Aug 25 13:44:59 2018
