servicing
convert: aTextEditor 
	(self isContinuation: aTextEditor)
		ifTrue: [self nextCandidate: aTextEditor]
		ifFalse: [self firstCandidate: aTextEditor]