testing
isContinuation: aTextEditor 
	^ aTextEditor hasSelection not
		and: [self lastSpit
				in: [:lastSpit | lastSpit notNil
						and: [lastSpit notEmpty
								and: [aTextEditor selectionInterval first - 1
										in: [:end | lastSpit
												= (aTextEditor paragraph text asString
														copyFrom: (end - lastSpit size + 1 max: 1)
														to: end)]]]]]