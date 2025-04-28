property activated : Boolean
property info : Integer

Class extends TCPConnectionOption

Class constructor($port : Integer)
	
	Super:C1705($port)
	
	This:C1470.activated:=False:C215
	This:C1470.info:=1
	
Function onData($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	var $data : 4D:C1709.Blob
	$data:=$event.data
	
	var $text : Text
	$text:=Convert to text:C1012($data; "utf-8")
	
	If ($text="Information")
		If (This:C1470.activated)
			$text:="You need to learn more about biology..."
		Else 
			If (This:C1470.info=1)
				$text:="It grows!"
			End if 
			If (This:C1470.info=2)
				$text:="It still grows!"
			End if 
			If (This:C1470.info=3)
				$text:="Still growing!"
			End if 
			If (This:C1470.info=4)
				$text:="What do you expect?"
			End if 
			If (This:C1470.info=5)
				$text:="Reset in progress..."
				This:C1470.info:=0
			End if 
			This:C1470.info+=1
		End if 
		CONVERT FROM TEXT:C1011($text; "utf-8"; $data)
		$connection.send($data)
	Else 
		If ($text="Activate")
			This:C1470.activated:=Not:C34(This:C1470.activated)
		End if 
	End if 