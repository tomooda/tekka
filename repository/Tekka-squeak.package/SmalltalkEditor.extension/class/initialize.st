*Tekka-squeak-class initialization
initialize
	"SmalltalkEditor initialize"
	self initializeCmdKeyShortcuts.
	self initializeShiftCmdKeyShortcuts.
	self initializeYellowButtonMenu.
	self initializeShiftedYellowButtonMenu.
	self installTekkaShortcut