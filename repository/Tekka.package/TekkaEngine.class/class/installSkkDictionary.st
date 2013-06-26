class initialization
installSkkDictionary
	"TekkaEngine installSkkDictionary"
	| dict |
	dict := Dictionary new.
	FileStream
		readOnlyFileNamed: (UIManager default chooseFileMatching: nil)
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
								in: [:line | line first isLetter
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
											dict at: key put: variants contents]]]]].
	^ SkkDictionary := dict