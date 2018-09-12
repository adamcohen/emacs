;;; Compiled snippets and support files for `go-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'go-mode
                     '(("wh" "When(\"$1\", func() {\n  $0\n})\n" "when" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/when" nil nil)
                       ("va" "var (\n  $0\n)" "varlist" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/varlist" nil nil)
                       ("swt" "switch x := $1.(type) {\n  case $2:\n  case $3:\n  default:\n}\n$0" "switchwithtype" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/switchwithtype" nil nil)
                       ("jbe" "JustBeforeEach(func() {\n  $0\n})\n" "justbeforeeach" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/justbeforeeach" nil nil)
                       ("it" "It(\"$1\", func() {\n  $0\n})\n" "it" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/it" nil nil)
                       ("ife" "if err != nil {\n   $0\n}" "iferror" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/iferror" nil nil)
                       ("fdm" "func ($1) $2($3) ($4) {\n  $0\n}\n" "functiondefmethod" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/functiondefmethod" nil nil)
                       ("fd" "func $1($2) ($3) {\n  $0\n}\n" "functiondef" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/functiondef" nil nil)
                       ("ene" "Expect(err).NotTo(HaveOccurred())\n$0" "expectnoerr" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/expectnoerr" nil nil)
                       ("ee" "Expect($1).To(Equal($0))" "expectequals" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/expectequals" nil nil)
                       ("ex" "Expect($1).To($0)" "expect" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/expect" nil nil)
                       ("ds" "Describe(\"$1\", func() {\n  $0\n})\n" "describe" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/describe" nil nil)
                       ("ct" "Context(\"$1\", func() {\n  $0\n})\n" "context" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/context" nil nil)
                       ("be" "BeforeEach(func() {\n  $0\n})\n" "beforeeach" nil nil nil "/Users/adam/.emacs.d/snippets/go-mode/beforeeach" nil nil)))


;;; Do not edit! File generated at Mon Sep 10 16:29:45 2018
