-- File generated by the BNF Converter (bnfc 2.9.4.1).

-- Templates for pattern matching on abstract syntax

{-# OPTIONS_GHC -fno-warn-unused-matches #-}

module Grammar.Skel where

import Prelude (($), Either(..), String, (++), Show, show)
import qualified Grammar.Abs

type Err = Either String
type Result = Err String

failure :: Show a => a -> Result
failure x = Left $ "Undefined case: " ++ show x

transIdent :: Grammar.Abs.Ident -> Result
transIdent x = case x of
  Grammar.Abs.Ident string -> failure x

transProgram :: Grammar.Abs.Program -> Result
transProgram x = case x of
  Grammar.Abs.Program stmts -> failure x

transBlock :: Grammar.Abs.Block -> Result
transBlock x = case x of
  Grammar.Abs.Block stmts -> failure x

transStmt :: Grammar.Abs.Stmt -> Result
transStmt x = case x of
  Grammar.Abs.Decl type_ item -> failure x
  Grammar.Abs.SExpr expr -> failure x
  Grammar.Abs.If expr block -> failure x
  Grammar.Abs.IfElse expr block1 block2 -> failure x
  Grammar.Abs.While expr block -> failure x
  Grammar.Abs.For ident expr1 expr2 block -> failure x
  Grammar.Abs.ForInList ident expr block -> failure x
  Grammar.Abs.Print exprs -> failure x
  Grammar.Abs.Return expr -> failure x
  Grammar.Abs.ReturnVoid -> failure x
  Grammar.Abs.Assign ident expr -> failure x
  Grammar.Abs.FunDef ident args type_ block -> failure x
  Grammar.Abs.SListPush ident expr -> failure x
  Grammar.Abs.StructDef ident structitems -> failure x

transItem :: Grammar.Abs.Item -> Result
transItem x = case x of
  Grammar.Abs.NoInit ident -> failure x
  Grammar.Abs.Init ident expr -> failure x

transArg :: Grammar.Abs.Arg -> Result
transArg x = case x of
  Grammar.Abs.Arg type_ ident -> failure x
  Grammar.Abs.ArgRef type_ ident -> failure x

transType :: Grammar.Abs.Type -> Result
transType x = case x of
  Grammar.Abs.TInt -> failure x
  Grammar.Abs.TBool -> failure x
  Grammar.Abs.TString -> failure x
  Grammar.Abs.TVoid -> failure x
  Grammar.Abs.TList type_ -> failure x
  Grammar.Abs.TStruct ident -> failure x
  Grammar.Abs.TLambda typeorrefs type_ -> failure x

transTypeOrRef :: Grammar.Abs.TypeOrRef -> Result
transTypeOrRef x = case x of
  Grammar.Abs.TRType type_ -> failure x
  Grammar.Abs.TRRef type_ -> failure x

transAddOp :: Grammar.Abs.AddOp -> Result
transAddOp x = case x of
  Grammar.Abs.Plus -> failure x
  Grammar.Abs.Minus -> failure x

transMulOp :: Grammar.Abs.MulOp -> Result
transMulOp x = case x of
  Grammar.Abs.Mul -> failure x
  Grammar.Abs.Div -> failure x
  Grammar.Abs.Mod -> failure x

transRelOp :: Grammar.Abs.RelOp -> Result
transRelOp x = case x of
  Grammar.Abs.LTH -> failure x
  Grammar.Abs.LE -> failure x
  Grammar.Abs.GTH -> failure x
  Grammar.Abs.GE -> failure x
  Grammar.Abs.EQ -> failure x
  Grammar.Abs.NEQ -> failure x

transExpr :: Grammar.Abs.Expr -> Result
transExpr x = case x of
  Grammar.Abs.EOr expr1 expr2 -> failure x
  Grammar.Abs.EAnd expr1 expr2 -> failure x
  Grammar.Abs.ERel expr1 relop expr2 -> failure x
  Grammar.Abs.EAdd expr1 addop expr2 -> failure x
  Grammar.Abs.EMul expr1 mulop expr2 -> failure x
  Grammar.Abs.ENeg expr -> failure x
  Grammar.Abs.ENot expr -> failure x
  Grammar.Abs.EApp expr exprorrefs -> failure x
  Grammar.Abs.EInt integer -> failure x
  Grammar.Abs.EVar ident -> failure x
  Grammar.Abs.ETrue -> failure x
  Grammar.Abs.EFalse -> failure x
  Grammar.Abs.EEmptyList type_ -> failure x
  Grammar.Abs.EString string -> failure x
  Grammar.Abs.ELambda idents typeorrefs type_ block -> failure x
  Grammar.Abs.EListLen expr -> failure x
  Grammar.Abs.EListAt expr1 expr2 -> failure x

transExprOrRef :: Grammar.Abs.ExprOrRef -> Result
transExprOrRef x = case x of
  Grammar.Abs.EorRExpr expr -> failure x
  Grammar.Abs.EorRRef ident -> failure x

transStructItem :: Grammar.Abs.StructItem -> Result
transStructItem x = case x of
  Grammar.Abs.StructItem type_ ident -> failure x
