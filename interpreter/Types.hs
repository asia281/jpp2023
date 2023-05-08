module Types where
    import Grammar.Abs

    import Data.Map as Map

    import Control.Monad.Reader
    import Control.Monad.State
    import Control.Monad.Except

    type Name = String

    type Loc = Integer

    -- Environment maps variable or function name to location
    type Env = Map.Map Name Loc

    -- Return value of block of statements, no return = nothing, otherwise = Just VMemory 
    type ReturnRes = Maybe VMemory

    -- Ident for passing by ref, vmemory otherwise
    data FuncVal = ByReference Loc | ByType VMemory

    -- Function - function body, environment of function, return type
    type FuncDef = ([FuncVal] -> Interpreter VMemory)

    -- List definition - hold type and list of values
    type ListDef = (Type, [VMemory])


-- Memory
    -- mapping from Loc to value in memory
    type StateInMemory = Map.Map Loc VMemory

    -- type for value in memory
    data VMemory = VBool Bool 
                | VInt Integer 
                | VString String 
                | VVoid 
                | VFun FuncDef 
                | VList ListDef 
                | VStruct StructDef 
                | VStructType StructType

    -- state in memory, next free location and 
    type Store = (StateInMemory, Loc)

-- Exceptions
    data RuntimeExceptions = NoReturnException 
                            | ZeroDivisionException
                            | OutOfRangeExeption Integer Integer
                            | NoStructFieldException String deriving Show

    data TypeCheckerExceptions = TypeCheckException Type Type 
                                | DeclarationInvTypeException Type 
                                | FuncArgsInvTypeException Type 
                                | NotListException Type 
                                | InvalidTypesInApplication
                                | NonUniqueArgName String String
                                | IdentifierNotExistException String 
                                | ReturnTypeMismatchException Type Type deriving Show


-- Structs
    type StructFieldName = String
    -- struct definition - field name and its value
    type StructDef = Map.Map StructFieldName VMemory
    -- struct description - field name and its type
    type StructType = Map.Map StructFieldName Type

-- Monad type of interpreter
    type Interpreter = ReaderT Env (StateT Store (ExceptT RuntimeExceptions IO))
