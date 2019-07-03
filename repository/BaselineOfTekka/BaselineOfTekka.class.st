Class {
	#name : #BaselineOfTekka,
	#superclass : #BaselineOf,
	#category : 'BaselineOfTekka'
}

{ #category : #baselines }
BaselineOfTekka >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Tekka-Core';
				package: 'Tekka-Extensions-GoogleIME' with: [ spec requires: 'Tekka-Core' ].
			spec group: 'default' with: #('Tekka-Core').
			spec group: 'Tekkazan' with: #('Tekka-Core' 'Tekka-Extensions-GoogleIME') ]
]
