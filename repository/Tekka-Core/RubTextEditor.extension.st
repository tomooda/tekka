Extension { #name : #RubTextEditor }

{ #category : #'*Tekka-Core' }
RubTextEditor class >> buildTekkaShortcut: aBuilder [
	<keymap>
	(aBuilder shortcut: #tekka) 
		category: #Tekka
		default: $j ctrl
		do: [ :target | target editor tekka ]
		description: 'Tekka'.
	(aBuilder shortcut: #tekkaCommand) 
		category: #Tekka
		default: $j command
		do: [ :target | target editor tekka ]
		description: 'Tekka'

]

{ #category : #'*Tekka-Core' }
RubTextEditor >> tekka [
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekka | tekka current convert: self]

]

{ #category : #'*Tekka-Core' }
RubTextEditor >> tekka: aKeyboardEvent [
	self tekka.
	^ true

]
