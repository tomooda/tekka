utilities
character: anInteger 
	^ Character
		value: (NeedsLeadingChar
				ifTrue: [anInteger]
				ifFalse: [anInteger bitAnd: 16r3FFFFF])