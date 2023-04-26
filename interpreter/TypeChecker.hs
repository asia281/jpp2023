module TypeChecker(runProgramCheck) where
    import Types
    import Grammar.Abs
    import Memory
    import Control.Monad.Reader
    import Control.Monad.Except
    import Data.List as List

    import qualified Data.Map.Strict as Map

    type TypeCheckEnv = Map.Map Name Type
    type TypeCheck = ReaderT TypeCheckEnv (ExceptT TypeCheckerExceptions IO)

    checkType :: Type -> Type -> TypeCheck ()
    checkType expected got = unless (expected == got) $ throwError (TypeCheckException expected got)

    checkTypeExpr :: Type -> Expr -> TypeCheck ()
    checkTypeExpr t e = do
        expr <- evalExprType e
        checkType expr t


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

    evalExprType (EApp expr vars) = do 
        TLambda argt typ <- evalExprType expr
        --ensureArgsTypes argt vars
        return typ

-- lambda
    evalExprType (ELambda args typ (Block block)) = do 
        (block_env, Just ret_typ) <- checkList block 
        checkType typ ret_typ
        let argt = foldl' (\acc (Arg t i) -> (t:acc)) [] args
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
        checkType typ got
        returnOk

    getTypeOfVarFromEnv :: Ident -> TypeCheck Type
    getTypeOfVarFromEnv (Ident ident) = do
        env <- ask
        case Map.lookup ident env of
            Just typ -> return typ
            Nothing -> throwError $ IdentifierNotExistException ident

    check :: Stmt -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    check (SExpr expr) = do
        _ <- evalExprType expr
        returnOk

    check (FunDef ident args typ (Block block)) = do
        -- todo ident and args

        (block_env, Just ret_typ) <- checkList block 
        checkType typ ret_typ
        checkList block

-- If
    check (If cond (Block block)) = do
        checkTypeExpr TBool cond
        checkList block

    check (IfElse cond (Block block1) (Block block2)) = do
        checkTypeExpr TBool cond
        t1 <- checkList block1
        t2 <- checkList block2
        case (t1, t2) of
            (Nothing, Nothing) -> returnNothing
            (Nothing, Nothing) -> returnNothing

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

    check (Decl typ ident) = do
        case ident of 
            NoInit (Ident i) -> do
                unless (isValidVType False typ) $ throwError $ DeclarationInvTypeException typ
                env <- ask
                return (Map.insert i typ env, Nothing)

            Init (Ident i) expr -> do
                unless (isValidVType True typ) $ throwError $ DeclarationInvTypeException typ
                _ <- evalExprType expr
                env <- ask
                return (Map.insert i typ env, Nothing)
-- Print
    check (PrintEndl expr) = check (Print expr)

    check (Print expr) = do
        _ <- evalListExprType expr
        returnOk

    evalListExprType :: [Expr] -> TypeCheck Type
    evalListExprType [] = return TVoid
    evalListExprType (h:t) = do
        _ <- evalExprType h
        evalListExprType t

-- Check for prog
    checkList :: [Stmt] -> TypeCheck (TypeCheckEnv, TypeCheckResult)
    checkList [] = do
        env <- ask
        return (env, Nothing)

    checkList (h:t) = do
        (env, typ) <- check h
        case typ of
            Just ok_typ -> return (env, Just ok_typ)
            Nothing -> local (const env) (checkList t)

-- Check number of 
    isValidVType :: Bool -> Type  -> Bool
    isValidVType inited t =
        case (inited, t) of
            (_, TInt)  -> True
            (_, TBool)  -> True
            (_, TString) -> True
            (_, TList {}) -> True
            (isInit, TLambda {}) -> isInit
            _ -> False

    runProgramCheck :: [Stmt] -> IO (Either TypeCheckerExceptions (TypeCheckEnv, TypeCheckResult))
    runProgramCheck program = runExceptT $ runReaderT (checkList program) Map.empty