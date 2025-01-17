//%attributes = {}
var $vStatus : Integer
var $TCP_ID : Integer
var $data : Blob
var $blob : Blob

var $activated:=False:C215

Repeat 
	$err:=TCP_Listen(""; 0; 19822; 0; $TCP_ID)
	$err:=TCP_State($TCP_ID; $vStatus)
	
	If ($vStatus=8)
		Repeat 
			DELAY PROCESS:C323(Current process:C322; 2)
			$err:=TCP_ReceiveBLOB($TCP_ID; $data)
			$err:=TCP_State($TCP_ID; $vStatus)
			
			If (BLOB size:C605($data)#0)
				$text:=BLOB to text:C555($data; 0)
				If ($text="Information")
					If ($activated)
						TEXT TO BLOB:C554("Alarm\r\n is on! Nothing to report."; $blob; UTF8 C string:K22:15)
					Else 
						TEXT TO BLOB:C554("Alarm is off! You should turn it on."; $blob; UTF8 C string:K22:15)
					End if 
					TCP_SendBLOB($TCP_ID; $blob)
				Else 
					If ($text="Activate")
						$activated:=Not:C34($activated)
					End if 
				End if 
			End if 
			
		Until (($vStatus=0) | ($err#0))
		TCP_Close($TCP_ID)
	End if 
Until (False:C215)