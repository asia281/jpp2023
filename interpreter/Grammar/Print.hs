-- File generated by the BNF Converter (bnfc 2.9.4.1).

{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase #-}
#if __GLASGOW_HASKELL__ <= 708
{-# LANGUAGE OverlappingInstances #-}
#endif

-- | Pretty-printer for Grammar.

module Grammar.Print where

import Prelude
  ( ($), (.)
  , Bool(..), (==), (<)
  , Int, Integer, Double, (+), (-), (*)
  , String, (++)
  , ShowS, showChar, showString
  , all, elem, foldr, id, map, null, replicate, shows, span
  )
import Data.Char ( Char, isSpace )
import qualified Grammar.Abs

-- | The top-level printing method.

printTree :: Print a => a -> String
printTree = render . prt 0

type Doc = [ShowS] -> [ShowS]

doc :: ShowS -> Doc
doc = (:)

render :: Doc -> String
render d = rend 0 False (map ($ "") $ d []) ""
  where
  rend
    :: Int        -- ^ Indentation level.
    -> Bool       -- ^ Pending indentation to be output before next character?
    -> [String]
    -> ShowS
  rend i p = \case
      "["      :ts -> char '[' . rend i False ts
      "("      :ts -> char '(' . rend i False ts
      "{"      :ts -> onNewLine i     p . showChar   '{'  . new (i+1) ts
      "}" : ";":ts -> onNewLine (i-1) p . showString "};" . new (i-1) ts
      "}"      :ts -> onNewLine (i-1) p . showChar   '}'  . new (i-1) ts
      [";"]        -> char ';'
      ";"      :ts -> char ';' . new i ts
      t  : ts@(s:_) | closingOrPunctuation s
                   -> pending . showString t . rend i False ts
      t        :ts -> pending . space t      . rend i False ts
      []           -> id
    where
    -- Output character after pending indentation.
    char :: Char -> ShowS
    char c = pending . showChar c

    -- Output pending indentation.
    pending :: ShowS
    pending = if p then indent i else id

  -- Indentation (spaces) for given indentation level.
  indent :: Int -> ShowS
  indent i = replicateS (2*i) (showChar ' ')

  -- Continue rendering in new line with new indentation.
  new :: Int -> [String] -> ShowS
  new j ts = showChar '\n' . rend j True ts

  -- Make sure we are on a fresh line.
  onNewLine :: Int -> Bool -> ShowS
  onNewLine i p = (if p then id else showChar '\n') . indent i

  -- Separate given string from following text by a space (if needed).
  space :: String -> ShowS
  space t s =
    case (all isSpace t', null spc, null rest) of
      (True , _   , True ) -> []              -- remove trailing space
      (False, _   , True ) -> t'              -- remove trailing space
      (False, True, False) -> t' ++ ' ' : s   -- add space if none
      _                    -> t' ++ s
    where
      t'          = showString t []
      (spc, rest) = span isSpace s

  closingOrPunctuation :: String -> Bool
  closingOrPunctuation [c] = c `elem` closerOrPunct
  closingOrPunctuation _   = False

  closerOrPunct :: String
  closerOrPunct = ")],;"

parenth :: Doc -> Doc
parenth ss = doc (showChar '(') . ss . doc (showChar ')')

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

concatD :: [Doc] -> Doc
concatD = foldr (.) id

replicateS :: Int -> ShowS -> ShowS
replicateS n f = concatS (replicate n f)

-- | The printer class does the job.

class Print a where
  prt :: Int -> a -> Doc

instance {-# OVERLAPPABLE #-} Print a => Print [a] where
  prt i = concatD . map (prt i)

instance Print Char where
  prt _ c = doc (showChar '\'' . mkEsc '\'' c . showChar '\'')

instance Print String where
  prt _ = printString

printString :: String -> Doc
printString s = doc (showChar '"' . concatS (map (mkEsc '"') s) . showChar '"')

mkEsc :: Char -> Char -> ShowS
mkEsc q = \case
  s | s == q -> showChar '\\' . showChar s
  '\\' -> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  s -> showChar s

prPrec :: Int -> Int -> Doc -> Doc
prPrec i j = if j < i then parenth else id

instance Print Integer where
  prt _ x = doc (shows x)

instance Print Double where
  prt _ x = doc (shows x)

instance Print Grammar.Abs.Ident where
  prt _ (Grammar.Abs.Ident i) = doc $ showString i
instance Print Grammar.Abs.Program where
  prt i = \case
    Grammar.Abs.Program stmts -> prPrec i 0 (concatD [prt 0 stmts])

instance Print Grammar.Abs.Block where
  prt i = \case
    Grammar.Abs.Block stmts -> prPrec i 0 (concatD [doc (showString "{"), prt 0 stmts, doc (showString "}")])

instance Print [Grammar.Abs.Stmt] where
  prt _ [] = concatD []
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, prt 0 xs]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ";"), prt 0 xs]

instance Print Grammar.Abs.Stmt where
  prt i = \case
    Grammar.Abs.Decl type_ item -> prPrec i 0 (concatD [prt 0 type_, prt 0 item])
    Grammar.Abs.SExpr expr -> prPrec i 0 (concatD [prt 0 expr, doc (showString ";")])
    Grammar.Abs.If expr block -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 block])
    Grammar.Abs.IfElse expr block1 block2 -> prPrec i 0 (concatD [doc (showString "if"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 block1, doc (showString "else"), prt 0 block2])
    Grammar.Abs.While expr block -> prPrec i 0 (concatD [doc (showString "while"), doc (showString "("), prt 0 expr, doc (showString ")"), prt 0 block])
    Grammar.Abs.For id_ expr1 expr2 block -> prPrec i 0 (concatD [doc (showString "for"), doc (showString "("), prt 0 id_, doc (showString "from"), prt 0 expr1, doc (showString "to"), prt 0 expr2, doc (showString ")"), prt 0 block])
    Grammar.Abs.Print exprs -> prPrec i 0 (concatD [doc (showString "print"), doc (showString "("), prt 0 exprs, doc (showString ")"), doc (showString ";")])
    Grammar.Abs.PrintEndl exprs -> prPrec i 0 (concatD [doc (showString "printEndl"), doc (showString "("), prt 0 exprs, doc (showString ")"), doc (showString ";")])
    Grammar.Abs.Return expr -> prPrec i 0 (concatD [doc (showString "return"), prt 0 expr, doc (showString ";")])
    Grammar.Abs.ReturnVoid -> prPrec i 0 (concatD [doc (showString "return"), doc (showString ";")])
    Grammar.Abs.Assign id_ expr -> prPrec i 0 (concatD [prt 0 id_, doc (showString "="), prt 0 expr, doc (showString ";")])
    Grammar.Abs.FunDef id_ args type_ block -> prPrec i 0 (concatD [doc (showString "fun"), prt 0 id_, doc (showString "("), prt 0 args, doc (showString ")"), doc (showString "->"), prt 0 type_, prt 0 block])
    Grammar.Abs.SListPush id_ expr -> prPrec i 0 (concatD [prt 0 id_, doc (showString "."), doc (showString "push"), doc (showString "("), prt 0 expr, doc (showString ")")])

instance Print Grammar.Abs.Item where
  prt i = \case
    Grammar.Abs.NoInit id_ -> prPrec i 0 (concatD [prt 0 id_])
    Grammar.Abs.Init id_ expr -> prPrec i 0 (concatD [prt 0 id_, doc (showString "="), prt 0 expr])

instance Print [Grammar.Abs.Item] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print [Grammar.Abs.Expr] where
  prt _ [] = concatD []
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Grammar.Abs.Arg where
  prt i = \case
    Grammar.Abs.Arg typeorref id_ -> prPrec i 0 (concatD [prt 0 typeorref, prt 0 id_])

instance Print [Grammar.Abs.Arg] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Grammar.Abs.Type where
  prt i = \case
    Grammar.Abs.TInt -> prPrec i 0 (concatD [doc (showString "int")])
    Grammar.Abs.TBool -> prPrec i 0 (concatD [doc (showString "bool")])
    Grammar.Abs.TString -> prPrec i 0 (concatD [doc (showString "string")])
    Grammar.Abs.TVoid -> prPrec i 0 (concatD [doc (showString "void")])
    Grammar.Abs.TList type_ -> prPrec i 0 (concatD [doc (showString "list"), doc (showString "<"), prt 0 type_, doc (showString ">")])
    Grammar.Abs.TLambda typeorrefs type_ -> prPrec i 0 (concatD [doc (showString "lambda"), doc (showString "<"), doc (showString "("), prt 0 typeorrefs, doc (showString ")"), doc (showString "->"), prt 0 type_, doc (showString ">")])

instance Print [Grammar.Abs.Type] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Grammar.Abs.TypeOrRef where
  prt i = \case
    Grammar.Abs.TRType type_ -> prPrec i 0 (concatD [prt 0 type_])
    Grammar.Abs.TRRef type_ -> prPrec i 0 (concatD [doc (showString "&"), prt 0 type_])

instance Print [Grammar.Abs.TypeOrRef] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Grammar.Abs.AddOp where
  prt i = \case
    Grammar.Abs.Plus -> prPrec i 0 (concatD [doc (showString "+")])
    Grammar.Abs.Minus -> prPrec i 0 (concatD [doc (showString "-")])

instance Print Grammar.Abs.MulOp where
  prt i = \case
    Grammar.Abs.Mul -> prPrec i 0 (concatD [doc (showString "*")])
    Grammar.Abs.Div -> prPrec i 0 (concatD [doc (showString "/")])
    Grammar.Abs.Mod -> prPrec i 0 (concatD [doc (showString "%")])

instance Print Grammar.Abs.RelOp where
  prt i = \case
    Grammar.Abs.LTH -> prPrec i 0 (concatD [doc (showString "<")])
    Grammar.Abs.LE -> prPrec i 0 (concatD [doc (showString "<=")])
    Grammar.Abs.GTH -> prPrec i 0 (concatD [doc (showString ">")])
    Grammar.Abs.GE -> prPrec i 0 (concatD [doc (showString ">=")])
    Grammar.Abs.EQ -> prPrec i 0 (concatD [doc (showString "==")])
    Grammar.Abs.NEQ -> prPrec i 0 (concatD [doc (showString "!=")])

instance Print Grammar.Abs.Expr where
  prt i = \case
    Grammar.Abs.EOr expr1 expr2 -> prPrec i 0 (concatD [prt 1 expr1, doc (showString "or"), prt 0 expr2])
    Grammar.Abs.EAnd expr1 expr2 -> prPrec i 1 (concatD [prt 2 expr1, doc (showString "and"), prt 1 expr2])
    Grammar.Abs.ERel expr1 relop expr2 -> prPrec i 2 (concatD [prt 2 expr1, prt 0 relop, prt 3 expr2])
    Grammar.Abs.EAdd expr1 addop expr2 -> prPrec i 3 (concatD [prt 3 expr1, prt 0 addop, prt 4 expr2])
    Grammar.Abs.EMul expr1 mulop expr2 -> prPrec i 4 (concatD [prt 4 expr1, prt 0 mulop, prt 5 expr2])
    Grammar.Abs.ENeg expr -> prPrec i 5 (concatD [doc (showString "-"), prt 6 expr])
    Grammar.Abs.ENot expr -> prPrec i 5 (concatD [doc (showString "not"), prt 6 expr])
    Grammar.Abs.EApp expr exprorrefs -> prPrec i 6 (concatD [prt 6 expr, doc (showString "("), prt 0 exprorrefs, doc (showString ")")])
    Grammar.Abs.EInt n -> prPrec i 7 (concatD [prt 0 n])
    Grammar.Abs.EVar id_ -> prPrec i 7 (concatD [prt 0 id_])
    Grammar.Abs.ETrue -> prPrec i 7 (concatD [doc (showString "true")])
    Grammar.Abs.EFalse -> prPrec i 7 (concatD [doc (showString "false")])
    Grammar.Abs.EEmptyList type_ -> prPrec i 7 (concatD [prt 0 type_, doc (showString "[]")])
    Grammar.Abs.EString str -> prPrec i 7 (concatD [printString str])
    Grammar.Abs.ELambda args type_ block -> prPrec i 7 (concatD [doc (showString "("), prt 0 args, doc (showString ")"), doc (showString "->"), prt 0 type_, prt 0 block])
    Grammar.Abs.EListLen expr -> prPrec i 5 (concatD [prt 6 expr, doc (showString "."), doc (showString "len()")])
    Grammar.Abs.EListAt expr1 expr2 -> prPrec i 5 (concatD [prt 6 expr1, doc (showString "."), doc (showString "at"), doc (showString "("), prt 6 expr2, doc (showString ")")])

instance Print [Grammar.Abs.Ident] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]

instance Print Grammar.Abs.ExprOrRef where
  prt i = \case
    Grammar.Abs.EorRExpr expr -> prPrec i 0 (concatD [prt 0 expr])
    Grammar.Abs.EorRRef id_ -> prPrec i 0 (concatD [doc (showString "&"), prt 0 id_])

instance Print [Grammar.Abs.ExprOrRef] where
  prt _ [] = concatD []
  prt _ [x] = concatD [prt 0 x]
  prt _ (x:xs) = concatD [prt 0 x, doc (showString ","), prt 0 xs]
