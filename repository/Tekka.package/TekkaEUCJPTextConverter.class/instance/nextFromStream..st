conversion
nextFromStream: aStream

	| character1 character2 offset value1 value2 nonUnicodeChar |
	aStream isBinary ifTrue: [^ aStream basicNext].
	character1 := aStream basicNext ifNil: [^ nil].
	character1 asciiValue <= 127 ifTrue: [^ character1].
	character2 := aStream basicNext ifNil: [^ nil].
	offset := 16rA1.
	value1 := character1 asciiValue - offset.
	value2 := character2 asciiValue - offset.
	(value1 < 0 or: [value1 > 93]) ifTrue: [^ nil].
	(value2 < 0 or: [value2 > 93]) ifTrue: [^ nil].

	nonUnicodeChar := Character value: value1 * 94 + value2 + (self leadingChar bitShift: 22).
	^ TekkaEngine character: nonUnicodeChar asUnicode +  (self languageEnvironment leadingChar bitShift: 22).
