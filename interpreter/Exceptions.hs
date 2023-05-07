module Exceptions(printTypeCheckError, printRuntimeError) where
    import Types
    import System.Exit (die)

    -- data ParseErr a = {location:Int, reason:String}
    -- type Error a = Either ParseErr a

    printTypeCheckError :: TypeCheckerExceptions -> IO ()
    printTypeCheckError err =
        case err of
            TypeCheckException t1 t2 -> die $ "Mismatch in types, expected: " ++ show t1 ++ ", got: " ++ show t2
            DeclarationInvTypeException t -> die $ "Wrong type of a declared element: " ++ show t
            FuncArgsInvTypeException t -> die $ "Wrong type of argument in function: " ++ show t
            NotListException t -> die $ "Element is not a list: " ++ show t
            InvalidTypesInApplication -> die $ "Function application got mismatching argument types"
            IdentifierNotExistException str -> die $ "No such identifier: " ++ show str 
            ReturnTypeMismatchException t1 t2 -> die $ "Mismatch in returned type, expected: " ++ show t1 ++ ", got: " ++ show t2

    printRuntimeError :: RuntimeExceptions -> IO()
    printRuntimeError err =
        case err of
            NoReturnException -> die $ "Missing return."
            ZeroDivisionException -> die $ "Division by zero."
            OutOfRangeExeption li i -> die $ "Out of range. List has length:" ++ show li ++ "and you're accessing element number:" ++ show i
           -- | NoStructFieldException String deriving Show