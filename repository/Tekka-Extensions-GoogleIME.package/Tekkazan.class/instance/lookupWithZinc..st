private
lookupWithZinc: aString 
	| encoded url response json ret |
	encoded := (Smalltalk at: #ZnPercentEncoder) new encode: aString.
	url := ('http://www.google.com/transliterate?langpair=ja-Hira|ja&text=' , encoded) asUrl.
	response := (Smalltalk at: #ZnEasy)
				get: url.
	json := response contents
				ifNil: [^ self].
	ret := ((Smalltalk at: #NeoJSONReader)
				on: json readStream) next.
	^ ret first second
		collect: [:each | ret allButFirst
				inject: each
				into: [:prev :each2 | prev , each2 second first]]