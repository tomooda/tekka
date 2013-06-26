servicing
firstCandidate: aTextEditor 
	| start end roman kana entries addEntry |
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
	aTextEditor selectFrom: start to: end.
	original := aTextEditor selection asString.
	roman := original asLowercase.
	kana := self romanToKana: roman.
	entries := OrderedCollection new: 20.
	addEntry := [:entry | (entries includes: entry) ifFalse: [entries add: entry]].
	addEntry value: kana.
	(roman size >= 2 and: [(roman last between: $a and: $z) and: [roman last isVowel not]])
		ifTrue: [(SkkDictionary
						at: ((self
								romanToKana: (roman copyFrom: 1 to: roman size - 1))
								copyWith: roman last)
						ifAbsent: [#()])
						do: [:stem | addEntry value: (stem copyWith: roman last)]].
	(SkkDictionary
				at: original asLowercase
				ifAbsent: [#()]) do: [ :entry | addEntry value: entry].
	(SkkDictionary
				at: kana
				ifAbsent: [#()]) do: [ :entry | addEntry value: entry].
	addEntry value: (self hiraganaToKatakana: kana).
	addEntry value: original.
	candidates := entries asArray.
	aTextEditor
		replace: aTextEditor selectionInterval
		with: kana
		and: [aTextEditor selectAt: aTextEditor stopIndex]