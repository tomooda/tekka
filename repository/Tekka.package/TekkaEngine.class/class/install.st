class initialization
install
	"TekkaEngine install"
	self installSkkDictionary.
	self setupNeedsLeadingChar.
	self installHiraganaToKatakana.
	self installRomanToKana.
	self installVowelIndexDictionary.
	TextEditor cmdActions at: $j asciiValue + 1 put: #tekka:.
	TextEditor
		allSubclassesDo: [:editorClass | editorClass cmdActions at: $j asciiValue + 1 put: #tekka:]