{-# OPTIONS_GHC -w #-}
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
{-# LANGUAGE PatternSynonyms #-}

module Grammar.Par
  ( happyError
  , myLexer
  , pProgram
  ) where

import Prelude

import qualified Grammar.Abs
import Grammar.Lex
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn 
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 (Grammar.Abs.Ident)
	| HappyAbsSyn5 (Integer)
	| HappyAbsSyn6 (String)
	| HappyAbsSyn7 (Grammar.Abs.Program)
	| HappyAbsSyn8 (Grammar.Abs.Block)
	| HappyAbsSyn9 ([Grammar.Abs.Stmt])
	| HappyAbsSyn10 (Grammar.Abs.Stmt)
	| HappyAbsSyn11 (Grammar.Abs.Item)
	| HappyAbsSyn12 ([Grammar.Abs.Item])
	| HappyAbsSyn13 ([Grammar.Abs.Expr])
	| HappyAbsSyn14 (Grammar.Abs.Arg)
	| HappyAbsSyn15 ([Grammar.Abs.Arg])
	| HappyAbsSyn16 (Grammar.Abs.Type)
	| HappyAbsSyn17 ([Grammar.Abs.Type])
	| HappyAbsSyn18 (Grammar.Abs.TypeOrRef)
	| HappyAbsSyn19 ([Grammar.Abs.TypeOrRef])
	| HappyAbsSyn20 (Grammar.Abs.AddOp)
	| HappyAbsSyn21 (Grammar.Abs.MulOp)
	| HappyAbsSyn22 (Grammar.Abs.RelOp)
	| HappyAbsSyn23 (Grammar.Abs.Expr)
	| HappyAbsSyn31 ([Grammar.Abs.Ident])
	| HappyAbsSyn32 (Grammar.Abs.ExprOrRef)
	| HappyAbsSyn33 ([Grammar.Abs.ExprOrRef])
	| HappyAbsSyn34 (Grammar.Abs.StructItem)
	| HappyAbsSyn35 ([Grammar.Abs.StructItem])

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181,
 action_182,
 action_183 :: () => Prelude.Int -> ({-HappyReduction (Err) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104 :: () => ({-HappyReduction (Err) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,762) ([0,0,2112,26688,30427,231,0,0,0,0,16384,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,256,0,64,0,0,0,0,0,0,0,0,0,2048,0,0,32768,45056,35,0,0,0,16384,1,0,0,0,0,4164,0,0,0,0,0,0,0,0,0,0,8256,0,0,0,0,0,0,0,0,0,0,8448,41216,33632,909,0,0,2,49474,6914,7,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,8192,0,0,128,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,4096,0,0,0,0,2048,2048,2821,7276,0,0,16,0,0,0,0,8192,0,0,0,0,0,2112,10304,24792,227,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,16392,55336,58208,0,0,0,0,0,16,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,528,2576,55350,56,0,8192,8196,27668,29104,0,0,64,0,0,0,0,0,0,45072,1216,0,0,256,0,0,0,0,0,66,49474,6918,7,0,1024,0,0,0,0,0,0,0,0,4,0,0,1,0,0,0,0,0,128,0,0,0,16384,0,0,0,0,0,256,0,0,0,0,32768,33,24737,36227,3,0,0,8192,256,0,0,0,132,33412,13837,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2112,10304,24792,227,0,0,0,0,0,0,0,0,0,0,0,0,0,66,49474,6918,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,24737,36227,3,0,16896,16896,1729,1819,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,8196,28084,29627,0,0,0,0,2048,0,0,32768,32784,45136,50881,1,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,264,1288,27675,28,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,33312,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,16384,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,1,0,0,0,72,0,0,0,4,256,19467,0,0,8192,0,0,0,0,0,16,1024,12332,1,0,0,4096,0,0,0,0,256,0,0,0,0,0,16,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,2817,76,0,0,32,0,0,0,0,0,0,0,1024,0,0,0,0,0,32,0,0,256,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,33792,33792,3458,3638,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,256,0,0,0,0,0,0,24608,2433,0,0,0,0,0,64,0,0,64,0,0,0,0,4096,0,0,0,0,0,0,0,0,8,0,0,0,11268,304,0,0,2112,10304,24792,227,0,32768,32784,45136,50881,1,0,0,0,0,0,0,0,1,49216,4866,0,0,0,0,0,0,0,0,0,0,0,0,0,6144,4098,13834,14552,0,0,32,5152,45100,113,0,0,0,0,0,0,0,4224,20608,49584,454,0,0,2,0,0,0,0,1536,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,32,0,0,0,0,0,0,0,64,0,0,0,0,0,32,0,0,0,0,0,0,0,16384,0,0,0,0,0,1,49216,4866,0,0,0,0,1,0,0,0,264,27912,61147,28,0,0,0,0,0,0,0,2048,0,0,0,0,8192,0,22536,608,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,704,19,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,24664,2,0,0,0,0,8192,0,0,0,0,0,32,0,0,0,0,0,0,0,0,32768,1408,38,0,0,0,0,0,0,0,4096,4098,13834,14552,0,0,0,0,0,4,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,704,19,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","Ident","Integer","String","Program","Block","ListStmt","Stmt","Item","ListItem","ListExpr","Arg","ListArg","Type","ListType","TypeOrRef","ListTypeOrRef","AddOp","MulOp","RelOp","Expr","Expr1","Expr2","Expr3","Expr4","Expr5","Expr6","Expr7","ListIdent","ExprOrRef","ListExprOrRef","StructItem","ListStructItem","'!='","'%'","'&'","'('","')'","'*'","'+'","','","'-'","'->'","'.'","'/'","';'","'<'","'<='","'='","'=='","'>'","'>='","'['","'[]'","']'","'and'","'at'","'bool'","'else'","'false'","'for'","'from'","'fun'","'if'","'in'","'int'","'lambda'","'len()'","'list'","'not'","'or'","'print'","'printEndl'","'push'","'return'","'string'","'struct'","'to'","'true'","'void'","'while'","'{'","'}'","L_Ident","L_integ","L_quoted","%eof"]
        bit_start = st Prelude.* 89
        bit_end = (st Prelude.+ 1) Prelude.* 89
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..88]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (39) = happyShift action_18
action_0 (44) = happyShift action_19
action_0 (55) = happyShift action_20
action_0 (60) = happyShift action_21
action_0 (62) = happyShift action_22
action_0 (63) = happyShift action_23
action_0 (65) = happyShift action_24
action_0 (66) = happyShift action_25
action_0 (68) = happyShift action_26
action_0 (69) = happyShift action_27
action_0 (71) = happyShift action_28
action_0 (72) = happyShift action_29
action_0 (74) = happyShift action_30
action_0 (75) = happyShift action_31
action_0 (77) = happyShift action_32
action_0 (78) = happyShift action_33
action_0 (79) = happyShift action_34
action_0 (81) = happyShift action_35
action_0 (82) = happyShift action_36
action_0 (83) = happyShift action_37
action_0 (86) = happyShift action_2
action_0 (87) = happyShift action_38
action_0 (88) = happyShift action_39
action_0 (89) = happyReduce_9
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 (6) = happyGoto action_5
action_0 (7) = happyGoto action_6
action_0 (9) = happyGoto action_7
action_0 (10) = happyGoto action_8
action_0 (16) = happyGoto action_9
action_0 (23) = happyGoto action_10
action_0 (24) = happyGoto action_11
action_0 (25) = happyGoto action_12
action_0 (26) = happyGoto action_13
action_0 (27) = happyGoto action_14
action_0 (28) = happyGoto action_15
action_0 (29) = happyGoto action_16
action_0 (30) = happyGoto action_17
action_0 _ = happyReduce_9

action_1 (86) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (46) = happyShift action_80
action_3 (51) = happyShift action_81
action_3 _ = happyReduce_86

action_4 _ = happyReduce_85

action_5 _ = happyReduce_90

action_6 (89) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_4

action_8 (48) = happyShift action_79
action_8 (85) = happyReduce_10
action_8 (89) = happyReduce_10
action_8 _ = happyReduce_10

action_9 (56) = happyShift action_78
action_9 (86) = happyShift action_2
action_9 (4) = happyGoto action_76
action_9 (11) = happyGoto action_77
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_13

action_11 (73) = happyShift action_75
action_11 _ = happyReduce_69

action_12 (36) = happyShift action_68
action_12 (49) = happyShift action_69
action_12 (50) = happyShift action_70
action_12 (52) = happyShift action_71
action_12 (53) = happyShift action_72
action_12 (54) = happyShift action_73
action_12 (58) = happyShift action_74
action_12 (22) = happyGoto action_67
action_12 _ = happyReduce_71

action_13 (42) = happyShift action_65
action_13 (44) = happyShift action_66
action_13 (20) = happyGoto action_64
action_13 _ = happyReduce_73

action_14 (37) = happyShift action_61
action_14 (41) = happyShift action_62
action_14 (47) = happyShift action_63
action_14 (21) = happyGoto action_60
action_14 _ = happyReduce_75

action_15 _ = happyReduce_77

action_16 (39) = happyShift action_58
action_16 (46) = happyShift action_59
action_16 _ = happyReduce_80

action_17 _ = happyReduce_84

action_18 (39) = happyShift action_18
action_18 (44) = happyShift action_19
action_18 (55) = happyShift action_20
action_18 (60) = happyShift action_21
action_18 (62) = happyShift action_22
action_18 (68) = happyShift action_26
action_18 (69) = happyShift action_27
action_18 (71) = happyShift action_28
action_18 (72) = happyShift action_29
action_18 (78) = happyShift action_33
action_18 (79) = happyShift action_45
action_18 (81) = happyShift action_35
action_18 (82) = happyShift action_36
action_18 (86) = happyShift action_2
action_18 (87) = happyShift action_38
action_18 (88) = happyShift action_39
action_18 (4) = happyGoto action_42
action_18 (5) = happyGoto action_4
action_18 (6) = happyGoto action_5
action_18 (16) = happyGoto action_43
action_18 (23) = happyGoto action_57
action_18 (24) = happyGoto action_11
action_18 (25) = happyGoto action_12
action_18 (26) = happyGoto action_13
action_18 (27) = happyGoto action_14
action_18 (28) = happyGoto action_15
action_18 (29) = happyGoto action_16
action_18 (30) = happyGoto action_17
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (39) = happyShift action_18
action_19 (55) = happyShift action_20
action_19 (60) = happyShift action_21
action_19 (62) = happyShift action_22
action_19 (68) = happyShift action_26
action_19 (69) = happyShift action_27
action_19 (71) = happyShift action_28
action_19 (78) = happyShift action_33
action_19 (79) = happyShift action_45
action_19 (81) = happyShift action_35
action_19 (82) = happyShift action_36
action_19 (86) = happyShift action_2
action_19 (87) = happyShift action_38
action_19 (88) = happyShift action_39
action_19 (4) = happyGoto action_42
action_19 (5) = happyGoto action_4
action_19 (6) = happyGoto action_5
action_19 (16) = happyGoto action_43
action_19 (29) = happyGoto action_56
action_19 (30) = happyGoto action_17
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (86) = happyShift action_2
action_20 (4) = happyGoto action_54
action_20 (31) = happyGoto action_55
action_20 _ = happyReduce_93

action_21 _ = happyReduce_43

action_22 _ = happyReduce_88

action_23 (39) = happyShift action_53
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (86) = happyShift action_2
action_24 (4) = happyGoto action_52
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (39) = happyShift action_51
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_42

action_27 (49) = happyShift action_50
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (49) = happyShift action_49
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (39) = happyShift action_18
action_29 (55) = happyShift action_20
action_29 (60) = happyShift action_21
action_29 (62) = happyShift action_22
action_29 (68) = happyShift action_26
action_29 (69) = happyShift action_27
action_29 (71) = happyShift action_28
action_29 (78) = happyShift action_33
action_29 (79) = happyShift action_45
action_29 (81) = happyShift action_35
action_29 (82) = happyShift action_36
action_29 (86) = happyShift action_2
action_29 (87) = happyShift action_38
action_29 (88) = happyShift action_39
action_29 (4) = happyGoto action_42
action_29 (5) = happyGoto action_4
action_29 (6) = happyGoto action_5
action_29 (16) = happyGoto action_43
action_29 (29) = happyGoto action_48
action_29 (30) = happyGoto action_17
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (39) = happyShift action_47
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (39) = happyShift action_46
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (39) = happyShift action_18
action_32 (44) = happyShift action_19
action_32 (55) = happyShift action_20
action_32 (60) = happyShift action_21
action_32 (62) = happyShift action_22
action_32 (68) = happyShift action_26
action_32 (69) = happyShift action_27
action_32 (71) = happyShift action_28
action_32 (72) = happyShift action_29
action_32 (78) = happyShift action_33
action_32 (79) = happyShift action_45
action_32 (81) = happyShift action_35
action_32 (82) = happyShift action_36
action_32 (86) = happyShift action_2
action_32 (87) = happyShift action_38
action_32 (88) = happyShift action_39
action_32 (4) = happyGoto action_42
action_32 (5) = happyGoto action_4
action_32 (6) = happyGoto action_5
action_32 (16) = happyGoto action_43
action_32 (23) = happyGoto action_44
action_32 (24) = happyGoto action_11
action_32 (25) = happyGoto action_12
action_32 (26) = happyGoto action_13
action_32 (27) = happyGoto action_14
action_32 (28) = happyGoto action_15
action_32 (29) = happyGoto action_16
action_32 (30) = happyGoto action_17
action_32 _ = happyReduce_22

action_33 _ = happyReduce_44

action_34 (86) = happyShift action_2
action_34 (4) = happyGoto action_41
action_34 _ = happyFail (happyExpListPerState 34)

action_35 _ = happyReduce_87

action_36 _ = happyReduce_45

action_37 (39) = happyShift action_40
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_2

action_39 _ = happyReduce_3

action_40 (39) = happyShift action_18
action_40 (44) = happyShift action_19
action_40 (55) = happyShift action_20
action_40 (60) = happyShift action_21
action_40 (62) = happyShift action_22
action_40 (68) = happyShift action_26
action_40 (69) = happyShift action_27
action_40 (71) = happyShift action_28
action_40 (72) = happyShift action_29
action_40 (78) = happyShift action_33
action_40 (79) = happyShift action_45
action_40 (81) = happyShift action_35
action_40 (82) = happyShift action_36
action_40 (86) = happyShift action_2
action_40 (87) = happyShift action_38
action_40 (88) = happyShift action_39
action_40 (4) = happyGoto action_42
action_40 (5) = happyGoto action_4
action_40 (6) = happyGoto action_5
action_40 (16) = happyGoto action_43
action_40 (23) = happyGoto action_110
action_40 (24) = happyGoto action_11
action_40 (25) = happyGoto action_12
action_40 (26) = happyGoto action_13
action_40 (27) = happyGoto action_14
action_40 (28) = happyGoto action_15
action_40 (29) = happyGoto action_16
action_40 (30) = happyGoto action_17
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (84) = happyShift action_109
action_41 _ = happyReduce_47

action_42 _ = happyReduce_86

action_43 (56) = happyShift action_78
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_21

action_45 (86) = happyShift action_2
action_45 (4) = happyGoto action_108
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (39) = happyShift action_18
action_46 (40) = happyReduce_34
action_46 (44) = happyShift action_19
action_46 (55) = happyShift action_20
action_46 (60) = happyShift action_21
action_46 (62) = happyShift action_22
action_46 (68) = happyShift action_26
action_46 (69) = happyShift action_27
action_46 (71) = happyShift action_28
action_46 (72) = happyShift action_29
action_46 (78) = happyShift action_33
action_46 (79) = happyShift action_45
action_46 (81) = happyShift action_35
action_46 (82) = happyShift action_36
action_46 (86) = happyShift action_2
action_46 (87) = happyShift action_38
action_46 (88) = happyShift action_39
action_46 (4) = happyGoto action_42
action_46 (5) = happyGoto action_4
action_46 (6) = happyGoto action_5
action_46 (13) = happyGoto action_107
action_46 (16) = happyGoto action_43
action_46 (23) = happyGoto action_106
action_46 (24) = happyGoto action_11
action_46 (25) = happyGoto action_12
action_46 (26) = happyGoto action_13
action_46 (27) = happyGoto action_14
action_46 (28) = happyGoto action_15
action_46 (29) = happyGoto action_16
action_46 (30) = happyGoto action_17
action_46 _ = happyReduce_34

action_47 (39) = happyShift action_18
action_47 (40) = happyReduce_34
action_47 (44) = happyShift action_19
action_47 (55) = happyShift action_20
action_47 (60) = happyShift action_21
action_47 (62) = happyShift action_22
action_47 (68) = happyShift action_26
action_47 (69) = happyShift action_27
action_47 (71) = happyShift action_28
action_47 (72) = happyShift action_29
action_47 (78) = happyShift action_33
action_47 (79) = happyShift action_45
action_47 (81) = happyShift action_35
action_47 (82) = happyShift action_36
action_47 (86) = happyShift action_2
action_47 (87) = happyShift action_38
action_47 (88) = happyShift action_39
action_47 (4) = happyGoto action_42
action_47 (5) = happyGoto action_4
action_47 (6) = happyGoto action_5
action_47 (13) = happyGoto action_105
action_47 (16) = happyGoto action_43
action_47 (23) = happyGoto action_106
action_47 (24) = happyGoto action_11
action_47 (25) = happyGoto action_12
action_47 (26) = happyGoto action_13
action_47 (27) = happyGoto action_14
action_47 (28) = happyGoto action_15
action_47 (29) = happyGoto action_16
action_47 (30) = happyGoto action_17
action_47 _ = happyReduce_34

action_48 (39) = happyShift action_58
action_48 _ = happyReduce_79

action_49 (60) = happyShift action_21
action_49 (68) = happyShift action_26
action_49 (69) = happyShift action_27
action_49 (71) = happyShift action_28
action_49 (78) = happyShift action_33
action_49 (79) = happyShift action_45
action_49 (82) = happyShift action_36
action_49 (16) = happyGoto action_104
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (39) = happyShift action_103
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (39) = happyShift action_18
action_51 (44) = happyShift action_19
action_51 (55) = happyShift action_20
action_51 (60) = happyShift action_21
action_51 (62) = happyShift action_22
action_51 (68) = happyShift action_26
action_51 (69) = happyShift action_27
action_51 (71) = happyShift action_28
action_51 (72) = happyShift action_29
action_51 (78) = happyShift action_33
action_51 (79) = happyShift action_45
action_51 (81) = happyShift action_35
action_51 (82) = happyShift action_36
action_51 (86) = happyShift action_2
action_51 (87) = happyShift action_38
action_51 (88) = happyShift action_39
action_51 (4) = happyGoto action_42
action_51 (5) = happyGoto action_4
action_51 (6) = happyGoto action_5
action_51 (16) = happyGoto action_43
action_51 (23) = happyGoto action_102
action_51 (24) = happyGoto action_11
action_51 (25) = happyGoto action_12
action_51 (26) = happyGoto action_13
action_51 (27) = happyGoto action_14
action_51 (28) = happyGoto action_15
action_51 (29) = happyGoto action_16
action_51 (30) = happyGoto action_17
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (39) = happyShift action_101
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (86) = happyShift action_2
action_53 (4) = happyGoto action_100
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (43) = happyShift action_99
action_54 _ = happyReduce_94

action_55 (57) = happyShift action_98
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (39) = happyShift action_58
action_56 _ = happyReduce_78

action_57 (40) = happyShift action_97
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (38) = happyShift action_96
action_58 (39) = happyShift action_18
action_58 (44) = happyShift action_19
action_58 (55) = happyShift action_20
action_58 (60) = happyShift action_21
action_58 (62) = happyShift action_22
action_58 (68) = happyShift action_26
action_58 (69) = happyShift action_27
action_58 (71) = happyShift action_28
action_58 (72) = happyShift action_29
action_58 (78) = happyShift action_33
action_58 (79) = happyShift action_45
action_58 (81) = happyShift action_35
action_58 (82) = happyShift action_36
action_58 (86) = happyShift action_2
action_58 (87) = happyShift action_38
action_58 (88) = happyShift action_39
action_58 (4) = happyGoto action_42
action_58 (5) = happyGoto action_4
action_58 (6) = happyGoto action_5
action_58 (16) = happyGoto action_43
action_58 (23) = happyGoto action_93
action_58 (24) = happyGoto action_11
action_58 (25) = happyGoto action_12
action_58 (26) = happyGoto action_13
action_58 (27) = happyGoto action_14
action_58 (28) = happyGoto action_15
action_58 (29) = happyGoto action_16
action_58 (30) = happyGoto action_17
action_58 (32) = happyGoto action_94
action_58 (33) = happyGoto action_95
action_58 _ = happyReduce_98

action_59 (59) = happyShift action_91
action_59 (70) = happyShift action_92
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (39) = happyShift action_18
action_60 (44) = happyShift action_19
action_60 (55) = happyShift action_20
action_60 (60) = happyShift action_21
action_60 (62) = happyShift action_22
action_60 (68) = happyShift action_26
action_60 (69) = happyShift action_27
action_60 (71) = happyShift action_28
action_60 (72) = happyShift action_29
action_60 (78) = happyShift action_33
action_60 (79) = happyShift action_45
action_60 (81) = happyShift action_35
action_60 (82) = happyShift action_36
action_60 (86) = happyShift action_2
action_60 (87) = happyShift action_38
action_60 (88) = happyShift action_39
action_60 (4) = happyGoto action_42
action_60 (5) = happyGoto action_4
action_60 (6) = happyGoto action_5
action_60 (16) = happyGoto action_43
action_60 (28) = happyGoto action_90
action_60 (29) = happyGoto action_16
action_60 (30) = happyGoto action_17
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_61

action_62 _ = happyReduce_59

action_63 _ = happyReduce_60

action_64 (39) = happyShift action_18
action_64 (44) = happyShift action_19
action_64 (55) = happyShift action_20
action_64 (60) = happyShift action_21
action_64 (62) = happyShift action_22
action_64 (68) = happyShift action_26
action_64 (69) = happyShift action_27
action_64 (71) = happyShift action_28
action_64 (72) = happyShift action_29
action_64 (78) = happyShift action_33
action_64 (79) = happyShift action_45
action_64 (81) = happyShift action_35
action_64 (82) = happyShift action_36
action_64 (86) = happyShift action_2
action_64 (87) = happyShift action_38
action_64 (88) = happyShift action_39
action_64 (4) = happyGoto action_42
action_64 (5) = happyGoto action_4
action_64 (6) = happyGoto action_5
action_64 (16) = happyGoto action_43
action_64 (27) = happyGoto action_89
action_64 (28) = happyGoto action_15
action_64 (29) = happyGoto action_16
action_64 (30) = happyGoto action_17
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_57

action_66 _ = happyReduce_58

action_67 (39) = happyShift action_18
action_67 (44) = happyShift action_19
action_67 (55) = happyShift action_20
action_67 (60) = happyShift action_21
action_67 (62) = happyShift action_22
action_67 (68) = happyShift action_26
action_67 (69) = happyShift action_27
action_67 (71) = happyShift action_28
action_67 (72) = happyShift action_29
action_67 (78) = happyShift action_33
action_67 (79) = happyShift action_45
action_67 (81) = happyShift action_35
action_67 (82) = happyShift action_36
action_67 (86) = happyShift action_2
action_67 (87) = happyShift action_38
action_67 (88) = happyShift action_39
action_67 (4) = happyGoto action_42
action_67 (5) = happyGoto action_4
action_67 (6) = happyGoto action_5
action_67 (16) = happyGoto action_43
action_67 (26) = happyGoto action_88
action_67 (27) = happyGoto action_14
action_67 (28) = happyGoto action_15
action_67 (29) = happyGoto action_16
action_67 (30) = happyGoto action_17
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_67

action_69 _ = happyReduce_62

action_70 _ = happyReduce_63

action_71 _ = happyReduce_66

action_72 _ = happyReduce_64

action_73 _ = happyReduce_65

action_74 (39) = happyShift action_18
action_74 (44) = happyShift action_19
action_74 (55) = happyShift action_20
action_74 (60) = happyShift action_21
action_74 (62) = happyShift action_22
action_74 (68) = happyShift action_26
action_74 (69) = happyShift action_27
action_74 (71) = happyShift action_28
action_74 (72) = happyShift action_29
action_74 (78) = happyShift action_33
action_74 (79) = happyShift action_45
action_74 (81) = happyShift action_35
action_74 (82) = happyShift action_36
action_74 (86) = happyShift action_2
action_74 (87) = happyShift action_38
action_74 (88) = happyShift action_39
action_74 (4) = happyGoto action_42
action_74 (5) = happyGoto action_4
action_74 (6) = happyGoto action_5
action_74 (16) = happyGoto action_43
action_74 (24) = happyGoto action_87
action_74 (25) = happyGoto action_12
action_74 (26) = happyGoto action_13
action_74 (27) = happyGoto action_14
action_74 (28) = happyGoto action_15
action_74 (29) = happyGoto action_16
action_74 (30) = happyGoto action_17
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (39) = happyShift action_18
action_75 (44) = happyShift action_19
action_75 (55) = happyShift action_20
action_75 (60) = happyShift action_21
action_75 (62) = happyShift action_22
action_75 (68) = happyShift action_26
action_75 (69) = happyShift action_27
action_75 (71) = happyShift action_28
action_75 (72) = happyShift action_29
action_75 (78) = happyShift action_33
action_75 (79) = happyShift action_45
action_75 (81) = happyShift action_35
action_75 (82) = happyShift action_36
action_75 (86) = happyShift action_2
action_75 (87) = happyShift action_38
action_75 (88) = happyShift action_39
action_75 (4) = happyGoto action_42
action_75 (5) = happyGoto action_4
action_75 (6) = happyGoto action_5
action_75 (16) = happyGoto action_43
action_75 (23) = happyGoto action_86
action_75 (24) = happyGoto action_11
action_75 (25) = happyGoto action_12
action_75 (26) = happyGoto action_13
action_75 (27) = happyGoto action_14
action_75 (28) = happyGoto action_15
action_75 (29) = happyGoto action_16
action_75 (30) = happyGoto action_17
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (51) = happyShift action_85
action_76 _ = happyReduce_27

action_77 _ = happyReduce_12

action_78 _ = happyReduce_89

action_79 (39) = happyShift action_18
action_79 (44) = happyShift action_19
action_79 (55) = happyShift action_20
action_79 (60) = happyShift action_21
action_79 (62) = happyShift action_22
action_79 (63) = happyShift action_23
action_79 (65) = happyShift action_24
action_79 (66) = happyShift action_25
action_79 (68) = happyShift action_26
action_79 (69) = happyShift action_27
action_79 (71) = happyShift action_28
action_79 (72) = happyShift action_29
action_79 (74) = happyShift action_30
action_79 (75) = happyShift action_31
action_79 (77) = happyShift action_32
action_79 (78) = happyShift action_33
action_79 (79) = happyShift action_34
action_79 (81) = happyShift action_35
action_79 (82) = happyShift action_36
action_79 (83) = happyShift action_37
action_79 (85) = happyReduce_9
action_79 (86) = happyShift action_2
action_79 (87) = happyShift action_38
action_79 (88) = happyShift action_39
action_79 (89) = happyReduce_9
action_79 (4) = happyGoto action_3
action_79 (5) = happyGoto action_4
action_79 (6) = happyGoto action_5
action_79 (9) = happyGoto action_84
action_79 (10) = happyGoto action_8
action_79 (16) = happyGoto action_9
action_79 (23) = happyGoto action_10
action_79 (24) = happyGoto action_11
action_79 (25) = happyGoto action_12
action_79 (26) = happyGoto action_13
action_79 (27) = happyGoto action_14
action_79 (28) = happyGoto action_15
action_79 (29) = happyGoto action_16
action_79 (30) = happyGoto action_17
action_79 _ = happyReduce_9

action_80 (76) = happyShift action_83
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (39) = happyShift action_18
action_81 (44) = happyShift action_19
action_81 (55) = happyShift action_20
action_81 (60) = happyShift action_21
action_81 (62) = happyShift action_22
action_81 (68) = happyShift action_26
action_81 (69) = happyShift action_27
action_81 (71) = happyShift action_28
action_81 (72) = happyShift action_29
action_81 (78) = happyShift action_33
action_81 (79) = happyShift action_45
action_81 (81) = happyShift action_35
action_81 (82) = happyShift action_36
action_81 (86) = happyShift action_2
action_81 (87) = happyShift action_38
action_81 (88) = happyShift action_39
action_81 (4) = happyGoto action_42
action_81 (5) = happyGoto action_4
action_81 (6) = happyGoto action_5
action_81 (16) = happyGoto action_43
action_81 (23) = happyGoto action_82
action_81 (24) = happyGoto action_11
action_81 (25) = happyGoto action_12
action_81 (26) = happyGoto action_13
action_81 (27) = happyGoto action_14
action_81 (28) = happyGoto action_15
action_81 (29) = happyGoto action_16
action_81 (30) = happyGoto action_17
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_23

action_83 (39) = happyShift action_137
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (85) = happyReduce_11
action_84 (89) = happyReduce_11
action_84 _ = happyReduce_11

action_85 (39) = happyShift action_18
action_85 (44) = happyShift action_19
action_85 (55) = happyShift action_20
action_85 (60) = happyShift action_21
action_85 (62) = happyShift action_22
action_85 (68) = happyShift action_26
action_85 (69) = happyShift action_27
action_85 (71) = happyShift action_28
action_85 (72) = happyShift action_29
action_85 (78) = happyShift action_33
action_85 (79) = happyShift action_45
action_85 (81) = happyShift action_35
action_85 (82) = happyShift action_36
action_85 (86) = happyShift action_2
action_85 (87) = happyShift action_38
action_85 (88) = happyShift action_39
action_85 (4) = happyGoto action_42
action_85 (5) = happyGoto action_4
action_85 (6) = happyGoto action_5
action_85 (16) = happyGoto action_43
action_85 (23) = happyGoto action_136
action_85 (24) = happyGoto action_11
action_85 (25) = happyGoto action_12
action_85 (26) = happyGoto action_13
action_85 (27) = happyGoto action_14
action_85 (28) = happyGoto action_15
action_85 (29) = happyGoto action_16
action_85 (30) = happyGoto action_17
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_68

action_87 _ = happyReduce_70

action_88 (42) = happyShift action_65
action_88 (44) = happyShift action_66
action_88 (20) = happyGoto action_64
action_88 _ = happyReduce_72

action_89 (37) = happyShift action_61
action_89 (41) = happyShift action_62
action_89 (47) = happyShift action_63
action_89 (21) = happyGoto action_60
action_89 _ = happyReduce_74

action_90 _ = happyReduce_76

action_91 (39) = happyShift action_135
action_91 _ = happyFail (happyExpListPerState 91)

action_92 _ = happyReduce_81

action_93 _ = happyReduce_96

action_94 (43) = happyShift action_134
action_94 _ = happyReduce_99

action_95 (40) = happyShift action_133
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (86) = happyShift action_2
action_96 (4) = happyGoto action_132
action_96 _ = happyFail (happyExpListPerState 96)

action_97 _ = happyReduce_92

action_98 (39) = happyShift action_131
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (86) = happyShift action_2
action_99 (4) = happyGoto action_54
action_99 (31) = happyGoto action_130
action_99 _ = happyReduce_93

action_100 (64) = happyShift action_128
action_100 (67) = happyShift action_129
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (38) = happyShift action_127
action_101 (60) = happyShift action_21
action_101 (68) = happyShift action_26
action_101 (69) = happyShift action_27
action_101 (71) = happyShift action_28
action_101 (78) = happyShift action_33
action_101 (79) = happyShift action_45
action_101 (82) = happyShift action_36
action_101 (14) = happyGoto action_124
action_101 (15) = happyGoto action_125
action_101 (16) = happyGoto action_126
action_101 _ = happyReduce_39

action_102 (40) = happyShift action_123
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (38) = happyShift action_122
action_103 (60) = happyShift action_21
action_103 (68) = happyShift action_26
action_103 (69) = happyShift action_27
action_103 (71) = happyShift action_28
action_103 (78) = happyShift action_33
action_103 (79) = happyShift action_45
action_103 (82) = happyShift action_36
action_103 (16) = happyGoto action_119
action_103 (18) = happyGoto action_120
action_103 (19) = happyGoto action_121
action_103 _ = happyReduce_54

action_104 (53) = happyShift action_118
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (40) = happyShift action_117
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (40) = happyReduce_35
action_106 (43) = happyShift action_116
action_106 _ = happyReduce_35

action_107 (40) = happyShift action_115
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_47

action_109 (60) = happyShift action_21
action_109 (68) = happyShift action_26
action_109 (69) = happyShift action_27
action_109 (71) = happyShift action_28
action_109 (78) = happyShift action_33
action_109 (79) = happyShift action_45
action_109 (82) = happyShift action_36
action_109 (16) = happyGoto action_112
action_109 (34) = happyGoto action_113
action_109 (35) = happyGoto action_114
action_109 _ = happyReduce_102

action_110 (40) = happyShift action_111
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (84) = happyShift action_149
action_111 (8) = happyGoto action_157
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (86) = happyShift action_2
action_112 (4) = happyGoto action_156
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (48) = happyShift action_155
action_113 _ = happyReduce_103

action_114 (85) = happyShift action_154
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_20

action_116 (39) = happyShift action_18
action_116 (40) = happyReduce_34
action_116 (44) = happyShift action_19
action_116 (55) = happyShift action_20
action_116 (60) = happyShift action_21
action_116 (62) = happyShift action_22
action_116 (68) = happyShift action_26
action_116 (69) = happyShift action_27
action_116 (71) = happyShift action_28
action_116 (72) = happyShift action_29
action_116 (78) = happyShift action_33
action_116 (79) = happyShift action_45
action_116 (81) = happyShift action_35
action_116 (82) = happyShift action_36
action_116 (86) = happyShift action_2
action_116 (87) = happyShift action_38
action_116 (88) = happyShift action_39
action_116 (4) = happyGoto action_42
action_116 (5) = happyGoto action_4
action_116 (6) = happyGoto action_5
action_116 (13) = happyGoto action_153
action_116 (16) = happyGoto action_43
action_116 (23) = happyGoto action_106
action_116 (24) = happyGoto action_11
action_116 (25) = happyGoto action_12
action_116 (26) = happyGoto action_13
action_116 (27) = happyGoto action_14
action_116 (28) = happyGoto action_15
action_116 (29) = happyGoto action_16
action_116 (30) = happyGoto action_17
action_116 _ = happyReduce_34

action_117 _ = happyReduce_19

action_118 _ = happyReduce_46

action_119 _ = happyReduce_52

action_120 (43) = happyShift action_152
action_120 _ = happyReduce_55

action_121 (40) = happyShift action_151
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (60) = happyShift action_21
action_122 (68) = happyShift action_26
action_122 (69) = happyShift action_27
action_122 (71) = happyShift action_28
action_122 (78) = happyShift action_33
action_122 (79) = happyShift action_45
action_122 (82) = happyShift action_36
action_122 (16) = happyGoto action_150
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (84) = happyShift action_149
action_123 (8) = happyGoto action_148
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (43) = happyShift action_147
action_124 _ = happyReduce_40

action_125 (40) = happyShift action_146
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (86) = happyShift action_2
action_126 (4) = happyGoto action_145
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (60) = happyShift action_21
action_127 (68) = happyShift action_26
action_127 (69) = happyShift action_27
action_127 (71) = happyShift action_28
action_127 (78) = happyShift action_33
action_127 (79) = happyShift action_45
action_127 (82) = happyShift action_36
action_127 (16) = happyGoto action_144
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (39) = happyShift action_18
action_128 (44) = happyShift action_19
action_128 (55) = happyShift action_20
action_128 (60) = happyShift action_21
action_128 (62) = happyShift action_22
action_128 (68) = happyShift action_26
action_128 (69) = happyShift action_27
action_128 (71) = happyShift action_28
action_128 (72) = happyShift action_29
action_128 (78) = happyShift action_33
action_128 (79) = happyShift action_45
action_128 (81) = happyShift action_35
action_128 (82) = happyShift action_36
action_128 (86) = happyShift action_2
action_128 (87) = happyShift action_38
action_128 (88) = happyShift action_39
action_128 (4) = happyGoto action_42
action_128 (5) = happyGoto action_4
action_128 (6) = happyGoto action_5
action_128 (16) = happyGoto action_43
action_128 (23) = happyGoto action_143
action_128 (24) = happyGoto action_11
action_128 (25) = happyGoto action_12
action_128 (26) = happyGoto action_13
action_128 (27) = happyGoto action_14
action_128 (28) = happyGoto action_15
action_128 (29) = happyGoto action_16
action_128 (30) = happyGoto action_17
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (39) = happyShift action_18
action_129 (44) = happyShift action_19
action_129 (55) = happyShift action_20
action_129 (60) = happyShift action_21
action_129 (62) = happyShift action_22
action_129 (68) = happyShift action_26
action_129 (69) = happyShift action_27
action_129 (71) = happyShift action_28
action_129 (72) = happyShift action_29
action_129 (78) = happyShift action_33
action_129 (79) = happyShift action_45
action_129 (81) = happyShift action_35
action_129 (82) = happyShift action_36
action_129 (86) = happyShift action_2
action_129 (87) = happyShift action_38
action_129 (88) = happyShift action_39
action_129 (4) = happyGoto action_42
action_129 (5) = happyGoto action_4
action_129 (6) = happyGoto action_5
action_129 (16) = happyGoto action_43
action_129 (23) = happyGoto action_142
action_129 (24) = happyGoto action_11
action_129 (25) = happyGoto action_12
action_129 (26) = happyGoto action_13
action_129 (27) = happyGoto action_14
action_129 (28) = happyGoto action_15
action_129 (29) = happyGoto action_16
action_129 (30) = happyGoto action_17
action_129 _ = happyFail (happyExpListPerState 129)

action_130 _ = happyReduce_95

action_131 (38) = happyShift action_122
action_131 (60) = happyShift action_21
action_131 (68) = happyShift action_26
action_131 (69) = happyShift action_27
action_131 (71) = happyShift action_28
action_131 (78) = happyShift action_33
action_131 (79) = happyShift action_45
action_131 (82) = happyShift action_36
action_131 (16) = happyGoto action_119
action_131 (18) = happyGoto action_120
action_131 (19) = happyGoto action_141
action_131 _ = happyReduce_54

action_132 _ = happyReduce_97

action_133 _ = happyReduce_83

action_134 (38) = happyShift action_96
action_134 (39) = happyShift action_18
action_134 (44) = happyShift action_19
action_134 (55) = happyShift action_20
action_134 (60) = happyShift action_21
action_134 (62) = happyShift action_22
action_134 (68) = happyShift action_26
action_134 (69) = happyShift action_27
action_134 (71) = happyShift action_28
action_134 (72) = happyShift action_29
action_134 (78) = happyShift action_33
action_134 (79) = happyShift action_45
action_134 (81) = happyShift action_35
action_134 (82) = happyShift action_36
action_134 (86) = happyShift action_2
action_134 (87) = happyShift action_38
action_134 (88) = happyShift action_39
action_134 (4) = happyGoto action_42
action_134 (5) = happyGoto action_4
action_134 (6) = happyGoto action_5
action_134 (16) = happyGoto action_43
action_134 (23) = happyGoto action_93
action_134 (24) = happyGoto action_11
action_134 (25) = happyGoto action_12
action_134 (26) = happyGoto action_13
action_134 (27) = happyGoto action_14
action_134 (28) = happyGoto action_15
action_134 (29) = happyGoto action_16
action_134 (30) = happyGoto action_17
action_134 (32) = happyGoto action_94
action_134 (33) = happyGoto action_140
action_134 _ = happyReduce_98

action_135 (39) = happyShift action_18
action_135 (55) = happyShift action_20
action_135 (60) = happyShift action_21
action_135 (62) = happyShift action_22
action_135 (68) = happyShift action_26
action_135 (69) = happyShift action_27
action_135 (71) = happyShift action_28
action_135 (78) = happyShift action_33
action_135 (79) = happyShift action_45
action_135 (81) = happyShift action_35
action_135 (82) = happyShift action_36
action_135 (86) = happyShift action_2
action_135 (87) = happyShift action_38
action_135 (88) = happyShift action_39
action_135 (4) = happyGoto action_42
action_135 (5) = happyGoto action_4
action_135 (6) = happyGoto action_5
action_135 (16) = happyGoto action_43
action_135 (29) = happyGoto action_139
action_135 (30) = happyGoto action_17
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_28

action_137 (39) = happyShift action_18
action_137 (44) = happyShift action_19
action_137 (55) = happyShift action_20
action_137 (60) = happyShift action_21
action_137 (62) = happyShift action_22
action_137 (68) = happyShift action_26
action_137 (69) = happyShift action_27
action_137 (71) = happyShift action_28
action_137 (72) = happyShift action_29
action_137 (78) = happyShift action_33
action_137 (79) = happyShift action_45
action_137 (81) = happyShift action_35
action_137 (82) = happyShift action_36
action_137 (86) = happyShift action_2
action_137 (87) = happyShift action_38
action_137 (88) = happyShift action_39
action_137 (4) = happyGoto action_42
action_137 (5) = happyGoto action_4
action_137 (6) = happyGoto action_5
action_137 (16) = happyGoto action_43
action_137 (23) = happyGoto action_138
action_137 (24) = happyGoto action_11
action_137 (25) = happyGoto action_12
action_137 (26) = happyGoto action_13
action_137 (27) = happyGoto action_14
action_137 (28) = happyGoto action_15
action_137 (29) = happyGoto action_16
action_137 (30) = happyGoto action_17
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (40) = happyShift action_170
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (39) = happyShift action_58
action_139 (40) = happyShift action_169
action_139 _ = happyFail (happyExpListPerState 139)

action_140 _ = happyReduce_100

action_141 (40) = happyShift action_168
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (40) = happyShift action_167
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (80) = happyShift action_166
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (86) = happyShift action_2
action_144 (4) = happyGoto action_165
action_144 _ = happyFail (happyExpListPerState 144)

action_145 _ = happyReduce_37

action_146 (45) = happyShift action_164
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (38) = happyShift action_127
action_147 (60) = happyShift action_21
action_147 (68) = happyShift action_26
action_147 (69) = happyShift action_27
action_147 (71) = happyShift action_28
action_147 (78) = happyShift action_33
action_147 (79) = happyShift action_45
action_147 (82) = happyShift action_36
action_147 (14) = happyGoto action_124
action_147 (15) = happyGoto action_163
action_147 (16) = happyGoto action_126
action_147 _ = happyReduce_39

action_148 (61) = happyShift action_162
action_148 _ = happyReduce_14

action_149 (39) = happyShift action_18
action_149 (44) = happyShift action_19
action_149 (55) = happyShift action_20
action_149 (60) = happyShift action_21
action_149 (62) = happyShift action_22
action_149 (63) = happyShift action_23
action_149 (65) = happyShift action_24
action_149 (66) = happyShift action_25
action_149 (68) = happyShift action_26
action_149 (69) = happyShift action_27
action_149 (71) = happyShift action_28
action_149 (72) = happyShift action_29
action_149 (74) = happyShift action_30
action_149 (75) = happyShift action_31
action_149 (77) = happyShift action_32
action_149 (78) = happyShift action_33
action_149 (79) = happyShift action_34
action_149 (81) = happyShift action_35
action_149 (82) = happyShift action_36
action_149 (83) = happyShift action_37
action_149 (85) = happyReduce_9
action_149 (86) = happyShift action_2
action_149 (87) = happyShift action_38
action_149 (88) = happyShift action_39
action_149 (4) = happyGoto action_3
action_149 (5) = happyGoto action_4
action_149 (6) = happyGoto action_5
action_149 (9) = happyGoto action_161
action_149 (10) = happyGoto action_8
action_149 (16) = happyGoto action_9
action_149 (23) = happyGoto action_10
action_149 (24) = happyGoto action_11
action_149 (25) = happyGoto action_12
action_149 (26) = happyGoto action_13
action_149 (27) = happyGoto action_14
action_149 (28) = happyGoto action_15
action_149 (29) = happyGoto action_16
action_149 (30) = happyGoto action_17
action_149 _ = happyReduce_9

action_150 _ = happyReduce_53

action_151 (45) = happyShift action_160
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (38) = happyShift action_122
action_152 (60) = happyShift action_21
action_152 (68) = happyShift action_26
action_152 (69) = happyShift action_27
action_152 (71) = happyShift action_28
action_152 (78) = happyShift action_33
action_152 (79) = happyShift action_45
action_152 (82) = happyShift action_36
action_152 (16) = happyGoto action_119
action_152 (18) = happyGoto action_120
action_152 (19) = happyGoto action_159
action_152 _ = happyReduce_54

action_153 (40) = happyReduce_36
action_153 _ = happyReduce_36

action_154 _ = happyReduce_26

action_155 (60) = happyShift action_21
action_155 (68) = happyShift action_26
action_155 (69) = happyShift action_27
action_155 (71) = happyShift action_28
action_155 (78) = happyShift action_33
action_155 (79) = happyShift action_45
action_155 (82) = happyShift action_36
action_155 (16) = happyGoto action_112
action_155 (34) = happyGoto action_113
action_155 (35) = happyGoto action_158
action_155 _ = happyReduce_102

action_156 _ = happyReduce_101

action_157 _ = happyReduce_16

action_158 _ = happyReduce_104

action_159 _ = happyReduce_56

action_160 (60) = happyShift action_21
action_160 (68) = happyShift action_26
action_160 (69) = happyShift action_27
action_160 (71) = happyShift action_28
action_160 (78) = happyShift action_33
action_160 (79) = happyShift action_45
action_160 (82) = happyShift action_36
action_160 (16) = happyGoto action_177
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (85) = happyShift action_176
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (84) = happyShift action_149
action_162 (8) = happyGoto action_175
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_41

action_164 (60) = happyShift action_21
action_164 (68) = happyShift action_26
action_164 (69) = happyShift action_27
action_164 (71) = happyShift action_28
action_164 (78) = happyShift action_33
action_164 (79) = happyShift action_45
action_164 (82) = happyShift action_36
action_164 (16) = happyGoto action_174
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_38

action_166 (39) = happyShift action_18
action_166 (44) = happyShift action_19
action_166 (55) = happyShift action_20
action_166 (60) = happyShift action_21
action_166 (62) = happyShift action_22
action_166 (68) = happyShift action_26
action_166 (69) = happyShift action_27
action_166 (71) = happyShift action_28
action_166 (72) = happyShift action_29
action_166 (78) = happyShift action_33
action_166 (79) = happyShift action_45
action_166 (81) = happyShift action_35
action_166 (82) = happyShift action_36
action_166 (86) = happyShift action_2
action_166 (87) = happyShift action_38
action_166 (88) = happyShift action_39
action_166 (4) = happyGoto action_42
action_166 (5) = happyGoto action_4
action_166 (6) = happyGoto action_5
action_166 (16) = happyGoto action_43
action_166 (23) = happyGoto action_173
action_166 (24) = happyGoto action_11
action_166 (25) = happyGoto action_12
action_166 (26) = happyGoto action_13
action_166 (27) = happyGoto action_14
action_166 (28) = happyGoto action_15
action_166 (29) = happyGoto action_16
action_166 (30) = happyGoto action_17
action_166 _ = happyFail (happyExpListPerState 166)

action_167 (84) = happyShift action_149
action_167 (8) = happyGoto action_172
action_167 _ = happyFail (happyExpListPerState 167)

action_168 (45) = happyShift action_171
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_82

action_170 _ = happyReduce_25

action_171 (60) = happyShift action_21
action_171 (68) = happyShift action_26
action_171 (69) = happyShift action_27
action_171 (71) = happyShift action_28
action_171 (78) = happyShift action_33
action_171 (79) = happyShift action_45
action_171 (82) = happyShift action_36
action_171 (16) = happyGoto action_181
action_171 _ = happyFail (happyExpListPerState 171)

action_172 _ = happyReduce_18

action_173 (40) = happyShift action_180
action_173 _ = happyFail (happyExpListPerState 173)

action_174 (84) = happyShift action_149
action_174 (8) = happyGoto action_179
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_15

action_176 _ = happyReduce_5

action_177 (53) = happyShift action_178
action_177 _ = happyFail (happyExpListPerState 177)

action_178 _ = happyReduce_48

action_179 _ = happyReduce_24

action_180 (84) = happyShift action_149
action_180 (8) = happyGoto action_183
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (84) = happyShift action_149
action_181 (8) = happyGoto action_182
action_181 _ = happyFail (happyExpListPerState 181)

action_182 _ = happyReduce_91

action_183 _ = happyReduce_17

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TV happy_var_1)))
	 =  HappyAbsSyn4
		 (Grammar.Abs.Ident happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn5
		 ((read happy_var_1) :: Integer
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TL happy_var_1)))
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn7
		 (Grammar.Abs.Program happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  8 happyReduction_5
happyReduction_5 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Grammar.Abs.Block happy_var_2
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_0  9 happyReduction_6
happyReduction_6  =  HappyAbsSyn9
		 ([]
	)

happyReduce_7 = happySpecReduce_1  9 happyReduction_7
happyReduction_7 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ((:[]) happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  9 happyReduction_8
happyReduction_8 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_0  9 happyReduction_9
happyReduction_9  =  HappyAbsSyn9
		 ([]
	)

happyReduce_10 = happySpecReduce_1  9 happyReduction_10
happyReduction_10 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ((:[]) happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  9 happyReduction_11
happyReduction_11 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2  10 happyReduction_12
happyReduction_12 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn10
		 (Grammar.Abs.Decl happy_var_1 happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  10 happyReduction_13
happyReduction_13 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn10
		 (Grammar.Abs.SExpr happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happyReduce 5 10 happyReduction_14
happyReduction_14 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.If happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 7 10 happyReduction_15
happyReduction_15 ((HappyAbsSyn8  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.IfElse happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 5 10 happyReduction_16
happyReduction_16 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 9 10 happyReduction_17
happyReduction_17 ((HappyAbsSyn8  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.For happy_var_3 happy_var_5 happy_var_7 happy_var_9
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 7 10 happyReduction_18
happyReduction_18 ((HappyAbsSyn8  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.ForInList happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 4 10 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.Print happy_var_3
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 4 10 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.PrintEndl happy_var_3
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_2  10 happyReduction_21
happyReduction_21 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Grammar.Abs.Return happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  10 happyReduction_22
happyReduction_22 _
	 =  HappyAbsSyn10
		 (Grammar.Abs.ReturnVoid
	)

happyReduce_23 = happySpecReduce_3  10 happyReduction_23
happyReduction_23 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn10
		 (Grammar.Abs.Assign happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happyReduce 8 10 happyReduction_24
happyReduction_24 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	(HappyAbsSyn16  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.FunDef happy_var_2 happy_var_4 happy_var_7 happy_var_8
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 6 10 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.SListPush happy_var_1 happy_var_5
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 5 10 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.StructDef happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_1  11 happyReduction_27
happyReduction_27 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn11
		 (Grammar.Abs.NoInit happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  11 happyReduction_28
happyReduction_28 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn11
		 (Grammar.Abs.Init happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  12 happyReduction_29
happyReduction_29 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ((:[]) happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  12 happyReduction_30
happyReduction_30 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_0  13 happyReduction_31
happyReduction_31  =  HappyAbsSyn13
		 ([]
	)

happyReduce_32 = happySpecReduce_1  13 happyReduction_32
happyReduction_32 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:[]) happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  13 happyReduction_33
happyReduction_33 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_0  13 happyReduction_34
happyReduction_34  =  HappyAbsSyn13
		 ([]
	)

happyReduce_35 = happySpecReduce_1  13 happyReduction_35
happyReduction_35 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:[]) happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  13 happyReduction_36
happyReduction_36 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_2  14 happyReduction_37
happyReduction_37 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn14
		 (Grammar.Abs.Arg happy_var_1 happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  14 happyReduction_38
happyReduction_38 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Grammar.Abs.ArgRef happy_var_2 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  15 happyReduction_39
happyReduction_39  =  HappyAbsSyn15
		 ([]
	)

happyReduce_40 = happySpecReduce_1  15 happyReduction_40
happyReduction_40 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 ((:[]) happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  15 happyReduction_41
happyReduction_41 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  16 happyReduction_42
happyReduction_42 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TInt
	)

happyReduce_43 = happySpecReduce_1  16 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TBool
	)

happyReduce_44 = happySpecReduce_1  16 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TString
	)

happyReduce_45 = happySpecReduce_1  16 happyReduction_45
happyReduction_45 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TVoid
	)

happyReduce_46 = happyReduce 4 16 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Grammar.Abs.TList happy_var_3
	) `HappyStk` happyRest

happyReduce_47 = happySpecReduce_2  16 happyReduction_47
happyReduction_47 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Grammar.Abs.TStruct happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happyReduce 8 16 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Grammar.Abs.TLambda happy_var_4 happy_var_7
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_0  17 happyReduction_49
happyReduction_49  =  HappyAbsSyn17
		 ([]
	)

happyReduce_50 = happySpecReduce_1  17 happyReduction_50
happyReduction_50 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 ((:[]) happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  17 happyReduction_51
happyReduction_51 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  18 happyReduction_52
happyReduction_52 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn18
		 (Grammar.Abs.TRType happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  18 happyReduction_53
happyReduction_53 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (Grammar.Abs.TRRef happy_var_2
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_0  19 happyReduction_54
happyReduction_54  =  HappyAbsSyn19
		 ([]
	)

happyReduce_55 = happySpecReduce_1  19 happyReduction_55
happyReduction_55 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 ((:[]) happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  19 happyReduction_56
happyReduction_56 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  20 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn20
		 (Grammar.Abs.Plus
	)

happyReduce_58 = happySpecReduce_1  20 happyReduction_58
happyReduction_58 _
	 =  HappyAbsSyn20
		 (Grammar.Abs.Minus
	)

happyReduce_59 = happySpecReduce_1  21 happyReduction_59
happyReduction_59 _
	 =  HappyAbsSyn21
		 (Grammar.Abs.Mul
	)

happyReduce_60 = happySpecReduce_1  21 happyReduction_60
happyReduction_60 _
	 =  HappyAbsSyn21
		 (Grammar.Abs.Div
	)

happyReduce_61 = happySpecReduce_1  21 happyReduction_61
happyReduction_61 _
	 =  HappyAbsSyn21
		 (Grammar.Abs.Mod
	)

happyReduce_62 = happySpecReduce_1  22 happyReduction_62
happyReduction_62 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.LTH
	)

happyReduce_63 = happySpecReduce_1  22 happyReduction_63
happyReduction_63 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.LE
	)

happyReduce_64 = happySpecReduce_1  22 happyReduction_64
happyReduction_64 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.GTH
	)

happyReduce_65 = happySpecReduce_1  22 happyReduction_65
happyReduction_65 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.GE
	)

happyReduce_66 = happySpecReduce_1  22 happyReduction_66
happyReduction_66 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.EQ
	)

happyReduce_67 = happySpecReduce_1  22 happyReduction_67
happyReduction_67 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.NEQ
	)

happyReduce_68 = happySpecReduce_3  23 happyReduction_68
happyReduction_68 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EOr happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  23 happyReduction_69
happyReduction_69 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  24 happyReduction_70
happyReduction_70 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EAnd happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  24 happyReduction_71
happyReduction_71 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  25 happyReduction_72
happyReduction_72 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.ERel happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  25 happyReduction_73
happyReduction_73 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  26 happyReduction_74
happyReduction_74 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EAdd happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  26 happyReduction_75
happyReduction_75 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  27 happyReduction_76
happyReduction_76 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EMul happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  27 happyReduction_77
happyReduction_77 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_2  28 happyReduction_78
happyReduction_78 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (Grammar.Abs.ENeg happy_var_2
	)
happyReduction_78 _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_2  28 happyReduction_79
happyReduction_79 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (Grammar.Abs.ENot happy_var_2
	)
happyReduction_79 _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  28 happyReduction_80
happyReduction_80 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_3  28 happyReduction_81
happyReduction_81 _
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EListLen happy_var_1
	)
happyReduction_81 _ _ _  = notHappyAtAll 

happyReduce_82 = happyReduce 6 28 happyReduction_82
happyReduction_82 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Grammar.Abs.EListAt happy_var_1 happy_var_5
	) `HappyStk` happyRest

happyReduce_83 = happyReduce 4 29 happyReduction_83
happyReduction_83 (_ `HappyStk`
	(HappyAbsSyn33  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Grammar.Abs.EApp happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_84 = happySpecReduce_1  29 happyReduction_84
happyReduction_84 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  30 happyReduction_85
happyReduction_85 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EInt happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  30 happyReduction_86
happyReduction_86 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EVar happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  30 happyReduction_87
happyReduction_87 _
	 =  HappyAbsSyn23
		 (Grammar.Abs.ETrue
	)

happyReduce_88 = happySpecReduce_1  30 happyReduction_88
happyReduction_88 _
	 =  HappyAbsSyn23
		 (Grammar.Abs.EFalse
	)

happyReduce_89 = happySpecReduce_2  30 happyReduction_89
happyReduction_89 _
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EEmptyList happy_var_1
	)
happyReduction_89 _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_1  30 happyReduction_90
happyReduction_90 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EString happy_var_1
	)
happyReduction_90 _  = notHappyAtAll 

happyReduce_91 = happyReduce 9 30 happyReduction_91
happyReduction_91 ((HappyAbsSyn8  happy_var_9) `HappyStk`
	(HappyAbsSyn16  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn31  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Grammar.Abs.ELambda happy_var_2 happy_var_5 happy_var_8 happy_var_9
	) `HappyStk` happyRest

happyReduce_92 = happySpecReduce_3  30 happyReduction_92
happyReduction_92 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (happy_var_2
	)
happyReduction_92 _ _ _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_0  31 happyReduction_93
happyReduction_93  =  HappyAbsSyn31
		 ([]
	)

happyReduce_94 = happySpecReduce_1  31 happyReduction_94
happyReduction_94 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn31
		 ((:[]) happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_3  31 happyReduction_95
happyReduction_95 (HappyAbsSyn31  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn31
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_95 _ _ _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  32 happyReduction_96
happyReduction_96 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn32
		 (Grammar.Abs.EorRExpr happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_2  32 happyReduction_97
happyReduction_97 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn32
		 (Grammar.Abs.EorRRef happy_var_2
	)
happyReduction_97 _ _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_0  33 happyReduction_98
happyReduction_98  =  HappyAbsSyn33
		 ([]
	)

happyReduce_99 = happySpecReduce_1  33 happyReduction_99
happyReduction_99 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn33
		 ((:[]) happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_3  33 happyReduction_100
happyReduction_100 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn33
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_100 _ _ _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_2  34 happyReduction_101
happyReduction_101 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn34
		 (Grammar.Abs.StructItem happy_var_1 happy_var_2
	)
happyReduction_101 _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_0  35 happyReduction_102
happyReduction_102  =  HappyAbsSyn35
		 ([]
	)

happyReduce_103 = happySpecReduce_1  35 happyReduction_103
happyReduction_103 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn35
		 ((:[]) happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_3  35 happyReduction_104
happyReduction_104 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn35
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_104 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 89 89 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 36;
	PT _ (TS _ 2) -> cont 37;
	PT _ (TS _ 3) -> cont 38;
	PT _ (TS _ 4) -> cont 39;
	PT _ (TS _ 5) -> cont 40;
	PT _ (TS _ 6) -> cont 41;
	PT _ (TS _ 7) -> cont 42;
	PT _ (TS _ 8) -> cont 43;
	PT _ (TS _ 9) -> cont 44;
	PT _ (TS _ 10) -> cont 45;
	PT _ (TS _ 11) -> cont 46;
	PT _ (TS _ 12) -> cont 47;
	PT _ (TS _ 13) -> cont 48;
	PT _ (TS _ 14) -> cont 49;
	PT _ (TS _ 15) -> cont 50;
	PT _ (TS _ 16) -> cont 51;
	PT _ (TS _ 17) -> cont 52;
	PT _ (TS _ 18) -> cont 53;
	PT _ (TS _ 19) -> cont 54;
	PT _ (TS _ 20) -> cont 55;
	PT _ (TS _ 21) -> cont 56;
	PT _ (TS _ 22) -> cont 57;
	PT _ (TS _ 23) -> cont 58;
	PT _ (TS _ 24) -> cont 59;
	PT _ (TS _ 25) -> cont 60;
	PT _ (TS _ 26) -> cont 61;
	PT _ (TS _ 27) -> cont 62;
	PT _ (TS _ 28) -> cont 63;
	PT _ (TS _ 29) -> cont 64;
	PT _ (TS _ 30) -> cont 65;
	PT _ (TS _ 31) -> cont 66;
	PT _ (TS _ 32) -> cont 67;
	PT _ (TS _ 33) -> cont 68;
	PT _ (TS _ 34) -> cont 69;
	PT _ (TS _ 35) -> cont 70;
	PT _ (TS _ 36) -> cont 71;
	PT _ (TS _ 37) -> cont 72;
	PT _ (TS _ 38) -> cont 73;
	PT _ (TS _ 39) -> cont 74;
	PT _ (TS _ 40) -> cont 75;
	PT _ (TS _ 41) -> cont 76;
	PT _ (TS _ 42) -> cont 77;
	PT _ (TS _ 43) -> cont 78;
	PT _ (TS _ 44) -> cont 79;
	PT _ (TS _ 45) -> cont 80;
	PT _ (TS _ 46) -> cont 81;
	PT _ (TS _ 47) -> cont 82;
	PT _ (TS _ 48) -> cont 83;
	PT _ (TS _ 49) -> cont 84;
	PT _ (TS _ 50) -> cont 85;
	PT _ (TV happy_dollar_dollar) -> cont 86;
	PT _ (TI happy_dollar_dollar) -> cont 87;
	PT _ (TL happy_dollar_dollar) -> cont 88;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 89 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = ((>>=))
happyReturn :: () => a -> Err a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> Err a
happyError' = (\(tokens, _) -> happyError tokens)
pProgram tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


type Err = Either String

happyError :: [Token] -> Err a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer :: String -> [Token]
myLexer = tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
