class initialization
downloadSkkDic
	| httpStream |
	httpStream := nil.
	(httpStream isNil and: [ Smalltalk includesKey: #HTTPSocket ])
		ifTrue: [ 
			httpStream := GZipReadStream
				on:
					(((Smalltalk at: #HTTPSocket) httpGet: self skkDicURL)
						binary;
						yourself) ].
	(httpStream isNil and: [ Smalltalk includesKey: #ZnHTTPSocketFacade ])
		ifTrue: [ 
			httpStream := (Smalltalk at: #GZipReadStream)
				on:
					((ZnHTTPSocketFacade httpGet: self skkDicURL)
						binary;
						yourself) ].
	httpStream isNil
		ifTrue: [ UIManager default inform: 'HTTPSocket or ZnHTTPSocketFacade required to download the dictionary.' ].
	FileStream
		newFileNamed: self skkDicFilename
		do: [ :localStream | 
			localStream binary.
			[ httpStream atEnd ] whileFalse: [ localStream nextPut: httpStream next ] ]