//%attributes = {}
#DECLARE($port : Integer; $TCP_ID : Integer; $activated : Boolean; $temperature : Integer)

DELAY PROCESS:C323(Current process:C322; 2)

var $status : Integer

Case of 
	: (Count parameters:C259=1)
		
		var $wait : Integer:=3
		If (0=TCP_Listen(""; 0; $port; $wait; $TCP_ID))
			If (0=TCP_State($TCP_ID; $status)) && ($status=8)
				CALL WORKER:C1389(Current process name:C1392; Current method name:C684; $port; $TCP_ID; False:C215; 10)
				return 
			End if 
			TCP_Close($TCP_ID)
			return 
		End if 
		
		CALL WORKER:C1389(Current process name:C1392; Current method name:C684; $port)
		
	: (Count parameters:C259=4)
		
		var $data : Blob
		var $blob : Blob
		var $text : Text
		
		If (0=TCP_ReceiveBLOB($TCP_ID; $data))
			If (BLOB size:C605($data)#0)
				$text:=BLOB to text:C555($data; UTF8 C string:K22:15)
				If ($text="Information")
					If ($activated)
						$temperature+=1
					Else 
						$temperature-=1
					End if 
					$text:="現在の室温は "+String:C10($temperature)+" 度です。"
					TEXT TO BLOB:C554($text; $blob; UTF8 C string:K22:15)
					TCP_SendBLOB($TCP_ID; $blob)
				Else 
					If ($text="Activate")
						$activated:=Not:C34($activated)
					End if 
				End if 
			End if 
		End if 
		
		If (0#TCP_State($TCP_ID; $status)) || ($status=0)
			TCP_Close($TCP_ID)
		Else 
			CALL WORKER:C1389(Current process name:C1392; Current method name:C684; $port; $TCP_ID; $activated; $temperature)
		End if 
		
End case 