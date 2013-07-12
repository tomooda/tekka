accessing
lastSpit
	^ candidates
		ifNotNil: [candidates notEmpty
				ifTrue: [candidates first]]