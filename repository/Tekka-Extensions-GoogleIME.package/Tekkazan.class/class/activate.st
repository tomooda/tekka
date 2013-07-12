class initialization
activate
	"Tekkazan activate"
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekkaEngine | tekkaEngine current addExtension: self current]