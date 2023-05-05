module ExecStmt where
    import Grammar.Abs

    import qualified Data.Map.Strict as Map
    import Data.List as List

    import Control.Monad.Reader
    import Control.Monad.State
    import Control.Monad.Except

    import Types
    import Memory
    import EvalExpr

    
-- Declarations
    defaultValue :: Type -> Expr
    defaultValue TInt = EInt 0
    defaultValue TBool = EFalse
    defaultValue TString = EString ""
    defaultValue (TList t) = EEmptyList t
    defaultValue TVoid = undefined
    defaultValue (TLambda _ _) = undefined


    initalised :: Type -> Ident -> Expr -> Interpreter (Env, ReturnRes)
    initalised _ ident expr = do
        evaledExpr <- evalExpr expr
        new_env <- addIdentToMem ident evaledExpr
        return (new_env, Nothing)

    execStmt :: Stmt -> Interpreter (Env, ReturnRes)
    execStmt (Decl typ i) = do
        case i of
            NoInit ident -> initalised typ ident (defaultValue typ)
            Init ident expr -> initalised typ ident expr

    execStmt (FunDef ident args typ (Block block)) = do 
        -- todo
        returnNothing

    execStmt (SListPush ident expr) = do
        evaledExpr <- evalExpr expr
        VList (typ, list) <- getValueFromIdent ident
        let newList = VList (typ, list ++ [evaledExpr])
        updateIdentInMem ident newList
        returnNothing

-- assignment
    execStmt (Assign ident expr) = do
        evaledExpr <- evalExpr expr
        updateIdentInMem ident evaledExpr
        returnNothing

    execStmt (SExpr expr) = do
        _ <- evalExpr expr
        returnNothing

-- return
    execStmt ReturnVoid = do
        env <- ask
        return (env, Just VVoid)

    execStmt (Return expr) = do
        env <- ask
        val <- evalExpr expr
        return (env, Just val)

    
-- conditions
    execStmt (If cond (Block block)) = do
        VBool evaledCond <- evalExpr cond
        if evaledCond then
            execList block
        else 
            returnNothing  
            
    execStmt (IfElse cond (Block block1) (Block block2)) = do
        VBool evaledCond <- evalExpr cond
        if evaledCond then
            execList block1
        else 
            execList block2  
-- loops
-- tocheck
    execStmt (While cond (Block block)) = do
        VBool evaledCond <- evalExpr cond
        if evaledCond then do
            (_, returned) <- execList block
            case returned of
                Nothing -> execStmt (While cond (Block block))
                _ -> returnNothing
        else 
            returnNothing


    execStmt (For ident start end (Block block)) = do
        VInt evaledStart <- evalExpr start
        VInt evaledEnd <- evalExpr end
        updateIdentInMem ident (VInt evaledStart)
        let plusOne = [Assign ident (EAdd (EInt 1) Plus (EVar ident))]
        let forBlock = Block (block ++ plusOne)
        let cond = ERel (EVar ident) LE (EInt evaledEnd)
        execStmt $ While cond forBlock
        
        
    execStmt (ForInList ident list (Block block)) = do
        VList (TInt, evaledList) <- evalExpr list
        loopList ident evaledList block
        where
            loopList :: Ident -> [VMemory] -> [Stmt] -> Interpreter (Env, ReturnRes)
            loopList _ [] _ = returnNothing
            loopList i (h:t) b = do
                updateIdentInMem i h
                _ <- execList b
                loopList i t b

-- print
    execStmt (Print e) = 
        case e of
            [] -> returnNothing
            h:t -> do
                expr <- evalExpr h
                liftIO $ putStr (vToString expr ++ " ")
                execStmt (Print t)
        
    execStmt (PrintEndl e) = execStmt (Print (e ++ [EString "\n"])) 
        
    vToString :: VMemory -> String
    vToString (VInt x) = show x
    vToString (VBool x) = show x
    vToString (VString s) = s
    vToString (VFun (args, typ, _, _)) = "Function (" ++ show args ++ ") -> " ++ show typ
    vToString (VList (_, elements)) = "[" ++ (foldl' (\a b -> a ++ (vToString b) ++ ", " ) "" elements) ++ "]"
    vToString e = show e

    returnNothing :: Interpreter (Env, ReturnRes)
    returnNothing = do
        env <- ask
        return (env, Nothing)

    execList :: [Stmt] -> Interpreter (Env, ReturnRes)
    execList [] = returnNothing
    execList (h:t) = do
        (env, ret) <- execStmt h
        case ret of
            Nothing -> local (const env) (execList t)
            _ -> return (env, ret)

    runProgram :: [Stmt] -> IO (Either RuntimeExceptions ((Env, ReturnRes), Store))
    runProgram program = runExceptT $ runStateT (runReaderT (execList program) Map.empty) (Map.empty, 0)