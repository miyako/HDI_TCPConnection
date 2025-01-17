//%attributes = {}
var $vStatus : Integer
var $TCP_ID : Integer
var $data : Blob
var $blob : Blob

var $activated:=False:C215
var $info:=1

Repeat 
	$err:=TCP_Listen(""; 0; 19824; 0; $TCP_ID)
	$err:=TCP_State($TCP_ID; $vStatus)
	
	If ($vStatus=8)
		DELAY PROCESS:C323(Current process:C322(); 2)
		Repeat 
			$err:=TCP_ReceiveBLOB($TCP_ID; $data)
			$err:=TCP_State($TCP_ID; $vStatus)
			
			If (BLOB size:C605($data)#0)
				$text:=BLOB to text:C555($data; 0)
				If ($text="Information")
					If ($activated)
						TEXT TO BLOB:C554("You need to learn more about biology..."; $blob; UTF8 C string:K22:15)
					Else 
						If ($info=1)
							TEXT TO BLOB:C554("It grows!"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=2)
							TEXT TO BLOB:C554("It still grows!"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=3)
							TEXT TO BLOB:C554("Still growing!"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=4)
							TEXT TO BLOB:C554("What do you expect?"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=5)
							TEXT TO BLOB:C554("Reset in progress..."; $blob; UTF8 C string:K22:15)
							$info:=0
						End if 
						$info+=1
					End if 
					TCP_SendBLOB($TCP_ID; $blob)
				Else 
					If ($text="Activate")
						$activated:=Not:C34($activated)
					End if 
				End if 
			End if 
			
		Until (($vStatus=0) | ($err#0))
	End if 
	TCP_Close($TCP_ID)
Until (False:C215)