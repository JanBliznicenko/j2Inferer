"
This objects represents the result of calculating a type of an expression.
"
Class {
	#name : 'J2Type',
	#superclass : 'Object',
	#instVars : [
		'minClasses'
	],
	#category : 'J2Inferer-Types',
	#package : 'J2Inferer',
	#tag : 'Types'
}

{ #category : 'as yet unclassified' }
J2Type class >> empty [
	^ self new.
]

{ #category : 'as yet unclassified' }
J2Type class >> withClass: aClass [
	^ self new
		minClasses: (Set with:aClass);
		yourself
]

{ #category : 'as yet unclassified' }
J2Type class >> withClasses: aCollection [
	| classes |
	classes := aCollection ifNotNil: [ Set newFrom: aCollection ] ifNil: [ Set new ].
	^ self new
		minClasses: classes;
		yourself
]

{ #category : 'accessing' }
J2Type >> classes [

	| results remainings |
	results := Set withAll:
		           (minClasses reject: [ :c |
			            minClasses includesAny: c superclasses ]).
	remainings := results asOrderedCollection.
	[ remainings isEmpty ] whileFalse: [
		| c siblings |
		c := remainings first.
		c superclass
			ifNil: [
				remainings remove: c.
				results remove: c ]
			ifNotNil: [
				siblings := c superclass subclasses.
				(results includesAll: siblings)
					ifTrue: [
						c analysedClass superclass = Trait
							ifTrue: [
								remainings removeAllSuchThat: [ :each |
									each analysedClass superclass = Trait ].
								results removeAllSuchThat: [ :each |
									each analysedClass superclass = Trait ] ]
							ifFalse: [
								remainings removeAllFoundIn: siblings.
								results removeAllFoundIn: siblings ].
						results add: c superclass.
						remainings add: c superclass ]
					ifFalse: [ remainings remove: c ] ] ].
	^ results
]

{ #category : 'enumerating' }
J2Type >> collect: aBlock [

	^ self classes collect: aBlock
]

{ #category : 'accessing' }
J2Type >> filter: aMessageSet [
	minClasses removeAllSuchThat: [ :c | (aMessageSet allSatisfy: [ :m | c canUnderstand: m ]) not ]
]

{ #category : 'accessing' }
J2Type >> ifEmpty: aBlock [
	self minClasses ifEmpty: aBlock.
]

{ #category : 'accessing' }
J2Type >> initialize [
	minClasses := Set new.
]

{ #category : 'accessing' }
J2Type >> minClasses [
	^ minClasses
]

{ #category : 'accessing' }
J2Type >> minClasses: anObject [
	minClasses := anObject
]

{ #category : 'accessing' }
J2Type >> union: anotherType [
	self minClasses addAll: anotherType minClasses.
]
