module ExecStmt where
    import Grammar.Abs

    import Data.Map as Map
    import Data.Maybe

    import Control.Monad.Reader
    import Control.Monad.State
    import Control.Monad.Except

    import Types
    import Memory
    import TypeChecker
    import EvalExpr


    execStmt :: Stmt -> Interpreter (Env, ReturnRes)

-- tocheck    
    execStmt (SExpr stmt) = do
        evalExpr stmt
        returnNothing

-- assignment
    execStmt (Assign id expr) = do
        evaledExpr <- evalExpr expr
        -- add to memory
        returnNothing

-- Return
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
                (env, returned) <- execList block
                case returned of
                    Nothing -> returnNothing
                    otherwise -> execStmt (While cond (Block block))
        else 
            returnNothing


    execStmt (For id start end (Block block)) = do
        VInt evaledStart <- evalExpr start
        VInt evaledEnd <- evalExpr end
        updateIdentInMem id (VInt evaledStart)
        let plusOne = [Assign id (EAdd (EInt 1) Plus (EVar id))]
        let forBlock = Block (block ++ plusOne)
        execStmt $ While (ERel (EVar id) LE (EInt evaledEnd)) forBlock
        
        
    execStmt (ForInList id list (Block block)) = do
        VList (TInt, evaledList) <- evalExpr list
        loopList id evaledList block
        where
            loopList :: Ident -> [VMemory] -> [Stmt] -> Interpreter (Env, ReturnRes)
            loopList id [] _ = returnNothing
            loopList id (h:t) block = do
                updateIdentInMem id h
                execList block
                loopList id t block

-- print
    execStmt (Print e) = 
        case e of
            [] -> returnNothing
            h:t -> do
                expr <- evalExpr h
                liftIO $ putStr $ vToString expr ++ " "
                execStmt (Print t)
        
    execStmt (PrintEndl e) = do
        execStmt (Print (e ++ [EString "\n"])) 


    vToString :: VMemory -> String
    vToString (VInt x) = show x
    vToString (VBool x) = show x
    vToString (VString s) = s
    vToString (VFun (args, typ, stmts, env)) = "Function (" ++ show args ++ ") -> " ++ show typ
    vToString (VList (typ, elems)) = "[" ++ (Prelude.foldl (\a b -> a ++ (vToString b) ++ ", " ) "" elems) ++ "]"
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

    runProgram program = runExceptT $ runStateT (runReaderT (execList program) Map.empty) (Map.empty, 0)