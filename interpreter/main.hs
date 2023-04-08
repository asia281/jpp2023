{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where
    import System.IO ( stdin, hGetContents, hPutStrLn, stderr, getContents, hPutStr )
    import System.Environment ( getArgs, getProgName )
    import System.Exit ( exitFailure, exitSuccess )
    import Control.Exception (catch, IOException)
    import Control.Monad.Error.Class (throwError)

    import Types

    import Grammar.Par
    import Grammar.Abs
    import Grammar.ErrM
    import Control.Monad.Reader
    import qualified Data.Map as Map
    import Data.Maybe
    import TypeChecker
    import ExecStmt


    -- data ParseErr a = {location:Int, reason:String}
    -- type Error a = Either ParseErr a


    -- exitWithErr :: String -> IO ()
    -- exitWithErr msg  = do
    --     hPutStrLn stderr msg
    --     exitFailure

    printTypeCheckError :: TypeCheckerExceptions -> [Char]
    printTypeCheckError error =
        case error of
            TypeCheckException t1 t2 -> "Mismatch in types, expected: " ++ show t1 ++ ", got: " ++ show t2
            DeclarationInvTypeException t -> "Wrong type of a declared element: " ++ show t
            FuncArgsInvTypeException t -> "Wrong type of argument in function: " ++ show t
            NotListException t -> "Element is not a list: " ++ show t
            IdentifierNotExistException str -> "No such identifier: " ++ show str 
            ReturnTypeMismatchException t1 t2 -> "Mismatch in returned type, expected: " ++ show t1 ++ ", got: " ++ show t2

    printRuntimeError :: RuntimeExceptions -> String
    printRuntimeError error =
        case error of
            NoReturnException -> "Missing return."
            ZeroDivisionException -> "Division by zero."
            OutOfRangeExeption i -> "Out of range:" ++ show i
           -- | NoStructFieldException String deriving Show

    run p = do
        check <- runProgramCheck p
        case check of
            (Left err) -> error (printTypeCheckError err)
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