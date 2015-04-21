versions
version006: spec
	<version: '0.6' imports: #('0.2-baseline')>
	spec
		for: #common
		do: [ 
			spec blessing: #stable.
			spec description: 'Tekka is a compact and modeless input method for Japanese.'.
			spec package: 'Tekka-Core' with: 'Tekka-Core-tomooda.9'.
			spec package: 'Tekka-Extensions-GoogleIME' with: 'Tekka-Extensions-GoogleIME-tomooda.4' ].
	spec for: #squeak do: [ spec package: 'Tekka-Platform' with: 'Tekka-Platform.squeak-tomooda.1' ].
	spec for: #pharo do: [ spec package: 'Tekka-Platform' with: 'Tekka-Platform.pharo-tomooda.1' ]