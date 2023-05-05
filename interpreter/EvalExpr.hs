module EvalExpr(evalExpr) where
    import Grammar.Abs
    import Control.Monad.Except
    import Types
    import Memory

-- EXPRESSION --
    evalAddOp :: AddOp -> Integer -> Integer -> Integer
    evalAddOp Minus e1 e2 = e1 - e2
    evalAddOp Plus e1 e2 = e1 + e2

    evalMulOp :: MulOp -> Integer -> Integer -> Integer
    evalMulOp Mul e1 e2 = e1 * e2
    evalMulOp Div e1 e2 = div e1 e2
    evalMulOp Mod e1 e2 = e1 `mod` e2

    evalRelOp :: RelOp -> Integer -> Integer -> Bool
    evalRelOp LTH e1 e2 = e1 < e2
    evalRelOp LE e1 e2 = e1 <= e2
    evalRelOp GTH e1 e2 = e1 > e2
    evalRelOp GE e1 e2 = e1 >= e2
    evalRelOp Grammar.Abs.EQ e1 e2 = e1 == e2
    evalRelOp NEQ e1 e2 = e1 /= e2

    evalExpr :: Expr -> Interpreter VMemory
    evalExpr (EVar ident) = getValueFromIdent ident
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

    evalExpr (ENeg e) = do
        VInt done <- evalExpr e 
        return $ VInt $ -done

    evalExpr (EMul e1 op e2) = do
        VInt done1 <- evalExpr e1 
        VInt done2 <- evalExpr e2
        if done2 == 0 && (op == Div || op == Mod) then 
            throwError ZeroDivisionException 
        else 
            return $ VInt $ evalMulOp op done1 done2

-- lists
    evalExpr (EListLen l) = do
        VList (_, elements) <- evalExpr l
        return $ VInt $ fromIntegral $ length elements

    evalExpr (EListAt l pos) = do
        VInt idx <- evalExpr pos
        VList (_, elements) <- evalExpr l
        let listLen = fromIntegral (length elements)
        if idx < 0 || listLen <= idx then
            throwError $ OutOfRangeExeption listLen idx
        else 
            return $ elements !! fromIntegral idx

    evalExpr (EApp expr vars) = do 
        VFun f <- evalExpr expr
        --ensureArgsTypes argt vars
        return $ VFun f

-- lambda
    evalExpr (ELambda args typ (Block block)) = do 
        conv_args <- argsToFun args []
        --return $ VFun $ conv_args typ block Map.empty 
        return $ VInt 1

    argsToFun :: [Arg] -> FunArgList -> Interpreter FunArgList
    argsToFun [] acc = return acc
    argsToFun ((Arg (TRType t) i):xs) acc = argsToFun xs ((ByValue, t, i):acc)
    argsToFun ((Arg (TRRef t) i):xs) acc = argsToFun xs ((ByReference, t, i):acc)

-- structs
