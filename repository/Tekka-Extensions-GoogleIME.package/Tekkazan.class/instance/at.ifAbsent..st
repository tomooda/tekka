accessing
at: aString ifAbsent: aBlock
	^ [ self candidatesFor: aString ]
		on: NameLookupFailure
		do: [ aBlock value ]