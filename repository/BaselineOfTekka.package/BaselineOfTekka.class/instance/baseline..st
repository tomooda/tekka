baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Tekka-Core';
				package: 'Tekka-Platform';
				package: 'Tekka-Extensions-GoogleIME'.
			spec group: 'default' with: #('Core').
			spec group: 'Core' with: #('Tekka-Core').
			spec group: 'Tekkazan' with: #('Tekka-Extensions-GoogleIME') ].
	spec
		for: #pharo
		do: [ spec package: 'Tekka-Platform' with: 'Tekka-Platform.pharo'.
			spec group: 'Core' with: #('Tekka-Platform') ]