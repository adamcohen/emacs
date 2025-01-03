(fset 'copy_columns
   [?\C-s ?| return ?\C-b C-return ?\C-e ?\M-> ?\C-w ?\C-a ?\C-  ?\M-> ?\C-u ?\M-| ?t ?r ?  ?- ?s ?  ?\' ?  ?\' return ?\C-  ?\C-  ?\C-  ?\M-> ?\M-r ?^ ?  return return ?\M-\' ?\C-  ?\C-  ?\C-  ?\C-  ?\C-  ?\M-> ?\M-r ?  ?$ return return ?\M-\' ?\C-  ?\C-  ?\C-  ?\M-> ?\M-r ?\C-q ?\C-j return ?, ?  return ?\C-a])

(fset 'kb
      [?\C-a ?\C-  ?\C-  ?\C-e ?\C-b ?\C-\M-f ?\C-w ?\M-\' ?\C-w])

(fset 'keb
      [?\C-  ?\C-e ?\C-b ?\C-\M-f ?\C-e ?\C-w])

(fset 'select-block
   [?\M-m ?\C-  ?\C-e ?\C-b ?\C-\M-l ?\C-e])

(defalias 'gl-update
   (kmacro "C-r <return> C u r r e n t <return> C-a C-k C-a C-SPC C-s <return> C-q C-j C-q C-j <return> C-k M-w C-j C-y C-SPC C-r <return> T o d a y <return> C-j C-w C-k C-k C-e C-SPC C-a C-r <return> C u r r e n t <return> C-j C-y C-d C-k C-e C-SPC C-a C-r <return> C u r r e n t <return> C-j M-x c h a n g e - v e r b s - t o - p a s t - t e n s e <return> C-a C-r <return> C u r r e n t <return> C-j C-k C-k C-a C-l C-l C-SPC C-e <backspace> C-c . <return> C-s <return> T o d a y <return> C-j 1 . SPC"))

(provide 'keyboard-macros)
