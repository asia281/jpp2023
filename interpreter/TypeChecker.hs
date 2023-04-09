module TypeChecker where
    import Types
    import Grammar.Abs
    import Memory
    import Control.Monad.Reader
    import Control.Monad.Except
    import Control.Monad.Identity

    import qualified Data.Map.Strict as Map

    type TypeCheckEnv = Map.Map Name Type
    type TypeCheck = ReaderT TypeCheckEnv (ExceptT TypeCheckerExceptions IO)

    runTC prog = runExceptT $ runReaderT (check prog) Map.empty

    checkType :: Type -> Type -> TypeCheck ()
    checkType expected got = unless (expected == got) $ throwError (TypeCheckException expected got)

    checkTypeExpr :: Type -> Expr -> TypeCheck ()
    checkTypeExpr t e = do
        ex <- evalExprType e
        checkType ex t


    evalTwoExpr :: Type -> Expr -> Expr -> TypeCheck Type
    evalTwoExpr expected e1 e2 = do
        checkTypeExpr expected e1  
        checkTypeExpr expected e2  
        return expected

-- base
    evalExprType :: Expr -> TypeCheck Type
    evalExprType (EVar id) = getTypeOfVarFromEnv id
    evalExprType EInt {} = return TInt
    evalExprType (EString _) = return TString
    evalExprType ETrue  = return TBool
    evalExprType EFalse = return TBool
    evalExprType (EOr e1 e2) = evalTwoExpr TBool e1 e2
    evalExprType (EAnd e1 e2) = evalTwoExpr TBool e1 e2
    evalExprType (ERel e1 op e2) = evalTwoExpr TBool e1 e2
    evalExprType (EAdd e1 op e2) = evalTwoExpr TInt e1 e2
    evalExprType (EMul e1 op e2) = evalTwoExpr TInt e1 e2
    evalExprType (ENot e) = do 
        checkTypeExpr TBool e
        return TBool
    evalExprType (ENeg e) = do 
        checkTypeExpr TBool e
        return TBool

-- lambda
 --   evalExprType (ELambda id args typ block) = do


-- lists
    evalExprType (EEmptyList t) = return $ TList t

    evalExprType (EListAt lexpr expr) = do
        typ <- evalExprType expr
        checkType TInt typ
        evalListType lexpr


    evalExprType (EListLen lexpr) = do
        evalListType lexpr 
        return TInt

    evalListType :: Expr -> TypeCheck Type
    evalListType expr = do
        typ <- evalExprType expr
        case typ of
            TList ltyp -> return ltyp
            otherwise -> throwError $ NotListException typ

    evalListExprType :: [Expr] -> TypeCheck Type
    evalListExprType [] = return TVoid
    evalListExprType (h:t) = do
        evalExprType h
        evalListExprType t

    type TypeCheckResult = Maybe Type

    returnOk :: TypeCheck (TypeCheckEnv, TypeCheckResult)
    returnOk = do
        env <- ask
        return (env, Nothing)

    checkTypeOfId :: Type -> Ident -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    checkTypeOfId typ id = do 
        got <- getTypeOfVarFromEnv id
        checkType typ got
        returnOk

    getTypeOfVarFromEnv :: Ident -> TypeCheck Type
    getTypeOfVarFromEnv (Ident id) = do
        env <- ask
        case Map.lookup id env of
            Nothing -> throwError $ IdentifierNotExistException id
            Just typ -> return typ

    check :: Stmt -> TypeCheck (TypeCheckEnv, TypeCheckResult)
-- If

    check (If cond (Block block)) = do
        checkTypeExpr TBool cond
        checkList block

    check (IfElse cond (Block block1) (Block block2)) = do
        checkTypeExpr TBool cond
        checkList block1
        checkList block2

-- While/for
    check (For id start end (Block block)) = do
        checkTypeExpr TInt start 
        checkTypeExpr TInt end 
        checkTypeOfId TInt id
        checkList block
        
    check (ForInList id list (Block block)) = do
        checkTypeExpr (TList TInt) list  
        checkTypeOfId TInt id
        checkList block

    check (While cond (Block block)) = do
        checkTypeExpr TBool cond
        checkList block

-- Structs

-- Lists

    check (SListPush id expr) = do
        typ <- evalExprType expr
        checkTypeOfId (TList typ) id

-- Assign
    check (Assign id expr) = do
        val <- evalExprType expr
        checkTypeOfId val id

-- Return
    check ReturnVoid = do
        env <- ask
        return (env, Just TVoid)

    check (Return expr) = do
        env <- ask
        val <- evalExprType expr
        return (env, Just val)
-- Print
    check (Print expr) = do
        t <- evalListExprType expr
        returnOk

    check (PrintEndl expr) = check (Print expr)

-- Check for prog
    checkList :: [Stmt] -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    checkList [] = do
        env <- ask
        return (env, Nothing)

    checkList (h:t) = do
        (env, typ) <- check h
        case typ of
            Nothing -> checkList t -- TODO 
            Just t -> return (env, Just t)

-- Check number of 
    isValidVType :: Type -> Bool -> TypeCheck Bool
    isValidVType TInt _  = return True
    isValidVType TBool _  = return True
    isValidVType TString _ = return True
    isValidVType TList {} _ = return True
    isValidVType TLambda {} isInit = return isInit
    isValidVType _ _ = return False

    runProgramCheck program = runExceptT $ runReaderT (checkList program) Map.empty