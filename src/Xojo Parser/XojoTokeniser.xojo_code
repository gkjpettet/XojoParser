#tag Class
Protected Class XojoTokeniser
	#tag Property, Flags = &h21
		Private mCharsLastIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrent As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTokenStart As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Tokens() As XojoToken
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
			Name="mCurrent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
