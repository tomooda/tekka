private
lookupWithZinc: aString 
	| answer |
	answer := WideString new writeStream.
	(((Smalltalk at: #ZnEasy)
		get: ('http://www.google.com/transliterate?langpair=ja-Hira|ja&text='
				, ((Smalltalk at: #ZnPercentEncoder) new encode: aString)) asUrl) contents findTokens: ']]')
		do: [:part | ((part copyFrom: 2 to: part size)
				findTokens: $,
				escapedBy: $\)
				ifNotEmpty: [:terms | terms size >= 2
						ifTrue: [(terms second findTokens: $" escapedBy: $\)
								in: [:entry | entry size = 3
										ifTrue: [answer nextPutAll: entry second]]]]].
	^ Array with: answer contents