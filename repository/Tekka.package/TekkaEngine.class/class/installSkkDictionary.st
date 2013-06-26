class initialization
installSkkDictionary
	"TekkaEngine installSkkDictionary"
	| dict |
	dict := Dictionary new.
	((FileStream isAFileNamed: self skkDicFilename) not
			and: [UIManager default confirm: 'SKK-JISYO.Lをダウンロードし保存しますか？ SKK-JISYO.LはGPLでライセンスされています。詳しくは http://www.gnu.org/licenses/gpl.html を参照ください。' , String cr , 'Do you want to download SKK-JISYO.L? SKK-JISYO.L is distributed under GPL. Please see http://www.gnu.org/licenses/gpl.html for details.'])
		ifTrue: [self downloadSkkDic ].
	(FileStream isAFileNamed: self skkDicFilename)
		ifTrue: [FileStream
				readOnlyFileNamed: self skkDicFilename
				do: [:stream | 
					stream converter: EUCJPTextConverter new.
					UIManager default
						displayProgress: 'Reading SKK dictionary'
						at: World center
						from: 0
						to: stream size
						during: [:progress | [stream atEnd]
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