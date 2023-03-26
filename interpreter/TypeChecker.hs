module TypeChecker where
    import Types
    import Memory

    type TC = ReaderT TTEnv (ExceptT TypeCheckExceptions IO)


    ensureType :: Type -> Type -> TC ()
    ensureType givenT expectedT = unless (givenT == expectedT) $ throwError (TypeCheckException givenT expectedT)

    ensureTypeExpr :: Expr -> Type -> TC ()
    ensureTypeExpr e t = ensureType (evalExprType e) t

    