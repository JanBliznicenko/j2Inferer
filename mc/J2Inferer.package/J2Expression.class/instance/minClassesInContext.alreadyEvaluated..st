calculating type
minClassesInContext: aContext alreadyEvaluated: alreadyEvaluated
	| singleImplementor r |
	(alreadyEvaluated includesKey: {self. aContext contents})
		ifTrue: [ 
			^ alreadyEvaluated at:{self. aContext contents}
		].
	alreadyEvaluated at: {self. aContext contents} put:(J2Type empty).
	r := self filter: (self generateMinClassesInContext: aContext alreadyEvaluated: alreadyEvaluated) byMessages: self selectors .
	
	(self inferer config singleImplementorEnabled and:[ r isEmpty ]) ifTrue: [ 
		singleImplementor := self inferer singleImplementorOf: self selectors.
		singleImplementor ifNotNil:[
			r := singleImplementor collect:[:e | self inferer typeInfoFor: e].	
		]	
	].
	
	alreadyEvaluated at: {self. aContext contents} put:r.
	
	^r