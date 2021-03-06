asserts
assert: typeVariable hasType: aBunchOfClasses onContext: aContext 
	| possibleClasses ps |
	ps := typeVariable possibleClassesInContext: (J2Context with:aContext).
	
	self assertAllMethodsOpened.
	
	self
		assert: [ ps isNotNil ]
		description: 'The possible classes are all classes in the instalation'.

	possibleClasses := ps classes collect: #analysedClass.
	self
		assert: (possibleClasses includesAll: aBunchOfClasses)
		description:
			[ 
			'Possible classes should have:' , aBunchOfClasses asArray printString , ' but found:'
				, possibleClasses asArray printString ].
	self
		assert: (possibleClasses difference: aBunchOfClasses) isEmpty
		description:
			[ 
			'Possible classes should have:' , aBunchOfClasses asArray printString , ' but found:'
				, possibleClasses asArray printString ]