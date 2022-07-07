#tag Module
Protected Module Objo
	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F6620616E204F626A6F20746F6B656E20747970652E
		Function ToString(Extends type As Objo.TokenTypes) As String
		  /// Returns a string representation of an Objo token type.
		  
		  Select Case type
		  Case TokenTypes.Ampersand
		    Return "Ampersand"
		    
		  Case TokenTypes.AmpersandEqual
		    Return "AmpersandEqual"
		    
		  Case TokenTypes.Bang
		    Return "Bang"
		    
		  Case TokenTypes.BooleanFalse
		    Return "False"
		    
		  Case TokenTypes.BooleanTrue
		    Return "True"
		    
		  Case TokenTypes.Caret
		    Return "Caret"
		    
		  Case TokenTypes.CaretEqual
		    Return "CaretEqual"
		    
		  Case TokenTypes.Colon
		    Return "Colon"
		    
		  Case TokenTypes.Comma
		    Return "Comma"
		    
		  Case TokenTypes.Directive
		    Return "Directive"
		    
		  Case TokenTypes.Dot
		    Return "Dot"
		    
		  Case TokenTypes.EOF
		    Return "EOF"
		    
		  Case TokenTypes.EOL
		    Return "EOL"
		    
		  Case TokenTypes.Equal
		    Return "Equal"
		    
		  Case TokenTypes.EqualEqual
		    Return "EqualEqual"
		    
		  Case TokenTypes.ForwardSlash
		    Return "ForwardSlash"
		    
		  Case TokenTypes.ForwardSlashEqual
		    Return "ForwardSlashEqual"
		    
		  Case TokenTypes.Greater
		    Return "Greater"
		    
		  Case TokenTypes.GreaterGreater
		    Return "GreaterGreater"
		    
		  Case TokenTypes.GreaterEqual
		    Return "GreaterEqual"
		    
		  Case TokenTypes.GreaterGreaterEqual
		    Return "GreaterGreaterEqual"
		    
		  Case TokenTypes.Identifier
		    Return "Identifier"
		    
		  Case TokenTypes.KeywordAbstract
		    Return "Abstract"
		    
		  Case TokenTypes.KeywordAnd
		    Return "And"
		    
		  Case TokenTypes.KeywordAs
		    Return "As"
		    
		  Case TokenTypes.KeywordAssert
		    Return "Assert"
		    
		  Case TokenTypes.KeywordAsync
		    Return "Async"
		    
		  Case TokenTypes.KeywordAwait
		    Return "Await"
		    
		  Case TokenTypes.KeywordBreak
		    Return "Break"
		    
		  Case TokenTypes.KeywordCase
		    Return "Case"
		    
		  Case TokenTypes.KeywordCatch
		    Return "Catch"
		    
		  Case TokenTypes.KeywordClass
		    Return "Class"
		    
		  Case TokenTypes.KeywordConst
		    Return "Const"
		    
		  Case TokenTypes.KeywordConstructor
		    Return "Constructor"
		    
		  Case TokenTypes.KeywordContinue
		    Return "Continue"
		    
		  Case TokenTypes.KeywordDefault
		    Return "Default"
		    
		  Case TokenTypes.KeywordDo
		    Return "Do"
		    
		  Case TokenTypes.KeywordDownTo
		    Return "DownTo"
		    
		  Case TokenTypes.KeywordElse
		    Return "Else"
		    
		  Case TokenTypes.KeywordElseIf
		    Return "ElseIf"
		    
		  Case TokenTypes.KeywordEnd
		    Return "End"
		    
		  Case TokenTypes.KeywordEnum
		    Return "Enum"
		    
		  Case TokenTypes.KeywordExit
		    Return "Exit"
		    
		  Case TokenTypes.KeywordExtends
		    Return "Extends"
		    
		  Case TokenTypes.KeywordExtension
		    Return "Extension"
		    
		  Case TokenTypes.KeywordFinal
		    Return "Final"
		    
		  Case TokenTypes.KeywordFinally
		    Return "Finally"
		    
		  Case TokenTypes.KeywordFor
		    Return "For"
		    
		  Case TokenTypes.KeywordFunction
		    Return "Function"
		    
		  Case TokenTypes.KeywordGet
		    Return "Get"
		    
		  Case TokenTypes.KeywordIf
		    Return "If"
		    
		  Case TokenTypes.KeywordImplements
		    Return "Implements"
		    
		  Case TokenTypes.KeywordIn
		    Return "In"
		    
		  Case TokenTypes.KeywordIs
		    Return "Is"
		    
		  Case TokenTypes.KeywordIsnt
		    Return "Isnt"
		    
		  Case TokenTypes.KeywordLate
		    Return "Late"
		    
		  Case TokenTypes.KeywordMixin
		    Return "Mixin"
		    
		  Case TokenTypes.KeywordNew
		    Return "New"
		    
		  Case TokenTypes.KeywordNext
		    Return "Next"
		    
		  Case TokenTypes.KeywordNot
		    Return "Not"
		    
		  Case TokenTypes.KeywordOn
		    Return "On"
		    
		  Case TokenTypes.KeywordOperator
		    Return "Operator"
		    
		  Case TokenTypes.KeywordOptional
		    Return "Optional"
		    
		  Case TokenTypes.KeywordOr
		    Return "Or"
		    
		  Case TokenTypes.KeywordRequired
		    Return "Required"
		    
		  Case TokenTypes.KeywordRethrow
		    Return "Rethrow"
		    
		  Case TokenTypes.KeywordReturn
		    Return "Return"
		    
		  Case TokenTypes.KeywordSelect
		    Return "Select"
		    
		  Case TokenTypes.KeywordSet
		    Return "Set"
		    
		  Case TokenTypes.KeywordStatic
		    Return "Static"
		    
		  Case TokenTypes.KeywordStep
		    Return "Step"
		    
		  Case TokenTypes.KeywordSub
		    Return "Sub"
		    
		  Case TokenTypes.KeywordSuper
		    Return "Super"
		    
		  Case TokenTypes.KeywordThen
		    Return "Then"
		    
		  Case TokenTypes.KeywordThis
		    Return "This"
		    
		  Case TokenTypes.KeywordThrow
		    Return "Throw"
		    
		  Case TokenTypes.KeywordTo
		    Return "To"
		    
		  Case TokenTypes.KeywordTry
		    Return "Try"
		    
		  Case TokenTypes.KeywordUntil
		    Return "Until"
		    
		  Case TokenTypes.KeywordVar
		    Return "Var"
		    
		  Case TokenTypes.KeywordWend
		    Return "Wend"
		    
		  Case TokenTypes.KeywordWhile
		    Return "While"
		    
		  Case TokenTypes.KeywordWith
		    Return "With"
		    
		  Case TokenTypes.KeywordXor
		    Return "Xor"
		    
		  Case TokenTypes.LCurly
		    Return "LCurly"
		    
		  Case TokenTypes.Less
		    Return "Less"
		    
		  Case TokenTypes.LessEqual
		    Return "LessEqual"
		    
		  Case TokenTypes.LessGreater
		    Return "LessGreater"
		    
		  Case TokenTypes.LessLess
		    Return "LessLess"
		    
		  Case TokenTypes.LessLessEqual
		    Return "LessLessEqual"
		    
		  Case TokenTypes.LexerError
		    Return "Lexer Error"
		    
		  Case TokenTypes.LParen
		    Return "LParen"
		    
		  Case TokenTypes.LSquare
		    Return "LSquare"
		    
		  Case TokenTypes.Minus
		    Return "Minus"
		    
		  Case TokenTypes.MinusEqual
		    Return "MinusEqual"
		    
		  Case TokenTypes.MinusMinus
		    Return "MinusMinus"
		    
		  Case TokenTypes.Null
		    Return "Null"
		    
		  Case TokenTypes.Number
		    Return "Number"
		    
		  Case TokenTypes.Percent
		    Return "Percent"
		    
		  Case TokenTypes.PercentEqual
		    Return "PercentEqual"
		    
		  Case TokenTypes.Pipe
		    Return "Pipe"
		    
		  Case TokenTypes.PipeEqual
		    Return "PipeEqual"
		    
		  Case TokenTypes.Plus
		    Return "Plus"
		    
		  Case TokenTypes.PlusEqual
		    Return "PlusEqual"
		    
		  Case TokenTypes.PlusPlus
		    Return "PlusPlus"
		    
		  Case TokenTypes.Query
		    Return "Query"
		    
		  Case TokenTypes.QueryDot
		    Return "Query Dot"
		    
		  Case TokenTypes.QueryQuery
		    Return "QueryQuery"
		    
		  Case TokenTypes.QueryQueryEqual
		    Return "QueryQueryEqual"
		    
		  Case TokenTypes.RCurly
		    Return "RCurly"
		    
		  Case TokenTypes.RParen
		    Return "RParen"
		    
		  Case TokenTypes.RSquare
		    Return "RSquare"
		    
		  Case TokenTypes.Star
		    Return "Star"
		    
		  Case TokenTypes.StarEqual
		    Return "StarEqual"
		    
		  Case TokenTypes.StringLiteral
		    Return "String"
		    
		  Case TokenTypes.Tilde
		    Return "Tilde"
		    
		  Case TokenTypes.TildeEqual
		    Return "TildeEqual"
		    
		  Case TokenTypes.TildeForwardSlash
		    Return "TildeForwardSlash"
		    
		  Case TokenTypes.TildeForwardSlashEqual
		    Return "TildeForwardSlashEqual"
		    
		  Case TokenTypes.Underscore
		    Return "Underscore"
		    
		  Else
		    Raise New InvalidArgumentException("Unknown Objo token type.")
		  End Select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E732061205465787420726570726573656E746174696F6E206F6620616E204F626A6F20746F6B656E20747970652E
		Function ToText(Extends type As Objo.TokenTypes) As Text
		  /// Returns a Text representation of an Objo token type.
		  
		  Return type.ToString.ToText
		End Function
	#tag EndMethod


	#tag Note, Name = Precedences
		None      
		Lowest     
		Assignment      = *= /= ~/= += -= &= |= ^= %=
		Conditional     ?:
		Null            ??
		Or              or
		And             and
		Equality        <> ==
		Is              is isnt
		Comparison      < > <= >=
		Bitwise Or      |
		Bitwise Xor     ^
		Bitwise And     &
		Shift           << >> >>>
		Additive        + -
		Multiplicative  * / ~/ %
		Unary Prefix    - -- ++ Not ~ await
		Unary Postfix   -- ++
		Call            . () []
		Primary
		
		
	#tag EndNote


	#tag Enum, Name = Precedence, Type = Integer, Flags = &h0, Binary = True
		None
		  Lowest
		  Assignment
		  Conditional
		  Null
		  LogicalOr
		  LogicalXor
		  LogicalAnd
		  Equality
		  Is_
		  Comparison
		  BitwiseOr
		  BitwiseXor
		  BitwiseAnd
		  Shift
		  Additive
		  Multiplicative
		  UnaryPrefix
		  UnaryPostfix
		  Call_
		Primary
	#tag EndEnum

	#tag Enum, Name = TokenTypes, Type = Integer, Flags = &h0
		Ampersand
		  AmpersandEqual
		  Bang
		  BooleanFalse
		  BooleanTrue
		  Caret
		  CaretEqual
		  Colon
		  Comma
		  Directive
		  Dot
		  EOF
		  EOL
		  Equal
		  EqualEqual
		  ForwardSlash
		  ForwardSlashEqual
		  Greater
		  GreaterGreater
		  GreaterEqual
		  GreaterGreaterEqual
		  Identifier
		  KeywordAbstract
		  KeywordAnd
		  KeywordAs
		  KeywordAssert
		  KeywordAsync
		  KeywordAwait
		  KeywordBreak
		  KeywordCase
		  KeywordCatch
		  KeywordClass
		  KeywordConst
		  KeywordConstructor
		  KeywordContinue
		  KeywordDefault
		  KeywordDo
		  KeywordDownTo
		  KeywordElse
		  KeywordElseIf
		  KeywordEnd
		  KeywordEnum
		  KeywordExit
		  KeywordExtends
		  KeywordExtension
		  KeywordFinal
		  KeywordFinally
		  KeywordFor
		  KeywordFunction
		  KeywordGet
		  KeywordIf
		  KeywordImplements
		  KeywordIn
		  KeywordIs
		  KeywordIsnt
		  KeywordLate
		  KeywordMixin
		  KeywordNew
		  KeywordNext
		  KeywordNot
		  KeywordOn
		  KeywordOperator
		  KeywordOptional
		  KeywordOr
		  KeywordRequired
		  KeywordRethrow
		  KeywordReturn
		  KeywordSelect
		  KeywordSet
		  KeywordStatic
		  KeywordStep
		  KeywordSub
		  KeywordSuper
		  KeywordThen
		  KeywordThis
		  KeywordThrow
		  KeywordTo
		  KeywordTry
		  KeywordUntil
		  KeywordVar
		  KeywordWend
		  KeywordWhile
		  KeywordWith
		  KeywordXor
		  LCurly
		  Less
		  LessEqual
		  LessGreater
		  LessLess
		  LessLessEqual
		  LexerError
		  LParen
		  LSquare
		  Minus
		  MinusEqual
		  MinusMinus
		  NoToken
		  Number
		  Null
		  Percent
		  PercentEqual
		  Pipe
		  PipeEqual
		  Plus
		  PlusEqual
		  PlusPlus
		  Query
		  QueryDot
		  QueryQuery
		  QueryQueryEqual
		  RCurly
		  RParen
		  RSquare
		  Star
		  StarEqual
		  StringLiteral
		  Tilde
		  TildeEqual
		  TildeForwardSlash
		  TildeForwardSlashEqual
		Underscore
	#tag EndEnum


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Module
#tag EndModule
