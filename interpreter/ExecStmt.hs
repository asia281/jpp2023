module ExecStmt where
    import AbsGrammar

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
    execStmt ReturnVoid = 
        env <- ask
        return (env, VVoid)

    execStmt (Return expr) = do
        env <- ask
        val <- evalExpr expr
        return (env, Just val)
    
-- conditions
    execStmt (If cond block) = do
        VBool evaledCond <- evalExpr cond
        case evaledCond of
            true -> execStmt block
            false -> returnNothing  
            
    execStmt (IfElse cond block1 block2) = do
        VBool evaledCond <- evalExpr cond
        case evaledCond of
            true -> execStmt block1
            false -> execStmt block2  
-- loops
-- tocheck
    execStmt (While cond block) = do
        VBool evaledCond <- evalExpr cond
        case evaledCond of
            true -> do
                (env, returned) <- execStmt block
                case returned of
                    Nothing -> returnNothing
                    otherwise -> execStmt (While cond block)
            false -> returnNothing
    
    execStmt (For id start end block) = do
        VInt evaledStart <- evalExpr start
        VInt evaledEnd <- evalExpr end
        
        
    execStmt (ForInList id list block) = do
        VList t evaledList <- evalExpr list
         

-- print
    execStmt (Print e) = 
        case e of
            [] -> returnNothing
            h:t -> do
                expr <- evalExpr h
                liftIO $ putStr (memToString expr)
                execStmt (Print t)

    returnNothing :: Interpreter (Env, ReturnRes)
    returnNothing = do
        env <- ask
        return (env, Nothing)
        
    execStmt (Block block) = do
        (env, var) <- execList block
        -- check env 
        return (env, var)

    execList :: [Stmt] -> Interpreter (Env, ReturnRes)
    execList [] = returnNothing
    execList (x : xt) = do
                (env, ret) <- evalStmt x
                if isNothing ret then
                    local (const env) (execList xs)
                else
                    return (env, ret)

    runProg prog = runExceptT $ runStateT (runReaderT (execList prog) Map.empty) (Map.empty, 0)