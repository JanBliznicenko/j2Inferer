scripts
inferAllInstalation
	" J2Scripts inferAllInstalation"

	inferer := nil.
	Smalltalk garbageCollect.
	inferer := J2Inferer new.
	inferer initWithNotifier: J2FileBasedNotifier new.
	ProtoObject withAllSubclasses
		do: [ :e | inferer enqueueClass: e ]
		displayingProgress: [ :e | e name ].
		
	inferer runAndWait.
	inferer notifier close.
	
	^ inferer