#tag Class
Protected Class ObjoLexer
	#tag Method, Flags = &h21, Description = 436F6E73756D6573207468652063686172616374657220617420606D43686172735B6D43757272656E745D6020616E642072657475726E732069742E
		Private Function Advance() As Text
		  /// Consumes the character at `mChars[mCurrent]` and returns it.
		  
		  mCurrent = mCurrent + 1
		  Return mChars(mCurrent - 1)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5472756520696620746865206C657865722068617320726561636865642074686520656E64206F662074686520736F7572636520636F64652E
		Private Function AtEnd() As Boolean
		  /// True if the lexer has reached the end of the source code.
		  
		  Return mCurrent > mChars.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E73756D65732064696769747320286F7074696F6E616C6C792073657061726174656420627920756E64657273636F726573292E2052657475726E732046616C73652069662074686572652061726520636F6E746967756F757320756E64657273636F7265732E
		Private Function ConsumeAndValidateDigits() As Boolean
		  /// Consumes digits (optionally separated by underscores). Returns False if
		  /// there are contiguous underscores.
		  
		  Var c As Text
		  Var lastCharWasUnderscore As Boolean = False
		  
		  While Not AtEnd
		    c = Peek
		    If c = "_" Then
		      If lastCharWasUnderscore Then
		        // Contiguous underscores are invalid.
		        Return False
		      Else
		        lastCharWasUnderscore = True
		        Call Advance
		      End If
		    ElseIf c.IsDigit Then
		      If lastCharWasUnderscore Then lastCharWasUnderscore = False
		      Call Advance
		    Else
		      Exit
		    End If
		  Wend
		  
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E73756D657320616E206F7074696F6E616C205B7175616E746974795D206F6620636F6E746967756F757320686578206469676974732E
		Private Function ConsumeHexDigits(quantity As Integer = -1) As Text
		  /// Consumes an optional [quantity] of contiguous hex digits.
		  ///
		  /// If [quantity] is specified and that number of contiguous hex digits
		  /// cannot be consumed then we rewind the current pointer to where we began
		  /// and return "".
		  
		  Var hex As Text
		  Var originalCurrent As Integer = mCurrent
		  
		  // Validate.
		  If quantity = 0 Or quantity < -1 Then Return ""
		  
		  While Not AtEnd
		    If Peek.IsHexDigit Then
		      If quantity = -1 Then
		        hex = hex + Advance
		      Else
		        If hex.Length < quantity Then
		          hex = hex + Advance
		        Else
		          Exit
		        End If
		      End If
		    Else
		      Exit
		    End If
		  Wend
		  
		  If quantity > 0 And hex.Length <> quantity Then
		    mCurrent = originalCurrent
		    Return ""
		  Else
		    Return hex
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865207370656369616C20454F4620746F6B656E2E
		Private Function EOFToken() As ObjoToken
		  /// Returns the special EOF token.
		  
		  Return New ObjoToken(Objo.TokenTypes.EOF, mChars.LastIndex + 1, _
		  mLineNumber, mLineStartPos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320616E206572726F7220746F6B656E20626567696E6E696E6720617420606D546F6B656E53746172746020616E64206C6F677320697420696E7465726E616C6C792E
		Private Function Error(message As Text) As ObjoToken
		  /// Returns an error token beginning at `mTokenStart` and logs it internally.
		  
		  Var t As New ObjoToken(TokenTypes.LexerError, mTokenStart, mLineNumber, _
		  mLineStartPos, message)
		  
		  Errors.Add(New ObjoLexerException(message, t))
		  
		  Return t
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MakeNumberToken(value As Double) As ObjoToken
		  /// Returns a new number token with the specified value starting at 
		  /// `mTokenStart`.
		  
		  Return New ObjoNumberToken(mTokenStart, mLineNumber, mLineStartPos, value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 437265617465732061206E657720746F6B656E20626567696E6E696E67206174206D546F6B656E53746172742E204966205B6861734C6578656D655D207468656E20746865206C6578656D6520697320636F6D70757465642066726F6D206D43757272656E742E
		Private Function MakeToken(type As Objo.TokenTypes, hasLexeme As Boolean = False) As ObjoToken
		  /// Creates a new token beginning at mTokenStart. If [hasLexeme] then the
		  /// lexeme is computed from mCurrent.
		  
		  If hasLexeme Then
		    Var lexeme As Text = mSource.Mid(mTokenStart, mCurrent - mTokenStart)
		    Return New ObjoToken(type, mTokenStart, mLineNumber, mLineStartPos, lexeme)
		  Else
		    Return New ObjoToken(type, mTokenStart, mLineNumber, mLineStartPos)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496620746865206E65787420636861726163746572206D617463686573205B635D207468656E206974277320636F6E73756D656420616E6420547275652069732072657475726E65642E204F74686572776973652046616C73652069732072657475726E65642E
		Private Function Match(c As Text) As Boolean
		  /// If the next character matches [c] then it's consumed and True 
		  /// is returned. Otherwise False is returned.
		  
		  If Peek = c Then
		    Call Advance
		    Return True
		  Else
		    Return False
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E7320746865206E65787420746F6B656E2E
		Function NextToken() As ObjoToken
		  /// Returns the next token.
		  ///
		  /// Assumes that `Reset()` has been called with the source code to tokenise.
		  
		  If AtEnd Then Return EOFToken
		  
		  Var t As ObjoToken
		  
		  t = SkipWhitespace
		  If t <> Nil Then
		    mLastTokenType = t.Type
		    Return t
		  End If
		  
		  If AtEnd Then
		    mLastTokenType = Objo.TokenTypes.EOF
		    Return EOFToken
		  End If
		  
		  // Store the current token start index.
		  mTokenStart = mCurrent
		  
		  Var c As Text = Advance
		  
		  // =============
		  // NUMBERS
		  // =============
		  If c = "0" Then
		    If Peek.IsExactly("x") And (PeekNext.IsHexDigit Or PeekNext = "_") Then
		      t = TryHexNumberToken
		      If t <> Nil Then
		        mLastTokenType = t.Type
		        Return t
		      End If
		    ElseIf Peek.IsExactly("b") And _
		      (PeekNext.IsBinaryDigit Or PeekNext = "_") Then
		      t = TryBinaryLiteralToken
		      If t <> Nil Then 
		        mLastTokenType = t.Type
		        Return t
		      End If
		    Else
		      t = TryNumberToken
		      If t <> Nil Then
		        mLastTokenType = t.Type
		        Return t
		      End If
		    End If
		  ElseIf c.IsDigit Then
		    t = TryNumberToken
		    If t <> Nil Then
		      mLastTokenType = t.Type
		      Return t
		    End If
		  End If
		  
		  // =====================================
		  // OPERATORS
		  // =====================================
		  t = TryOperatorToken(c)
		  If t <> Nil Then
		    mLastTokenType = t.Type
		    Return t
		  End If
		  
		  // =====================================
		  // STRINGS
		  // =====================================
		  t = TryStringToken(c)
		  If t <> Nil Then
		    mLastTokenType = t.Type
		    Return t
		  End If
		  
		  // =========================
		  // DIRECTIVES
		  // =========================
		  If c = "#" Then
		    t = TryDirectiveToken
		    If t <> Nil Then
		      mLastTokenType = t.Type
		      Return t
		    End If
		  End If
		  
		  // =========================
		  // UNDERSCORE
		  // =========================
		  If c = "_" Then
		    If Peek.IsASCIILetter Then
		      t = TryUnderscorePrefixedIdentifierToken
		      If t <> Nil Then
		        mLastTokenType = t.Type
		        Return t
		      End If
		    Else
		      mLastTokenType = Objo.TokenTypes.Underscore
		      Return MakeToken(Objo.TokenTypes.Underscore)
		    End If
		  End If
		  
		  // =========================
		  // KEYWORDS & IDENTIFIERS
		  // =========================
		  If c.IsASCIILetter Then
		    t = TryIdentifierOrKeywordToken
		    If t <> Nil Then
		      mLastTokenType = t.Type
		      Return t
		    End If
		  End If
		  
		  // =====================================
		  // UNRECOGNISED CHARACTER
		  // =====================================
		  Return Error("Unrecognised character `" + c + "`.")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520636861726163746572206174205B6D43757272656E745D2062757420646F6573202A2A6E6F742A2A20636F6E73756D652069742E2052657475726E7320222220696620454F462E
		Private Function Peek() As Text
		  /// Returns the character at [mCurrent] but does **not** consume it.
		  /// Returns "" if EOF.
		  
		  Return If(mCurrent <= mChars.LastIndex, mChars(mCurrent), "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074686520636861726163746572206174205B6D43757272656E74202B20315D2062757420646F6573202A2A6E6F742A2A20636F6E73756D652069742E2052657475726E7320222220696620454F462E
		Private Function PeekNext() As Text
		  /// Returns the character at [mCurrent + 1] but does **not** consume it.
		  /// Returns "" if EOF.
		  
		  Return If(mCurrent + 1 <= mChars.LastIndex, mChars(mCurrent + 1), "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206C61737420636F6E73756D656420636861726163746572206F7220222220696620776527726520617420746865207374617274206F66207468652074686520736F757263652E
		Private Function Previous() As Text
		  /// Returns the last consumed character or "" if we're at the start of the
		  /// the source.
		  
		  If mCurrent - 1 > mChars.LastIndex Then
		    Return ""
		  Else
		    Return mChars(mCurrent - 1)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657365747320746865206C6578657220736F2069742063616E2073756273657175656E746C7920746F6B656E697365205B736F75726365436F64655D2E
		Sub Reset(sourceCode As Text, standardiseLineEndings As Boolean = True)
		  /// Resets the lexer so it can subsequently tokenise [sourceCode].
		  
		  // Store a copy of the source code with its line endings standardised.
		  If standardiseLineEndings Then
		    mSource = sourceCode.ReplaceLineEndings(&u0A)
		  Else
		    mSource = sourceCode
		  End If
		  
		  mChars = mSource.Split()
		  mTokenStart = 0
		  mCurrent = 0
		  mLineNumber = 1
		  mLineStartPos = 0
		  mLastTokenType = Objo.TokenTypes.NoToken
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 416476616E6365732070617374207768697465737061636520616E6420636F6D6D656E74732E2052657475726E73204E696C206F7220616E20454F4C20746F6B656E2E
		Private Function SkipWhitespace() As ObjoToken
		  /// Advances past whitespace and comments. Returns Nil or an EOL token.
		  ///
		  /// Returns Nil if a non-whitespace character encountered or 
		  /// returns an EOL token.
		  /// Handles contiguous EOLs by moving past them and only returning the 
		  /// last one encountered.
		  /// Handles line continuation operators if they occur at the end of a 
		  /// line, otherwise returns Nil.
		  
		  Var t As ObjoToken
		  
		  Do
		    Select Case Peek
		    Case "" // EOF.
		      Return t
		      
		    Case &u0A // EOL.
		      Call Advance
		      mTokenStart = mCurrent - 1
		      
		      Select Case mLastTokenType
		        // Only produce an EOL token if the last token returned was not capable
		        // of continuing a line.
		      Case Objo.TokenTypes.Comma, Objo.TokenTypes.EOL, _
		        Objo.TokenTypes.LCurly, Objo.TokenTypes.LParen, _
		        Objo.TokenTypes.LSquare, Objo.TokenTypes.Underscore
		        
		        // And this isn't the first token we've produced.
		      Case TokenTypes.NoToken
		        
		      Else
		        // Or the next character is `)`, `]`, `}`.
		        If Not Peek.IsExactly(")", "]", "}") Then
		          mLastTokenType = Objo.TokenTypes.EOL
		          t = MakeToken(Objo.TokenTypes.EOL)
		        End If
		        
		      End Select
		      
		      mLineNumber = mLineNumber + 1
		      mLineStartPos = mCurrent
		      
		    Case "_"
		      // Is this the last non-whitespace character on this line?
		      Var isLastCharOnLine As Boolean = False
		      For i As Integer = mCurrent + 1 To mChars.LastIndex
		        Select Case mChars(i)
		        Case " ", &u0009
		          Continue
		        Case &u0A
		          isLastCharOnLine = True
		          Exit
		        Else
		          Exit
		        End Select
		      Next i
		      If Not isLastCharOnLine Then Return t
		      
		      // Move past this underscore.
		      Call Advance
		      
		      // Advance to the next non-whitespace character. Don't produce EOL tokens
		      // but do increment the line number and line number start positions.
		      While Not AtEnd
		        Select Case Peek
		        Case " ", &u0009
		          Call Advance
		        Case &u0A
		          Call Advance
		          mTokenStart = mCurrent - 1
		          mLineNumber = mLineNumber + 1
		          mLineStartPos = mCurrent
		        Else
		          Return Nil
		        End Select
		      Wend
		      
		    Case " ", &u0009
		      // Consume this space / horizontal tab.
		      Call Advance
		      
		    Case "/"
		      If PeekNext = "/" Then
		        // This is a comment.
		        mCurrent = mCurrent + 2
		        // Advance to the EOL or EOF.
		        Do
		          If Peek = "" Then
		            Return t
		          ElseIf Peek = &u0A Then
		            Call Advance
		            If mLastTokenType = TokenTypes.EOL Or _
		              mLastTokenType = TokenTypes.NoToken Then
		              // We only create an EOL token if the last returned token wasn't an
		              // EOL and this isn't the first token produced.
		              // This clause is here because Xojo enums don't support the 
		              //`<>` operator.
		            ElseIf Peek.IsExactly(")", "]", "}") Then
		              // The next token is capable of continuing this line so we 
		              // won't create an EOL token but we will handle line numbering, etc.
		              mTokenStart = mCurrent
		              
		            Else
		              Select Case mLastTokenType
		              Case Objo.TokenTypes.Comma, _
		                Objo.TokenTypes.LCurly, Objo.TokenTypes.LParen, _
		                Objo.TokenTypes.LSquare, Objo.TokenTypes.Underscore
		                // The last token on this line (before this comment) is capable
		                // of continuing a line so we won't produce an EOL token.
		                // We do need to handle line numbering, etc though.
		                mTokenStart = mCurrent
		              Else
		                // We need to add an EOL after this comment.
		                mTokenStart = mCurrent - 1
		                t = MakeToken(Objo.TokenTypes.EOL)
		                mTokenStart = mCurrent
		              End Select
		            End If
		            mLineNumber = mLineNumber + 1
		            mLineStartPos = mCurrent
		            Exit
		          Else
		            Call Advance
		          End If
		        Loop
		      Else
		        Return t
		      End If
		      
		    Else
		      Return t
		      
		    End Select
		  Loop
		  
		  Return t
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546F6B656E69736573205B736F75726365436F64655D20696E746F20616E206172726179206F6620746F6B656E732E
		Function Tokenise(sourceCode As Text) As ObjoToken()
		  /// Tokenises [sourceCode] into an array of tokens.
		  
		  Var tokens() As ObjoToken
		  
		  If sourceCode.Empty Then Return tokens
		  
		  Reset(sourceCode)
		  
		  While Not AtEnd
		    tokens.Add(NextToken)
		  Wend
		  
		  // Ensure we always terminate the array with an EOF token.
		  If tokens.Count = 0 Then
		    tokens.Add(EOFToken)
		  Else
		    If tokens(tokens.LastIndex).Type <> Objo.TokenTypes.EOF Then
		      tokens.Add(EOFToken)
		    End If
		  End If
		  
		  Return tokens
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E642072657475726E20612062696E617279206E756D62657220746F6B656E2E2052657475726E73204E696C20696620756E7375636365737366756C2E
		Private Function TryBinaryLiteralToken() As ObjoNumberToken
		  /// Tries to consume and return a binary number token. 
		  /// Returns Nil if unsuccessful.
		  ///
		  /// Assumes that [mCurrent] points at the `b` after the `0`:
		  /// ```
		  /// 0b1001
		  ///  ^
		  /// ```
		  /// Assumes that there is at least one hex digit after the `b`.
		  
		  // Cache the current pointer in case we need to restore it.
		  Var oldCurrent As Integer = mCurrent
		  
		  // Advance past the `b`.
		  mCurrent = mCurrent + 1
		  
		  Var lastCharWasUnderscore As Boolean = False
		  Var c As Text
		  While Not AtEnd
		    c = Peek
		    If c = "_" Then
		      If lastCharWasUnderscore Then
		        // Contiguous underscores are invalid.
		        // Restore the current pointer.
		        mCurrent = oldCurrent
		        Return Nil
		      Else
		        lastCharWasUnderscore = True
		        Call Advance
		      End If
		    ElseIf c.IsBinaryDigit Then
		      If lastCharWasUnderscore Then lastCharWasUnderscore = False
		      Call Advance
		    Else
		      Exit
		    End If
		  Wend
		  
		  // Compute the binary component of the lexeme.
		  Var b As Text = mSource.Mid(mTokenStart + 2, mCurrent - mTokenStart - 2)
		  
		  // Remove any underscores.
		  b = b.ReplaceAll("_", "")
		  
		  Return New ObjoNumberToken(mTokenStart, mLineNumber, mLineStartPos, _
		  Integer.FromBinary(b))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F2063726561746520612076616C69642064697265637469766520746F6B656E2E2052657475726E73204E696C20696620756E61626C6520746F2E
		Private Function TryDirectiveToken() As ObjoToken
		  /// Tries to create a valid directive token. Returns Nil if unable to.
		  ///
		  /// Assumes that we have just consumed a `#`.
		  
		  // Assert that the `#` is at the beginning of a line.
		  If mCurrent - 1 <> mLineStartPos Then Return Nil
		  
		  // We need to see at least one ASCII letter.
		  If Not Peek.IsASCIILetter Then Return Nil
		  
		  // Consume the directive.
		  Var directive As Text
		  While Not AtEnd
		    If Peek.IsASCIILetter Then
		      directive = directive + Advance
		    Else
		      Exit
		    End If
		  Wend
		  
		  Return New ObjoToken(Objo.TokenTypes.Directive, _
		  mTokenStart, mLineNumber, mLineStartPos, directive)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E642072657475726E206120686578206E756D62657220746F6B656E2E2052657475726E73204E696C20696620756E7375636365737366756C2E
		Private Function TryHexNumberToken() As ObjoNumberToken
		  /// Tries to consume and return a hex number token. 
		  /// Returns Nil if unsuccessful.
		  ///
		  /// Assumes that [mCurrent] points at the `x` after the `0`:
		  /// ```
		  /// 0xFF
		  ///  ^
		  /// ```
		  /// Assumes that there is at least one hex digit after the `x`.
		  
		  // Cache the current pointer in case we need to restore it.
		  Var oldCurrent As Integer = mCurrent
		  
		  // Advance past the `x`.
		  mCurrent = mCurrent + 1
		  
		  Var lastCharWasUnderscore As Boolean = False
		  Var c As Text
		  While Not AtEnd
		    c = Peek
		    If c = "_" Then
		      If lastCharWasUnderscore Then
		        // Contiguous underscores are invalid.
		        // Restore the current pointer.
		        mCurrent = oldCurrent
		        Return Nil
		      Else
		        lastCharWasUnderscore = True
		        Call Advance
		      End If
		    ElseIf c.IsHexDigit Then
		      If lastCharWasUnderscore Then lastCharWasUnderscore = False
		      Call Advance
		    Else
		      Exit
		    End If
		  Wend
		  
		  // Compute the hex component of the lexeme.
		  Var hex As Text = mSource.Mid(mTokenStart + 2, mCurrent - mTokenStart - 2)
		  
		  // Remove any underscores.
		  hex = hex.ReplaceAll("_", "")
		  
		  Return New ObjoNumberToken(mTokenStart, mLineNumber, mLineStartPos, _
		  Integer.FromHex(hex))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F206372656174652061206B6579776F7264206F72206964656E74696669657220746F6B656E2E2052657475726E73204E696C20696620756E61626C6520746F2E
		Private Function TryIdentifierOrKeywordToken() As ObjoToken
		  /// Tries to create a keyword or identifier token. Returns Nil if unable to.
		  ///
		  /// Assumes that we have just consumed an ASCII character.
		  
		  // Consume the lexeme.
		  Var lexeme As Text = Previous
		  While Not AtEnd
		    If Peek.IsASCIILetterDigitOrUnderscore Then
		      lexeme = lexeme + Advance
		    Else
		      Exit
		    End If
		  Wend
		  
		  // Reserved identifier?
		  If ReservedIdentifiers.HasKey(lexeme) Then
		    Return New ObjoToken(ReservedIdentifiers.Value(lexeme), _
		    mTokenStart, mLineNumber, mLineStartPos, lexeme)
		  ElseIf ForbiddenIdentifiers.HasKey(lexeme) Then
		    Return Error("The identifier `" + lexeme + _
		    "` is reserved for internal use and cannot be used.")
		  Else
		    Return New ObjoToken(Objo.TokenTypes.Identifier, _
		    mTokenStart, mLineNumber, mLineStartPos, lexeme)
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F20636F6E73756D6520616E642072657475726E206120646563696D616C206E756D62657220746F6B656E2E2052657475726E73204E696C20696620756E7375636365737366756C2E
		Private Function TryNumberToken() As ObjoNumberToken
		  /// Tries to consume and return a decimal number token. 
		  /// Returns Nil if unsuccessful.
		  ///
		  /// Assumes that [mCurrent] points at a digit.
		  
		  // Cache the current pointer value in case we hit an error and need 
		  // to restore it.
		  Var oldCurrent As Integer = mCurrent
		  
		  If Not ConsumeAndValidateDigits Then
		    // Restore the current pointer.
		    mCurrent = oldCurrent
		    Return Nil
		  End If
		  
		  // Is this a double?
		  If Peek = "." And PeekNext.IsDigit Then
		    // Consume the dot.
		    mCurrent = mCurrent + 1
		    
		    // Consume the mantissa.
		    If Not ConsumeAndValidateDigits Then
		      // Restore the current pointer.
		      mCurrent = oldCurrent
		      Return Nil
		    End If
		  End If
		  
		  // Is there an exponent?
		  If Peek = "e" Then
		    Var nextChar As Text = PeekNext
		    If nextChar = "-" Or nextChar = "+" Then
		      // Consume the e/E and sign character.
		      mCurrent = mCurrent + 2
		      
		      // Consume the exponent.
		      If Not ConsumeAndValidateDigits Then
		        // Restore the current pointer.
		        mCurrent = oldCurrent
		        Return Nil
		      End If
		      
		    ElseIf nextChar.IsDigit Then
		      // Consume the e/E character.
		      mCurrent = mCurrent + 1
		      
		      If Not ConsumeAndValidateDigits Then
		        // Restore the current pointer.
		        mCurrent = oldCurrent
		        Return Nil
		      End If
		    End If
		  End If
		  
		  // Compute the lexeme.
		  Var lexeme As Text = mSource.Mid(mTokenStart, mCurrent - mTokenStart)
		  
		  // Remove any underscores.
		  lexeme = lexeme.ReplaceAll("_", "")
		  
		  Return New ObjoNumberToken(mTokenStart, mLineNumber, mLineStartPos, _
		  Val(lexeme))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F2063726561746520612076616C6964206F70657261746F7220746F6B656E20626567696E6E696E672077697468205B636861725D2E2052657475726E73204E696C20696620756E61626C6520746F2E
		Private Function TryOperatorToken(c As Text) As ObjoToken
		  /// Tries to create a valid operator token beginning with [c]. Returns Nil
		  /// if unable to.
		  ///
		  /// Assumes that [c] is at `mChars(mCurrent - 1)`.
		  
		  // Single character.
		  Select Case c
		  Case "("
		    Return MakeToken(TokenTypes.LParen)
		  Case ")"
		    Return MakeToken(TokenTypes.RParen)
		  Case "["
		    Return MakeToken(TokenTypes.LSquare)
		  Case "]"
		    Return MakeToken(TokenTypes.RSquare)
		  Case "{"
		    Return MakeToken(TokenTypes.LCurly)
		  Case "}"
		    Return MakeToken(TokenTypes.RCurly)
		  Case "."
		    Return MakeToken(TokenTypes.Dot)
		  Case ","
		    Return MakeToken(TokenTypes.Comma)
		  Case ":"
		    Return MakeToken(TokenTypes.Colon)
		  Case "!"
		    Return MakeToken(TokenTypes.Bang)
		    
		    // Multiple character operators.
		  Case "+"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.PlusEqual)
		    ElseIf Match("+") Then
		      Return MakeToken(TokenTypes.PlusPlus)
		    Else
		      Return MakeToken(TokenTypes.Plus)
		    End If
		  Case "-"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.MinusEqual)
		    ElseIf Match("-") Then
		      Return MakeToken(TokenTypes.MinusMinus)
		    Else
		      Return MakeToken(TokenTypes.Minus)
		    End If
		  Case "*"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.StarEqual)
		    Else
		      Return MakeToken(TokenTypes.Star)
		    End If
		  Case "/"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.ForwardSlashEqual)
		    Else
		      Return MakeToken(TokenTypes.ForwardSlash)
		    End If
		  Case "~"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.TildeEqual)
		    ElseIf Match("/") Then
		      If Match("=") Then
		        Return MakeToken(TokenTypes.TildeForwardSlashEqual)
		      Else
		        Return MakeToken(TokenTypes.TildeForwardSlash)
		      End If
		    Else
		      Return MakeToken(TokenTypes.Tilde)
		    End If
		  Case "="
		    If Match("=") Then
		      Return MakeToken(TokenTypes.EqualEqual)
		    Else
		      Return MakeToken(TokenTypes.Equal)
		    End If
		  Case "%"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.PercentEqual)
		    Else
		      Return MakeToken(TokenTypes.Percent)
		    End If
		  Case "&"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.AmpersandEqual)
		    Else
		      Return MakeToken(TokenTypes.Ampersand)
		    End If
		  Case "|"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.PipeEqual)
		    Else
		      Return MakeToken(TokenTypes.Pipe)
		    End If
		  Case "^"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.CaretEqual)
		    Else
		      Return MakeToken(TokenTypes.Caret)
		    End If
		  Case "?"
		    If Match(".") Then
		      Return MakeToken(TokenTypes.QueryDot)
		    ElseIf Match("?") Then
		      If Match("=") Then
		        Return MakeToken(TokenTypes.QueryQueryEqual)
		      Else
		        Return MakeToken(TokenTypes.QueryQuery)
		      End If
		    Else
		      Return MakeToken(TokenTypes.Query)
		    End If
		  Case "<"
		    If Match(">") Then
		      Return MakeToken(TokenTypes.LessGreater)
		    ElseIf Match("=") Then
		      Return MakeToken(TokenTypes.LessEqual)
		    ElseIf Match("<") Then
		      If Match("=") Then
		        Return MakeToken(TokenTypes.LessLessEqual)
		      Else
		        Return MakeToken(TokenTypes.LessLess)
		      End If
		    Else
		      Return MakeToken(TokenTypes.Less)
		    End If
		  Case ">"
		    If Match("=") Then
		      Return MakeToken(TokenTypes.GreaterEqual)
		    ElseIf Peek = ">" And PeekNext = "=" Then
		      mCurrent = mCurrent + 2
		      Return MakeToken(TokenTypes.GreaterGreaterEqual)
		    Else
		      Return MakeToken(TokenTypes.Greater)
		    End If
		  End Select
		  
		  Return Nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F2063726561746520612076616C696420737472696E6720746F6B656E20626567696E6E696E672077697468205B635D2E2052657475726E73204E696C20696620756E61626C6520746F2E
		Private Function TryStringToken(c As Text) As ObjoToken
		  /// Tries to create a valid string token beginning with [c]. Returns Nil
		  /// if unable to.
		  ///
		  /// Assumes that [c] is at `mChars(mCurrent - 1)`.
		  
		  Var delimiter As Text
		  
		  // Raw string?
		  Var isRaw As Boolean = False
		  If c.IsExactly("r") Then
		    Select Case Peek
		    Case "'"
		      isRaw = True
		      delimiter = Advance
		    Case """"
		      isRaw = True
		      delimiter = Advance
		    Else
		      Return Nil
		    End Select
		  Else
		    Select Case Previous
		    Case "'", """"
		      delimiter = Previous
		    Else
		      Return Nil
		    End Select
		  End If
		  
		  // Consume characters until we hit the end of the string, EOL or EOF.
		  Var lexeme As Text
		  Var terminated As Boolean = False
		  While Not AtEnd
		    Select Case Peek
		    Case delimiter
		      terminated = True
		      Call Advance
		      Exit
		    Case "\"
		      If isRaw Then
		        lexeme = lexeme + Advance
		      Else
		        Call Advance
		        Var nxt As Text = Advance
		        If nxt = "\" Then
		          lexeme = lexeme + "\"
		          
		        ElseIf nxt = "'" Then
		          lexeme = lexeme + "'"
		          
		        ElseIf nxt = """" Then
		          lexeme = lexeme + """"
		          
		        ElseIf nxt.IsExactly("n") Then
		          lexeme = lexeme + &u0A // Line feed.
		          
		        ElseIf nxt.IsExactly("r") Then
		          lexeme = lexeme + &u0D // Carriage return.
		          
		        ElseIf nxt.IsExactly("t") Then
		          lexeme = lexeme + &u0009 // Horizontal tab.
		          
		        ElseIf nxt.IsExactly("u") Then
		          Var hex As Text
		          If Peek = "{" Then
		            Call Advance
		            hex = ConsumeHexDigits
		            If hex = "" Then
		              lexeme = lexeme + "\u{"
		            Else
		              If Peek <> "}" Then
		                lexeme = lexeme + "\u{" + hex
		              Else
		                Call Advance // Move past the `}`.
		                Try
		                  lexeme = lexeme + _
		                  Text.FromUnicodeCodepoint(Integer.FromHex(hex))
		                Catch e As RuntimeException
		                  // Invalid codepoint.
		                  lexeme = lexeme + "\u{" + hex + "}"
		                End Try
		              End If
		            End If
		          Else
		            hex = ConsumeHexDigits(4)
		            If hex = "" Then
		              lexeme = lexeme + "\u"
		            Else
		              Try
		                lexeme = lexeme + _
		                Text.FromUnicodeCodepoint(Integer.FromHex(hex))
		              Catch e As RuntimeException
		                // Invalid codepoint.
		                lexeme = lexeme + "\u{" + hex
		              End Try
		            End If
		          End If
		          
		        Else
		          lexeme = lexeme + "\" + Previous
		        End If
		      End If
		      
		    Case &u0A
		      Exit
		    Else
		      lexeme = lexeme + Advance
		    End Select
		  Wend
		  
		  If Not terminated Then Return Error("Unterminated string literal.")
		  
		  Return New ObjoToken(Objo.TokenTypes.StringLiteral, _
		  mTokenStart, mLineNumber, mLineStartPos, lexeme)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 547269657320746F2063726561746520616E206964656E74696669657220746F6B656E207468617420626567696E73207769746820616E20756E64657273636F72652E2052657475726E73204E696C20696620756E61626C6520746F2E
		Private Function TryUnderscorePrefixedIdentifierToken() As ObjoToken
		  /// Tries to create an identifier token that begins with an underscore. 
		  /// Returns Nil if unable to.
		  ///
		  /// Assumes that we have just consumed an underscore and that the next character
		  /// is an ASCII letter.
		  
		  // Consume the lexeme.
		  Var lexeme As Text = Previous + Advance
		  While Not AtEnd
		    If Peek.IsASCIILetterDigitOrUnderscore Then
		      lexeme = lexeme + Advance
		    Else
		      Exit
		    End If
		  Wend
		  
		  // Forbidden identifier?
		  If ForbiddenIdentifiers.HasKey(lexeme) Then
		    Return Error("The identifier `" + lexeme + _
		    "` is reserved for internal use and cannot be used.")
		  Else
		    Return New ObjoToken(Objo.TokenTypes.Identifier, _
		    mTokenStart, mLineNumber, mLineStartPos, lexeme)
		  End If
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 416E79206572726F72732074686174206F6363757272656420647572696E6720746F6B656E69736174696F6E2E
		Errors() As ObjoLexerException
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 4B6579203D206C6578656D6520617320546578742C2056616C7565203D204E696C
		#tag Getter
			Get
			  Static bd As New BetterDictionary( _
			  True,  _
			  "covariant" : Nil, _
			  "deferred" : Nil, _
			  "double" : Nil, _
			  "dynamic" : Nil, _
			  "export" : Nil, _
			  "external" : Nil, _
			  "factory" : Nil, _
			  "hide" : Nil, _
			  "int" : Nil, _
			  "import" : Nil, _
			  "library" : Nil, _
			  "num" : Nil, _
			  "part" : Nil, _
			  "show" : Nil, _
			  "sync" : Nil, _
			  "void" : Nil, _
			  "yield" : Nil)
			  
			  Return bd
			  
			End Get
		#tag EndGetter
		Private Shared ForbiddenIdentifiers As BetterDictionary
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0, Description = 5472756520696620746865206C6578657220656E636F756E746572656420616E79206572726F7273207768696C737420746F6B656E6973696E672E
		#tag Getter
			Get
			  Return Errors.Count > 0
			End Get
		#tag EndGetter
		HasError As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21, Description = 606D536F75726365602073706C697420696E746F20616E206172726179206F6620636861726163746572732E
		Private mChars() As Text
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 506F696E747320746F2074686520696E64657820696E20606D436861727360206F6620746865206E6578742063686172616374657220746F206265206576616C75617465642E
		Private mCurrent As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652074797065206F662074686520746F6B656E206C61737420656D697474656420627920746865206C657865722E
		Private mLastTokenType As Objo.TokenTypes = Objo.TokenTypes.NoToken
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206C696E65206E756D626572207468652063757272656E7420746F6B656E20737461727473206F6E2E
		Private mLineNumber As Integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206162736F6C75746520706F736974696F6E20696E2074686520736F7572636520636F6465206F6620746865207374617274206F66207468652063757272656E74206C696E652E
		Private mLineStartPos As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 4120636F7079206F662074686520287374616E64617264697365642920736F7572636520636F6465206265696E6720746F6B656E697365642E
		Private mSource As Text
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 302D626173656420706F736974696F6E20696E20606D536F7572636560207768657265207468697320746F6B656E20626567696E732E
		Private mTokenStart As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21, Description = 4B6579203D206C6578656D6520617320546578742C2056616C7565203D204F626A6F2E546F6B656E5479706573
		#tag Getter
			Get
			  Static rw As New BetterDictionary( _
			  True,  _
			  "false" : TokenTypes.BooleanFalse, _
			  "null" : TokenTypes.Null, _
			  "true" : TokenTypes.BooleanTrue, _
			  "abstract" : TokenTypes.KeywordAbstract, _
			  "and" : TokenTypes.KeywordAnd, _
			  "as" : TokenTypes.KeywordAs, _
			  "assert" : TokenTypes.KeywordAssert, _
			  "async" : TokenTypes.KeywordAsync, _
			  "await" : TokenTypes.KeywordAwait, _
			  "break" : TokenTypes.KeywordBreak, _
			  "case" : TokenTypes.KeywordCase, _
			    "catch" : TokenTypes.KeywordCatch, _
			      "class" : TokenTypes.KeywordClass, _
			        "const" : TokenTypes.KeywordConst, _
			        "constructor" : TokenTypes.KeywordConstructor, _
			        "continue" : TokenTypes.KeywordContinue, _
			        "default" : TokenTypes.KeywordDefault, _
			        "do" : TokenTypes.KeywordDo, _
			          "downto" : TokenTypes.KeywordDownTo, _
			  "else" : TokenTypes.KeywordElse, _
			    "elseif" : TokenTypes.KeywordElseIf, _
			      "end" : TokenTypes.KeywordEnd, _
			      "enum" : TokenTypes.KeywordEnum, _
			      "exit" : TokenTypes.KeywordExit, _
			      "extends" : TokenTypes.KeywordExtends, _
			      "extension" : TokenTypes.KeywordExtension, _
			      "final" : TokenTypes.KeywordFinal, _
			      "finally" : TokenTypes.KeywordFinally, _
			        "for" : TokenTypes.KeywordFor, _
			          "function" : TokenTypes.KeywordFunction, _
			            "get" : TokenTypes.KeywordGet, _
			            "if" : TokenTypes.KeywordIf, _
			              "implements" : TokenTypes.KeywordImplements, _
			              "in" : TokenTypes.KeywordIn, _
			              "is" : TokenTypes.KeywordIs, _
			              "isnt" : TokenTypes.KeywordIsnt, _
			              "late" : TokenTypes.KeywordLate, _
			              "mixin" : TokenTypes.KeywordMixin, _
			              "new" : TokenTypes.KeywordNew, _
			        "next" : TokenTypes.KeywordNext, _
			        "not" : TokenTypes.KeywordNot, _
			        "on" : TokenTypes.KeywordOn, _
			        "operator" : TokenTypes.KeywordOperator, _
			        "optional" : TokenTypes.KeywordOptional, _
			        "or" : TokenTypes.KeywordOr, _
			        "required" : TokenTypes.KeywordRequired, _
			        "rethrow" : TokenTypes.KeywordRethrow, _
			        "return" : TokenTypes.KeywordReturn, _
			        "select" : TokenTypes.KeywordSelect, _
			          "set" : TokenTypes.KeywordSet, _
			          "static" : TokenTypes.KeywordStatic, _
			          "step" : TokenTypes.KeywordStep, _
			          "sub" : TokenTypes.KeywordSub, _
			            "super" : TokenTypes.KeywordSuper, _
			            "then" : TokenTypes.KeywordThen, _
			            "this" : TokenTypes.KeywordThis, _
			            "throw" : TokenTypes.KeywordThrow, _
			            "to" : TokenTypes.KeywordTo, _
			            "try" : TokenTypes.KeywordTry, _
			              "until" : TokenTypes.KeywordUntil, _
			              "var" : TokenTypes.KeywordVar, _
			              "wend" : TokenTypes.KeywordWend, _
			              "while" : TokenTypes.KeywordWhile, _
			                "with" : TokenTypes.KeywordWith, _
			                "xor" : TokenTypes.KeywordXor _
			                )
			                
			                Return rw
			                
			End Get
		#tag EndGetter
		Private Shared ReservedIdentifiers As BetterDictionary
	#tag EndComputedProperty


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
			Name="HasError"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
