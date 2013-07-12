extensions
removeExtension: aDictionary 
	(extensions notNil
			and: [extensions includes: aDictionary])
		ifFalse: [^ aDictionary].
	extensions := (extensions
				ifNil: [Array new])
				copyWithout: aDictionary.
	^ aDictionary