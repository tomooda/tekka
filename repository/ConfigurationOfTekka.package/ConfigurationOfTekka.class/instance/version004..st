versions
version004: spec 
	<version: '0.4' imports: #('0.1-baseline')>
	spec
		for: #common
		do: [spec blessing: #stable.
			spec description: 'Tekka is a compact and modeless input method for Japanese.'.
			spec package: 'Tekka-Core' with: 'Tekka-Core-tomooda.7'.
			spec package: 'Tekka-Extensions-GoogleIME' with: 'Tekka-Extensions-GoogleIME-tomooda.4'.
			spec package: 'Tekka-Platform' with: 'Tekka-Platform.squeak-tomooda.1'].
	