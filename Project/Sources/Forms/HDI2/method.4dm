var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Load:K2:1)
		
		InitInfo
		
		Form:C1466.lightBulb:=cs:C1710.HouseDevice.new(Form:C1466; 19820)
		Form:C1466.thermometer:=cs:C1710.HouseDevice.new(Form:C1466; 19821)
		Form:C1466.alarm:=cs:C1710.HouseDevice.new(Form:C1466; 19822)
		Form:C1466.music:=cs:C1710.HouseDevice.new(Form:C1466; 19823)
		Form:C1466.plant:=cs:C1710.HouseDevice.new(Form:C1466; 19824)
		
		OBJECT SET ENABLED:C1123(*; "ButtonConnect"; False:C215)
		OBJECT SET ENABLED:C1123(*; "ButtonInfo"; False:C215)
		OBJECT SET ENABLED:C1123(*; "ButtonActivate"; False:C215)
		OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; False:C215)
		
	: ($event.code=On Unload:K2:2)
		
		KILL WORKER:C1390("4D_Lightbulb_Server")
		KILL WORKER:C1390("4D_Thermometer_Server")
		KILL WORKER:C1390("4D_Alarm_Server")
		KILL WORKER:C1390("4D_Music_Server")
		KILL WORKER:C1390("4D_Plant_Server")
		
		Form:C1466.lightBulb.disconnect()
		Form:C1466.thermometer.disconnect()
		Form:C1466.alarm.disconnect()
		Form:C1466.music.disconnect()
		Form:C1466.plant.disconnect()
		
End case 