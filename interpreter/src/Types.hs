module Types where
    import AbsGrammar

    import Data.Map as Map
    import Data.Maybe

    import Control.Monad.Reader
    import Control.Monad.State
    import Control.Monad.Except

    type VarName = String


    type Loc = Integer
-- Environment, maps variable/function name to location
    type Env = Map.Map VarName Loc
    -- return value of block of statements. Nothing when no return, Just MemVal if return occured 
    type ReturnRes = Maybe MemVal
    -- way of passing argument to function
    data PassArgType = ByValue | ByRef deriving Show 
    -- argument passed to function (name of variable, type of variable, way of passing argument)
    type FunArg = (VariableName, Type, PassArgType)

    -- list of arguments passed to function
    type FunArgList = [FunArg]

    -- function/lambda - fun body, environment when declared function, return type, capture group when declared function/lambda (function always empty)
    type FuncDef = ([Stmt], MyEnv, FunArgList, Type, CaptureGroup)

    -- list definition - hold type and list of values
    type ListDef = (Type, [MemVal])

    -- "memory"
    type State = Map.Map Loc Mem


-- Structs
    type StructFieldName = String
    -- struct definition - field name and its value
    type StructDef = Map.Map StructFieldName MemVal

    -- struct description - field name and its type
    type StructDesc = Map.Map StructFieldName Type

