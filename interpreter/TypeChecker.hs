module TypeChecker(runProgramCheck) where
    import Types
    import Grammar.Abs
    import Control.Monad.Reader
    import Control.Monad.Except
    import Data.List as List

    import qualified Data.Map.Strict as Map

    type TypeCheckEnv = Map.Map Name Type
    type TypeCheck = ReaderT TypeCheckEnv (ExceptT TypeCheckerExceptions IO)


    checkType :: Type -> Type -> TypeCheck ()
    checkType expected got = unless (expected == got) $ throwError $ TypeCheckException expected got

    checkTypeExpr :: Type -> Expr -> TypeCheck ()
    checkTypeExpr t e = do
        expr <- evalExprType e
        checkType t expr

    evalTwoExpr :: Type -> Expr -> Expr -> Type -> TypeCheck Type
    evalTwoExpr expected e1 e2 ret = do
        checkTypeExpr expected e1  
        checkTypeExpr expected e2  
        return ret

-- base
    evalExprType :: Expr -> TypeCheck Type
    evalExprType (EVar ident) = getTypeOfVarFromEnv ident
    evalExprType EInt {} = return TInt
    evalExprType (EString _) = return TString
    evalExprType ETrue  = return TBool
    evalExprType EFalse = return TBool
    evalExprType (EOr e1 e2) = evalTwoExpr TBool e1 e2 TBool
    evalExprType (EAnd e1 e2) = evalTwoExpr TBool e1 e2 TBool
    evalExprType (ERel e1 _ e2) = evalTwoExpr TInt e1 e2 TBool
    evalExprType (EAdd e1 _ e2) = evalTwoExpr TInt e1 e2 TInt
    evalExprType (EMul e1 _ e2) = evalTwoExpr TInt e1 e2 TInt
    evalExprType (ENot e) = do 
        checkTypeExpr TBool e
        return TBool
    evalExprType (ENeg e) = do 
        checkTypeExpr TBool e
        return TBool

-- lambda
    evalExprType (ELambda args typ (Block block)) = do 
        let argt = foldl' (\acc (Arg t _) -> (t:acc)) [] args
        (_, retTyp) <- checkList block 
        case (retTyp, typ) of
            (Nothing, TVoid) -> return $ TLambda argt TVoid
            (Nothing, _) -> throwError $ ReturnTypeMismatchException TVoid typ
            (Just vRet, _) -> do
                unless (vRet == typ) $ throwError $ ReturnTypeMismatchException vRet typ
                return $ TLambda argt typ

-- lists
    evalExprType (EEmptyList t) = return $ TList t

    evalExprType (EListAt lexpr expr) = do
        typ <- evalExprType expr
        checkType TInt typ
        evalListType lexpr

    evalExprType (EListLen lexpr) = do
        _ <- evalListType lexpr 
        return TInt
    
    evalExprType (EApp expr vars) = do 
        TLambda argt typ <- evalExprType expr
        mapMTwo argt vars
        return typ

    mapMTwo :: [TypeOrRef] -> [ExprOrRef] -> TypeCheck ()
    mapMTwo [] [] = return ()
    mapMTwo (arg : argt) (var : t) = do
        _ <- checkArgs arg var
        mapMTwo argt t
        where 
            checkArgs (TRRef typ) (EorRRef ident) = do
                identType <- getTypeOfVarFromEnv ident
                checkType typ identType

            checkArgs (TRType typ) (EorRExpr expr) = do
                exprTyp <- evalExprType expr
                checkType typ exprTyp

            checkArgs _ _ = throwError InvalidTypesInApplication

    mapMTwo _ _ = undefined


    evalListType :: Expr -> TypeCheck Type
    evalListType expr = do
        typ <- evalExprType expr
        case typ of
            TList ltyp -> return ltyp
            _ -> throwError $ NotListException typ


    type TypeCheckResult = Maybe Type

    returnOk :: TypeCheck (TypeCheckEnv, TypeCheckResult)
    returnOk = do
        env <- ask
        return (env, Nothing)

    checkTypeOfId :: Type -> Ident -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    checkTypeOfId typ ident = do 
        got <- getTypeOfVarFromEnv ident
        checkType got typ
        returnOk

    getTypeOfVarFromEnv :: Ident -> TypeCheck Type
    getTypeOfVarFromEnv (Ident ident) = do
        env <- ask
        case Map.lookup ident env of
            Just typ -> return typ
            Nothing -> throwError $ IdentifierNotExistException ident

    checkUniqueness :: [Char] -> [Arg] -> [[Char]] -> TypeCheck()
    checkUniqueness _ [] _ = return ()
    checkUniqueness ident ((Arg _ (Ident x)):xs) acc = do
        if elem x acc
            then throwError $ NonUniqueArgName ident x
            else checkUniqueness ident xs (x : acc)

    check :: Stmt -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    check (SExpr expr) = evalExprType expr >> returnOk

    check (FunDef (Ident ident) args typ (Block block)) = do
        checkUniqueness ident args []
        let argt = foldl' (\acc (Arg t _) -> (t:acc)) [] args
        let fun = TLambda argt typ
        begEnv <- ask
        newEnv <- foldM addArgTypesToEnv begEnv args

        let envAfterFuncDef = Map.insert ident fun newEnv
        (env, retTyp) <- local (const envAfterFuncDef) (checkList block)
        case (retTyp, typ) of
            (Nothing, TVoid) -> return (Map.insert ident fun env, Nothing)
            (Nothing, _) -> throwError $ ReturnTypeMismatchException TVoid typ
            (Just vRet, _) -> do 
                unless (vRet == typ) $ throwError $ ReturnTypeMismatchException vRet typ
                return (Map.insert ident fun env, Just vRet)
        where 
            addArgTypesToEnv prevEnv (Arg (TRRef trtyp) (Ident i)) = return $ Map.insert i trtyp prevEnv
            addArgTypesToEnv prevEnv (Arg (TRType trtyp) (Ident i)) = return $ Map.insert i trtyp prevEnv

-- If
    check (If cond (Block block)) = do
        checkTypeExpr TBool cond
        checkList block

    check (IfElse cond (Block block1) (Block block2)) = do
        checkTypeExpr TBool cond
        (_, t1) <- checkList block1
        (_, t2) <- checkList block2
        env <- ask
        case (t1, t2) of
            (Nothing, Nothing) -> return (env, Nothing)
            (Nothing, Just t2') -> throwError $ ReturnTypeMismatchException TVoid t2'
            (Just t1', Nothing) -> throwError $ ReturnTypeMismatchException t1' TVoid
            (Just t1', Just t2') -> do
                unless (t1' == t2') $ throwError $ ReturnTypeMismatchException t1' t2'
                return (env, t1)

-- While/for
    check (For ident start end (Block block)) = do
        checkTypeExpr TInt start 
        checkTypeExpr TInt end 
        _ <- checkTypeOfId TInt ident
        checkList block
        
    check (ForInList ident list (Block block)) = do
        checkTypeExpr (TList TInt) list  
        _ <- checkTypeOfId TInt ident
        checkList block

    check (While cond (Block block)) = do
        checkTypeExpr TBool cond
        checkList block

-- Structs

-- Lists

    check (SListPush ident expr) = do
        typ <- evalExprType expr
        checkTypeOfId (TList typ) ident

-- Assign
    check (Assign ident expr) = do
        val <- evalExprType expr
        checkTypeOfId val ident

-- Return
    check ReturnVoid = do
        env <- ask
        return (env, Just TVoid)

    check (Return expr) = do
        env <- ask
        val <- evalExprType expr
        return (env, Just val)

    check (Decl typ ident) = checkDecl typ ident
        
-- Print
    check (PrintEndl expr) = check (Print expr)

    check (Print expr) = evalListExprType expr >> returnOk

    evalListExprType :: [Expr] -> TypeCheck Type
    evalListExprType [] = return TVoid
    evalListExprType (h:t) = do
        _ <- evalExprType h
        evalListExprType t

-- Check for prog
    checkList :: [Stmt] -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    checkList [] = returnOk

    checkList (h:t) = do
        (env, typ) <- check h
        case typ of
            Just ok_typ -> return (env, Just ok_typ)
            Nothing -> local (const env) (checkList t)

    checkDecl :: Type -> Item -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    checkDecl typ (NoInit (Ident i)) = do
        unless (isValidVType False typ) $ throwError $ DeclarationInvTypeException typ
        env <- ask
        return (Map.insert i typ env, Nothing)

    checkDecl typ (Init (Ident i) expr) = do
        unless (isValidVType True typ) $ throwError $ DeclarationInvTypeException typ
        _ <- evalExprType expr
        env <- ask
        return (Map.insert i typ env, Nothing)

    isValidVType :: Bool -> Type  -> Bool
    isValidVType inited TLambda {} = inited
    isValidVType _ _ = True

    runProgramCheck :: [Stmt] -> IO (Either TypeCheckerExceptions (TypeCheckEnv, TypeCheckResult))
    runProgramCheck program = runExceptT $ runReaderT (checkList program) Map.empty