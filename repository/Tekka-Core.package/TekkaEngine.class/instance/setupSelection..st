servicing
setupSelection: aTextEditor 
	| isRoman start end |
	aTextEditor hasSelection
		ifTrue: [^ self].
	isRoman := [:char | ((char between: $a and: $z)
					or: [char between: $A and: $Z])
				or: [#($' $- $~ ) includes: char]].
	start := aTextEditor selectionInterval first.
	end := aTextEditor selectionInterval last.
	(start >= 2
			and: [isRoman
					value: (aTextEditor paragraph text at: start - 1)])
		ifTrue: [[start >= 2
				and: [isRoman
						value: (aTextEditor paragraph text at: start - 1)]]
				whileTrue: [start := start - 1]]
		ifFalse: [0
				to: (9 min: end - 1)
				do: [:numChars | (SkkDictionary
							includesKey: (aTextEditor paragraph text asString copyFrom: end - numChars to: end))
						ifTrue: [start := end - numChars]]].
	aTextEditor selectFrom: start to: end