tests
testSelfInInheritance
	| classInfo methodInfo |
	self inferClass: J2ParentClass.
	self inferMethod: Object >> #yourself.
	classInfo := self inferClass: J2ChildClass.
		
	methodInfo := classInfo methodTypeFor: Object >> #yourself.
	self assert: methodInfo returnValue hasType: {J2ChildClass} onContext: { classInfo }.