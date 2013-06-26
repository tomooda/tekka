utilities
readline: aStream 
	aStream atEnd
		ifTrue: [^ nil].
	^ WideString
		new: 1000
		streamContents: [:stream | | ch | [(ch := aStream next) == nil
				or: [(CharacterSet crlf includes: ch)
						and: [ch = Character cr
								ifTrue: [aStream peekFor: Character lf].
							true]]]
				whileFalse: [stream nextPut: ch]]