servicing
hiraganaToKatakana: aString 
	^ aString
		collect: [:char | HiraganaToKatakana
				at: char
				ifAbsent: [char]]