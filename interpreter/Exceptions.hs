module Exceptions(printTypeCheckError, printRuntimeError) where
    import Types
    import Grammar.Abs
    import Memory
    import Control.Monad.Except

    import qualified Data.Map.Strict as Map
    import System.Exit (die)
    import Control.Monad.Error.Class (throwError)


    -- data ParseErr a = {location:Int, reason:String}
    -- type Error a = Either ParseErr a

    printTypeCheckError :: TypeCheckerExceptions -> IO ()
    printTypeCheckError error =
        case error of
            TypeCheckException t1 t2 -> die $ "Mismatch in types, expected: " ++ show t1 ++ ", got: " ++ show t2
            DeclarationInvTypeException t -> die $ "Wrong type of a declared element: " ++ show t
            FuncArgsInvTypeException t -> die $ "Wrong type of argument in function: " ++ show t
            NotListException t -> die $ "Element is not a list: " ++ show t
            IdentifierNotExistException str -> die $ "No such identifier: " ++ show str 
            ReturnTypeMismatchException t1 t2 -> die $ "Mismatch in returned type, expected: " ++ show t1 ++ ", got: " ++ show t2

    printRuntimeError :: RuntimeExceptions -> IO()
    printRuntimeError error =
        case error of
            NoReturnException -> die $ "Missing return."
            ZeroDivisionException -> die $ "Division by zero."
            OutOfRangeExeption i -> die $ "Out of range:" ++ show i
           -- | NoStructFieldException String deriving Show