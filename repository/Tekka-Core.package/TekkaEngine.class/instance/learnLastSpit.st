servicing
learnLastSpit
	| bringFirst |
	bringFirst :=	[:key :entry | (SkkDictionary
								at: key
								ifAbsent: [])
								ifNotNilDo: [:entries | (entries includes: entry)
										ifTrue: [SkkDictionary at: key put: (Array with: entry)
													, (entries copyWithout: entry)]]].
	keys
		ifNotNil: [self lastSpit
				ifNotNil: [:lastSpit | keys
						do: [:key | bringFirst value: key value: lastSpit.
							lastSpit size >= 2
										ifTrue: [bringFirst value: key value: (lastSpit copyFrom: 1 to: lastSpit size - 1)]]]].