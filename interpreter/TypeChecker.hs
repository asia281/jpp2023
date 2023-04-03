module TypeChecker where
    import Types
    import Memory
    import qualified Data.Map.Strict as Map

    type TypeCheckEnv = Map.Map VariableName Type
    type TypeCheck = ReaderT TypeCheckEnv (ExceptT TypeCheckExceptions IO)

    runTC prog = runExceptT $ runReaderT (check prog) Map.empty

    checkType :: Type -> Type -> TypeCheck ()
    checkType expected got = unless (expected == got) $ throwError (TypeCheckException expected got)

    checkTypeExpr :: Expr -> Type -> TypeCheck ()
    checkTypeExpr e t = checkType (evalExprType e) t


    
    evalExprType :: Expr -> TypeCheck Type

-- base
    evalExprType (EVar id) = getTypeOfVarFromEnv id
    evalExprType EInt {} = return TInt
    evalExprType (EString _) = return TString
    evalExprType ETrue  = return TBool
    evalExprType EFalse = return TBool

    evalTwoExpr expected e1 e2 = do
        checkTypeExpr expected e1
        checkTypeExpr expected e2
        return expected

    evalExprType (EOr e1 e2) = evalTwoExpr TBool e1 e2
    evalExprType (EAnd e1 e2) = evalTwoExpr TBool e1 e2
    evalExprType (ERel e1 op e2) = evalTwoExpr TBool e1 e2
    evalExprType (EAdd e1 op e2) = evalTwoExpr TInt e1 e2
    evalExprType (EMul e1 op e2) = evalTwoExpr TInt e1 e2
    evalExprType (ENot e) | (ENeg e) = do 
        checkTypeExpr expected e
        return expected

-- lambda
    evalExprType (ELambda id args typ block) = do


-- lists
    evalExprType (EEmptyList t) = return $ TList t

    evalExprType (ListAt lexpr expr) = do
        typ <- evalExprType expr
        ltyp <- evalListType lexpr


    evalExprType (ListLen lexpr) = evalListType (evalExprType lexpr) >> return TInt

    evalListType :: Expr -> TypeCheck Type
    evalListType t = 
        case t of
            TList ltyp -> return ltyp
            otherwise -> throwError $ NotAListException typ

    type TypeCheckResult = Maybe Type

    returnOk :: TypeCheck (TypeCheckEnv, TypeCheckResult)
    returnOk = do
        env <- ask
        return (env, Nothing)
-- If
    check [] = do
        env <- ask
        return (env, Nothing)

    check (h:t) = do
        (env, typ) <- check h
        case typ of
            Nothing -> check t -- TODO 
            Just t -> return (env, t)

    check (If cond block) = do
        checkTypeExpr TBool cond
        check block

    check (IfElse cond block1 block2) = do
        checkTypeExpr TBool cond
        check block1
        check block2

-- While/for
    check (For id start end stmt) = do
        checkTypeExpr TInt start 
        checkTypeExpr TInt end 
        checkTypeOfId TInt id
        check stmt

    check (While cond expr) = do
        checkTypeExpr TBool cond
        checkType stmt

-- Structs

-- Lists
    checkTypeOfId :: Type -> Id -> TypeCheck Type
    checkTypeOfId typ id = do 
        checkType typ $ getTypeOfVarFromEnv id
        returnOk

    getTypeOfVarFromEnv :: Id -> TypeCheck Type
    getTypeOfVarFromEnv (Id id) = do
        env <- ask
        case Map.lookup id env of
            Nothing -> throwError $ IdentifierNotExistException id
            Just typ -> return typ


    check (ListPush ident expr) = do
        typ <- evalExprType expr
        checkTypeOfId (TList typ) id

-- Assign
    check (Assign id expr) = do
        checkTypeOfId (evalExpr expr) id

-- Return
    check ReturnVoid = do
        env <- ask
        return (env, Just Void)

    check (Return expr) = do
        env <- ask
        val <- evalExprType expr
        return (env, Just val)
-- Print
    check (Print expr) = 
        evalExprType expr
        returnOk

-- Check number of 
    isValidVType :: Type -> Bool -> TT Bool
    isValidVarType 
        | TInt _ | TBool _ | isValidVarType TString = return True
        | TList {} _ = return True
        | TLambda {} isInit = return isInit
        | otherwise = return False