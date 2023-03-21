module TypeChecker where
    import Types
    import Memory

    type TC = ReaderT TTEnv (ExceptT TypeCheckExceptions IO)


    ensureType :: Type -> Type -> TC ()
    ensureType givenType expectedType = unless (givenType == expectedType) $ throwError $ TypeCheckException givenType expectedType

    ensureTypeExpr :: Expr -> Type -> TC ()
    ensureTypeExpr e t = do
        typ <- evalExprType e
        ensureType typ t