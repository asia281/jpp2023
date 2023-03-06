module Main where
    import System.IO ( stdin, hGetContents, hPutStrLn, stderr, getContents, hPutStr )
    import System.Environment ( getArgs, getProgName )
    import System.Exit ( exitFailure, exitSuccess )
    import Control.Exception (catch, IOException)

    import Interpreter
    import TypeChecker
    import Types

    import ParGrammar
    import AbsGrammar
    import ErrM

    exitWithErr :: String -> IO ()
    exitWithErr msg = do
        hPutStrLn stderr msg
        exitFailure

