{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where
    import System.Environment ( getArgs )

    import Types

    import Grammar.Par
    import Grammar.Abs
    import Grammar.ErrM
    import Control.Monad.Reader
    import qualified Data.Map as Map
    import Data.Maybe
    import TypeChecker
    import ExecStmt
    import Exceptions

    run :: [Stmt] -> IO ()
    run p = do
        check <- runProgramCheck p
        case check of
            (Left err) -> printTypeCheckError err
            (Right _) -> runProgram p

    main :: IO ()
    main = do
        file <- getArgs
        case file of
            [] -> error "No args provided!"
            file:_ -> do
                program <- readFile file
                let parser = pProgram . myLexer
                case parser program of
                    Ok (Program p) -> do
                        run p
                        return ()
                    Bad e -> error e