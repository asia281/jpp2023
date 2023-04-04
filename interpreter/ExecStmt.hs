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



-- STMT --

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

    evalStmt :: Stmt -> Interpreter (Env, ReturnRes)

    interpretAll :: [Stmt] -> Interpreter (Env, ReturnRes)
    interpretAll [] = returnNothing
    interpretAll (x : xt) = do
                (env, ret) <- evalStmt x
                if isNothing ret then
                    local (const env) (interpretAll xs)
                else
                    return (env, ret)

    runProg prog = runExceptT $ runStateT (runReaderT (interpretAll prog) Map.empty) (Map.empty, 0)