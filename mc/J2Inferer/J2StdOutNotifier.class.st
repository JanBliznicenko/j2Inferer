"
Simple implemetation of the notifier that logs the output to the standard output.
"
Class {
	#name : 'J2StdOutNotifier',
	#superclass : 'J2AbstractNotifier',
	#category : 'J2Inferer',
	#package : 'J2Inferer'
}

{ #category : 'logging' }
J2StdOutNotifier >> doLog: aValuable level: logLevel [.
	Stdio stdout  << aValuable value.
	Stdio stdout crlf.

]
