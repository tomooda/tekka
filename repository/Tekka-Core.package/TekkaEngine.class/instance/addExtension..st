extensions
addExtension: aDictionary 
	(extensions notNil
			and: [extensions includes: aDictionary])
		ifTrue: [^ aDictionary].
	extensions := (extensions
				ifNil: [Array new])
				copyWith: aDictionary.
	^ aDictionary