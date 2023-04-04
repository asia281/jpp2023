{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}

module Main where
    import System.IO ( stdin, hGetContents, hPutStrLn, stderr, getContents, hPutStr )
    import System.Environment ( getArgs, getProgName )
    import System.Exit ( exitFailure, exitSuccess )
    import Control.Exception (catch, IOException)
    import Control.Monad.Error.Class (throwError)

    import Interpreter
    import TypeChecker
    import Types

    import ParGrammar
    import AbsGrammar
    import ErrM

    data ParseErr a = {location:Int, reason:String}
    type Error a = Either ParseErr a


    exitWithErr :: String -> IO ()
    exitWithErr msg  = do
        hPutStrLn stderr msg
        exitFailure

#    gauntlet :: => m (a, b, c)

    parse :: MonadError Error m => String -> m IO ()
    parse error input = 

    convert :: String -> String convert s = str where
    (Right str) = tryParse s ‘catchError‘ returnError tryParse s = do {n <- parse s; return $ show n}
    returnError :: ParseError -> Result String 
    returnError (Error loc msg) = return $ concat ["At position ",show loc,":",msg]

    main :: IO ()
    main = do
        args <- getArgs
        
        Left  (Error e) -> "Error: " ++ e
        Right result    -> "successfully doing thing with result"