sole instance
current
	^ Current
		ifNil: [Current := self new]