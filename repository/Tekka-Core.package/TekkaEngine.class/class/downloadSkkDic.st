class initialization
downloadSkkDic
	| httpStream |
	httpStream := GZipReadStream on: ((HTTPSocket httpGet: self skkDicURL) binary; yourself).
	FileStream
		newFileNamed: self skkDicFilename
		do: [:localStream | 
			localStream binary.
			[httpStream atEnd]
				whileFalse: [localStream nextPut: httpStream next]]