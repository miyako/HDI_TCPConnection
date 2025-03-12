var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Clicked:K2:4)
		
		Case of 
			: (FORM Get current page:C276=1)
				
				FORM GOTO PAGE:C247(2)
				
			: (FORM Get current page:C276=2)
				
				If (Is Windows:C1573 && Application info:C1599().SDIMode)
					INVOKE ACTION:C1439(ak return to design mode:K76:62)
				Else 
					CANCEL:C270
				End if 
				
		End case 
		
End case 