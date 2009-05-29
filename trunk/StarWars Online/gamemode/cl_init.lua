include('cl_hud')

local SW_menu = vgui.Create( "DFrame" )
SW_menu:SetPos( 50,50 )
SW_menu:SetSize( 1000, 900 )
SW_menu:SetTitle( "Testing Derma Stuff" )
SW_menu:SetVisible( true )
SW_menu:SetDraggable( true )
SW_menu:ShowCloseButton( true )
SW_menu:MakePopup()




function SWSendDataTable( table )										//Sends a Table to the Server (DataTable)
	datastream.StreamToServer( "ClientToServer_Table", table )
end
function SWSendMainDataTable( table )									//Sends a Table to the Server (MainDataTable)
	datastream.StreamToServer( "ClientToServer_MTable", table )
end
function SWGetDataTable( ply, handler, id, encoded, decoded )			//Gets a Table from the Server (DataTable)
	DataTable = decoded
end
function SWGetMainDataTable( ply, handler, id, encoded, decoded )		//Gets a Table from the server (MainDataTable)
	MainDataTable = decoded
end
datastream.Hook( "ServerToClient_Table", SWGetDataTable )				//like a Hook
datastream.Hook( "ServerToClient_MTable", SWGetMainDataTable )			//like a hook

















