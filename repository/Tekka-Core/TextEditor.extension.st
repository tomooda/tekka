Extension { #name : #TextEditor }

{ #category : #'*Tekka-Core' }
TextEditor class >> buildTekkaShortcut: aBuilder [
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

]

{ #category : #'*Tekka-Core' }
TextEditor class >> installTekkaShortcut [
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekkaClass | 
			self cmdActions ifNil: [self initializeCmdKeyShortcuts].
			self cmdActions at: $j asciiValue + 1 put: #tekka:]
]

{ #category : #'*Tekka-Core' }
TextEditor >> tekka [
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekka | tekka current convert: self]
]

{ #category : #'*Tekka-Core' }
TextEditor >> tekka: aKeyboardEvent [
	self tekka.
	^ true
]
