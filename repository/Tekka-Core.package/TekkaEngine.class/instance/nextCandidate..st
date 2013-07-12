servicing
nextCandidate: aTextEditor 
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