#tag Class
Protected Class App
Inherits DesktopApplication
	#tag Event
		Sub AppearanceChanged()
		  If Color.IsDarkMode Then
		    NotificationKit.Send(Self, NOTIFICATION_SWITCHED_TO_DARK_MODE)
		  Else
		    NotificationKit.Send(Self, NOTIFICATION_SWITCHED_TO_LIGHT_MODE)
		  End If
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  // Create a global undo manager.
		  UndoManager = New UKUndoManager
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, Description = 4C6F61647320746865206E616D65642062756E646C6564207468656D652066726F6D20746865206170702773205265736F75726365732F5468656D657320666F6C64657220696E746F2061204243455468656D65206F626A6563742E
		Function LoadBundledTheme(fileName As String) As BCETheme
		  /// Loads the named bundled theme from the app's Resources/Themes folder into a BCETheme object.
		  
		  Var f As FolderItem
		  Try
		    f = SpecialFolder.Resource("Themes").Child(fileName)
		  Catch e
		    Raise New InvalidArgumentException("Unable to load the requested " + _
		    "bundled theme")
		  End Try
		  
		  // Get the contents of the file. Should be valid JSON.
		  Var tin As TextInputStream
		  Var json As String
		  Try
		    tin = TextInputStream.Open(f)
		    json = tin.ReadAll
		  Catch e As IOException
		    Raise New IOException("Unable to open the bundled theme file `" + _
		    fileName + "`")
		  Finally
		    tin.Close
		  End Try
		  
		  // Try to parse the JSON into a theme.
		  Var theme As BCETheme
		  Try
		    theme = New BCETheme(json)
		  Catch e As InvalidArgumentException
		    Raise New InvalidArgumentException("The contents of `" + fileName + _
		    "` is not a valid theme")
		  End Try
		  
		  // Update the editor's theme.
		  Return theme
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520676C6F62616C20756E646F206D616E61676572
		UndoManager As UKUndoManager
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant

	#tag Constant, Name = NOTIFICATION_ALL_APPEARANCE, Type = String, Dynamic = False, Default = \"App.Appearance.*", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NOTIFICATION_SWITCHED_TO_DARK_MODE, Type = String, Dynamic = False, Default = \"App.Appearance.DarkMode", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NOTIFICATION_SWITCHED_TO_LIGHT_MODE, Type = String, Dynamic = False, Default = \"App.Appearance.LightMode", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=false
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoQuit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowHiDPI"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BugVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Copyright"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastWindowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MajorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MinorVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="NonReleaseVersion"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RegionCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StageCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Version"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_CurrentEventTime"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
