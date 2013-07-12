class initialization
setupNeedsLeadingChar
	NeedsLeadingChar := ((String fromByteArray: #[164 162]) convertFromEncoding: 'eucjp') first leadingChar > 0