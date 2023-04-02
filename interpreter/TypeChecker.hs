module TypeChecker where
    import Types
    import Memory
    import qualified Data.Map.Strict as Map


    type TypeCheck = ReaderT TTEnv (ExceptT TypeCheckExceptions IO)


    checkType :: Type -> Type -> TypeCheck ()
    checkType got expected = unless (got == expected) $ throwError (TypeCheckException got expected)

    checkTypeExpr :: Expr -> Type -> TypeCheck ()
    checkTypeExpr e t = checkType (evalExprType e) t


    getIdType :: Id -> TypeCheck Type
    getIdType (Id id) = do
        env <- ask
        case Map.lookup id env of
            Nothing -> throwError $ IdentifierNotExistException id
            Just typ -> return typ


    
    evalExprType :: Expr -> TypeCheck Type

-- If
    evalExprType (If ) = 

-- While/for

-- Lambda

-- Structs

-- Lists
    evalExprType (EEmptyList t) = return $ TList t
    evalExprType (ListAt expr) = 

    evalExprType (ListPush expr) = 

    evalExprType (ListLen expr) = checkIfList (evalExprType expr)
        where checkIfList 
                | TList {} = TInt
                | otherwise = throwError $ NotAListException typ


-- Print
    evalExprType (Print expr) = 

-- Check number of 
    isValidVType :: Type -> Bool -> TT Bool
    isValidVarType 
        | TInt _ | TBool _ | isValidVarType TString = return True
        | TList {} _ = return True
        | TLambda {} isInit = return isInit
        | otherwise = return False