module Memory where
    import Grammar.Abs

    import Data.Map as Map
    import Data.Bifunctor
    import Control.Monad.Reader
    import Control.Monad.State

    import Types
    -- we have mappings env: ident -> loc and store: loc -> vmem
    addIdentToMem :: Ident -> VMemory -> Interpreter Env
    addIdentToMem (Ident ident) vmem = do
        env <- ask
        (store, loc) <- get 
        -- add updated store and location (= loc + 1)
        let new_store = Map.insert loc vmem store
        put (new_store, loc + 1)
        -- and return updated env
        let new_env = Map.insert ident loc env
        return new_env

    getFunLoc :: Interpreter Loc
    getFunLoc = do        
        (_, loc) <- get
        modify (second (+1))
        return loc
                    

    updateIdentInMem :: Ident -> VMemory -> Interpreter ()
    updateIdentInMem (Ident ident) vmem = do
        env <- ask
        (store, loc) <- get 
        -- get location from env
        let Just ident_location = Map.lookup ident env
        -- and change the V in store
        let new_store = Map.insert ident_location vmem store
        put (new_store, loc)
        return ()


    getLocFromIdent :: Ident -> Interpreter Loc
    getLocFromIdent (Ident ident) = do
        env <- ask
        let Just loc = Map.lookup ident env
        return loc

    getValueFromIdent :: Ident -> Interpreter VMemory
    getValueFromIdent ident = do
        (store, _) <- get
        ident_loc <- getLocFromIdent ident
        liftIO $ print ident_loc
        let Just vmem = Map.lookup ident_loc store
        liftIO $ print "m"
        return vmem