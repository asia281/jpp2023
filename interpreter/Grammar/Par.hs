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
	| HappyAbsSyn31 (Grammar.Abs.ExprOrRef)
	| HappyAbsSyn32 ([Grammar.Abs.ExprOrRef])
	| HappyAbsSyn33 (Grammar.Abs.StructItem)
	| HappyAbsSyn34 ([Grammar.Abs.StructItem])

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
 action_175 :: () => Prelude.Int -> ({-HappyReduction (Err) = -}
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
 happyReduce_100 :: () => ({-HappyReduction (Err) = -}
	   Prelude.Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> (Err) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> (Err) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,755) ([0,0,1056,27904,30555,14,0,0,0,0,64,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,4,16384,0,0,0,0,0,0,0,0,0,4096,0,0,16384,55296,5,0,0,0,2560,0,0,0,0,8704,8,0,0,0,0,0,0,0,0,0,4128,0,0,0,0,0,0,0,0,0,32768,16,27668,14552,0,0,16,33408,6917,7,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,16,0,8192,0,0,0,0,0,0,0,0,0,0,0,2,0,8,0,0,64,0,0,0,0,2,45136,58208,0,0,64,0,0,0,0,2048,16385,34497,909,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,264,49472,36230,3,0,0,0,0,4,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,256,0,0,66,45136,58209,0,0,64,0,0,0,0,0,16384,33472,9,0,0,1,0,0,0,0,32,0,0,0,0,33792,40960,50016,454,0,32768,0,0,0,0,0,0,0,0,1,0,512,0,0,0,0,32768,0,0,0,0,0,268,49472,36230,3,0,0,1024,32,0,0,8192,4,6917,3638,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,45136,58209,0,0,0,0,0,0,0,0,0,0,0,0,0,33,55336,29104,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,264,49472,36230,3,0,8448,10240,45272,113,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,32770,44470,1851,0,0,0,0,8,0,0,2112,2560,27702,28,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,33792,40960,50016,454,0,0,0,0,0,0,0,0,0,0,0,0,20480,0,0,0,0,4096,65,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,8192,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,36,0,0,32768,0,22536,304,0,0,64,0,0,0,0,512,8192,49504,4,0,16384,0,11268,152,0,0,0,4,0,0,0,0,8,0,0,0,32768,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,2817,38,0,0,8,0,0,0,0,0,0,0,2,0,0,0,0,256,0,0,1024,0,0,0,0,0,0,0,2,0,2048,16385,34497,909,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,32,0,0,0,0,0,4096,24752,2,0,32768,0,0,0,0,0,0,0,8192,0,0,4096,0,0,0,0,16384,0,0,0,0,0,0,0,16384,0,0,0,1024,38956,0,0,4096,32770,3458,1819,0,0,66,45136,58209,0,0,0,0,0,0,0,0,0,0,0,0,32768,33,55336,29104,0,0,32,1280,13835,14,0,0,0,0,0,0,32768,16,27668,14552,0,0,32,0,0,0,0,1536,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,16384,0,0,0,0,0,512,0,0,0,0,0,0,0,8192,0,0,0,0,2048,32768,1408,19,0,0,0,32,0,0,0,2112,55808,61110,28,0,0,2,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,512,8192,49504,4,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,24752,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24608,1217,0,0,0,1024,38956,0,0,0,0,0,128,0,0,0,0,2048,0,0,0,0,0,0,0,0,16384,33472,9,0,0,0,0,0,0,0,1056,1280,13851,14,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pProgram","Ident","Integer","String","Program","Block","ListStmt","Stmt","Item","ListItem","ListExpr","Arg","ListArg","Type","ListType","TypeOrRef","ListTypeOrRef","AddOp","MulOp","RelOp","Expr","Expr1","Expr2","Expr3","Expr4","Expr5","Expr6","Expr7","ExprOrRef","ListExprOrRef","StructItem","ListStructItem","'!='","'%'","'&'","'('","')'","'*'","'+'","','","'-'","'->'","'.'","'/'","';'","'<'","'<='","'='","'=='","'>'","'>='","'[]'","'and'","'at'","'bool'","'else'","'false'","'for'","'from'","'fun'","'if'","'in'","'int'","'lambda'","'len()'","'list'","'not'","'or'","'print'","'push'","'return'","'string'","'struct'","'to'","'true'","'void'","'while'","'{'","'}'","L_Ident","L_integ","L_quoted","%eof"]
        bit_start = st Prelude.* 85
        bit_end = (st Prelude.+ 1) Prelude.* 85
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..84]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (38) = happyShift action_18
action_0 (43) = happyShift action_19
action_0 (57) = happyShift action_20
action_0 (59) = happyShift action_21
action_0 (60) = happyShift action_22
action_0 (62) = happyShift action_23
action_0 (63) = happyShift action_24
action_0 (65) = happyShift action_25
action_0 (66) = happyShift action_26
action_0 (68) = happyShift action_27
action_0 (69) = happyShift action_28
action_0 (71) = happyShift action_29
action_0 (73) = happyShift action_30
action_0 (74) = happyShift action_31
action_0 (75) = happyShift action_32
action_0 (77) = happyShift action_33
action_0 (78) = happyShift action_34
action_0 (79) = happyShift action_35
action_0 (82) = happyShift action_2
action_0 (83) = happyShift action_36
action_0 (84) = happyShift action_37
action_0 (85) = happyReduce_9
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

action_1 (82) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (45) = happyShift action_76
action_3 (50) = happyShift action_77
action_3 _ = happyReduce_85

action_4 _ = happyReduce_84

action_5 _ = happyReduce_89

action_6 (85) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_4

action_8 (47) = happyShift action_75
action_8 (81) = happyReduce_10
action_8 (85) = happyReduce_10
action_8 _ = happyReduce_10

action_9 (54) = happyShift action_74
action_9 (82) = happyShift action_2
action_9 (4) = happyGoto action_72
action_9 (11) = happyGoto action_73
action_9 _ = happyFail (happyExpListPerState 9)

action_10 _ = happyReduce_13

action_11 (70) = happyShift action_71
action_11 _ = happyReduce_68

action_12 (35) = happyShift action_64
action_12 (48) = happyShift action_65
action_12 (49) = happyShift action_66
action_12 (51) = happyShift action_67
action_12 (52) = happyShift action_68
action_12 (53) = happyShift action_69
action_12 (55) = happyShift action_70
action_12 (22) = happyGoto action_63
action_12 _ = happyReduce_70

action_13 (41) = happyShift action_61
action_13 (43) = happyShift action_62
action_13 (20) = happyGoto action_60
action_13 _ = happyReduce_72

action_14 (36) = happyShift action_57
action_14 (40) = happyShift action_58
action_14 (46) = happyShift action_59
action_14 (21) = happyGoto action_56
action_14 _ = happyReduce_74

action_15 _ = happyReduce_76

action_16 (38) = happyShift action_54
action_16 (45) = happyShift action_55
action_16 _ = happyReduce_79

action_17 _ = happyReduce_83

action_18 (38) = happyShift action_18
action_18 (43) = happyShift action_19
action_18 (57) = happyShift action_20
action_18 (59) = happyShift action_21
action_18 (65) = happyShift action_25
action_18 (66) = happyShift action_26
action_18 (68) = happyShift action_27
action_18 (69) = happyShift action_28
action_18 (74) = happyShift action_31
action_18 (75) = happyShift action_43
action_18 (77) = happyShift action_33
action_18 (78) = happyShift action_34
action_18 (82) = happyShift action_2
action_18 (83) = happyShift action_36
action_18 (84) = happyShift action_37
action_18 (4) = happyGoto action_40
action_18 (5) = happyGoto action_4
action_18 (6) = happyGoto action_5
action_18 (16) = happyGoto action_41
action_18 (23) = happyGoto action_53
action_18 (24) = happyGoto action_11
action_18 (25) = happyGoto action_12
action_18 (26) = happyGoto action_13
action_18 (27) = happyGoto action_14
action_18 (28) = happyGoto action_15
action_18 (29) = happyGoto action_16
action_18 (30) = happyGoto action_17
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (38) = happyShift action_18
action_19 (57) = happyShift action_20
action_19 (59) = happyShift action_21
action_19 (65) = happyShift action_25
action_19 (66) = happyShift action_26
action_19 (68) = happyShift action_27
action_19 (74) = happyShift action_31
action_19 (75) = happyShift action_43
action_19 (77) = happyShift action_33
action_19 (78) = happyShift action_34
action_19 (82) = happyShift action_2
action_19 (83) = happyShift action_36
action_19 (84) = happyShift action_37
action_19 (4) = happyGoto action_40
action_19 (5) = happyGoto action_4
action_19 (6) = happyGoto action_5
action_19 (16) = happyGoto action_41
action_19 (29) = happyGoto action_52
action_19 (30) = happyGoto action_17
action_19 _ = happyFail (happyExpListPerState 19)

action_20 _ = happyReduce_42

action_21 _ = happyReduce_87

action_22 (38) = happyShift action_51
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (82) = happyShift action_2
action_23 (4) = happyGoto action_50
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (38) = happyShift action_49
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_41

action_26 (48) = happyShift action_48
action_26 (82) = happyShift action_2
action_26 (4) = happyGoto action_47
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (48) = happyShift action_46
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (38) = happyShift action_18
action_28 (57) = happyShift action_20
action_28 (59) = happyShift action_21
action_28 (65) = happyShift action_25
action_28 (66) = happyShift action_26
action_28 (68) = happyShift action_27
action_28 (74) = happyShift action_31
action_28 (75) = happyShift action_43
action_28 (77) = happyShift action_33
action_28 (78) = happyShift action_34
action_28 (82) = happyShift action_2
action_28 (83) = happyShift action_36
action_28 (84) = happyShift action_37
action_28 (4) = happyGoto action_40
action_28 (5) = happyGoto action_4
action_28 (6) = happyGoto action_5
action_28 (16) = happyGoto action_41
action_28 (29) = happyGoto action_45
action_28 (30) = happyGoto action_17
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (38) = happyShift action_44
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (38) = happyShift action_18
action_30 (43) = happyShift action_19
action_30 (57) = happyShift action_20
action_30 (59) = happyShift action_21
action_30 (65) = happyShift action_25
action_30 (66) = happyShift action_26
action_30 (68) = happyShift action_27
action_30 (69) = happyShift action_28
action_30 (74) = happyShift action_31
action_30 (75) = happyShift action_43
action_30 (77) = happyShift action_33
action_30 (78) = happyShift action_34
action_30 (82) = happyShift action_2
action_30 (83) = happyShift action_36
action_30 (84) = happyShift action_37
action_30 (4) = happyGoto action_40
action_30 (5) = happyGoto action_4
action_30 (6) = happyGoto action_5
action_30 (16) = happyGoto action_41
action_30 (23) = happyGoto action_42
action_30 (24) = happyGoto action_11
action_30 (25) = happyGoto action_12
action_30 (26) = happyGoto action_13
action_30 (27) = happyGoto action_14
action_30 (28) = happyGoto action_15
action_30 (29) = happyGoto action_16
action_30 (30) = happyGoto action_17
action_30 _ = happyReduce_21

action_31 _ = happyReduce_43

action_32 (82) = happyShift action_2
action_32 (4) = happyGoto action_39
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_86

action_34 _ = happyReduce_44

action_35 (38) = happyShift action_38
action_35 _ = happyFail (happyExpListPerState 35)

action_36 _ = happyReduce_2

action_37 _ = happyReduce_3

action_38 (38) = happyShift action_18
action_38 (43) = happyShift action_19
action_38 (57) = happyShift action_20
action_38 (59) = happyShift action_21
action_38 (65) = happyShift action_25
action_38 (66) = happyShift action_26
action_38 (68) = happyShift action_27
action_38 (69) = happyShift action_28
action_38 (74) = happyShift action_31
action_38 (75) = happyShift action_43
action_38 (77) = happyShift action_33
action_38 (78) = happyShift action_34
action_38 (82) = happyShift action_2
action_38 (83) = happyShift action_36
action_38 (84) = happyShift action_37
action_38 (4) = happyGoto action_40
action_38 (5) = happyGoto action_4
action_38 (6) = happyGoto action_5
action_38 (16) = happyGoto action_41
action_38 (23) = happyGoto action_105
action_38 (24) = happyGoto action_11
action_38 (25) = happyGoto action_12
action_38 (26) = happyGoto action_13
action_38 (27) = happyGoto action_14
action_38 (28) = happyGoto action_15
action_38 (29) = happyGoto action_16
action_38 (30) = happyGoto action_17
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (80) = happyShift action_104
action_39 _ = happyReduce_46

action_40 _ = happyReduce_85

action_41 (54) = happyShift action_74
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_20

action_43 (82) = happyShift action_2
action_43 (4) = happyGoto action_103
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (38) = happyShift action_18
action_44 (39) = happyReduce_33
action_44 (43) = happyShift action_19
action_44 (57) = happyShift action_20
action_44 (59) = happyShift action_21
action_44 (65) = happyShift action_25
action_44 (66) = happyShift action_26
action_44 (68) = happyShift action_27
action_44 (69) = happyShift action_28
action_44 (74) = happyShift action_31
action_44 (75) = happyShift action_43
action_44 (77) = happyShift action_33
action_44 (78) = happyShift action_34
action_44 (82) = happyShift action_2
action_44 (83) = happyShift action_36
action_44 (84) = happyShift action_37
action_44 (4) = happyGoto action_40
action_44 (5) = happyGoto action_4
action_44 (6) = happyGoto action_5
action_44 (13) = happyGoto action_101
action_44 (16) = happyGoto action_41
action_44 (23) = happyGoto action_102
action_44 (24) = happyGoto action_11
action_44 (25) = happyGoto action_12
action_44 (26) = happyGoto action_13
action_44 (27) = happyGoto action_14
action_44 (28) = happyGoto action_15
action_44 (29) = happyGoto action_16
action_44 (30) = happyGoto action_17
action_44 _ = happyReduce_33

action_45 (38) = happyShift action_54
action_45 _ = happyReduce_78

action_46 (57) = happyShift action_20
action_46 (65) = happyShift action_25
action_46 (66) = happyShift action_100
action_46 (68) = happyShift action_27
action_46 (74) = happyShift action_31
action_46 (75) = happyShift action_43
action_46 (78) = happyShift action_34
action_46 (16) = happyGoto action_99
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (38) = happyShift action_98
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (38) = happyShift action_97
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (38) = happyShift action_18
action_49 (43) = happyShift action_19
action_49 (57) = happyShift action_20
action_49 (59) = happyShift action_21
action_49 (65) = happyShift action_25
action_49 (66) = happyShift action_26
action_49 (68) = happyShift action_27
action_49 (69) = happyShift action_28
action_49 (74) = happyShift action_31
action_49 (75) = happyShift action_43
action_49 (77) = happyShift action_33
action_49 (78) = happyShift action_34
action_49 (82) = happyShift action_2
action_49 (83) = happyShift action_36
action_49 (84) = happyShift action_37
action_49 (4) = happyGoto action_40
action_49 (5) = happyGoto action_4
action_49 (6) = happyGoto action_5
action_49 (16) = happyGoto action_41
action_49 (23) = happyGoto action_96
action_49 (24) = happyGoto action_11
action_49 (25) = happyGoto action_12
action_49 (26) = happyGoto action_13
action_49 (27) = happyGoto action_14
action_49 (28) = happyGoto action_15
action_49 (29) = happyGoto action_16
action_49 (30) = happyGoto action_17
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (38) = happyShift action_95
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (82) = happyShift action_2
action_51 (4) = happyGoto action_94
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (38) = happyShift action_54
action_52 _ = happyReduce_77

action_53 (39) = happyShift action_93
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (37) = happyShift action_92
action_54 (38) = happyShift action_18
action_54 (43) = happyShift action_19
action_54 (57) = happyShift action_20
action_54 (59) = happyShift action_21
action_54 (65) = happyShift action_25
action_54 (66) = happyShift action_26
action_54 (68) = happyShift action_27
action_54 (69) = happyShift action_28
action_54 (74) = happyShift action_31
action_54 (75) = happyShift action_43
action_54 (77) = happyShift action_33
action_54 (78) = happyShift action_34
action_54 (82) = happyShift action_2
action_54 (83) = happyShift action_36
action_54 (84) = happyShift action_37
action_54 (4) = happyGoto action_40
action_54 (5) = happyGoto action_4
action_54 (6) = happyGoto action_5
action_54 (16) = happyGoto action_41
action_54 (23) = happyGoto action_89
action_54 (24) = happyGoto action_11
action_54 (25) = happyGoto action_12
action_54 (26) = happyGoto action_13
action_54 (27) = happyGoto action_14
action_54 (28) = happyGoto action_15
action_54 (29) = happyGoto action_16
action_54 (30) = happyGoto action_17
action_54 (31) = happyGoto action_90
action_54 (32) = happyGoto action_91
action_54 _ = happyReduce_94

action_55 (56) = happyShift action_87
action_55 (67) = happyShift action_88
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (38) = happyShift action_18
action_56 (43) = happyShift action_19
action_56 (57) = happyShift action_20
action_56 (59) = happyShift action_21
action_56 (65) = happyShift action_25
action_56 (66) = happyShift action_26
action_56 (68) = happyShift action_27
action_56 (69) = happyShift action_28
action_56 (74) = happyShift action_31
action_56 (75) = happyShift action_43
action_56 (77) = happyShift action_33
action_56 (78) = happyShift action_34
action_56 (82) = happyShift action_2
action_56 (83) = happyShift action_36
action_56 (84) = happyShift action_37
action_56 (4) = happyGoto action_40
action_56 (5) = happyGoto action_4
action_56 (6) = happyGoto action_5
action_56 (16) = happyGoto action_41
action_56 (28) = happyGoto action_86
action_56 (29) = happyGoto action_16
action_56 (30) = happyGoto action_17
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_60

action_58 _ = happyReduce_58

action_59 _ = happyReduce_59

action_60 (38) = happyShift action_18
action_60 (43) = happyShift action_19
action_60 (57) = happyShift action_20
action_60 (59) = happyShift action_21
action_60 (65) = happyShift action_25
action_60 (66) = happyShift action_26
action_60 (68) = happyShift action_27
action_60 (69) = happyShift action_28
action_60 (74) = happyShift action_31
action_60 (75) = happyShift action_43
action_60 (77) = happyShift action_33
action_60 (78) = happyShift action_34
action_60 (82) = happyShift action_2
action_60 (83) = happyShift action_36
action_60 (84) = happyShift action_37
action_60 (4) = happyGoto action_40
action_60 (5) = happyGoto action_4
action_60 (6) = happyGoto action_5
action_60 (16) = happyGoto action_41
action_60 (27) = happyGoto action_85
action_60 (28) = happyGoto action_15
action_60 (29) = happyGoto action_16
action_60 (30) = happyGoto action_17
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_56

action_62 _ = happyReduce_57

action_63 (38) = happyShift action_18
action_63 (43) = happyShift action_19
action_63 (57) = happyShift action_20
action_63 (59) = happyShift action_21
action_63 (65) = happyShift action_25
action_63 (66) = happyShift action_26
action_63 (68) = happyShift action_27
action_63 (69) = happyShift action_28
action_63 (74) = happyShift action_31
action_63 (75) = happyShift action_43
action_63 (77) = happyShift action_33
action_63 (78) = happyShift action_34
action_63 (82) = happyShift action_2
action_63 (83) = happyShift action_36
action_63 (84) = happyShift action_37
action_63 (4) = happyGoto action_40
action_63 (5) = happyGoto action_4
action_63 (6) = happyGoto action_5
action_63 (16) = happyGoto action_41
action_63 (26) = happyGoto action_84
action_63 (27) = happyGoto action_14
action_63 (28) = happyGoto action_15
action_63 (29) = happyGoto action_16
action_63 (30) = happyGoto action_17
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_66

action_65 _ = happyReduce_61

action_66 _ = happyReduce_62

action_67 _ = happyReduce_65

action_68 _ = happyReduce_63

action_69 _ = happyReduce_64

action_70 (38) = happyShift action_18
action_70 (43) = happyShift action_19
action_70 (57) = happyShift action_20
action_70 (59) = happyShift action_21
action_70 (65) = happyShift action_25
action_70 (66) = happyShift action_26
action_70 (68) = happyShift action_27
action_70 (69) = happyShift action_28
action_70 (74) = happyShift action_31
action_70 (75) = happyShift action_43
action_70 (77) = happyShift action_33
action_70 (78) = happyShift action_34
action_70 (82) = happyShift action_2
action_70 (83) = happyShift action_36
action_70 (84) = happyShift action_37
action_70 (4) = happyGoto action_40
action_70 (5) = happyGoto action_4
action_70 (6) = happyGoto action_5
action_70 (16) = happyGoto action_41
action_70 (24) = happyGoto action_83
action_70 (25) = happyGoto action_12
action_70 (26) = happyGoto action_13
action_70 (27) = happyGoto action_14
action_70 (28) = happyGoto action_15
action_70 (29) = happyGoto action_16
action_70 (30) = happyGoto action_17
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (38) = happyShift action_18
action_71 (43) = happyShift action_19
action_71 (57) = happyShift action_20
action_71 (59) = happyShift action_21
action_71 (65) = happyShift action_25
action_71 (66) = happyShift action_26
action_71 (68) = happyShift action_27
action_71 (69) = happyShift action_28
action_71 (74) = happyShift action_31
action_71 (75) = happyShift action_43
action_71 (77) = happyShift action_33
action_71 (78) = happyShift action_34
action_71 (82) = happyShift action_2
action_71 (83) = happyShift action_36
action_71 (84) = happyShift action_37
action_71 (4) = happyGoto action_40
action_71 (5) = happyGoto action_4
action_71 (6) = happyGoto action_5
action_71 (16) = happyGoto action_41
action_71 (23) = happyGoto action_82
action_71 (24) = happyGoto action_11
action_71 (25) = happyGoto action_12
action_71 (26) = happyGoto action_13
action_71 (27) = happyGoto action_14
action_71 (28) = happyGoto action_15
action_71 (29) = happyGoto action_16
action_71 (30) = happyGoto action_17
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (50) = happyShift action_81
action_72 _ = happyReduce_26

action_73 _ = happyReduce_12

action_74 _ = happyReduce_88

action_75 (38) = happyShift action_18
action_75 (43) = happyShift action_19
action_75 (57) = happyShift action_20
action_75 (59) = happyShift action_21
action_75 (60) = happyShift action_22
action_75 (62) = happyShift action_23
action_75 (63) = happyShift action_24
action_75 (65) = happyShift action_25
action_75 (66) = happyShift action_26
action_75 (68) = happyShift action_27
action_75 (69) = happyShift action_28
action_75 (71) = happyShift action_29
action_75 (73) = happyShift action_30
action_75 (74) = happyShift action_31
action_75 (75) = happyShift action_32
action_75 (77) = happyShift action_33
action_75 (78) = happyShift action_34
action_75 (79) = happyShift action_35
action_75 (81) = happyReduce_9
action_75 (82) = happyShift action_2
action_75 (83) = happyShift action_36
action_75 (84) = happyShift action_37
action_75 (85) = happyReduce_9
action_75 (4) = happyGoto action_3
action_75 (5) = happyGoto action_4
action_75 (6) = happyGoto action_5
action_75 (9) = happyGoto action_80
action_75 (10) = happyGoto action_8
action_75 (16) = happyGoto action_9
action_75 (23) = happyGoto action_10
action_75 (24) = happyGoto action_11
action_75 (25) = happyGoto action_12
action_75 (26) = happyGoto action_13
action_75 (27) = happyGoto action_14
action_75 (28) = happyGoto action_15
action_75 (29) = happyGoto action_16
action_75 (30) = happyGoto action_17
action_75 _ = happyReduce_9

action_76 (72) = happyShift action_79
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (38) = happyShift action_18
action_77 (43) = happyShift action_19
action_77 (57) = happyShift action_20
action_77 (59) = happyShift action_21
action_77 (65) = happyShift action_25
action_77 (66) = happyShift action_26
action_77 (68) = happyShift action_27
action_77 (69) = happyShift action_28
action_77 (74) = happyShift action_31
action_77 (75) = happyShift action_43
action_77 (77) = happyShift action_33
action_77 (78) = happyShift action_34
action_77 (82) = happyShift action_2
action_77 (83) = happyShift action_36
action_77 (84) = happyShift action_37
action_77 (4) = happyGoto action_40
action_77 (5) = happyGoto action_4
action_77 (6) = happyGoto action_5
action_77 (16) = happyGoto action_41
action_77 (23) = happyGoto action_78
action_77 (24) = happyGoto action_11
action_77 (25) = happyGoto action_12
action_77 (26) = happyGoto action_13
action_77 (27) = happyGoto action_14
action_77 (28) = happyGoto action_15
action_77 (29) = happyGoto action_16
action_77 (30) = happyGoto action_17
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_22

action_79 (38) = happyShift action_130
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (81) = happyReduce_11
action_80 (85) = happyReduce_11
action_80 _ = happyReduce_11

action_81 (38) = happyShift action_18
action_81 (43) = happyShift action_19
action_81 (57) = happyShift action_20
action_81 (59) = happyShift action_21
action_81 (65) = happyShift action_25
action_81 (66) = happyShift action_26
action_81 (68) = happyShift action_27
action_81 (69) = happyShift action_28
action_81 (74) = happyShift action_31
action_81 (75) = happyShift action_43
action_81 (77) = happyShift action_33
action_81 (78) = happyShift action_34
action_81 (82) = happyShift action_2
action_81 (83) = happyShift action_36
action_81 (84) = happyShift action_37
action_81 (4) = happyGoto action_40
action_81 (5) = happyGoto action_4
action_81 (6) = happyGoto action_5
action_81 (16) = happyGoto action_41
action_81 (23) = happyGoto action_129
action_81 (24) = happyGoto action_11
action_81 (25) = happyGoto action_12
action_81 (26) = happyGoto action_13
action_81 (27) = happyGoto action_14
action_81 (28) = happyGoto action_15
action_81 (29) = happyGoto action_16
action_81 (30) = happyGoto action_17
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_67

action_83 _ = happyReduce_69

action_84 (41) = happyShift action_61
action_84 (43) = happyShift action_62
action_84 (20) = happyGoto action_60
action_84 _ = happyReduce_71

action_85 (36) = happyShift action_57
action_85 (40) = happyShift action_58
action_85 (46) = happyShift action_59
action_85 (21) = happyGoto action_56
action_85 _ = happyReduce_73

action_86 _ = happyReduce_75

action_87 (38) = happyShift action_128
action_87 _ = happyFail (happyExpListPerState 87)

action_88 _ = happyReduce_80

action_89 _ = happyReduce_92

action_90 (42) = happyShift action_127
action_90 _ = happyReduce_95

action_91 (39) = happyShift action_126
action_91 _ = happyFail (happyExpListPerState 91)

action_92 (82) = happyShift action_2
action_92 (4) = happyGoto action_125
action_92 _ = happyFail (happyExpListPerState 92)

action_93 _ = happyReduce_91

action_94 (61) = happyShift action_123
action_94 (64) = happyShift action_124
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (37) = happyShift action_122
action_95 (57) = happyShift action_20
action_95 (65) = happyShift action_25
action_95 (66) = happyShift action_100
action_95 (68) = happyShift action_27
action_95 (74) = happyShift action_31
action_95 (75) = happyShift action_43
action_95 (78) = happyShift action_34
action_95 (14) = happyGoto action_119
action_95 (15) = happyGoto action_120
action_95 (16) = happyGoto action_121
action_95 _ = happyReduce_38

action_96 (39) = happyShift action_118
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (37) = happyShift action_116
action_97 (57) = happyShift action_20
action_97 (65) = happyShift action_25
action_97 (66) = happyShift action_100
action_97 (68) = happyShift action_27
action_97 (74) = happyShift action_31
action_97 (75) = happyShift action_43
action_97 (78) = happyShift action_34
action_97 (16) = happyGoto action_113
action_97 (18) = happyGoto action_114
action_97 (19) = happyGoto action_117
action_97 _ = happyReduce_53

action_98 (37) = happyShift action_116
action_98 (57) = happyShift action_20
action_98 (65) = happyShift action_25
action_98 (66) = happyShift action_100
action_98 (68) = happyShift action_27
action_98 (74) = happyShift action_31
action_98 (75) = happyShift action_43
action_98 (78) = happyShift action_34
action_98 (16) = happyGoto action_113
action_98 (18) = happyGoto action_114
action_98 (19) = happyGoto action_115
action_98 _ = happyReduce_53

action_99 (52) = happyShift action_112
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (48) = happyShift action_48
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (39) = happyShift action_111
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (39) = happyReduce_34
action_102 (42) = happyShift action_110
action_102 _ = happyReduce_34

action_103 _ = happyReduce_46

action_104 (57) = happyShift action_20
action_104 (65) = happyShift action_25
action_104 (66) = happyShift action_100
action_104 (68) = happyShift action_27
action_104 (74) = happyShift action_31
action_104 (75) = happyShift action_43
action_104 (78) = happyShift action_34
action_104 (16) = happyGoto action_107
action_104 (33) = happyGoto action_108
action_104 (34) = happyGoto action_109
action_104 _ = happyReduce_98

action_105 (39) = happyShift action_106
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (80) = happyShift action_141
action_106 (8) = happyGoto action_150
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (82) = happyShift action_2
action_107 (4) = happyGoto action_149
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (47) = happyShift action_148
action_108 _ = happyReduce_99

action_109 (81) = happyShift action_147
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (38) = happyShift action_18
action_110 (39) = happyReduce_33
action_110 (43) = happyShift action_19
action_110 (57) = happyShift action_20
action_110 (59) = happyShift action_21
action_110 (65) = happyShift action_25
action_110 (66) = happyShift action_26
action_110 (68) = happyShift action_27
action_110 (69) = happyShift action_28
action_110 (74) = happyShift action_31
action_110 (75) = happyShift action_43
action_110 (77) = happyShift action_33
action_110 (78) = happyShift action_34
action_110 (82) = happyShift action_2
action_110 (83) = happyShift action_36
action_110 (84) = happyShift action_37
action_110 (4) = happyGoto action_40
action_110 (5) = happyGoto action_4
action_110 (6) = happyGoto action_5
action_110 (13) = happyGoto action_146
action_110 (16) = happyGoto action_41
action_110 (23) = happyGoto action_102
action_110 (24) = happyGoto action_11
action_110 (25) = happyGoto action_12
action_110 (26) = happyGoto action_13
action_110 (27) = happyGoto action_14
action_110 (28) = happyGoto action_15
action_110 (29) = happyGoto action_16
action_110 (30) = happyGoto action_17
action_110 _ = happyReduce_33

action_111 _ = happyReduce_19

action_112 _ = happyReduce_45

action_113 _ = happyReduce_51

action_114 (42) = happyShift action_145
action_114 _ = happyReduce_54

action_115 (39) = happyShift action_144
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (57) = happyShift action_20
action_116 (65) = happyShift action_25
action_116 (66) = happyShift action_100
action_116 (68) = happyShift action_27
action_116 (74) = happyShift action_31
action_116 (75) = happyShift action_43
action_116 (78) = happyShift action_34
action_116 (16) = happyGoto action_143
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (39) = happyShift action_142
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (80) = happyShift action_141
action_118 (8) = happyGoto action_140
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (42) = happyShift action_139
action_119 _ = happyReduce_39

action_120 (39) = happyShift action_138
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (82) = happyShift action_2
action_121 (4) = happyGoto action_137
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (57) = happyShift action_20
action_122 (65) = happyShift action_25
action_122 (66) = happyShift action_100
action_122 (68) = happyShift action_27
action_122 (74) = happyShift action_31
action_122 (75) = happyShift action_43
action_122 (78) = happyShift action_34
action_122 (16) = happyGoto action_136
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (38) = happyShift action_18
action_123 (43) = happyShift action_19
action_123 (57) = happyShift action_20
action_123 (59) = happyShift action_21
action_123 (65) = happyShift action_25
action_123 (66) = happyShift action_26
action_123 (68) = happyShift action_27
action_123 (69) = happyShift action_28
action_123 (74) = happyShift action_31
action_123 (75) = happyShift action_43
action_123 (77) = happyShift action_33
action_123 (78) = happyShift action_34
action_123 (82) = happyShift action_2
action_123 (83) = happyShift action_36
action_123 (84) = happyShift action_37
action_123 (4) = happyGoto action_40
action_123 (5) = happyGoto action_4
action_123 (6) = happyGoto action_5
action_123 (16) = happyGoto action_41
action_123 (23) = happyGoto action_135
action_123 (24) = happyGoto action_11
action_123 (25) = happyGoto action_12
action_123 (26) = happyGoto action_13
action_123 (27) = happyGoto action_14
action_123 (28) = happyGoto action_15
action_123 (29) = happyGoto action_16
action_123 (30) = happyGoto action_17
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (38) = happyShift action_18
action_124 (43) = happyShift action_19
action_124 (57) = happyShift action_20
action_124 (59) = happyShift action_21
action_124 (65) = happyShift action_25
action_124 (66) = happyShift action_26
action_124 (68) = happyShift action_27
action_124 (69) = happyShift action_28
action_124 (74) = happyShift action_31
action_124 (75) = happyShift action_43
action_124 (77) = happyShift action_33
action_124 (78) = happyShift action_34
action_124 (82) = happyShift action_2
action_124 (83) = happyShift action_36
action_124 (84) = happyShift action_37
action_124 (4) = happyGoto action_40
action_124 (5) = happyGoto action_4
action_124 (6) = happyGoto action_5
action_124 (16) = happyGoto action_41
action_124 (23) = happyGoto action_134
action_124 (24) = happyGoto action_11
action_124 (25) = happyGoto action_12
action_124 (26) = happyGoto action_13
action_124 (27) = happyGoto action_14
action_124 (28) = happyGoto action_15
action_124 (29) = happyGoto action_16
action_124 (30) = happyGoto action_17
action_124 _ = happyFail (happyExpListPerState 124)

action_125 _ = happyReduce_93

action_126 _ = happyReduce_82

action_127 (37) = happyShift action_92
action_127 (38) = happyShift action_18
action_127 (43) = happyShift action_19
action_127 (57) = happyShift action_20
action_127 (59) = happyShift action_21
action_127 (65) = happyShift action_25
action_127 (66) = happyShift action_26
action_127 (68) = happyShift action_27
action_127 (69) = happyShift action_28
action_127 (74) = happyShift action_31
action_127 (75) = happyShift action_43
action_127 (77) = happyShift action_33
action_127 (78) = happyShift action_34
action_127 (82) = happyShift action_2
action_127 (83) = happyShift action_36
action_127 (84) = happyShift action_37
action_127 (4) = happyGoto action_40
action_127 (5) = happyGoto action_4
action_127 (6) = happyGoto action_5
action_127 (16) = happyGoto action_41
action_127 (23) = happyGoto action_89
action_127 (24) = happyGoto action_11
action_127 (25) = happyGoto action_12
action_127 (26) = happyGoto action_13
action_127 (27) = happyGoto action_14
action_127 (28) = happyGoto action_15
action_127 (29) = happyGoto action_16
action_127 (30) = happyGoto action_17
action_127 (31) = happyGoto action_90
action_127 (32) = happyGoto action_133
action_127 _ = happyReduce_94

action_128 (38) = happyShift action_18
action_128 (57) = happyShift action_20
action_128 (59) = happyShift action_21
action_128 (65) = happyShift action_25
action_128 (66) = happyShift action_26
action_128 (68) = happyShift action_27
action_128 (74) = happyShift action_31
action_128 (75) = happyShift action_43
action_128 (77) = happyShift action_33
action_128 (78) = happyShift action_34
action_128 (82) = happyShift action_2
action_128 (83) = happyShift action_36
action_128 (84) = happyShift action_37
action_128 (4) = happyGoto action_40
action_128 (5) = happyGoto action_4
action_128 (6) = happyGoto action_5
action_128 (16) = happyGoto action_41
action_128 (29) = happyGoto action_132
action_128 (30) = happyGoto action_17
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_27

action_130 (38) = happyShift action_18
action_130 (43) = happyShift action_19
action_130 (57) = happyShift action_20
action_130 (59) = happyShift action_21
action_130 (65) = happyShift action_25
action_130 (66) = happyShift action_26
action_130 (68) = happyShift action_27
action_130 (69) = happyShift action_28
action_130 (74) = happyShift action_31
action_130 (75) = happyShift action_43
action_130 (77) = happyShift action_33
action_130 (78) = happyShift action_34
action_130 (82) = happyShift action_2
action_130 (83) = happyShift action_36
action_130 (84) = happyShift action_37
action_130 (4) = happyGoto action_40
action_130 (5) = happyGoto action_4
action_130 (6) = happyGoto action_5
action_130 (16) = happyGoto action_41
action_130 (23) = happyGoto action_131
action_130 (24) = happyGoto action_11
action_130 (25) = happyGoto action_12
action_130 (26) = happyGoto action_13
action_130 (27) = happyGoto action_14
action_130 (28) = happyGoto action_15
action_130 (29) = happyGoto action_16
action_130 (30) = happyGoto action_17
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (39) = happyShift action_163
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (38) = happyShift action_54
action_132 (39) = happyShift action_162
action_132 _ = happyFail (happyExpListPerState 132)

action_133 _ = happyReduce_96

action_134 (39) = happyShift action_161
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (76) = happyShift action_160
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (82) = happyShift action_2
action_136 (4) = happyGoto action_159
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_36

action_138 (44) = happyShift action_158
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (37) = happyShift action_122
action_139 (57) = happyShift action_20
action_139 (65) = happyShift action_25
action_139 (66) = happyShift action_100
action_139 (68) = happyShift action_27
action_139 (74) = happyShift action_31
action_139 (75) = happyShift action_43
action_139 (78) = happyShift action_34
action_139 (14) = happyGoto action_119
action_139 (15) = happyGoto action_157
action_139 (16) = happyGoto action_121
action_139 _ = happyReduce_38

action_140 (58) = happyShift action_156
action_140 _ = happyReduce_14

action_141 (38) = happyShift action_18
action_141 (43) = happyShift action_19
action_141 (57) = happyShift action_20
action_141 (59) = happyShift action_21
action_141 (60) = happyShift action_22
action_141 (62) = happyShift action_23
action_141 (63) = happyShift action_24
action_141 (65) = happyShift action_25
action_141 (66) = happyShift action_26
action_141 (68) = happyShift action_27
action_141 (69) = happyShift action_28
action_141 (71) = happyShift action_29
action_141 (73) = happyShift action_30
action_141 (74) = happyShift action_31
action_141 (75) = happyShift action_32
action_141 (77) = happyShift action_33
action_141 (78) = happyShift action_34
action_141 (79) = happyShift action_35
action_141 (81) = happyReduce_9
action_141 (82) = happyShift action_2
action_141 (83) = happyShift action_36
action_141 (84) = happyShift action_37
action_141 (4) = happyGoto action_3
action_141 (5) = happyGoto action_4
action_141 (6) = happyGoto action_5
action_141 (9) = happyGoto action_155
action_141 (10) = happyGoto action_8
action_141 (16) = happyGoto action_9
action_141 (23) = happyGoto action_10
action_141 (24) = happyGoto action_11
action_141 (25) = happyGoto action_12
action_141 (26) = happyGoto action_13
action_141 (27) = happyGoto action_14
action_141 (28) = happyGoto action_15
action_141 (29) = happyGoto action_16
action_141 (30) = happyGoto action_17
action_141 _ = happyReduce_9

action_142 (44) = happyShift action_154
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_52

action_144 (44) = happyShift action_153
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (37) = happyShift action_116
action_145 (57) = happyShift action_20
action_145 (65) = happyShift action_25
action_145 (66) = happyShift action_100
action_145 (68) = happyShift action_27
action_145 (74) = happyShift action_31
action_145 (75) = happyShift action_43
action_145 (78) = happyShift action_34
action_145 (16) = happyGoto action_113
action_145 (18) = happyGoto action_114
action_145 (19) = happyGoto action_152
action_145 _ = happyReduce_53

action_146 (39) = happyReduce_35
action_146 _ = happyReduce_35

action_147 _ = happyReduce_25

action_148 (57) = happyShift action_20
action_148 (65) = happyShift action_25
action_148 (66) = happyShift action_100
action_148 (68) = happyShift action_27
action_148 (74) = happyShift action_31
action_148 (75) = happyShift action_43
action_148 (78) = happyShift action_34
action_148 (16) = happyGoto action_107
action_148 (33) = happyGoto action_108
action_148 (34) = happyGoto action_151
action_148 _ = happyReduce_98

action_149 _ = happyReduce_97

action_150 _ = happyReduce_16

action_151 _ = happyReduce_100

action_152 _ = happyReduce_55

action_153 (57) = happyShift action_20
action_153 (65) = happyShift action_25
action_153 (66) = happyShift action_100
action_153 (68) = happyShift action_27
action_153 (74) = happyShift action_31
action_153 (75) = happyShift action_43
action_153 (78) = happyShift action_34
action_153 (16) = happyGoto action_170
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (57) = happyShift action_20
action_154 (65) = happyShift action_25
action_154 (66) = happyShift action_100
action_154 (68) = happyShift action_27
action_154 (74) = happyShift action_31
action_154 (75) = happyShift action_43
action_154 (78) = happyShift action_34
action_154 (16) = happyGoto action_169
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (81) = happyShift action_168
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (80) = happyShift action_141
action_156 (8) = happyGoto action_167
action_156 _ = happyFail (happyExpListPerState 156)

action_157 _ = happyReduce_40

action_158 (57) = happyShift action_20
action_158 (65) = happyShift action_25
action_158 (66) = happyShift action_100
action_158 (68) = happyShift action_27
action_158 (74) = happyShift action_31
action_158 (75) = happyShift action_43
action_158 (78) = happyShift action_34
action_158 (16) = happyGoto action_166
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_37

action_160 (38) = happyShift action_18
action_160 (43) = happyShift action_19
action_160 (57) = happyShift action_20
action_160 (59) = happyShift action_21
action_160 (65) = happyShift action_25
action_160 (66) = happyShift action_26
action_160 (68) = happyShift action_27
action_160 (69) = happyShift action_28
action_160 (74) = happyShift action_31
action_160 (75) = happyShift action_43
action_160 (77) = happyShift action_33
action_160 (78) = happyShift action_34
action_160 (82) = happyShift action_2
action_160 (83) = happyShift action_36
action_160 (84) = happyShift action_37
action_160 (4) = happyGoto action_40
action_160 (5) = happyGoto action_4
action_160 (6) = happyGoto action_5
action_160 (16) = happyGoto action_41
action_160 (23) = happyGoto action_165
action_160 (24) = happyGoto action_11
action_160 (25) = happyGoto action_12
action_160 (26) = happyGoto action_13
action_160 (27) = happyGoto action_14
action_160 (28) = happyGoto action_15
action_160 (29) = happyGoto action_16
action_160 (30) = happyGoto action_17
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (80) = happyShift action_141
action_161 (8) = happyGoto action_164
action_161 _ = happyFail (happyExpListPerState 161)

action_162 _ = happyReduce_81

action_163 _ = happyReduce_24

action_164 _ = happyReduce_18

action_165 (39) = happyShift action_174
action_165 _ = happyFail (happyExpListPerState 165)

action_166 (80) = happyShift action_141
action_166 (8) = happyGoto action_173
action_166 _ = happyFail (happyExpListPerState 166)

action_167 _ = happyReduce_15

action_168 _ = happyReduce_5

action_169 (52) = happyShift action_172
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (80) = happyShift action_141
action_170 (8) = happyGoto action_171
action_170 _ = happyFail (happyExpListPerState 170)

action_171 _ = happyReduce_90

action_172 _ = happyReduce_47

action_173 _ = happyReduce_23

action_174 (80) = happyShift action_141
action_174 (8) = happyGoto action_175
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_17

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
	(HappyAbsSyn34  happy_var_4) `HappyStk`
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
	(HappyAbsSyn32  happy_var_3) `HappyStk`
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

happyReduce_90 = happyReduce 8 30 happyReduction_90
happyReduction_90 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	(HappyAbsSyn16  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (Grammar.Abs.ELambda happy_var_2 happy_var_4 happy_var_7 happy_var_8
	) `HappyStk` happyRest

happyReduce_91 = happySpecReduce_3  30 happyReduction_91
happyReduction_91 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (happy_var_2
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  31 happyReduction_92
happyReduction_92 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn31
		 (Grammar.Abs.EorRExpr happy_var_1
	)
happyReduction_92 _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_2  31 happyReduction_93
happyReduction_93 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn31
		 (Grammar.Abs.EorRRef happy_var_2
	)
happyReduction_93 _ _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_0  32 happyReduction_94
happyReduction_94  =  HappyAbsSyn32
		 ([]
	)

happyReduce_95 = happySpecReduce_1  32 happyReduction_95
happyReduction_95 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 ((:[]) happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_3  32 happyReduction_96
happyReduction_96 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_96 _ _ _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_2  33 happyReduction_97
happyReduction_97 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn33
		 (Grammar.Abs.StructItem happy_var_1 happy_var_2
	)
happyReduction_97 _ _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_0  34 happyReduction_98
happyReduction_98  =  HappyAbsSyn34
		 ([]
	)

happyReduce_99 = happySpecReduce_1  34 happyReduction_99
happyReduction_99 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn34
		 ((:[]) happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_3  34 happyReduction_100
happyReduction_100 (HappyAbsSyn34  happy_var_3)
	_
	(HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn34
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_100 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 85 85 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS _ 1) -> cont 35;
	PT _ (TS _ 2) -> cont 36;
	PT _ (TS _ 3) -> cont 37;
	PT _ (TS _ 4) -> cont 38;
	PT _ (TS _ 5) -> cont 39;
	PT _ (TS _ 6) -> cont 40;
	PT _ (TS _ 7) -> cont 41;
	PT _ (TS _ 8) -> cont 42;
	PT _ (TS _ 9) -> cont 43;
	PT _ (TS _ 10) -> cont 44;
	PT _ (TS _ 11) -> cont 45;
	PT _ (TS _ 12) -> cont 46;
	PT _ (TS _ 13) -> cont 47;
	PT _ (TS _ 14) -> cont 48;
	PT _ (TS _ 15) -> cont 49;
	PT _ (TS _ 16) -> cont 50;
	PT _ (TS _ 17) -> cont 51;
	PT _ (TS _ 18) -> cont 52;
	PT _ (TS _ 19) -> cont 53;
	PT _ (TS _ 20) -> cont 54;
	PT _ (TS _ 21) -> cont 55;
	PT _ (TS _ 22) -> cont 56;
	PT _ (TS _ 23) -> cont 57;
	PT _ (TS _ 24) -> cont 58;
	PT _ (TS _ 25) -> cont 59;
	PT _ (TS _ 26) -> cont 60;
	PT _ (TS _ 27) -> cont 61;
	PT _ (TS _ 28) -> cont 62;
	PT _ (TS _ 29) -> cont 63;
	PT _ (TS _ 30) -> cont 64;
	PT _ (TS _ 31) -> cont 65;
	PT _ (TS _ 32) -> cont 66;
	PT _ (TS _ 33) -> cont 67;
	PT _ (TS _ 34) -> cont 68;
	PT _ (TS _ 35) -> cont 69;
	PT _ (TS _ 36) -> cont 70;
	PT _ (TS _ 37) -> cont 71;
	PT _ (TS _ 38) -> cont 72;
	PT _ (TS _ 39) -> cont 73;
	PT _ (TS _ 40) -> cont 74;
	PT _ (TS _ 41) -> cont 75;
	PT _ (TS _ 42) -> cont 76;
	PT _ (TS _ 43) -> cont 77;
	PT _ (TS _ 44) -> cont 78;
	PT _ (TS _ 45) -> cont 79;
	PT _ (TS _ 46) -> cont 80;
	PT _ (TS _ 47) -> cont 81;
	PT _ (TV happy_dollar_dollar) -> cont 82;
	PT _ (TI happy_dollar_dollar) -> cont 83;
	PT _ (TL happy_dollar_dollar) -> cont 84;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 85 tk tks = happyError' (tks, explist)
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
