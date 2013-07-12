class initialization
ifInstalled: aBlock 
	^ Current
		ifNotNil: [:current | aBlock cull: current]