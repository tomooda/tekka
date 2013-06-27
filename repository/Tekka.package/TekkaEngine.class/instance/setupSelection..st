servicing
setupSelection: aTextEditor 
	| start end |
	aTextEditor hasSelection
		ifTrue: [^ self].
	start := aTextEditor selectionInterval first.
	end := aTextEditor selectionInterval last.
	(start >= 2
			and: [(aTextEditor paragraph text at: start - 1) isLetter])
		ifTrue: [[start >= 2
				and: [| char |
					char := aTextEditor paragraph text at: start - 1.
					((char between: $a and: $z)
							or: [char between: $A and: $Z])
						or: [#($' $- $~ ) includes: char]]]
				whileTrue: [start := start - 1]]
		ifFalse: [0
				to: (9 min: end - 1)
				do: [:numChars | (SkkDictionary
							includesKey: (aTextEditor paragraph text asString copyFrom: end - numChars to: end))
						ifTrue: [start := end - numChars]]].
	aTextEditor selectFrom: start to: end