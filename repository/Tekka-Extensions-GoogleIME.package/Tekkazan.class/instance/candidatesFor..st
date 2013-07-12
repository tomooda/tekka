private
candidatesFor: aString 
	^ ((Smalltalk includesKey: #ZnEasy)
			and: [Smalltalk includesKey: #ZnPercentEncoder])
		ifTrue: [self lookupWithZinc: aString]
		ifFalse: [self lookupWithHttpSocket: aString]