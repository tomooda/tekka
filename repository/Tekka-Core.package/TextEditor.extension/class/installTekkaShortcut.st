*Tekka-Core-class initialization
installTekkaShortcut
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekkaClass | 
			self cmdActions ifNil: [self initializeCmdKeyShortcuts].
			self cmdActions at: $j asciiValue + 1 put: #tekka:]