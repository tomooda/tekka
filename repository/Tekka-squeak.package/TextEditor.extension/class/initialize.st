*Tekka-Platform.squeak-class initialization
initialize 
	"Initialize the keyboard shortcut maps and the shared buffers
	for copying text across views and managing again and undo." 
 
	"TextEditor initialize"

	UndoSelection := FindText := ChangeText := Text new.
	UndoMessage := Message selector: #halt.

	self initializeCmdKeyShortcuts.
	self initializeShiftCmdKeyShortcuts.
	self initializeYellowButtonMenu.
	self initializeShiftedYellowButtonMenu.
	self installTekkaShortcut