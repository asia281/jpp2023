module Evaluate where
    import AbsGrammar

    import Data.Map as Map
    import Data.Maybe

    import Control.Monad.Reader
    import Control.Monad.State
    import Control.Monad.Except

    import Types
    import Memory
    import TypeChecker

-- EXPRESSION --
    evalAddOp Minus e1 e2 = e1 - e2
    evalAddOp Plus e1 e2 = e1 + e2

    evalMulOp Mul e1 e2 = e1 * e2
    evalMulOp Div e1 e2 = div e1 e2
    evalMulOp Mod e1 e2 = e1 `mod` e2

    evalRelOp LTH e1 e2 = e1 < e2
    evalRelOp LE e1 e2 = e1 <= e2
    evalRelOp GTH e1 e2 = e1 > e2
    evalRelOp GE e1 e2 = e1 >= e2
    evalRelOp EQ e1 e2 = e1 == e2
    evalRelOp NEQ e1 e2 = e1 /= e2

    evalExpr :: Expr -> Interpreter VMemory

    evalExpr (EVar ident) = readFromMemory ident
    evalExpr ETrue = return $ VBool True
    evalExpr EFalse = return $ VBool False
    evalExpr (EInt var) = return $ VInt var
    evalExpr (EString str) = return $ VString str
    evalExpr (EEmptyList typ) = return $ VList (typ, [])

-- bool operators
    evalExpr (ERel e1 op e2) = do
        VInt done1 <- evalExpr e1 
        VInt done2 <- evalExpr e2
        return $ VBool $ evalRelOp op done1 done2

    evalExpr (EAnd e1 e2) = do
        VBool done1 <- evalExpr e1 
        VBool done2 <- evalExpr e2
        return $ VBool $ done1 && done2

    evalExpr (EOr e1 e2) = do
        VBool done1 <- evalExpr e1 
        VBool done2 <- evalExpr e2
        return $ VBool $ done1 || done2

    evalExpr (ENot e) = do
        VBool done <- evalExpr e
        return $ VBool $ not done
    
--  int operators
    evalExpr (EAdd e1 op e2) = do
        VInt done1 <- evalExpr e1 
        VInt done2 <- evalExpr e2
        return $ VInt $ evalAddOp op done1 done2

    evalExpr (Neg e) = do
        VInt done <- evalExpr e 
        return $ VInt $ -done

    evalExpr (EMul e1 op e2)
        | e2 == 0 && (op == Div || op == Mod) = throwError ZeroDivisionException
        | return $ VInt $ evalMulOp op (evalExpr e1) (evalExpr e2)


-- lists
    evalExpr (ListLen l) = do
        VList (_, elems) <- evalExpr l
        return $ VInt $ length elems

    evalExpr (ListAt l pos) = do
        VInt idx <- evalExpr pos
        VList (_, elems) <- evalExpr l
        if idx < 0 || length elems >= idx then
            throwError $ OutOfRangeExeption idx

        return $ elems !! idx

-- structs


-- STMT --
    returnNothing :: Interpreter (Env, ReturnRes)
    returnNothing = do
        env <- ask
        return (env, Nothing)

    evalStmt :: Stmt -> Interpreter (Env, ReturnRes)

    interpretAll :: [Stmt] -> Interpreter (Env, ReturnRes)
    interpretAll [] = returnNothing
    interpretAll (x : xt) = do
                (env, ret) <- evalStmt x
                if isNothing ret then
                    local (const env) (interpretAll xs)
                else
                    return (env, ret)

    runProg prog = runExceptT $ runStateT (runReaderT (interpretMany prog) Map.empty) (Map.empty, 0)