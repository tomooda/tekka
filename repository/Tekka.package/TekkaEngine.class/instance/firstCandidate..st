servicing
firstCandidate: aTextEditor 
	| start end roman kana entries |
	aTextEditor hasSelection
		ifTrue: [^ self].
	start := aTextEditor selectionInterval first.
	end := aTextEditor selectionInterval last.
	[start > 1
		and: [| char |
			char := aTextEditor paragraph text at: start - 1.
			((char between: $a and: $z)
					or: [char between: $A and: $Z])
				or: [#($' $- $~ ) includes: char]]]
		whileTrue: [start := start - 1].
	aTextEditor selectFrom: start to: end.
	roman := aTextEditor selection asString.
	original := roman.
	kana := self romanToKana: roman.
	entries := Array new writeStream.
	entries nextPut: kana.
	roman size >= 2
		ifTrue: [entries
				nextPutAll: ((SkkDictionary
						at: ((self
								romanToKana: (roman copyFrom: 1 to: roman size - 1))
								copyWith: roman last)
						ifAbsent: [#()])
						collect: [:stem | stem copyWith: roman last])].
	entries
		nextPutAll: (SkkDictionary
				at: original asLowercase
				ifAbsent: [#()]).
	entries
		nextPutAll: (SkkDictionary
				at: kana
				ifAbsent: [#()]).
	entries
		nextPut: (self hiraganaToKatakana: kana).
	entries nextPut: original.
	candidates := entries contents.
	aTextEditor
				replace: aTextEditor selectionInterval
				with: kana
				and: [aTextEditor selectAt: aTextEditor stopIndex]