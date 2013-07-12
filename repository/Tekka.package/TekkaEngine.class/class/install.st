class initialization
install
	"TekkaEngine install"
	self setupNeedsLeadingChar.
	self installSkkDictionary.
	self installHiraganaToKatakana.
	self installRomanToKana.
	self installVowelIndexDictionary.
	Current := self new.
	TextEditor installTekkaShortcut.
	TextEditor
		allSubclassesDo: [:editorClass | editorClass installTekkaShortcut]