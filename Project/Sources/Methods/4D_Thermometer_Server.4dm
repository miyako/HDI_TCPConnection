//%attributes = {}
var $vStatus : Integer
var $TCP_ID : Integer
var $data : Blob
var $blob : Blob
var $temperature:=10

var $activated:=False:C215

Repeat 
	$err:=TCP_Listen(""; 0; 19821; 0; $TCP_ID)
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
						$temperature+=1
					Else 
						$temperature-=1
					End if 
					$text:="Temperature is "+String:C10($temperature)+" degree Celsius"
					TEXT TO BLOB:C554($text; $blob; UTF8 C string:K22:15)
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