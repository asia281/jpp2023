module Print where

import AbsGrammar
import Data.Char

-- the printer class does the job
class Print a where
  prt :: Int -> a -> Doc
  prtList :: Int -> [a] -> Doc
  prtList i = concatD . map (prt i)



instance Print Integer where
  prt _ x = doc (shows x)

instance Print Double where
  prt _ x = doc (shows x)

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j<i then parenth else id

instance Print Op where
  prt i e = case e of
    Plus -> prPrec i 0 (concatD [doc (showString "+")])
    Minus -> prPrec i 0 (concatD [doc (showString "-")])
    Mult -> prPrec i 0 (concatD [doc (showString "*")])
    Div -> prPrec i 0 (concatD [doc (showString "/")])
    Mod -> prPrec i 0 (concatD [doc (showString "%")])

instance Print RelOp where
  prt i e = case e of
    LTH -> prPrec i 0 (concatD [doc (showString "<")])
    LE -> prPrec i 0 (concatD [doc (showString "<=")])
    GTH -> prPrec i 0 (concatD [doc (showString ">")])
    GE -> prPrec i 0 (concatD [doc (showString ">=")])
    EQ -> prPrec i 0 (concatD [doc (showString "==")])
    NEQ -> prPrec i 0 (concatD [doc (showString "!=")])
