private
lookupWithHttpSocket: aString 
	"GoogleIMEDictionary new lookupWithHttpSocket: 'にほんごをにゅうりょくする'"
	| answer |
	answer := WideString new writeStream.
	(((HTTPSocket httpGet: 'http://www.google.com/transliterate?langpair=ja-Hira|ja&text=' , aString) contents convertFromEncoding: 'utf-8')
		findTokens: ']]')
		do: [:part | ((part copyFrom: 2 to: part size) findTokens: $, escapedBy: $\)
				ifNotEmpty: [:terms | terms size >= 2
						ifTrue: [(terms second findTokens: $" escapedBy: $\)
								in: [:entry | entry size = 3
										ifTrue: [answer nextPutAll: entry second]]]]].
	^ Array with: answer contents