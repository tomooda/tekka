*Tekka-Platform.pharo
buildTekkaShortcut: aBuilder
	<keymap>
	(aBuilder shortcut: #tekka) 
		category: #TextEditor
		default: $j ctrl
		do: [ :target | | morph | morph := target textMorph. morph handleEdit: [ morph editor tekka ]]
		description: 'Tekka'.
	(aBuilder shortcut: #tekkaCommand) 
		category: #TextEditor
		default: $j command
		do: [ :target | | morph | morph := target textMorph. morph handleEdit: [ morph editor tekka ]]
		description: 'Tekka'