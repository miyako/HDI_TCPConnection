Class constructor($form : Object; $port : Integer)
	
	This:C1470.form:=$form
	This:C1470.connection:=Null:C1517
	This:C1470.port:=$port
	
	//Connects to one of the servers launched inside workers
Function connect()
	
	This:C1470.connection:=4D:C1709.TCPConnection.new("localhost"; This:C1470.port; This:C1470)
	
	//Disconnect from the server
Function disconnect()
	
	This:C1470.connection.shutdown()
	This:C1470.connection:=Null:C1517
	
	//Send a blob to the server, the server always answer with a text to show to the user
Function getInfo()
	
	var $blob : Blob
	TEXT TO BLOB:C554("Information"; $blob)
	This:C1470.connection.send($blob)
	
	//Send a blob to the server to "activate" the device
Function activate()
	
	var $blob : Blob
	TEXT TO BLOB:C554("Activate"; $blob)
	This:C1470.connection.send($blob)
	
	//Callback called when the connection is successfully established
Function onConnection($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41("Connection established")
	
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; True:C214)
	
	//Callback called when the connection is properly closed
Function onShutdown($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41("Connection closed")
	
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; False:C215)
	
	//Callback called when receiving data. The simple servers always send a sentence to show to the user
Function onData($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41(BLOB to text:C555($event.data; UTF8 text without length:K22:17))
	
	//Warning: There's no guarantee you'll receive all the data you need in a single network packet.
	//To avoid complexifying this HDI, I haven't checked that I have all my data but you should do it especially if you send a lot of data.
	
	//Callback called when the connection is closed unexpectedly
Function onError($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	
	ALERT:C41("Connection error")
	
	OBJECT SET ENABLED:C1123(*; "ButtonConnect"; True:C214)
	OBJECT SET ENABLED:C1123(*; "ButtonInfo"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonActivate"; False:C215)
	OBJECT SET ENABLED:C1123(*; "ButtonDisconnect"; False:C215)
	
	//Callback called after onShutdown/onError just before the TCPConnection object is released
Function onTerminate($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	