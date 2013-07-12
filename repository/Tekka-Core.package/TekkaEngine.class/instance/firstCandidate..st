servicing
firstCandidate: aTextEditor 
	| roman kana entries addEntry |
	self learnLastSpit.
	self setupSelection: aTextEditor.
	original := aTextEditor selection asString.
	roman := original asLowercase.
	kana := self romanToKana: roman.
	entries := OrderedCollection new: 20.
	keys := OrderedCollection new: 5.
	addEntry := [:entry | (entries includes: entry)
				ifFalse: [entries add: entry]].
	extensions ifNotNil: [ :exts | exts do: [ :extension |
			(extension at: kana ifAbsent: [#()]) do: [ :entry | addEntry value: entry]]].
	kana ~= original
		ifTrue: [addEntry value: kana].
	(roman size >= 2
			and: [(roman last between: $a and: $z)
					and: [roman last isVowel not
							or: [roman size >= 3
									and: [(roman at: roman size - 1) isVowel]]]])
		ifTrue: [((self
				romanToKana: (roman copyFrom: 1 to: roman size - 1))
				copyWith: roman last)
				in: [:key | 
					keys add: key.
					(SkkDictionary
						at: key
						ifAbsent: [#()])
						do: [:stem | addEntry
								value: (stem
										copyWith: (roman last isVowel
												ifTrue: [(self romanToKana: roman last asString) first]
												ifFalse: [roman last]))]]].
	original asLowercase
		in: [:key | 
			keys add: key.
			(SkkDictionary
				at: key
				ifAbsent: [#()])
				do: [:entry | addEntry value: entry]].
	keys add: kana.
	(SkkDictionary
		at: kana
		ifAbsent: [#()])
		do: [:entry | addEntry value: entry].
	addEntry
		value: (self hiraganaToKatakana: kana).
	addEntry value: original.
	candidates := entries asArray.
	aTextEditor
		replace: aTextEditor selectionInterval
		with: candidates first
		and: [aTextEditor selectAt: aTextEditor stopIndex]