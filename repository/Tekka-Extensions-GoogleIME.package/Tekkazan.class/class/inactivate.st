class initialization
inactivate
	"Tekkazan inactivate"
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekkaEngine | tekkaEngine current removeExtension: self current]