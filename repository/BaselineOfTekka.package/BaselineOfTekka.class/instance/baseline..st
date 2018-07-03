baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Tekka-Core';
				package: 'Tekka-Platform.pharo';
				package: 'Tekka-Extensions-GoogleIME'.
			spec group: 'default' with: #('Core').
			spec group: 'Core' with: #('Tekka-Core' 'Tekka-Platform.pharo').
			spec group: 'Tekkazan' with: #('Tekka-Extensions-GoogleIME') ]