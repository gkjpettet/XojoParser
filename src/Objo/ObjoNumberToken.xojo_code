#tag Class
Protected Class ObjoNumberToken
Inherits ObjoToken
	#tag Method, Flags = &h0
		Sub Constructor(start As Integer, lineNumber As Integer, lineNumberStartPos As Integer, value As Double)
		  Self.Type = Objo.TokenTypes.Number
		  Self.AbsStartPosition = start
		  Self.LineNumber = lineNumber
		  Self.LineNumberStartPos = lineNumberStartPos
		  Self.Value = value
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206E756D657269632076616C7565206F662074686973206E756D62657220746F6B656E2E
		Value As Double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AbsStartPosition"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumber"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartPosition"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Lexeme"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Text"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="Objo.TokenTypes.EOF"
			Type="Objo.TokenTypes"
			EditorType=""
			#tag EnumValues
				"0 - Ampersand"
				"1 - AmpersandEqual"
				"2 - Bang"
				"3 - BooleanFalse"
				"4 - BooleanTrue"
				"5 - Caret"
				"6 - CaretEqual"
				"7 - Colon"
				"8 - Comma"
				"9 - Directive"
				"10 - Dot"
				"11 - EOF"
				"12 - EOL"
				"13 - Equal"
				"14 - EqualEqual"
				"15 - ForwardSlash"
				"16 - ForwardSlashEqual"
				"17 - Greater"
				"18 - GreaterGreater"
				"19 - GreaterEqual"
				"20 - GreaterGreaterEqual"
				"21 - Identifier"
				"22 - KeywordAbstract"
				"23 - KeywordAnd"
				"24 - KeywordAs"
				"25 - KeywordAssert"
				"26 - KeywordAsync"
				"27 - KeywordAwait"
				"28 - KeywordBreak"
				"29 - KeywordCase"
				"30 - KeywordCatch"
				"31 - KeywordClass"
				"32 - KeywordConst"
				"33 - KeywordConstructor"
				"34 - KeywordContinue"
				"35 - KeywordDefault"
				"36 - KeywordDo"
				"37 - KeywordDownTo"
				"38 - KeywordElse"
				"39 - KeywordElseIf"
				"40 - KeywordEnd"
				"41 - KeywordEnum"
				"42 - KeywordExit"
				"43 - KeywordExtends"
				"44 - KeywordExtension"
				"45 - KeywordFinal"
				"46 - KeywordFinally"
				"47 - KeywordFor"
				"48 - KeywordFunction"
				"49 - KeywordGet"
				"50 - KeywordIf"
				"51 - KeywordImplements"
				"52 - KeywordIn"
				"53 - KeywordIs"
				"54 - KeywordIsnt"
				"55 - KeywordLate"
				"56 - KeywordMixin"
				"57 - KeywordNew"
				"58 - KeywordNext"
				"59 - KeywordNot"
				"60 - KeywordOn"
				"61 - KeywordOperator"
				"62 - KeywordOptional"
				"63 - KeywordOr"
				"64 - KeywordRequired"
				"65 - KeywordRethrow"
				"66 - KeywordReturn"
				"67 - KeywordSelect"
				"68 - KeywordSet"
				"69 - KeywordStatic"
				"70 - KeywordStep"
				"71 - KeywordSub"
				"72 - KeywordSuper"
				"73 - KeywordThen"
				"74 - KeywordThis"
				"75 - KeywordThrow"
				"76 - KeywordTo"
				"77 - KeywordTry"
				"78 - KeywordUntil"
				"79 - KeywordVar"
				"80 - KeywordWend"
				"81 - KeywordWhile"
				"82 - KeywordWith"
				"83 - KeywordXor"
				"84 - LCurly"
				"85 - Less"
				"86 - LessEqual"
				"87 - LessGreater"
				"88 - LessLess"
				"89 - LessLessEqual"
				"90 - LexerError"
				"91 - LParen"
				"92 - LSquare"
				"93 - Minus"
				"94 - MinusEqual"
				"95 - MinusMinus"
				"96 - NoToken"
				"97 - Number"
				"98 - Null"
				"99 - Percent"
				"100 - PercentEqual"
				"101 - Pipe"
				"102 - PipeEqual"
				"103 - Plus"
				"104 - PlusEqual"
				"105 - PlusPlus"
				"106 - Query"
				"107 - QueryDot"
				"108 - QueryQuery"
				"109 - QueryQueryEqual"
				"110 - RCurly"
				"111 - RParen"
				"112 - RSquare"
				"113 - Star"
				"114 - StarEqual"
				"115 - StringLiteral"
				"116 - Tilde"
				"117 - TildeEqual"
				"118 - TildeForwardSlash"
				"119 - TildeForwardSlashEqual"
				"120 - Underscore"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
