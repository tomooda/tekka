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

{ #category : #accessing }
Tekkazan >> at: aString ifAbsent: aBlock [
	^ [ self candidatesFor: aString ]
		on: NameLookupFailure
		do: [ aBlock value ]
]

{ #category : #private }
Tekkazan >> candidatesFor: aString [ 
	^ ((Smalltalk includesKey: #ZnEasy)
			and: [Smalltalk includesKey: #ZnPercentEncoder])
		ifTrue: [self lookupWithZinc: aString]
		ifFalse: [self lookupWithHttpSocket: aString]
]

{ #category : #private }
Tekkazan >> lookupWithHttpSocket: aString [ 
	"Tekkazan new lookupWithHttpSocket: 'にほんごをにゅうりょくする'"
	| answer |
	answer := WideString new writeStream.
	(((HTTPSocket httpGet: 'http://www.google.com/transliterate?langpair=ja-Hira|ja&text=' , aString) contents convertFromEncoding: 'utf-8')
		findTokens: ']]')
		do: [:part | ((part copyFrom: 2 to: part size) findTokens: $, escapedBy: $\)
				ifNotEmpty: [:terms | terms size >= 2
						ifTrue: [(terms second findTokens: $" escapedBy: $\)
								in: [:entry | entry size = 3
										ifTrue: [answer nextPutAll: entry second]]]]].
	^ Array with: answer contents
]

{ #category : #private }
Tekkazan >> lookupWithZinc: aString [ 
	"Tekkazan new lookupWithZinc: 'にほんごをにゅうりょくする'"
	| answer |
	answer := WideString new writeStream.
	(((Smalltalk at: #ZnEasy)
		get: ('http://www.google.com/transliterate?langpair=ja-Hira|ja&text='
				, ((Smalltalk at: #ZnPercentEncoder) new encode: aString)) asUrl) contents findTokens: ']]')
		do: [:part | ((part copyFrom: 2 to: part size)
				findTokens: $,
				escapedBy: $\)
				ifNotEmpty: [:terms | terms size >= 2
						ifTrue: [(terms second findTokens: $" escapedBy: $\)
								in: [:entry | entry size = 3
										ifTrue: [answer nextPutAll: entry second]]]]].
	^ Array with: answer contents
]
