class initialization
downloadSkkDic
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