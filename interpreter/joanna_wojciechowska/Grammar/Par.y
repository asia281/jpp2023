-- -*- haskell -*- File generated by the BNF Converter (bnfc 2.9.4.1).

-- Parser definition for use with Happy
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
{-# LANGUAGE PatternSynonyms #-}

module Grammar.Par
  ( happyError
  , myLexer
  , pProgram
  ) where

import Prelude

import qualified Grammar.Abs
import Grammar.Lex

}

%name pProgram Program
-- no lexer declaration
%monad { Err } { (>>=) } { return }
%tokentype {Token}
%token
  '!='        { PT _ (TS _ 1)  }
  '%'         { PT _ (TS _ 2)  }
  '&'         { PT _ (TS _ 3)  }
  '('         { PT _ (TS _ 4)  }
  ')'         { PT _ (TS _ 5)  }
  '*'         { PT _ (TS _ 6)  }
  '+'         { PT _ (TS _ 7)  }
  ','         { PT _ (TS _ 8)  }
  '-'         { PT _ (TS _ 9)  }
  '->'        { PT _ (TS _ 10) }
  '.'         { PT _ (TS _ 11) }
  '/'         { PT _ (TS _ 12) }
  ';'         { PT _ (TS _ 13) }
  '<'         { PT _ (TS _ 14) }
  '<='        { PT _ (TS _ 15) }
  '='         { PT _ (TS _ 16) }
  '=='        { PT _ (TS _ 17) }
  '>'         { PT _ (TS _ 18) }
  '>='        { PT _ (TS _ 19) }
  '[]'        { PT _ (TS _ 20) }
  'and'       { PT _ (TS _ 21) }
  'at'        { PT _ (TS _ 22) }
  'bool'      { PT _ (TS _ 23) }
  'else'      { PT _ (TS _ 24) }
  'false'     { PT _ (TS _ 25) }
  'for'       { PT _ (TS _ 26) }
  'from'      { PT _ (TS _ 27) }
  'fun'       { PT _ (TS _ 28) }
  'if'        { PT _ (TS _ 29) }
  'int'       { PT _ (TS _ 30) }
  'lambda'    { PT _ (TS _ 31) }
  'len()'     { PT _ (TS _ 32) }
  'list'      { PT _ (TS _ 33) }
  'not'       { PT _ (TS _ 34) }
  'or'        { PT _ (TS _ 35) }
  'print'     { PT _ (TS _ 36) }
  'printEndl' { PT _ (TS _ 37) }
  'push'      { PT _ (TS _ 38) }
  'return'    { PT _ (TS _ 39) }
  'string'    { PT _ (TS _ 40) }
  'to'        { PT _ (TS _ 41) }
  'true'      { PT _ (TS _ 42) }
  'void'      { PT _ (TS _ 43) }
  'while'     { PT _ (TS _ 44) }
  '{'         { PT _ (TS _ 45) }
  '}'         { PT _ (TS _ 46) }
  L_Ident     { PT _ (TV $$)   }
  L_integ     { PT _ (TI $$)   }
  L_quoted    { PT _ (TL $$)   }

%%

Ident :: { Grammar.Abs.Ident }
Ident  : L_Ident { Grammar.Abs.Ident $1 }

Integer :: { Integer }
Integer  : L_integ  { (read $1) :: Integer }

String  :: { String }
String   : L_quoted { $1 }

Program :: { Grammar.Abs.Program }
Program : ListStmt { Grammar.Abs.Program $1 }

Block :: { Grammar.Abs.Block }
Block : '{' ListStmt '}' { Grammar.Abs.Block $2 }

ListStmt :: { [Grammar.Abs.Stmt] }
ListStmt
  : {- empty -} { [] }
  | Stmt ListStmt { (:) $1 $2 }
  | {- empty -} { [] }
  | Stmt { (:[]) $1 }
  | Stmt ';' ListStmt { (:) $1 $3 }

Stmt :: { Grammar.Abs.Stmt }
Stmt
  : Type Item { Grammar.Abs.Decl $1 $2 }
  | Expr ';' { Grammar.Abs.SExpr $1 }
  | 'if' '(' Expr ')' Block { Grammar.Abs.If $3 $5 }
  | 'if' '(' Expr ')' Block 'else' Block { Grammar.Abs.IfElse $3 $5 $7 }
  | 'while' '(' Expr ')' Block { Grammar.Abs.While $3 $5 }
  | 'for' '(' Ident 'from' Expr 'to' Expr ')' Block { Grammar.Abs.For $3 $5 $7 $9 }
  | 'print' '(' ListExpr ')' ';' { Grammar.Abs.Print $3 }
  | 'printEndl' '(' ListExpr ')' ';' { Grammar.Abs.PrintEndl $3 }
  | 'return' Expr ';' { Grammar.Abs.Return $2 }
  | 'return' ';' { Grammar.Abs.ReturnVoid }
  | Ident '=' Expr ';' { Grammar.Abs.Assign $1 $3 }
  | 'fun' Ident '(' ListArg ')' '->' Type Block { Grammar.Abs.FunDef $2 $4 $7 $8 }
  | Ident '.' 'push' '(' Expr ')' { Grammar.Abs.SListPush $1 $5 }

Item :: { Grammar.Abs.Item }
Item
  : Ident { Grammar.Abs.NoInit $1 }
  | Ident '=' Expr { Grammar.Abs.Init $1 $3 }

ListItem :: { [Grammar.Abs.Item] }
ListItem : Item { (:[]) $1 } | Item ',' ListItem { (:) $1 $3 }

ListExpr :: { [Grammar.Abs.Expr] }
ListExpr
  : {- empty -} { [] }
  | Expr { (:[]) $1 }
  | Expr ',' ListExpr { (:) $1 $3 }
  | {- empty -} { [] }
  | Expr { (:[]) $1 }
  | Expr ',' ListExpr { (:) $1 $3 }

Arg :: { Grammar.Abs.Arg }
Arg : TypeOrRef Ident { Grammar.Abs.Arg $1 $2 }

ListArg :: { [Grammar.Abs.Arg] }
ListArg
  : {- empty -} { [] }
  | Arg { (:[]) $1 }
  | Arg ',' ListArg { (:) $1 $3 }

Type :: { Grammar.Abs.Type }
Type
  : 'int' { Grammar.Abs.TInt }
  | 'bool' { Grammar.Abs.TBool }
  | 'string' { Grammar.Abs.TString }
  | 'void' { Grammar.Abs.TVoid }
  | 'list' '<' Type '>' { Grammar.Abs.TList $3 }
  | 'lambda' '<' '(' ListTypeOrRef ')' '->' Type '>' { Grammar.Abs.TLambda $4 $7 }

ListType :: { [Grammar.Abs.Type] }
ListType
  : {- empty -} { [] }
  | Type { (:[]) $1 }
  | Type ',' ListType { (:) $1 $3 }

TypeOrRef :: { Grammar.Abs.TypeOrRef }
TypeOrRef
  : Type { Grammar.Abs.TRType $1 }
  | '&' Type { Grammar.Abs.TRRef $2 }

ListTypeOrRef :: { [Grammar.Abs.TypeOrRef] }
ListTypeOrRef
  : {- empty -} { [] }
  | TypeOrRef { (:[]) $1 }
  | TypeOrRef ',' ListTypeOrRef { (:) $1 $3 }

AddOp :: { Grammar.Abs.AddOp }
AddOp : '+' { Grammar.Abs.Plus } | '-' { Grammar.Abs.Minus }

MulOp :: { Grammar.Abs.MulOp }
MulOp
  : '*' { Grammar.Abs.Mul }
  | '/' { Grammar.Abs.Div }
  | '%' { Grammar.Abs.Mod }

RelOp :: { Grammar.Abs.RelOp }
RelOp
  : '<' { Grammar.Abs.LTH }
  | '<=' { Grammar.Abs.LE }
  | '>' { Grammar.Abs.GTH }
  | '>=' { Grammar.Abs.GE }
  | '==' { Grammar.Abs.EQ }
  | '!=' { Grammar.Abs.NEQ }

Expr :: { Grammar.Abs.Expr }
Expr : Expr1 'or' Expr { Grammar.Abs.EOr $1 $3 } | Expr1 { $1 }

Expr1 :: { Grammar.Abs.Expr }
Expr1 : Expr2 'and' Expr1 { Grammar.Abs.EAnd $1 $3 } | Expr2 { $1 }

Expr2 :: { Grammar.Abs.Expr }
Expr2
  : Expr2 RelOp Expr3 { Grammar.Abs.ERel $1 $2 $3 } | Expr3 { $1 }

Expr3 :: { Grammar.Abs.Expr }
Expr3
  : Expr3 AddOp Expr4 { Grammar.Abs.EAdd $1 $2 $3 } | Expr4 { $1 }

Expr4 :: { Grammar.Abs.Expr }
Expr4
  : Expr4 MulOp Expr5 { Grammar.Abs.EMul $1 $2 $3 } | Expr5 { $1 }

Expr5 :: { Grammar.Abs.Expr }
Expr5
  : '-' Expr6 { Grammar.Abs.ENeg $2 }
  | 'not' Expr6 { Grammar.Abs.ENot $2 }
  | Expr6 { $1 }
  | Expr6 '.' 'len()' { Grammar.Abs.EListLen $1 }
  | Expr6 '.' 'at' '(' Expr6 ')' { Grammar.Abs.EListAt $1 $5 }

Expr6 :: { Grammar.Abs.Expr }
Expr6
  : Expr6 '(' ListExprOrRef ')' { Grammar.Abs.EApp $1 $3 }
  | Expr7 { $1 }

Expr7 :: { Grammar.Abs.Expr }
Expr7
  : Integer { Grammar.Abs.EInt $1 }
  | Ident { Grammar.Abs.EVar $1 }
  | 'true' { Grammar.Abs.ETrue }
  | 'false' { Grammar.Abs.EFalse }
  | Type '[]' { Grammar.Abs.EEmptyList $1 }
  | String { Grammar.Abs.EString $1 }
  | '(' ListArg ')' '->' Type Block { Grammar.Abs.ELambda $2 $5 $6 }
  | '(' Expr ')' { $2 }

ListIdent :: { [Grammar.Abs.Ident] }
ListIdent
  : {- empty -} { [] }
  | Ident { (:[]) $1 }
  | Ident ',' ListIdent { (:) $1 $3 }

ExprOrRef :: { Grammar.Abs.ExprOrRef }
ExprOrRef
  : Expr { Grammar.Abs.EorRExpr $1 }
  | '&' Ident { Grammar.Abs.EorRRef $2 }

ListExprOrRef :: { [Grammar.Abs.ExprOrRef] }
ListExprOrRef
  : {- empty -} { [] }
  | ExprOrRef { (:[]) $1 }
  | ExprOrRef ',' ListExprOrRef { (:) $1 $3 }

{

type Err = Either String

happyError :: [Token] -> Err a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer :: String -> [Token]
myLexer = tokens

}
