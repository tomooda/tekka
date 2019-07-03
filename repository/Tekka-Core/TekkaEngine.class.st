Class {
	#name : #TekkaEngine,
	#superclass : #Object,
	#instVars : [
		'original',
		'candidates',
		'keys',
		'extensions'
	],
	#classVars : [
		'Current',
		'HiraganaToKatakana',
		'NeedsLeadingChar',
		'RomanToKana',
		'SkkDictionary',
		'VowelIndexDictionary'
	],
	#category : 'Tekka-Core'
}

{ #category : #utilities }
TekkaEngine class >> character: anInteger [ 
	^ Character
		value: (NeedsLeadingChar
				ifTrue: [anInteger]
				ifFalse: [anInteger bitAnd: 16r3FFFFF])
]

{ #category : #'sole instance' }
TekkaEngine class >> current [
	^ Current
		ifNil: [Current := self new]
]

{ #category : #'class initialization' }
TekkaEngine class >> downloadSkkDic [
	(Smalltalk includesKey: #HTTPSocket)
		ifTrue: [ 
			| httpStream |
			httpStream := GZipReadStream
				on:
					(((Smalltalk at: #HTTPSocket) httpGet: self skkDicURL)
						binary;
						yourself).
			FileStream
				newFileNamed: self skkDicFilename
				do: [ :localStream | 
					localStream binary.
					[ httpStream atEnd ] whileFalse: [ localStream nextPut: httpStream next ] ].
			^ self ].
	(Smalltalk includesKey: #ZnClient)
		ifTrue: [ 
			| gzipStream |
			gzipStream := (Smalltalk at: #GZipReadStream)
				on:
					(ZnClient new
						beOneShot;
						get: self skkDicURL asZnUrl).
			FileStream
				newFileNamed: self skkDicFilename
				do: [ :localStream | 
					localStream binary.
					[ gzipStream atEnd ] whileFalse: [ localStream nextPut: gzipStream next ] ].
			^ self ].
	^ UIManager default inform: 'HTTPSocket or ZnHTTPSocketFacade required to download the dictionary.'
]

{ #category : #'class initialization' }
TekkaEngine class >> ifInstalled: aBlock [ 
	^ Current
		ifNotNil: [:current | aBlock cull: current]
]

{ #category : #'class initialization' }
TekkaEngine class >> install [
	"TekkaEngine install"
	self setupNeedsLeadingChar.
	self installSkkDictionary.
	self installHiraganaToKatakana.
	self installRomanToKana.
	self installVowelIndexDictionary.
	Current := self new.
	TextEditor installTekkaShortcut.
	TextEditor
		allSubclassesDo: [:editorClass | editorClass installTekkaShortcut]
]

{ #category : #'class initialization' }
TekkaEngine class >> installHiraganaToKatakana [
	"TekkaEngine installHiraganaToKatakana"
	| dict composer |
	dict := Dictionary new.
	composer := [:hiras :katas | hiras
				with: katas
				do: [:hira :kata | dict
						at: (self character: hira asciiValue)
						put: (self character: kata asciiValue)]].
	composer value: 'あいうえお' value: 'アイウエオ'.
	composer value: 'ぁぃぅぇぉ' value: 'ァィゥェォ'.
	composer value: 'ゔ' value: 'ヴ'.
	composer value: 'かきくけこ' value: 'カキクケコ'.
	composer value: 'がぎぐげご' value: 'ガギグゲゴ'.
	composer value: 'さしすせそ' value: 'サシスセソ'.
	composer value: 'ざじずぜぞ' value: 'ザジズゼゾ'.
	composer value: 'たちつてと' value: 'タチツテト'.
	composer value: 'だぢづでど' value: 'ダヂヅデド'.
	composer value: 'なにぬねの' value: 'ナニヌネノ'.
	composer value: 'はひふへほ' value: 'ハヒフヘホ'.
	composer value: 'ばびぶべぼ' value: 'バビブベボ'.
	composer value: 'ぱぴぷぺぽ' value: 'パピプペポ'.
	composer value: 'まみむめも' value: 'マミムメモ'.
	composer value: 'やゆよ' value: 'ヤユヨ'.
	composer value: 'ゃゅょ' value: 'ャュョ'.
	composer value: 'らりるれろ' value: 'ラリルレロ'.
	composer value: 'わをんっゎ' value: 'ワヲンッヮ'.
	^ HiraganaToKatakana := dict
]

{ #category : #'class initialization' }
TekkaEngine class >> installRomanToKana [
	"TekkaEngine installRomanToKana"
	
	| dict composer |
	dict := Dictionary new.
	composer := [ :consonant :kanas | dict at: consonant put: (kanas asArray collect: [ :kana | kana asString collect: [ :c | self character: c asciiValue]])].
	composer value: '' value: 'あいうえお'.
	composer value: 'b' value: 'ばびぶべぼ'.
	composer value: 'by' value: #('びゃ' 'びぃ' 'びゅ' 'びぇ' 'びょ').
	composer value: 'cy' value: #('ちゃ' 'ちぃ' 'ちゅ' 'ちぇ' 'ちょ').
	composer value: 'ch' value: #('ちゃ' 'ち' 'ちゅ' 'ちぇ' 'ちょ').
	composer value: 'd' value: 'だぢづでど'.
	composer value: 'dy' value: #('ぢゃ' 'ぢぃ' 'ぢゅ' 'ぢぇ' 'ぢょ').
	composer value: 'dh' value: #('でゃ' 'でぃ' 'でゅ' 'でぇ' 'でょ').
	composer value: 'f' value: #('ふぁ' 'ふぃ' 'ふ' 'ふぇ' 'ふぉ').
	composer value: 'fy' value: #('ふゃ' 'ふぃ' 'ふゅ' 'ふぇ' 'ふょ').
	composer value: 'g' value: 'がぎぐげご'.
	composer value: 'gy' value: #('ぎゃ' 'ぎぃ' 'ぎゅ' 'ぎぇ' 'ぎょ').
	composer value: 'h' value: 'はひふへほ'.
	composer value: 'hy' value: #('ひゃ' 'ひぃ' 'ひゅ' 'ひぇ' 'ひょ').
	composer value: 'j' value: #('じゃ' 'じ' 'じゅ' 'じぇ' 'じょ').
	composer value: 'jy' value: #('じゃ' 'じぃ' 'じゅ' 'じぇ' 'じょ').
	composer value: 'k' value: 'かきくけこ'.
	composer value: 'ky' value: #('きゃ' 'きぃ' 'きゅ' 'きぇ' 'きょ').
	composer value: 'l' value: 'らりるれろ'.
	composer value: 'ly' value: #('りゃ' 'りぃ' 'りゅ' 'りぇ' 'りょ').
	composer value: 'm' value: 'まみむめも'.
	composer value: 'my' value: #('みゃ' 'みぃ' 'みゅ' 'みぇ' 'みょ').
	composer value: 'n' value: 'なにぬねの'.
	composer value: 'ny' value: #('にゃ' 'にぃ' 'にゅ' 'にぇ' 'にょ').
	composer value: 'p' value: 'ぱぴぷぺぽ'.
	composer value: 'py' value: #('ぴゃ' 'ぴぃ' 'ぴゅ' 'ぴぇ' 'ぴょ').
	composer value: 'q' value: #('くぁ' 'くぃ' 'くぅ' 'くぇ' 'くぉ').
	composer value: 'r' value: 'らりるれろ'.
	composer value: 'ry' value: #('りゃ' 'りぃ' 'りゅ' 'りぇ' 'りょ').
	composer value: 's' value: 'さしすせそ'.
	composer value: 'sh' value: #('しゃ' 'し' 'しゅ' 'しぇ' 'しょ').
	composer value: 'sy' value: #('しゃ' 'しぃ' 'しゅ' 'しぇ' 'しょ').
	composer value: 't' value: 'たちつてと'.
	composer value: 'th' value: #('てゃ' 'てぃ' 'てゅ' 'てぇ' 'てょ').
	composer value: 'ts' value: #('つぁ' 'つぃ' 'つ' 'つぇ' 'つぉ').
	composer value: 'ty' value: #('ちゃ' 'ちぃ' 'ちゅ' 'ちぇ' 'ちょ').
	composer value: 'v' value: #('ゔぁ' 'ゔぃ' 'ゔ' 'ゔぇ' 'ゔぉ').
	composer value: 'vy' value: #('ゔゃ' 'ゔぃ' 'ゔゅ' 'ゔぇ' 'ゔょ').
	composer value: 'w' value: #('わ' 'うぃ' 'う' 'うぇ' 'を').
	composer value: 'wh' value: #('うぁ' 'うぃ' 'う' 'うぇ' 'うぉ').
	composer value: 'x' value: 'ぁぃぅぇぉ'.
	composer value: 'xt' value: #('xta' 'xti'  'っ' 'xte' 'xto').
	composer value: 'xw' value: 'ゎぃぅぇぉ'.
	composer value: 'xy' value: 'ゃぃゅぇょ'.
	composer value: 'y' value: #('や' 'い' 'ゆ' 'いぇ' 'よ').
	composer value: 'z' value: 'ざじずぜぞ'.
	composer value: 'zy' value: #('じゃ' 'じぃ' 'じゅ' 'じぇ' 'じょ').
	^ RomanToKana := dict
]

{ #category : #'class initialization' }
TekkaEngine class >> installSkkDictionary [
	"TekkaEngine installSkkDictionary"
	| dict |
	dict := Dictionary new.
	((FileStream isAFileNamed: self skkDicFilename) not
			and: [UIManager default confirm: 'SKK-JISYO.Lをダウンロードし保存しますか？ SKK-JISYO.LはGPLでライセンスされています。詳しくは http://www.gnu.org/licenses/gpl.html を参照ください。' , String cr , 'Do you want to download SKK-JISYO.L? SKK-JISYO.L is distributed under GPL. Please see http://www.gnu.org/licenses/gpl.html for details.'])
		ifTrue: [self downloadSkkDic].
	(FileStream isAFileNamed: self skkDicFilename)
		ifTrue: [FileStream
				readOnlyFileNamed: self skkDicFilename
				do: [:stream | 
					stream converter: TekkaEUCJPTextConverter new.
					UIManager default
						displayProgress: 'Reading SKK dictionary'
						from: 0
						to: stream size
						during: [:progressModel | 
							| progress progressThreshold |
							progressThreshold := 0.0.
							progress := [:value | value > progressThreshold
										ifTrue: [progressModel value: value.
											progressThreshold := value + 4096]].
							[stream atEnd]
								whileFalse: [progress value: stream position.
									(self readline: stream)
										in: [:line | (#($; $> ) includes: line first) not
												ifTrue: [| lineStream key variants |
													lineStream := line readStream.
													key := lineStream upTo: Character space.
													variants := Array new writeStream.
													lineStream next.
													[lineStream atEnd]
														whileFalse: [| variant |
															variant := lineStream upTo: $/.
															(variant includes: $;)
																ifTrue: [variant := variant copyFrom: 1 to: (variant indexOf: $;)
																					- 1].
															variants nextPut: variant].
													dict at: key put: variants contents]]]]]]
		ifFalse: [dict
				at: '.'
				put: (Array with: (self character: 20983810) asString).
			dict
				at: ','
				put: (Array with: (self character: 20983809) asString)].
	^ SkkDictionary := dict
]

{ #category : #'class initialization' }
TekkaEngine class >> installVowelIndexDictionary [
	"TekkaEngine installVowelIndexDictionary"
	^ VowelIndexDictionary := Dictionary new at: $a put: 1;
				 at: $i put: 2;
				 at: $u put: 3;
				 at: $e put: 4;
				 at: $o put: 5;
				 yourself
]

{ #category : #utilities }
TekkaEngine class >> readline: aStream [ 
	aStream atEnd
		ifTrue: [^ nil].
	^ WideString
		new: 1000
		streamContents: [:stream | | ch | [(ch := aStream next) == nil
				or: [(CharacterSet crlf includes: ch)
						and: [ch = Character cr
								ifTrue: [aStream peekFor: Character lf].
							true]]]
				whileFalse: [stream nextPut: ch]]
]

{ #category : #'class initialization' }
TekkaEngine class >> setupNeedsLeadingChar [
	NeedsLeadingChar := ((String fromByteArray: #[164 162]) convertFromEncoding: 'eucjp') first leadingChar > 0
]

{ #category : #resources }
TekkaEngine class >> skkDicFilename [
	^ 'SKK-JISYO.L' copy
]

{ #category : #resources }
TekkaEngine class >> skkDicURL [
	^ 'http://openlab.jp/skk/dic/SKK-JISYO.L.gz' copy
]

{ #category : #extensions }
TekkaEngine >> addExtension: aDictionary [ 
	(extensions notNil
			and: [extensions includes: aDictionary])
		ifTrue: [^ aDictionary].
	extensions := (extensions
				ifNil: [Array new])
				copyWith: aDictionary.
	^ aDictionary
]

{ #category : #servicing }
TekkaEngine >> character: anInteger [ 
	^ self class character: anInteger
]

{ #category : #servicing }
TekkaEngine >> convert: aTextEditor [ 
	(self isContinuation: aTextEditor)
		ifTrue: [self nextCandidate: aTextEditor]
		ifFalse: [self firstCandidate: aTextEditor]
]

{ #category : #servicing }
TekkaEngine >> firstCandidate: aTextEditor [ 
	| roman kana entries addEntry |
	self learnLastSpit.
	self setupSelection: aTextEditor.
	original := aTextEditor selection asString.
	roman := original asLowercase.
	kana := self romanToKana: roman.
	entries := OrderedCollection new: 20.
	keys := OrderedCollection new: 5.
	addEntry := [:entry | (entries includes: entry)
				ifFalse: [entries add: entry]].
	extensions ifNotNil: [ :exts | exts do: [ :extension |
			(extension at: kana ifAbsent: [#()]) do: [ :entry | addEntry value: entry]]].
	kana ~= original
		ifTrue: [addEntry value: kana].
	(roman size >= 2
			and: [(roman last between: $a and: $z)
					and: [roman last isVowel not
							or: [roman size >= 3
									and: [(roman at: roman size - 1) isVowel]]]])
		ifTrue: [((self
				romanToKana: (roman copyFrom: 1 to: roman size - 1))
				copyWith: roman last)
				in: [:key | 
					keys add: key.
					(SkkDictionary
						at: key
						ifAbsent: [#()])
						do: [:stem | addEntry
								value: (stem
										copyWith: (roman last isVowel
												ifTrue: [(self romanToKana: roman last asString) first]
												ifFalse: [roman last]))]]].
	original asLowercase
		in: [:key | 
			keys add: key.
			(SkkDictionary
				at: key
				ifAbsent: [#()])
				do: [:entry | addEntry value: entry]].
	keys add: kana.
	(SkkDictionary
		at: kana
		ifAbsent: [#()])
		do: [:entry | addEntry value: entry].
	addEntry
		value: (self hiraganaToKatakana: kana).
	addEntry value: original.
	candidates := entries asArray.
	aTextEditor
		replace: aTextEditor selectionInterval
		with: candidates first
		and: [aTextEditor selectAt: aTextEditor stopIndex]
]

{ #category : #servicing }
TekkaEngine >> hiraganaToKatakana: aString [ 
	^ aString
		collect: [:char | HiraganaToKatakana
				at: char
				ifAbsent: [char]]
]

{ #category : #extensions }
TekkaEngine >> includesExtension: aDictionary [
	^ extensions includes: aDictionary
]

{ #category : #testing }
TekkaEngine >> isContinuation: aTextEditor [ 
	^ aTextEditor hasSelection not
		and: [self lastSpit
				in: [:lastSpit | lastSpit notNil
						and: [lastSpit notEmpty
								and: [aTextEditor selectionInterval first - 1
										in: [:end | lastSpit
												= (aTextEditor paragraph text asString
														copyFrom: (end - lastSpit size + 1 max: 1)
														to: end)]]]]]
]

{ #category : #accessing }
TekkaEngine >> lastSpit [
	^ candidates
		ifNotNil: [candidates notEmpty
				ifTrue: [candidates first]]
]

{ #category : #servicing }
TekkaEngine >> learnLastSpit [
	| bringFirst |
	bringFirst :=	[:key :entry | (SkkDictionary
								at: key
								ifAbsent: [])
								ifNotNilDo: [:entries | (entries includes: entry)
										ifTrue: [SkkDictionary at: key put: (Array with: entry)
													, (entries copyWithout: entry)]]].
	keys
		ifNotNil: [self lastSpit
				ifNotNil: [:lastSpit | keys
						do: [:key | bringFirst value: key value: lastSpit.
							lastSpit size >= 2
										ifTrue: [bringFirst value: key value: (lastSpit copyFrom: 1 to: lastSpit size - 1)]]]].
]

{ #category : #servicing }
TekkaEngine >> nextCandidate: aTextEditor [ 
	| selection selectionStart selectionEnd |
	selection := self lastSpit.
	selectionEnd := aTextEditor selectionInterval first - 1.
	selectionStart := selectionEnd - selection size + 1 max: 1.
	aTextEditor selectFrom: selectionStart to: selectionEnd.
	candidates := (candidates copyFrom: 2 to: candidates size)
				copyWith: candidates first.
	aTextEditor
				replace: aTextEditor selectionInterval
				with: candidates first
				and: [aTextEditor selectAt: aTextEditor stopIndex]
]

{ #category : #extensions }
TekkaEngine >> removeExtension: aDictionary [ 
	(extensions notNil
			and: [extensions includes: aDictionary])
		ifFalse: [^ aDictionary].
	extensions := (extensions
				ifNil: [Array new])
				copyWithout: aDictionary.
	^ aDictionary
]

{ #category : #servicing }
TekkaEngine >> romanToKana: aString [ 
	"TekkaEngine new romanToKana: 'janjaan'"
	"TekkaEngine new romanToKana: 'jyan''jya-n'"
	"TekkaEngine new romanToKana: 'jixyannjixya~n'"
	| kana consonant |
	kana := String new writeStream.
	consonant := String new.
	aString asLowercase
		do: [:char | char = $~
				ifTrue: [kana nextPutAll: consonant.
					kana
						nextPut: (self character: 21036894).
					consonant := String new]
				ifFalse: [char = $-
						ifTrue: [kana nextPutAll: consonant.
							kana
								nextPut: (self character: 20984060).
							consonant := String new]
						ifFalse: [char isVowel
								ifTrue: [(RomanToKana
										at: consonant
										ifAbsent: [])
										ifNil: [kana nextPutAll: consonant;
												 nextPut: char]
										ifNotNil: [:kanas | kana
												nextPutAll: (kanas
														at: (VowelIndexDictionary at: char))].
									consonant := String new]
								ifFalse: [((char = $n
												or: [char = $'])
											and: [consonant = 'n'])
										ifTrue: [kana
												nextPut: (self character: 20983955).
											consonant := String new]
										ifFalse: [((char between: $a and: $z) or: [char between: $A and: $Z]) not
												ifTrue: [kana nextPutAll: consonant;
														 nextPut: char.
													consonant := String new]
												ifFalse: [(consonant = 'n' and: [char ~= $y])
														ifTrue: [kana
																nextPut: (self character: 20983955).
															consonant := String new]
														ifFalse: [consonant = char asString ifTrue: [kana nextPut: (self character: 20983907). consonant := String new]].
													consonant := consonant copyWith: char]]]]]].
	consonant = 'n'
		ifTrue: [kana
				nextPut: (self character: 20983955).
			consonant := String new].
	^ kana contents , consonant
]

{ #category : #servicing }
TekkaEngine >> setupSelection: aTextEditor [ 
	| isRoman start end |
	aTextEditor hasSelection
		ifTrue: [^ self].
	isRoman := [:char | ((char between: $a and: $z)
					or: [char between: $A and: $Z])
				or: [#($' $- $~ ) includes: char]].
	start := aTextEditor selectionInterval first.
	end := aTextEditor selectionInterval last.
	(start >= 2
			and: [isRoman
					value: (aTextEditor paragraph text at: start - 1)])
		ifTrue: [[start >= 2
				and: [isRoman
						value: (aTextEditor paragraph text at: start - 1)]]
				whileTrue: [start := start - 1]]
		ifFalse: [0
				to: (9 min: end - 1)
				do: [:numChars | (SkkDictionary
							includesKey: (aTextEditor paragraph text asString copyFrom: end - numChars to: end))
						ifTrue: [start := end - numChars]]].
	aTextEditor selectFrom: start to: end
]
