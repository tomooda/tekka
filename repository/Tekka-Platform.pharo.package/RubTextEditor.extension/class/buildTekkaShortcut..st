*Tekka-Platform.pharo
buildTekkaShortcut: aBuilder
	<keymap>
	(aBuilder shortcut: #tekka) 
		category: #Tekka
		default: $j command
		do: [ :target | target editor tekka ]
		description: 'Tekka'
