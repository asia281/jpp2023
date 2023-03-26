module Types where
    import AbsGrammar

    import Data.Map as Map
    import Data.Maybe

    import Control.Monad.Reader
    import Control.Monad.State
    import Control.Monad.Except

    type Name = String

    type Loc = Integer

    -- Environment maps variable or function name to location
    type Env = Map.Map Name Loc

    -- Return value of block of statements, no return = nothing, otherwise = Just MemVal 
    type ReturnRes = Maybe VMemory

    -- How to pass an argument to function
    data PassArgType = ByValue | ByReference deriving Show 

    -- Type with information if it's passed by reference or value
    type TypeToPass = (Type, PassArgType)

    -- Argument passed to function (name, type of variable, way of passing argument)
    type FunArg = (VariableName, Type, PassArgType)
    -- list of arguments passed to function
    type FunArgList = [FunArg]

    -- Function - function body, environment of function, return type
    type FuncDef = ([Stmt], Env, FunArgList, Type)

    -- List definition - hold type and list of values
    type ListDef = (Type, [VMemory])


-- Memory
    -- mapping from Loc to value in memory
    type State = Map.Map Loc VMemory

    -- type for value in memory
    data VMemory = VBool Bool 
                | VInt Integer 
                | VString String 
                | VVoid 
                | FunVal FuncDef 
                | VList ListDef 
                | VStruct StructDef 
                | VStructType StructType deriving Show

    -- state in memory, next free location and 
    data Store = (State, Loc)

-- Exceptions
    data RuntimeExceptions = NoReturnException 
                            | ZeroDivisionException
                            | OutOfRangeExeption Integer 
                            | NoStructFieldException String deriving Show

    data TypeCheckerExceptions = TypeCheckException Type Type 
                                | DeclarationInvTypeException Type 
                                | FuncArgsInvTypeException Type 
                                | NotListException Type 
                                | IdentifierNotExistException String 
                                | ReturnTypeMismatchException (Maybe Type) (Maybe Type)  deriving Show


-- Structs
    type StructFieldName = String
    -- struct definition - field name and its value
    type StructDef = Map.Map StructFieldName VMemory
    -- struct description - field name and its type
    type StructType = Map.Map StructFieldName Type


-- Monad type
    type InterpreterMonad = ReaderT Env (StateT Store (ExceptT RuntimeExceptions IO))
