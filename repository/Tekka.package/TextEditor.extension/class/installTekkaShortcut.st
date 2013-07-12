*Tekka-class initialization
installTekkaShortcut
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekkaClass | tekkaClass
				ifInstalled: [self cmdActions at: $j asciiValue + 1 put: #tekka:]]