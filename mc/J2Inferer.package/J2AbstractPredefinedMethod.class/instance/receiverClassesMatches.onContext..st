testing if can handle
receiverClassesMatches: aMessage onContext: aContext.
	^ implementingClasses isEmpty
		or: [ aContext contents includesAny: implementingClasses ]