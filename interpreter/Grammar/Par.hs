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
 action_179 :: () => Prelude.Int -> ({-HappyReduction (Err) = -}
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
 happyReduce_103 :: () => ({-HappyReduction (Err) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,742) ([0,0,2112,26688,47835,115,0,0,0,0,4096,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,32768,0,4096,0,0,0,0,0,0,0,0,0,0,1,0,0,8,571,0,0,0,0,10,0,0,0,0,16656,0,0,0,0,0,0,0,0,0,0,8256,0,0,0,0,0,0,0,0,0,0,2112,10304,45272,113,0,16384,16384,22568,29104,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,16,0,16384,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,1,0,0,0,16384,16384,22568,29104,0,0,64,0,0,0,0,16384,16392,55336,29104,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,16392,55336,29104,0,0,0,0,0,4,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,16,0,16384,16392,55336,29104,0,0,64,0,0,0,0,0,0,22536,304,0,0,64,0,0,0,0,16384,16392,55336,29104,0,0,64,0,0,0,0,0,0,0,4096,0,0,1024,0,0,0,0,0,0,1,0,0,0,64,0,0,0,0,32768,0,0,0,0,0,2144,10304,45272,113,0,0,0,8196,0,0,0,2112,10304,45272,113,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2112,10304,45272,113,0,0,0,0,0,0,0,0,0,0,0,0,16384,16392,55336,29104,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2112,10304,45272,113,0,16384,16392,55336,29104,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,16392,56168,29626,0,0,0,0,1024,0,0,16384,16392,55336,29104,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,16384,16392,55336,29104,0,0,0,0,0,0,0,0,0,0,0,0,0,2560,0,0,0,0,4096,65,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,32768,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,4096,0,0,0,32768,4,0,0,8192,0,22536,304,0,0,128,0,0,0,0,8192,0,22536,304,0,0,0,16,0,0,0,32768,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,2048,12376,1,0,32768,0,0,0,0,0,0,0,0,4,0,0,0,0,4096,0,0,32768,0,0,0,0,0,0,0,2048,0,0,2112,10304,45272,113,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,32768,0,0,0,0,0,0,2048,12376,1,0,0,0,0,1024,0,0,1024,0,0,0,0,32768,0,0,0,0,0,0,0,0,16,0,0,0,22536,304,0,0,2112,10304,45272,113,0,16384,16392,55336,29104,0,0,0,0,0,0,0,8192,0,22536,304,0,0,0,0,0,0,0,0,0,0,0,0,0,2144,10304,45272,113,0,16384,16384,22568,29104,0,0,0,0,0,0,0,16384,16392,55336,29104,0,0,128,0,0,0,0,49152,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,128,0,0,0,0,0,0,0,64,0,0,0,0,0,16,0,0,0,0,0,0,0,4096,0,0,0,0,8192,0,22536,304,0,0,0,4096,0,0,0,16384,16392,56168,29626,0,0,0,0,0,0,0,0,16,0,0,0,0,32,2048,12376,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22536,304,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,12376,1,0,0,0,0,2048,0,0,0,0,0,4,0,0,0,0,0,0,0,0,2048,12376,1,0,0,0,0,0,0,0,2112,10304,45272,113,0,0,0,0,1024,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22536,304,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","Ident","Integer","String","Program","Block","ListStmt","Stmt","Item","ListItem","ListExpr","Arg","ListArg","Type","ListType","TypeOrRef","ListTypeOrRef","AddOp","MulOp","RelOp","Expr","Expr1","Expr2","Expr3","Expr4","Expr5","Expr6","Expr7","ListIdent","ExprOrRef","ListExprOrRef","StructItem","ListStructItem","'!='","'%'","'&'","'('","')'","'*'","'+'","','","'-'","'->'","'.'","'/'","';'","'<'","'<='","'='","'=='","'>'","'>='","'['","'[]'","']'","'and'","'at'","'bool'","'else'","'false'","'for'","'from'","'fun'","'if'","'in'","'int'","'lambda'","'len()'","'list'","'not'","'or'","'print'","'push'","'return'","'string'","'struct'","'to'","'true'","'void'","'while'","'{'","'}'","L_Ident","L_integ","L_quoted","%eof"]
        bit_start = st Prelude.* 88
        bit_end = (st Prelude.+ 1) Prelude.* 88
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..87]
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
action_0 (76) = happyShift action_31
action_0 (77) = happyShift action_32
action_0 (78) = happyShift action_33
action_0 (80) = happyShift action_34
action_0 (81) = happyShift action_35
action_0 (82) = happyShift action_36
action_0 (85) = happyShift action_2
action_0 (86) = happyShift action_37
action_0 (87) = happyShift action_38
action_0 (88) = happyReduce_9
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

action_1 (85) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (46) = happyShift action_78
action_3 (51) = happyShift action_79
action_3 _ = happyReduce_85

action_4 _ = happyReduce_84

action_5 _ = happyReduce_89

action_6 (88) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_4

action_8 (48) = happyShift action_77
action_8 (84) = happyReduce_10
action_8 (88) = happyReduce_10
action_8 _ = happyReduce_10

action_9 (56) = happyShift action_76
action_9 (85) = happyShift action_2
action_9 (4) = happyGoto action_74
action_9 (11) = happyGoto action_75
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_13

action_11 (73) = happyShift action_73
action_11 _ = happyReduce_68

action_12 (36) = happyShift action_66
action_12 (49) = happyShift action_67
action_12 (50) = happyShift action_68
action_12 (52) = happyShift action_69
action_12 (53) = happyShift action_70
action_12 (54) = happyShift action_71
action_12 (58) = happyShift action_72
action_12 (22) = happyGoto action_65
action_12 _ = happyReduce_70

action_13 (42) = happyShift action_63
action_13 (44) = happyShift action_64
action_13 (20) = happyGoto action_62
action_13 _ = happyReduce_72

action_14 (37) = happyShift action_59
action_14 (41) = happyShift action_60
action_14 (47) = happyShift action_61
action_14 (21) = happyGoto action_58
action_14 _ = happyReduce_74

action_15 _ = happyReduce_76

action_16 (39) = happyShift action_56
action_16 (46) = happyShift action_57
action_16 _ = happyReduce_79

action_17 _ = happyReduce_83

action_18 (39) = happyShift action_18
action_18 (44) = happyShift action_19
action_18 (55) = happyShift action_20
action_18 (60) = happyShift action_21
action_18 (62) = happyShift action_22
action_18 (68) = happyShift action_26
action_18 (69) = happyShift action_27
action_18 (71) = happyShift action_28
action_18 (72) = happyShift action_29
action_18 (77) = happyShift action_32
action_18 (78) = happyShift action_44
action_18 (80) = happyShift action_34
action_18 (81) = happyShift action_35
action_18 (85) = happyShift action_2
action_18 (86) = happyShift action_37
action_18 (87) = happyShift action_38
action_18 (4) = happyGoto action_41
action_18 (5) = happyGoto action_4
action_18 (6) = happyGoto action_5
action_18 (16) = happyGoto action_42
action_18 (23) = happyGoto action_55
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
action_19 (77) = happyShift action_32
action_19 (78) = happyShift action_44
action_19 (80) = happyShift action_34
action_19 (81) = happyShift action_35
action_19 (85) = happyShift action_2
action_19 (86) = happyShift action_37
action_19 (87) = happyShift action_38
action_19 (4) = happyGoto action_41
action_19 (5) = happyGoto action_4
action_19 (6) = happyGoto action_5
action_19 (16) = happyGoto action_42
action_19 (29) = happyGoto action_54
action_19 (30) = happyGoto action_17
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (85) = happyShift action_2
action_20 (4) = happyGoto action_52
action_20 (31) = happyGoto action_53
action_20 _ = happyReduce_92

action_21 _ = happyReduce_42

action_22 _ = happyReduce_87

action_23 (39) = happyShift action_51
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (85) = happyShift action_2
action_24 (4) = happyGoto action_50
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (39) = happyShift action_49
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_41

action_27 (49) = happyShift action_48
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (49) = happyShift action_47
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (39) = happyShift action_18
action_29 (55) = happyShift action_20
action_29 (60) = happyShift action_21
action_29 (62) = happyShift action_22
action_29 (68) = happyShift action_26
action_29 (69) = happyShift action_27
action_29 (71) = happyShift action_28
action_29 (77) = happyShift action_32
action_29 (78) = happyShift action_44
action_29 (80) = happyShift action_34
action_29 (81) = happyShift action_35
action_29 (85) = happyShift action_2
action_29 (86) = happyShift action_37
action_29 (87) = happyShift action_38
action_29 (4) = happyGoto action_41
action_29 (5) = happyGoto action_4
action_29 (6) = happyGoto action_5
action_29 (16) = happyGoto action_42
action_29 (29) = happyGoto action_46
action_29 (30) = happyGoto action_17
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (39) = happyShift action_45
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (39) = happyShift action_18
action_31 (44) = happyShift action_19
action_31 (55) = happyShift action_20
action_31 (60) = happyShift action_21
action_31 (62) = happyShift action_22
action_31 (68) = happyShift action_26
action_31 (69) = happyShift action_27
action_31 (71) = happyShift action_28
action_31 (72) = happyShift action_29
action_31 (77) = happyShift action_32
action_31 (78) = happyShift action_44
action_31 (80) = happyShift action_34
action_31 (81) = happyShift action_35
action_31 (85) = happyShift action_2
action_31 (86) = happyShift action_37
action_31 (87) = happyShift action_38
action_31 (4) = happyGoto action_41
action_31 (5) = happyGoto action_4
action_31 (6) = happyGoto action_5
action_31 (16) = happyGoto action_42
action_31 (23) = happyGoto action_43
action_31 (24) = happyGoto action_11
action_31 (25) = happyGoto action_12
action_31 (26) = happyGoto action_13
action_31 (27) = happyGoto action_14
action_31 (28) = happyGoto action_15
action_31 (29) = happyGoto action_16
action_31 (30) = happyGoto action_17
action_31 _ = happyReduce_21

action_32 _ = happyReduce_43

action_33 (85) = happyShift action_2
action_33 (4) = happyGoto action_40
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_86

action_35 _ = happyReduce_44

action_36 (39) = happyShift action_39
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyReduce_2

action_38 _ = happyReduce_3

action_39 (39) = happyShift action_18
action_39 (44) = happyShift action_19
action_39 (55) = happyShift action_20
action_39 (60) = happyShift action_21
action_39 (62) = happyShift action_22
action_39 (68) = happyShift action_26
action_39 (69) = happyShift action_27
action_39 (71) = happyShift action_28
action_39 (72) = happyShift action_29
action_39 (77) = happyShift action_32
action_39 (78) = happyShift action_44
action_39 (80) = happyShift action_34
action_39 (81) = happyShift action_35
action_39 (85) = happyShift action_2
action_39 (86) = happyShift action_37
action_39 (87) = happyShift action_38
action_39 (4) = happyGoto action_41
action_39 (5) = happyGoto action_4
action_39 (6) = happyGoto action_5
action_39 (16) = happyGoto action_42
action_39 (23) = happyGoto action_107
action_39 (24) = happyGoto action_11
action_39 (25) = happyGoto action_12
action_39 (26) = happyGoto action_13
action_39 (27) = happyGoto action_14
action_39 (28) = happyGoto action_15
action_39 (29) = happyGoto action_16
action_39 (30) = happyGoto action_17
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (83) = happyShift action_106
action_40 _ = happyReduce_46

action_41 _ = happyReduce_85

action_42 (56) = happyShift action_76
action_42 _ = happyFail (happyExpListPerState 42)

action_43 _ = happyReduce_20

action_44 (85) = happyShift action_2
action_44 (4) = happyGoto action_105
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (39) = happyShift action_18
action_45 (40) = happyReduce_33
action_45 (44) = happyShift action_19
action_45 (55) = happyShift action_20
action_45 (60) = happyShift action_21
action_45 (62) = happyShift action_22
action_45 (68) = happyShift action_26
action_45 (69) = happyShift action_27
action_45 (71) = happyShift action_28
action_45 (72) = happyShift action_29
action_45 (77) = happyShift action_32
action_45 (78) = happyShift action_44
action_45 (80) = happyShift action_34
action_45 (81) = happyShift action_35
action_45 (85) = happyShift action_2
action_45 (86) = happyShift action_37
action_45 (87) = happyShift action_38
action_45 (4) = happyGoto action_41
action_45 (5) = happyGoto action_4
action_45 (6) = happyGoto action_5
action_45 (13) = happyGoto action_103
action_45 (16) = happyGoto action_42
action_45 (23) = happyGoto action_104
action_45 (24) = happyGoto action_11
action_45 (25) = happyGoto action_12
action_45 (26) = happyGoto action_13
action_45 (27) = happyGoto action_14
action_45 (28) = happyGoto action_15
action_45 (29) = happyGoto action_16
action_45 (30) = happyGoto action_17
action_45 _ = happyReduce_33

action_46 (39) = happyShift action_56
action_46 _ = happyReduce_78

action_47 (60) = happyShift action_21
action_47 (68) = happyShift action_26
action_47 (69) = happyShift action_27
action_47 (71) = happyShift action_28
action_47 (77) = happyShift action_32
action_47 (78) = happyShift action_44
action_47 (81) = happyShift action_35
action_47 (16) = happyGoto action_102
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (39) = happyShift action_101
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (39) = happyShift action_18
action_49 (44) = happyShift action_19
action_49 (55) = happyShift action_20
action_49 (60) = happyShift action_21
action_49 (62) = happyShift action_22
action_49 (68) = happyShift action_26
action_49 (69) = happyShift action_27
action_49 (71) = happyShift action_28
action_49 (72) = happyShift action_29
action_49 (77) = happyShift action_32
action_49 (78) = happyShift action_44
action_49 (80) = happyShift action_34
action_49 (81) = happyShift action_35
action_49 (85) = happyShift action_2
action_49 (86) = happyShift action_37
action_49 (87) = happyShift action_38
action_49 (4) = happyGoto action_41
action_49 (5) = happyGoto action_4
action_49 (6) = happyGoto action_5
action_49 (16) = happyGoto action_42
action_49 (23) = happyGoto action_100
action_49 (24) = happyGoto action_11
action_49 (25) = happyGoto action_12
action_49 (26) = happyGoto action_13
action_49 (27) = happyGoto action_14
action_49 (28) = happyGoto action_15
action_49 (29) = happyGoto action_16
action_49 (30) = happyGoto action_17
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (39) = happyShift action_99
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (85) = happyShift action_2
action_51 (4) = happyGoto action_98
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (43) = happyShift action_97
action_52 _ = happyReduce_93

action_53 (57) = happyShift action_96
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (39) = happyShift action_56
action_54 _ = happyReduce_77

action_55 (40) = happyShift action_95
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (38) = happyShift action_94
action_56 (39) = happyShift action_18
action_56 (44) = happyShift action_19
action_56 (55) = happyShift action_20
action_56 (60) = happyShift action_21
action_56 (62) = happyShift action_22
action_56 (68) = happyShift action_26
action_56 (69) = happyShift action_27
action_56 (71) = happyShift action_28
action_56 (72) = happyShift action_29
action_56 (77) = happyShift action_32
action_56 (78) = happyShift action_44
action_56 (80) = happyShift action_34
action_56 (81) = happyShift action_35
action_56 (85) = happyShift action_2
action_56 (86) = happyShift action_37
action_56 (87) = happyShift action_38
action_56 (4) = happyGoto action_41
action_56 (5) = happyGoto action_4
action_56 (6) = happyGoto action_5
action_56 (16) = happyGoto action_42
action_56 (23) = happyGoto action_91
action_56 (24) = happyGoto action_11
action_56 (25) = happyGoto action_12
action_56 (26) = happyGoto action_13
action_56 (27) = happyGoto action_14
action_56 (28) = happyGoto action_15
action_56 (29) = happyGoto action_16
action_56 (30) = happyGoto action_17
action_56 (32) = happyGoto action_92
action_56 (33) = happyGoto action_93
action_56 _ = happyReduce_97

action_57 (59) = happyShift action_89
action_57 (70) = happyShift action_90
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (39) = happyShift action_18
action_58 (44) = happyShift action_19
action_58 (55) = happyShift action_20
action_58 (60) = happyShift action_21
action_58 (62) = happyShift action_22
action_58 (68) = happyShift action_26
action_58 (69) = happyShift action_27
action_58 (71) = happyShift action_28
action_58 (72) = happyShift action_29
action_58 (77) = happyShift action_32
action_58 (78) = happyShift action_44
action_58 (80) = happyShift action_34
action_58 (81) = happyShift action_35
action_58 (85) = happyShift action_2
action_58 (86) = happyShift action_37
action_58 (87) = happyShift action_38
action_58 (4) = happyGoto action_41
action_58 (5) = happyGoto action_4
action_58 (6) = happyGoto action_5
action_58 (16) = happyGoto action_42
action_58 (28) = happyGoto action_88
action_58 (29) = happyGoto action_16
action_58 (30) = happyGoto action_17
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_60

action_60 _ = happyReduce_58

action_61 _ = happyReduce_59

action_62 (39) = happyShift action_18
action_62 (44) = happyShift action_19
action_62 (55) = happyShift action_20
action_62 (60) = happyShift action_21
action_62 (62) = happyShift action_22
action_62 (68) = happyShift action_26
action_62 (69) = happyShift action_27
action_62 (71) = happyShift action_28
action_62 (72) = happyShift action_29
action_62 (77) = happyShift action_32
action_62 (78) = happyShift action_44
action_62 (80) = happyShift action_34
action_62 (81) = happyShift action_35
action_62 (85) = happyShift action_2
action_62 (86) = happyShift action_37
action_62 (87) = happyShift action_38
action_62 (4) = happyGoto action_41
action_62 (5) = happyGoto action_4
action_62 (6) = happyGoto action_5
action_62 (16) = happyGoto action_42
action_62 (27) = happyGoto action_87
action_62 (28) = happyGoto action_15
action_62 (29) = happyGoto action_16
action_62 (30) = happyGoto action_17
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_56

action_64 _ = happyReduce_57

action_65 (39) = happyShift action_18
action_65 (44) = happyShift action_19
action_65 (55) = happyShift action_20
action_65 (60) = happyShift action_21
action_65 (62) = happyShift action_22
action_65 (68) = happyShift action_26
action_65 (69) = happyShift action_27
action_65 (71) = happyShift action_28
action_65 (72) = happyShift action_29
action_65 (77) = happyShift action_32
action_65 (78) = happyShift action_44
action_65 (80) = happyShift action_34
action_65 (81) = happyShift action_35
action_65 (85) = happyShift action_2
action_65 (86) = happyShift action_37
action_65 (87) = happyShift action_38
action_65 (4) = happyGoto action_41
action_65 (5) = happyGoto action_4
action_65 (6) = happyGoto action_5
action_65 (16) = happyGoto action_42
action_65 (26) = happyGoto action_86
action_65 (27) = happyGoto action_14
action_65 (28) = happyGoto action_15
action_65 (29) = happyGoto action_16
action_65 (30) = happyGoto action_17
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_66

action_67 _ = happyReduce_61

action_68 _ = happyReduce_62

action_69 _ = happyReduce_65

action_70 _ = happyReduce_63

action_71 _ = happyReduce_64

action_72 (39) = happyShift action_18
action_72 (44) = happyShift action_19
action_72 (55) = happyShift action_20
action_72 (60) = happyShift action_21
action_72 (62) = happyShift action_22
action_72 (68) = happyShift action_26
action_72 (69) = happyShift action_27
action_72 (71) = happyShift action_28
action_72 (72) = happyShift action_29
action_72 (77) = happyShift action_32
action_72 (78) = happyShift action_44
action_72 (80) = happyShift action_34
action_72 (81) = happyShift action_35
action_72 (85) = happyShift action_2
action_72 (86) = happyShift action_37
action_72 (87) = happyShift action_38
action_72 (4) = happyGoto action_41
action_72 (5) = happyGoto action_4
action_72 (6) = happyGoto action_5
action_72 (16) = happyGoto action_42
action_72 (24) = happyGoto action_85
action_72 (25) = happyGoto action_12
action_72 (26) = happyGoto action_13
action_72 (27) = happyGoto action_14
action_72 (28) = happyGoto action_15
action_72 (29) = happyGoto action_16
action_72 (30) = happyGoto action_17
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (39) = happyShift action_18
action_73 (44) = happyShift action_19
action_73 (55) = happyShift action_20
action_73 (60) = happyShift action_21
action_73 (62) = happyShift action_22
action_73 (68) = happyShift action_26
action_73 (69) = happyShift action_27
action_73 (71) = happyShift action_28
action_73 (72) = happyShift action_29
action_73 (77) = happyShift action_32
action_73 (78) = happyShift action_44
action_73 (80) = happyShift action_34
action_73 (81) = happyShift action_35
action_73 (85) = happyShift action_2
action_73 (86) = happyShift action_37
action_73 (87) = happyShift action_38
action_73 (4) = happyGoto action_41
action_73 (5) = happyGoto action_4
action_73 (6) = happyGoto action_5
action_73 (16) = happyGoto action_42
action_73 (23) = happyGoto action_84
action_73 (24) = happyGoto action_11
action_73 (25) = happyGoto action_12
action_73 (26) = happyGoto action_13
action_73 (27) = happyGoto action_14
action_73 (28) = happyGoto action_15
action_73 (29) = happyGoto action_16
action_73 (30) = happyGoto action_17
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (51) = happyShift action_83
action_74 _ = happyReduce_26

action_75 _ = happyReduce_12

action_76 _ = happyReduce_88

action_77 (39) = happyShift action_18
action_77 (44) = happyShift action_19
action_77 (55) = happyShift action_20
action_77 (60) = happyShift action_21
action_77 (62) = happyShift action_22
action_77 (63) = happyShift action_23
action_77 (65) = happyShift action_24
action_77 (66) = happyShift action_25
action_77 (68) = happyShift action_26
action_77 (69) = happyShift action_27
action_77 (71) = happyShift action_28
action_77 (72) = happyShift action_29
action_77 (74) = happyShift action_30
action_77 (76) = happyShift action_31
action_77 (77) = happyShift action_32
action_77 (78) = happyShift action_33
action_77 (80) = happyShift action_34
action_77 (81) = happyShift action_35
action_77 (82) = happyShift action_36
action_77 (84) = happyReduce_9
action_77 (85) = happyShift action_2
action_77 (86) = happyShift action_37
action_77 (87) = happyShift action_38
action_77 (88) = happyReduce_9
action_77 (4) = happyGoto action_3
action_77 (5) = happyGoto action_4
action_77 (6) = happyGoto action_5
action_77 (9) = happyGoto action_82
action_77 (10) = happyGoto action_8
action_77 (16) = happyGoto action_9
action_77 (23) = happyGoto action_10
action_77 (24) = happyGoto action_11
action_77 (25) = happyGoto action_12
action_77 (26) = happyGoto action_13
action_77 (27) = happyGoto action_14
action_77 (28) = happyGoto action_15
action_77 (29) = happyGoto action_16
action_77 (30) = happyGoto action_17
action_77 _ = happyReduce_9

action_78 (75) = happyShift action_81
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (39) = happyShift action_18
action_79 (44) = happyShift action_19
action_79 (55) = happyShift action_20
action_79 (60) = happyShift action_21
action_79 (62) = happyShift action_22
action_79 (68) = happyShift action_26
action_79 (69) = happyShift action_27
action_79 (71) = happyShift action_28
action_79 (72) = happyShift action_29
action_79 (77) = happyShift action_32
action_79 (78) = happyShift action_44
action_79 (80) = happyShift action_34
action_79 (81) = happyShift action_35
action_79 (85) = happyShift action_2
action_79 (86) = happyShift action_37
action_79 (87) = happyShift action_38
action_79 (4) = happyGoto action_41
action_79 (5) = happyGoto action_4
action_79 (6) = happyGoto action_5
action_79 (16) = happyGoto action_42
action_79 (23) = happyGoto action_80
action_79 (24) = happyGoto action_11
action_79 (25) = happyGoto action_12
action_79 (26) = happyGoto action_13
action_79 (27) = happyGoto action_14
action_79 (28) = happyGoto action_15
action_79 (29) = happyGoto action_16
action_79 (30) = happyGoto action_17
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_22

action_81 (39) = happyShift action_133
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (84) = happyReduce_11
action_82 (88) = happyReduce_11
action_82 _ = happyReduce_11

action_83 (39) = happyShift action_18
action_83 (44) = happyShift action_19
action_83 (55) = happyShift action_20
action_83 (60) = happyShift action_21
action_83 (62) = happyShift action_22
action_83 (68) = happyShift action_26
action_83 (69) = happyShift action_27
action_83 (71) = happyShift action_28
action_83 (72) = happyShift action_29
action_83 (77) = happyShift action_32
action_83 (78) = happyShift action_44
action_83 (80) = happyShift action_34
action_83 (81) = happyShift action_35
action_83 (85) = happyShift action_2
action_83 (86) = happyShift action_37
action_83 (87) = happyShift action_38
action_83 (4) = happyGoto action_41
action_83 (5) = happyGoto action_4
action_83 (6) = happyGoto action_5
action_83 (16) = happyGoto action_42
action_83 (23) = happyGoto action_132
action_83 (24) = happyGoto action_11
action_83 (25) = happyGoto action_12
action_83 (26) = happyGoto action_13
action_83 (27) = happyGoto action_14
action_83 (28) = happyGoto action_15
action_83 (29) = happyGoto action_16
action_83 (30) = happyGoto action_17
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_67

action_85 _ = happyReduce_69

action_86 (42) = happyShift action_63
action_86 (44) = happyShift action_64
action_86 (20) = happyGoto action_62
action_86 _ = happyReduce_71

action_87 (37) = happyShift action_59
action_87 (41) = happyShift action_60
action_87 (47) = happyShift action_61
action_87 (21) = happyGoto action_58
action_87 _ = happyReduce_73

action_88 _ = happyReduce_75

action_89 (39) = happyShift action_131
action_89 _ = happyFail (happyExpListPerState 89)

action_90 _ = happyReduce_80

action_91 _ = happyReduce_95

action_92 (43) = happyShift action_130
action_92 _ = happyReduce_98

action_93 (40) = happyShift action_129
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (85) = happyShift action_2
action_94 (4) = happyGoto action_128
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_91

action_96 (39) = happyShift action_127
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (85) = happyShift action_2
action_97 (4) = happyGoto action_52
action_97 (31) = happyGoto action_126
action_97 _ = happyReduce_92

action_98 (64) = happyShift action_124
action_98 (67) = happyShift action_125
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (38) = happyShift action_123
action_99 (60) = happyShift action_21
action_99 (68) = happyShift action_26
action_99 (69) = happyShift action_27
action_99 (71) = happyShift action_28
action_99 (77) = happyShift action_32
action_99 (78) = happyShift action_44
action_99 (81) = happyShift action_35
action_99 (14) = happyGoto action_120
action_99 (15) = happyGoto action_121
action_99 (16) = happyGoto action_122
action_99 _ = happyReduce_38

action_100 (40) = happyShift action_119
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (38) = happyShift action_118
action_101 (60) = happyShift action_21
action_101 (68) = happyShift action_26
action_101 (69) = happyShift action_27
action_101 (71) = happyShift action_28
action_101 (77) = happyShift action_32
action_101 (78) = happyShift action_44
action_101 (81) = happyShift action_35
action_101 (16) = happyGoto action_115
action_101 (18) = happyGoto action_116
action_101 (19) = happyGoto action_117
action_101 _ = happyReduce_53

action_102 (53) = happyShift action_114
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (40) = happyShift action_113
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (40) = happyReduce_34
action_104 (43) = happyShift action_112
action_104 _ = happyReduce_34

action_105 _ = happyReduce_46

action_106 (60) = happyShift action_21
action_106 (68) = happyShift action_26
action_106 (69) = happyShift action_27
action_106 (71) = happyShift action_28
action_106 (77) = happyShift action_32
action_106 (78) = happyShift action_44
action_106 (81) = happyShift action_35
action_106 (16) = happyGoto action_109
action_106 (34) = happyGoto action_110
action_106 (35) = happyGoto action_111
action_106 _ = happyReduce_101

action_107 (40) = happyShift action_108
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (83) = happyShift action_145
action_108 (8) = happyGoto action_153
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (85) = happyShift action_2
action_109 (4) = happyGoto action_152
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (48) = happyShift action_151
action_110 _ = happyReduce_102

action_111 (84) = happyShift action_150
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (39) = happyShift action_18
action_112 (40) = happyReduce_33
action_112 (44) = happyShift action_19
action_112 (55) = happyShift action_20
action_112 (60) = happyShift action_21
action_112 (62) = happyShift action_22
action_112 (68) = happyShift action_26
action_112 (69) = happyShift action_27
action_112 (71) = happyShift action_28
action_112 (72) = happyShift action_29
action_112 (77) = happyShift action_32
action_112 (78) = happyShift action_44
action_112 (80) = happyShift action_34
action_112 (81) = happyShift action_35
action_112 (85) = happyShift action_2
action_112 (86) = happyShift action_37
action_112 (87) = happyShift action_38
action_112 (4) = happyGoto action_41
action_112 (5) = happyGoto action_4
action_112 (6) = happyGoto action_5
action_112 (13) = happyGoto action_149
action_112 (16) = happyGoto action_42
action_112 (23) = happyGoto action_104
action_112 (24) = happyGoto action_11
action_112 (25) = happyGoto action_12
action_112 (26) = happyGoto action_13
action_112 (27) = happyGoto action_14
action_112 (28) = happyGoto action_15
action_112 (29) = happyGoto action_16
action_112 (30) = happyGoto action_17
action_112 _ = happyReduce_33

action_113 _ = happyReduce_19

action_114 _ = happyReduce_45

action_115 _ = happyReduce_51

action_116 (43) = happyShift action_148
action_116 _ = happyReduce_54

action_117 (40) = happyShift action_147
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (60) = happyShift action_21
action_118 (68) = happyShift action_26
action_118 (69) = happyShift action_27
action_118 (71) = happyShift action_28
action_118 (77) = happyShift action_32
action_118 (78) = happyShift action_44
action_118 (81) = happyShift action_35
action_118 (16) = happyGoto action_146
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (83) = happyShift action_145
action_119 (8) = happyGoto action_144
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (43) = happyShift action_143
action_120 _ = happyReduce_39

action_121 (40) = happyShift action_142
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (85) = happyShift action_2
action_122 (4) = happyGoto action_141
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (60) = happyShift action_21
action_123 (68) = happyShift action_26
action_123 (69) = happyShift action_27
action_123 (71) = happyShift action_28
action_123 (77) = happyShift action_32
action_123 (78) = happyShift action_44
action_123 (81) = happyShift action_35
action_123 (16) = happyGoto action_140
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (39) = happyShift action_18
action_124 (44) = happyShift action_19
action_124 (55) = happyShift action_20
action_124 (60) = happyShift action_21
action_124 (62) = happyShift action_22
action_124 (68) = happyShift action_26
action_124 (69) = happyShift action_27
action_124 (71) = happyShift action_28
action_124 (72) = happyShift action_29
action_124 (77) = happyShift action_32
action_124 (78) = happyShift action_44
action_124 (80) = happyShift action_34
action_124 (81) = happyShift action_35
action_124 (85) = happyShift action_2
action_124 (86) = happyShift action_37
action_124 (87) = happyShift action_38
action_124 (4) = happyGoto action_41
action_124 (5) = happyGoto action_4
action_124 (6) = happyGoto action_5
action_124 (16) = happyGoto action_42
action_124 (23) = happyGoto action_139
action_124 (24) = happyGoto action_11
action_124 (25) = happyGoto action_12
action_124 (26) = happyGoto action_13
action_124 (27) = happyGoto action_14
action_124 (28) = happyGoto action_15
action_124 (29) = happyGoto action_16
action_124 (30) = happyGoto action_17
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (39) = happyShift action_18
action_125 (44) = happyShift action_19
action_125 (55) = happyShift action_20
action_125 (60) = happyShift action_21
action_125 (62) = happyShift action_22
action_125 (68) = happyShift action_26
action_125 (69) = happyShift action_27
action_125 (71) = happyShift action_28
action_125 (72) = happyShift action_29
action_125 (77) = happyShift action_32
action_125 (78) = happyShift action_44
action_125 (80) = happyShift action_34
action_125 (81) = happyShift action_35
action_125 (85) = happyShift action_2
action_125 (86) = happyShift action_37
action_125 (87) = happyShift action_38
action_125 (4) = happyGoto action_41
action_125 (5) = happyGoto action_4
action_125 (6) = happyGoto action_5
action_125 (16) = happyGoto action_42
action_125 (23) = happyGoto action_138
action_125 (24) = happyGoto action_11
action_125 (25) = happyGoto action_12
action_125 (26) = happyGoto action_13
action_125 (27) = happyGoto action_14
action_125 (28) = happyGoto action_15
action_125 (29) = happyGoto action_16
action_125 (30) = happyGoto action_17
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_94

action_127 (38) = happyShift action_118
action_127 (60) = happyShift action_21
action_127 (68) = happyShift action_26
action_127 (69) = happyShift action_27
action_127 (71) = happyShift action_28
action_127 (77) = happyShift action_32
action_127 (78) = happyShift action_44
action_127 (81) = happyShift action_35
action_127 (16) = happyGoto action_115
action_127 (18) = happyGoto action_116
action_127 (19) = happyGoto action_137
action_127 _ = happyReduce_53

action_128 _ = happyReduce_96

action_129 _ = happyReduce_82

action_130 (38) = happyShift action_94
action_130 (39) = happyShift action_18
action_130 (44) = happyShift action_19
action_130 (55) = happyShift action_20
action_130 (60) = happyShift action_21
action_130 (62) = happyShift action_22
action_130 (68) = happyShift action_26
action_130 (69) = happyShift action_27
action_130 (71) = happyShift action_28
action_130 (72) = happyShift action_29
action_130 (77) = happyShift action_32
action_130 (78) = happyShift action_44
action_130 (80) = happyShift action_34
action_130 (81) = happyShift action_35
action_130 (85) = happyShift action_2
action_130 (86) = happyShift action_37
action_130 (87) = happyShift action_38
action_130 (4) = happyGoto action_41
action_130 (5) = happyGoto action_4
action_130 (6) = happyGoto action_5
action_130 (16) = happyGoto action_42
action_130 (23) = happyGoto action_91
action_130 (24) = happyGoto action_11
action_130 (25) = happyGoto action_12
action_130 (26) = happyGoto action_13
action_130 (27) = happyGoto action_14
action_130 (28) = happyGoto action_15
action_130 (29) = happyGoto action_16
action_130 (30) = happyGoto action_17
action_130 (32) = happyGoto action_92
action_130 (33) = happyGoto action_136
action_130 _ = happyReduce_97

action_131 (39) = happyShift action_18
action_131 (55) = happyShift action_20
action_131 (60) = happyShift action_21
action_131 (62) = happyShift action_22
action_131 (68) = happyShift action_26
action_131 (69) = happyShift action_27
action_131 (71) = happyShift action_28
action_131 (77) = happyShift action_32
action_131 (78) = happyShift action_44
action_131 (80) = happyShift action_34
action_131 (81) = happyShift action_35
action_131 (85) = happyShift action_2
action_131 (86) = happyShift action_37
action_131 (87) = happyShift action_38
action_131 (4) = happyGoto action_41
action_131 (5) = happyGoto action_4
action_131 (6) = happyGoto action_5
action_131 (16) = happyGoto action_42
action_131 (29) = happyGoto action_135
action_131 (30) = happyGoto action_17
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_27

action_133 (39) = happyShift action_18
action_133 (44) = happyShift action_19
action_133 (55) = happyShift action_20
action_133 (60) = happyShift action_21
action_133 (62) = happyShift action_22
action_133 (68) = happyShift action_26
action_133 (69) = happyShift action_27
action_133 (71) = happyShift action_28
action_133 (72) = happyShift action_29
action_133 (77) = happyShift action_32
action_133 (78) = happyShift action_44
action_133 (80) = happyShift action_34
action_133 (81) = happyShift action_35
action_133 (85) = happyShift action_2
action_133 (86) = happyShift action_37
action_133 (87) = happyShift action_38
action_133 (4) = happyGoto action_41
action_133 (5) = happyGoto action_4
action_133 (6) = happyGoto action_5
action_133 (16) = happyGoto action_42
action_133 (23) = happyGoto action_134
action_133 (24) = happyGoto action_11
action_133 (25) = happyGoto action_12
action_133 (26) = happyGoto action_13
action_133 (27) = happyGoto action_14
action_133 (28) = happyGoto action_15
action_133 (29) = happyGoto action_16
action_133 (30) = happyGoto action_17
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (40) = happyShift action_166
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (39) = happyShift action_56
action_135 (40) = happyShift action_165
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_99

action_137 (40) = happyShift action_164
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (40) = happyShift action_163
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (79) = happyShift action_162
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (85) = happyShift action_2
action_140 (4) = happyGoto action_161
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_36

action_142 (45) = happyShift action_160
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (38) = happyShift action_123
action_143 (60) = happyShift action_21
action_143 (68) = happyShift action_26
action_143 (69) = happyShift action_27
action_143 (71) = happyShift action_28
action_143 (77) = happyShift action_32
action_143 (78) = happyShift action_44
action_143 (81) = happyShift action_35
action_143 (14) = happyGoto action_120
action_143 (15) = happyGoto action_159
action_143 (16) = happyGoto action_122
action_143 _ = happyReduce_38

action_144 (61) = happyShift action_158
action_144 _ = happyReduce_14

action_145 (39) = happyShift action_18
action_145 (44) = happyShift action_19
action_145 (55) = happyShift action_20
action_145 (60) = happyShift action_21
action_145 (62) = happyShift action_22
action_145 (63) = happyShift action_23
action_145 (65) = happyShift action_24
action_145 (66) = happyShift action_25
action_145 (68) = happyShift action_26
action_145 (69) = happyShift action_27
action_145 (71) = happyShift action_28
action_145 (72) = happyShift action_29
action_145 (74) = happyShift action_30
action_145 (76) = happyShift action_31
action_145 (77) = happyShift action_32
action_145 (78) = happyShift action_33
action_145 (80) = happyShift action_34
action_145 (81) = happyShift action_35
action_145 (82) = happyShift action_36
action_145 (84) = happyReduce_9
action_145 (85) = happyShift action_2
action_145 (86) = happyShift action_37
action_145 (87) = happyShift action_38
action_145 (4) = happyGoto action_3
action_145 (5) = happyGoto action_4
action_145 (6) = happyGoto action_5
action_145 (9) = happyGoto action_157
action_145 (10) = happyGoto action_8
action_145 (16) = happyGoto action_9
action_145 (23) = happyGoto action_10
action_145 (24) = happyGoto action_11
action_145 (25) = happyGoto action_12
action_145 (26) = happyGoto action_13
action_145 (27) = happyGoto action_14
action_145 (28) = happyGoto action_15
action_145 (29) = happyGoto action_16
action_145 (30) = happyGoto action_17
action_145 _ = happyReduce_9

action_146 _ = happyReduce_52

action_147 (45) = happyShift action_156
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (38) = happyShift action_118
action_148 (60) = happyShift action_21
action_148 (68) = happyShift action_26
action_148 (69) = happyShift action_27
action_148 (71) = happyShift action_28
action_148 (77) = happyShift action_32
action_148 (78) = happyShift action_44
action_148 (81) = happyShift action_35
action_148 (16) = happyGoto action_115
action_148 (18) = happyGoto action_116
action_148 (19) = happyGoto action_155
action_148 _ = happyReduce_53

action_149 (40) = happyReduce_35
action_149 _ = happyReduce_35

action_150 _ = happyReduce_25

action_151 (60) = happyShift action_21
action_151 (68) = happyShift action_26
action_151 (69) = happyShift action_27
action_151 (71) = happyShift action_28
action_151 (77) = happyShift action_32
action_151 (78) = happyShift action_44
action_151 (81) = happyShift action_35
action_151 (16) = happyGoto action_109
action_151 (34) = happyGoto action_110
action_151 (35) = happyGoto action_154
action_151 _ = happyReduce_101

action_152 _ = happyReduce_100

action_153 _ = happyReduce_16

action_154 _ = happyReduce_103

action_155 _ = happyReduce_55

action_156 (60) = happyShift action_21
action_156 (68) = happyShift action_26
action_156 (69) = happyShift action_27
action_156 (71) = happyShift action_28
action_156 (77) = happyShift action_32
action_156 (78) = happyShift action_44
action_156 (81) = happyShift action_35
action_156 (16) = happyGoto action_173
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (84) = happyShift action_172
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (83) = happyShift action_145
action_158 (8) = happyGoto action_171
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_40

action_160 (60) = happyShift action_21
action_160 (68) = happyShift action_26
action_160 (69) = happyShift action_27
action_160 (71) = happyShift action_28
action_160 (77) = happyShift action_32
action_160 (78) = happyShift action_44
action_160 (81) = happyShift action_35
action_160 (16) = happyGoto action_170
action_160 _ = happyFail (happyExpListPerState 160)

action_161 _ = happyReduce_37

action_162 (39) = happyShift action_18
action_162 (44) = happyShift action_19
action_162 (55) = happyShift action_20
action_162 (60) = happyShift action_21
action_162 (62) = happyShift action_22
action_162 (68) = happyShift action_26
action_162 (69) = happyShift action_27
action_162 (71) = happyShift action_28
action_162 (72) = happyShift action_29
action_162 (77) = happyShift action_32
action_162 (78) = happyShift action_44
action_162 (80) = happyShift action_34
action_162 (81) = happyShift action_35
action_162 (85) = happyShift action_2
action_162 (86) = happyShift action_37
action_162 (87) = happyShift action_38
action_162 (4) = happyGoto action_41
action_162 (5) = happyGoto action_4
action_162 (6) = happyGoto action_5
action_162 (16) = happyGoto action_42
action_162 (23) = happyGoto action_169
action_162 (24) = happyGoto action_11
action_162 (25) = happyGoto action_12
action_162 (26) = happyGoto action_13
action_162 (27) = happyGoto action_14
action_162 (28) = happyGoto action_15
action_162 (29) = happyGoto action_16
action_162 (30) = happyGoto action_17
action_162 _ = happyFail (happyExpListPerState 162)

action_163 (83) = happyShift action_145
action_163 (8) = happyGoto action_168
action_163 _ = happyFail (happyExpListPerState 163)

action_164 (45) = happyShift action_167
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_81

action_166 _ = happyReduce_24

action_167 (60) = happyShift action_21
action_167 (68) = happyShift action_26
action_167 (69) = happyShift action_27
action_167 (71) = happyShift action_28
action_167 (77) = happyShift action_32
action_167 (78) = happyShift action_44
action_167 (81) = happyShift action_35
action_167 (16) = happyGoto action_177
action_167 _ = happyFail (happyExpListPerState 167)

action_168 _ = happyReduce_18

action_169 (40) = happyShift action_176
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (83) = happyShift action_145
action_170 (8) = happyGoto action_175
action_170 _ = happyFail (happyExpListPerState 170)

action_171 _ = happyReduce_15

action_172 _ = happyReduce_5

action_173 (53) = happyShift action_174
action_173 _ = happyFail (happyExpListPerState 173)

action_174 _ = happyReduce_47

action_175 _ = happyReduce_23

action_176 (83) = happyShift action_145
action_176 (8) = happyGoto action_179
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (83) = happyShift action_145
action_177 (8) = happyGoto action_178
action_177 _ = happyFail (happyExpListPerState 177)

action_178 _ = happyReduce_90

action_179 _ = happyReduce_17

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

happyReduce_20 = happySpecReduce_2  10 happyReduction_20
happyReduction_20 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Grammar.Abs.Return happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  10 happyReduction_21
happyReduction_21 _
	 =  HappyAbsSyn10
		 (Grammar.Abs.ReturnVoid
	)

happyReduce_22 = happySpecReduce_3  10 happyReduction_22
happyReduction_22 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn10
		 (Grammar.Abs.Assign happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happyReduce 8 10 happyReduction_23
happyReduction_23 ((HappyAbsSyn8  happy_var_8) `HappyStk`
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

happyReduce_24 = happyReduce 6 10 happyReduction_24
happyReduction_24 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.SListPush happy_var_1 happy_var_5
	) `HappyStk` happyRest

happyReduce_25 = happyReduce 5 10 happyReduction_25
happyReduction_25 (_ `HappyStk`
	(HappyAbsSyn35  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Grammar.Abs.StructDef happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_26 = happySpecReduce_1  11 happyReduction_26
happyReduction_26 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn11
		 (Grammar.Abs.NoInit happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  11 happyReduction_27
happyReduction_27 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn11
		 (Grammar.Abs.Init happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  12 happyReduction_28
happyReduction_28 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ((:[]) happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  12 happyReduction_29
happyReduction_29 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0  13 happyReduction_30
happyReduction_30  =  HappyAbsSyn13
		 ([]
	)

happyReduce_31 = happySpecReduce_1  13 happyReduction_31
happyReduction_31 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:[]) happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  13 happyReduction_32
happyReduction_32 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_0  13 happyReduction_33
happyReduction_33  =  HappyAbsSyn13
		 ([]
	)

happyReduce_34 = happySpecReduce_1  13 happyReduction_34
happyReduction_34 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:[]) happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  13 happyReduction_35
happyReduction_35 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn13
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_2  14 happyReduction_36
happyReduction_36 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn14
		 (Grammar.Abs.Arg happy_var_1 happy_var_2
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  14 happyReduction_37
happyReduction_37 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn14
		 (Grammar.Abs.ArgRef happy_var_2 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_0  15 happyReduction_38
happyReduction_38  =  HappyAbsSyn15
		 ([]
	)

happyReduce_39 = happySpecReduce_1  15 happyReduction_39
happyReduction_39 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 ((:[]) happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  15 happyReduction_40
happyReduction_40 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  16 happyReduction_41
happyReduction_41 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TInt
	)

happyReduce_42 = happySpecReduce_1  16 happyReduction_42
happyReduction_42 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TBool
	)

happyReduce_43 = happySpecReduce_1  16 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TString
	)

happyReduce_44 = happySpecReduce_1  16 happyReduction_44
happyReduction_44 _
	 =  HappyAbsSyn16
		 (Grammar.Abs.TVoid
	)

happyReduce_45 = happyReduce 4 16 happyReduction_45
happyReduction_45 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Grammar.Abs.TList happy_var_3
	) `HappyStk` happyRest

happyReduce_46 = happySpecReduce_2  16 happyReduction_46
happyReduction_46 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (Grammar.Abs.TStruct happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happyReduce 8 16 happyReduction_47
happyReduction_47 (_ `HappyStk`
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

happyReduce_48 = happySpecReduce_0  17 happyReduction_48
happyReduction_48  =  HappyAbsSyn17
		 ([]
	)

happyReduce_49 = happySpecReduce_1  17 happyReduction_49
happyReduction_49 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 ((:[]) happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  17 happyReduction_50
happyReduction_50 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  18 happyReduction_51
happyReduction_51 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn18
		 (Grammar.Abs.TRType happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_2  18 happyReduction_52
happyReduction_52 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (Grammar.Abs.TRRef happy_var_2
	)
happyReduction_52 _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_0  19 happyReduction_53
happyReduction_53  =  HappyAbsSyn19
		 ([]
	)

happyReduce_54 = happySpecReduce_1  19 happyReduction_54
happyReduction_54 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 ((:[]) happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  19 happyReduction_55
happyReduction_55 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  20 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn20
		 (Grammar.Abs.Plus
	)

happyReduce_57 = happySpecReduce_1  20 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn20
		 (Grammar.Abs.Minus
	)

happyReduce_58 = happySpecReduce_1  21 happyReduction_58
happyReduction_58 _
	 =  HappyAbsSyn21
		 (Grammar.Abs.Mul
	)

happyReduce_59 = happySpecReduce_1  21 happyReduction_59
happyReduction_59 _
	 =  HappyAbsSyn21
		 (Grammar.Abs.Div
	)

happyReduce_60 = happySpecReduce_1  21 happyReduction_60
happyReduction_60 _
	 =  HappyAbsSyn21
		 (Grammar.Abs.Mod
	)

happyReduce_61 = happySpecReduce_1  22 happyReduction_61
happyReduction_61 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.LTH
	)

happyReduce_62 = happySpecReduce_1  22 happyReduction_62
happyReduction_62 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.LE
	)

happyReduce_63 = happySpecReduce_1  22 happyReduction_63
happyReduction_63 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.GTH
	)

happyReduce_64 = happySpecReduce_1  22 happyReduction_64
happyReduction_64 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.GE
	)

happyReduce_65 = happySpecReduce_1  22 happyReduction_65
happyReduction_65 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.EQ
	)

happyReduce_66 = happySpecReduce_1  22 happyReduction_66
happyReduction_66 _
	 =  HappyAbsSyn22
		 (Grammar.Abs.NEQ
	)

happyReduce_67 = happySpecReduce_3  23 happyReduction_67
happyReduction_67 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EOr happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  23 happyReduction_68
happyReduction_68 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  24 happyReduction_69
happyReduction_69 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EAnd happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  24 happyReduction_70
happyReduction_70 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_70 _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  25 happyReduction_71
happyReduction_71 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.ERel happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  25 happyReduction_72
happyReduction_72 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  26 happyReduction_73
happyReduction_73 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EAdd happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  26 happyReduction_74
happyReduction_74 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  27 happyReduction_75
happyReduction_75 (HappyAbsSyn23  happy_var_3)
	(HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EMul happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  27 happyReduction_76
happyReduction_76 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_2  28 happyReduction_77
happyReduction_77 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (Grammar.Abs.ENeg happy_var_2
	)
happyReduction_77 _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_2  28 happyReduction_78
happyReduction_78 (HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (Grammar.Abs.ENot happy_var_2
	)
happyReduction_78 _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  28 happyReduction_79
happyReduction_79 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  28 happyReduction_80
happyReduction_80 _
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EListLen happy_var_1
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happyReduce 6 28 happyReduction_81
happyReduction_81 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Grammar.Abs.EListAt happy_var_1 happy_var_5
	) `HappyStk` happyRest

happyReduce_82 = happyReduce 4 29 happyReduction_82
happyReduction_82 (_ `HappyStk`
	(HappyAbsSyn33  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Grammar.Abs.EApp happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_83 = happySpecReduce_1  29 happyReduction_83
happyReduction_83 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  30 happyReduction_84
happyReduction_84 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EInt happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  30 happyReduction_85
happyReduction_85 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EVar happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  30 happyReduction_86
happyReduction_86 _
	 =  HappyAbsSyn23
		 (Grammar.Abs.ETrue
	)

happyReduce_87 = happySpecReduce_1  30 happyReduction_87
happyReduction_87 _
	 =  HappyAbsSyn23
		 (Grammar.Abs.EFalse
	)

happyReduce_88 = happySpecReduce_2  30 happyReduction_88
happyReduction_88 _
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EEmptyList happy_var_1
	)
happyReduction_88 _ _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_1  30 happyReduction_89
happyReduction_89 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn23
		 (Grammar.Abs.EString happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happyReduce 9 30 happyReduction_90
happyReduction_90 ((HappyAbsSyn8  happy_var_9) `HappyStk`
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

happyReduce_91 = happySpecReduce_3  30 happyReduction_91
happyReduction_91 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (happy_var_2
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_0  31 happyReduction_92
happyReduction_92  =  HappyAbsSyn31
		 ([]
	)

happyReduce_93 = happySpecReduce_1  31 happyReduction_93
happyReduction_93 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn31
		 ((:[]) happy_var_1
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_3  31 happyReduction_94
happyReduction_94 (HappyAbsSyn31  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn31
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_94 _ _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  32 happyReduction_95
happyReduction_95 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn32
		 (Grammar.Abs.EorRExpr happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_2  32 happyReduction_96
happyReduction_96 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn32
		 (Grammar.Abs.EorRRef happy_var_2
	)
happyReduction_96 _ _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_0  33 happyReduction_97
happyReduction_97  =  HappyAbsSyn33
		 ([]
	)

happyReduce_98 = happySpecReduce_1  33 happyReduction_98
happyReduction_98 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn33
		 ((:[]) happy_var_1
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_3  33 happyReduction_99
happyReduction_99 (HappyAbsSyn33  happy_var_3)
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn33
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_99 _ _ _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_2  34 happyReduction_100
happyReduction_100 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn34
		 (Grammar.Abs.StructItem happy_var_1 happy_var_2
	)
happyReduction_100 _ _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_0  35 happyReduction_101
happyReduction_101  =  HappyAbsSyn35
		 ([]
	)

happyReduce_102 = happySpecReduce_1  35 happyReduction_102
happyReduction_102 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn35
		 ((:[]) happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_3  35 happyReduction_103
happyReduction_103 (HappyAbsSyn35  happy_var_3)
	_
	(HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn35
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_103 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 88 88 notHappyAtAll (HappyState action) sts stk []

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
	PT _ (TV happy_dollar_dollar) -> cont 85;
	PT _ (TI happy_dollar_dollar) -> cont 86;
	PT _ (TL happy_dollar_dollar) -> cont 87;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 88 tk tks = happyError' (tks, explist)
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
