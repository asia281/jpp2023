module Memory where
    import Grammar.Abs

    import Data.Map as Map
    import Data.Maybe

    import Control.Monad.Reader
    import Control.Monad.State
    import Control.Monad.Except

    import Types
    -- we have mappings env: ident -> loc and store: loc -> vmem
    addIdentToMem :: Ident -> VMemory -> Interpreter Env
    addIdentToMem (Ident id) vmem = do
        env <- ask
        (store, loc) <- get 
        -- add updated store and location (= loc + 1)
        let new_store = Map.insert loc vmem store
        put (new_store, loc + 1)
        -- and return updated env
        let new_env = Map.insert id loc env
        return new_env


    updateIdentInMem :: Ident -> VMemory -> Interpreter ()
    updateIdentInMem (Ident id) vmem = do
        env <- ask
        (store, loc) <- get 
        -- get location from env
        let Just ident_location = Map.lookup id env
        -- and change the V in store
        let new_store = Map.insert ident_location vmem store
        put (new_store, loc)
        return ()


    getLocFromIdent :: Ident -> Interpreter Loc
    getLocFromIdent (Ident id) = do
        env <- ask
        let Just loc = Map.lookup id env
        return loc

    getVFromIdent :: Ident -> Interpreter VMemory
    getVFromIdent id = do
        (store, _) <- get
        ident_loc <- getLocFromIdent id
        let Just vmem = Map.lookup ident_loc store
        return vmem