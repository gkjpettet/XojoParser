#tag Class
Protected Class ObjoToken
	#tag Method, Flags = &h0
		Sub Constructor(type As Objo.TokenTypes, absoluteStart As Integer, lineNumber As Integer, lineNumberStartPos As Integer, lexeme As Text = "")
		  Self.Type = type
		  Self.AbsStartPosition = absoluteStart
		  Self.LineNumber = lineNumber
		  Self.LineNumberStartPos = lineNumberStartPos
		  Self.Lexeme = lexeme
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520302D626173656420706F736974696F6E20696E2074686520736F7572636520636F64652074686174207468697320746F6B656E207374617274732061742E
		AbsStartPosition As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520746F6B656E2773206C6578656D652E204D617920626520656D7074792E
		Lexeme As Text
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 312D6261736564206C696E65206E756D626572207468697320746F6B656E206F6363757273206F6E2E
		LineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h1, Description = 4162736F6C75746520706F736974696F6E20696E2074686520736F7572636520636F6465207468617420746865206C696E65207468697320746F6B656E206973206F6E20626567696E732061742E
		Protected LineNumberStartPos As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520302D626173656420706F736974696F6E206F6620746865207374617274206F66207468697320746F6B656E202A6C6F63616C2A20746F20746865206C696E65206974206973206F6E2E
		#tag Getter
			Get
			  Return AbsStartPosition - LineNumberStartPos
			  
			End Get
		#tag EndGetter
		StartPosition As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Type As Objo.TokenTypes = Objo.TokenTypes.EOF
	#tag EndProperty


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
		#tag ViewProperty
			Name="AbsStartPosition"
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
			Name="LineNumber"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StartPosition"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue="Objo.TokenTypes.EOF"
			Type="Objo.TokenTypes"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
