Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		InitInfo
		
		Form:C1466.lightBulb:=cs:C1710.HouseDevice.new(Form:C1466; 19820)
		Form:C1466.thermometer:=cs:C1710.HouseDevice.new(Form:C1466; 19821)
		Form:C1466.alarm:=cs:C1710.HouseDevice.new(Form:C1466; 19822)
		Form:C1466.music:=cs:C1710.HouseDevice.new(Form:C1466; 19823)
		Form:C1466.plant:=cs:C1710.HouseDevice.new(Form:C1466; 19824)
		
	: (Form event code:C388=On Close Box:K2:21)
		If (Is Windows:C1573 && Application info:C1599().SDIMode)
			QUIT 4D:C291
		Else 
			CANCEL:C270
		End if 
		
End case 

