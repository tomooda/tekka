*Tekka-Core
buildTekkaShortcut: aBuilder
	<keymap>
	(aBuilder shortcut: #tekka) 
		category: RubTextEditor name
		default: $j ctrl
		do: [ :target | target editor tekka ]
		description: 'Tekka'.
	(aBuilder shortcut: #tekkaCommand) 
		category: RubTextEditor name
		default: $j command
		do: [ :target | target editor tekka ]
		description: 'Tekka'
