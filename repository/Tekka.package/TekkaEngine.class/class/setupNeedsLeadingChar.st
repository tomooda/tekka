class initialization
setupNeedsLeadingChar
	SkkDictionary ifNil: [ ^ NeedsLeadingChar := true ].
	SkkDictionary
		keysDo: [ :key | 
			key
				do: [ :char | 
					char asciiValue >= 256
						ifTrue: [ ^ NeedsLeadingChar := char leadingChar > 0 ] ] ]