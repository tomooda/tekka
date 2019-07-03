Class {
	#name : #Tekkazan,
	#superclass : #Object,
	#classVars : [
		'Current'
	],
	#category : 'Tekka-Extensions-GoogleIME'
}

{ #category : #'class initialization' }
Tekkazan class >> activate [
	"Tekkazan activate"
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekkaEngine | tekkaEngine current addExtension: self current]
]

{ #category : #utilities }
Tekkazan class >> at: aString ifAbsent: aBlock [
	^ self current at: aString ifAbsent: aBlock
]

{ #category : #'sole instance' }
Tekkazan class >> current [
	^ Current
		ifNil: [Current := self new]
]

{ #category : #'class initialization' }
Tekkazan class >> deactivate [
	^ self inactivate
]

{ #category : #'class initialization' }
Tekkazan class >> disable [
	^ self inactivate
]

{ #category : #'class initialization' }
Tekkazan class >> enable [
	^ self activate
]

{ #category : #'class initialization' }
Tekkazan class >> inactivate [
	"Tekkazan inactivate"
	Smalltalk
		at: #TekkaEngine
		ifPresent: [:tekkaEngine | tekkaEngine current removeExtension: self current]
]

{ #category : #testing }
Tekkazan class >> isActive [
	"Tekkazan isActive"

	^ (Smalltalk globals includesKey: #TekkaEngine)
		and:
			[ (Smalltalk at: #TekkaEngine) current includesExtension: self current ]
]

{ #category : #settings }
Tekkazan class >> tekkazanSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #Tekka)
		label: 'Tekka';
		description: 'Tekka related settings';
		noOrdering;
		with: [ (aBuilder setting: #useTekkazan)
				label: 'Use Tekkazan (Google IME)';
				noOrdering;
				description:
					'If checked then Tekka will use Google IME API to convert a Japanese phrase.' ]
]

{ #category : #settings }
Tekkazan class >> useTekkazan [
	^ self isActive
]

{ #category : #settings }
Tekkazan class >> useTekkazan: aBoolean [
	aBoolean = true
		ifTrue: [ self activate ]
		ifFalse: [ self inactivate ]
]

{ #category : #accessing }
Tekkazan >> at: aString ifAbsent: aBlock [
	^ [ self candidatesFor: aString ]
		on: NameLookupFailure
		do: [ aBlock value ]
]

{ #category : #private }
Tekkazan >> candidatesFor: aString [
	"Tekkazan new candidatesFor: '日本語を入力する'"

	| answer |
	answer := WideString new writeStream.
	(((Smalltalk at: #ZnEasy)
		get:
			('http://www.google.com/transliterate?langpair=ja-Hira|ja&text='
				, ((Smalltalk at: #ZnPercentEncoder) new encode: aString)) asUrl)
		contents findTokens: ']]')
		do: [ :part | 
			((part copyFrom: 2 to: part size) findTokens: $, escapedBy: $\)
				ifNotEmpty: [ :terms | 
					terms size >= 2
						ifTrue: [ (terms second findTokens: $" escapedBy: $\)
								in: [ :entry | 
									entry size = 3
										ifTrue: [ answer nextPutAll: entry second ] ] ] ] ].
	^ Array with: answer contents
]
