//%attributes = {}
#DECLARE($port : Integer; $TCP_ID : Integer; $activated : Boolean; $info : Integer)

DELAY PROCESS:C323(Current process:C322; 2)

var $status : Integer

Case of 
	: (Count parameters:C259=1)
		
		var $wait : Integer:=3
		If (0=TCP_Listen(""; 0; $port; $wait; $TCP_ID))
			If (0=TCP_State($TCP_ID; $status)) && ($status=8)
				CALL WORKER:C1389(Current process name:C1392; Current method name:C684; $port; $TCP_ID; False:C215; 1)
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
						TEXT TO BLOB:C554("生きているので停止できません"; $blob; UTF8 C string:K22:15)
					Else 
						If ($info=1)
							TEXT TO BLOB:C554("成長しています"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=2)
							TEXT TO BLOB:C554("引き続き成長しています"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=3)
							TEXT TO BLOB:C554("まだまだ成長しています"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=4)
							TEXT TO BLOB:C554("どこまで成長するのでしょう？"; $blob; UTF8 C string:K22:15)
						End if 
						If ($info=5)
							TEXT TO BLOB:C554("成長記録リセット中..."; $blob; UTF8 C string:K22:15)
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
		End if 
		
		If (0#TCP_State($TCP_ID; $status)) || ($status=0)
			TCP_Close($TCP_ID)
		Else 
			CALL WORKER:C1389(Current process name:C1392; Current method name:C684; $port; $TCP_ID; $activated; $info)
		End if 
		
End case 