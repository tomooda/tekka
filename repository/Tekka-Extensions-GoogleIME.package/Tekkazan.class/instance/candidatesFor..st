private
candidatesFor: aString 
	^ ((Smalltalk includesKey: #ZnEasy)
			and: [(Smalltalk includesKey: #ZnPercentEncoder)
					and: [Smalltalk includesKey: #NeoJSONReader]])
		ifTrue: [self lookupWithZinc: aString]
		ifFalse: [self lookupWithHttpSocket: aString]