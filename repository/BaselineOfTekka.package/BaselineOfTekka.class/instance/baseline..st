baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'Tekka-Core';
				package: 'Tekka-Platform';
				package: 'Tekka-Extensions-GoogleIME'.
			spec group: 'default' with: #('Tekka-Core' 'Tekka-Platform') ]