module Main where
    import System.Environment ( getArgs )

    import Grammar.Par
    import Grammar.Abs
    import Grammar.ErrM
    import TypeChecker
    import Interpreter
    import Exceptions

    runFile :: (Print a, Show a) => Verbosity -> ParseFun a -> FilePath -> IO ()
    runFile v p f = putStrLn f >> readFile f >>= run v p

    run :: [Stmt] -> IO ()
    run p = do
        check <- runProgramCheck p
        case check of
            (Left err) -> printTypeCheckError err
            (Right _) -> do 
                runResult <- runProgram p
                case runResult of
                    Left err -> printRuntimeError err
                    Right _ -> return ()


    main :: IO ()
    main = do
        file <- getArgs
        case file of
            [] -> liftIO getContents >>= run pProgram
            f:_ -> do
                program <- readFile f
                let parser = pProgram . myLexer
                case parser program of
                    Ok (Program p) -> do
                        run p
                        return ()
                    Bad e -> error e
                    _ -> undefined