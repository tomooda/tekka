servicing
romanToKana: aString 
	"TekkaEngine new romanToKana: 'janjaan'"
	"TekkaEngine new romanToKana: 'jyan''jya-n'"
	"TekkaEngine new romanToKana: 'jixyannjixya~n'"
	| kana consonant |
	kana := String new writeStream.
	consonant := String new.
	aString asLowercase
		do: [:char | char = $~
				ifTrue: [kana nextPutAll: consonant.
					kana
						nextPut: (self character: 21036894).
					consonant := String new]
				ifFalse: [char = $-
						ifTrue: [kana nextPutAll: consonant.
							kana
								nextPut: (self character: 20984060).
							consonant := String new]
						ifFalse: [char isVowel
								ifTrue: [(RomanToKana
										at: consonant
										ifAbsent: [])
										ifNil: [kana nextPutAll: consonant;
												 nextPut: char]
										ifNotNil: [:kanas | kana
												nextPutAll: (kanas
														at: (VowelIndexDictionary at: char))].
									consonant := String new]
								ifFalse: [((char = $n
												or: [char = $'])
											and: [consonant = 'n'])
										ifTrue: [kana
												nextPut: (self character: 20983955).
											consonant := String new]
										ifFalse: [((char between: $a and: $z) or: [char between: $A and: $Z]) not
												ifTrue: [kana nextPutAll: consonant;
														 nextPut: char.
													consonant := String new]
												ifFalse: [(consonant = 'n' and: [char ~= $y])
														ifTrue: [kana
																nextPut: (self character: 20983955).
															consonant := String new]
														ifFalse: [consonant = char asString ifTrue: [kana nextPut: (self character: 20983907). consonant := String new]].
													consonant := consonant copyWith: char]]]]]].
	consonant = 'n'
		ifTrue: [kana
				nextPut: (self character: 20983955).
			consonant := String new].
	^ kana contents , consonant