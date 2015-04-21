baselines
baseline002: spec 
	<version: '0.2-baseline'>
	spec
		for: #common
		do: [spec blessing: #baseline.
			spec description: 'Default configuration'.
			spec repository: 'http://smalltalkhub.com/mc/tomooda/Tekka/main'.
			spec package: 'Tekka-Core';
				 package: 'Tekka-Platform';
				 package: 'Tekka-Extensions-GoogleIME'.
			spec group: 'default' with: #('Core' ).
			spec group: 'Core' with: #('Tekka-Core' ).
			spec group: 'Tekkazan' with: #('Tekka-Extensions-GoogleIME' )].
	spec
		for: #squeak
		do: [spec package: 'Tekka-Platform' with: 'Tekka-Platform.squeak'.
			spec group: 'Core' with: #('Tekka-Platform' )].
	spec
		for: #pharo
		do: [spec package: 'Tekka-Platform' with: 'Tekka-Platform.pharo'.
			spec group: 'Core' with: #('Tekka-Platform' )].
