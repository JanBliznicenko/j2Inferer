minimal types
minClassesInContext: aContext alreadyEvaluated: alreadyEvaluated
	"I have to change the context if is the meta class the receiver"
	| newContext |
	newContext := isMeta ifTrue:[ aContext metaClassContext ] ifFalse:[ aContext].
	^ expression minClassesInContext: newContext alreadyEvaluated: alreadyEvaluated.