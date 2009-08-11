
--This alows me to add functions to the player object
local Player = FindMetaTable("Player")

--This is only called at the begining so that the char sellection can display the name and such
function Player:LoadChars()
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print("realy?")
		local contents = util.KeyValuesToTable(file.Read(FilePath))
		self.Chars = contents
		datastream.StreamToClients(self,"chardata",{Chars = contents})
	else

	end
end

function Player:SaveChars()
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print("realy?")

		file.Write(FilePath,util.TableToKeyValues(self.Chars))
	else
		local CharsTable = {}
		table.Merge(CharsTable, CharTable)

		self.Chars = CharTable
		file.Write(FilePath,util.TableToKeyValues(CharTable))
		contents = CharTable
	end
end

function Player:MakeChar(CharTable)
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print("realy?")
		local contents = util.KeyValuesToTable(file.Read(FilePath))

		table.Merge(contents, CharTable)
		self.Chars = contents
		file.Write(FilePath,util.TableToKeyValues(contents))
	else
		local CharsTable = {}
		table.Merge(CharsTable, CharTable)

		self.Chars = CharTable
		file.Write(FilePath,util.TableToKeyValues(CharTable))
		contents = CharTable
	end
	
	datastream.StreamToClients(self,"chardata",{Chars = self.Chars})
end

function IncomingHook( pl, handler, id, encoded, decoded )

	print( "GLON Encoded: " .. encoded );
	print( "Decoded:" );
	PrintTable( decoded );
	
	pl:MakeChar(decoded)
end
datastream.Hook( "PlayerChar", IncomingHook );

function Player:Load(charkey)
	self:SetNWInt("char",charkey)
	self:Kill()
end

function LoadPlyCon(ply, cmd, args)
	local lol = string.lower(string.Implode(" ", args))
	PrintTable(args)
	print(lol)
	ply.Char = ply.Chars[lol]
end
concommand.Add("SWOLoadChar", LoadPlyCon)

function Player:GetClass()
	return self.Char.Class or "Unknown"
end
function Player:Incapacitate( duration )
	if( sefl:GetNWBool( "IsInRagdoll" ) ) then
		if( PlayerRagdoll:IsValid() ) then
			PlayerRagdoll:Remove()
			
			self:SetPos( PlayerRagdoll:GetPos() + Vector( 0, 0, 50 ) )
			self:Spawn()
			
		end
		self:SetModel( PlayerRagdoll:GetModel() )
		self:SetNWBool( "IsInRagdoll", false )
		self:DrawViewModel( true )
		self:DrawWorldModel( true )
		self:SetColor( 255, 255, 255, 255 )
		self:Freeze( false )
		
	else
		if( self:InVehicle() )then
			self:ExitVehicle()
			self:GetParent():Remove()
		end
		if( self:GetMoveType() == MOVETYPE_NOCLIP )
			self:SetMoveType( MOVETYPE_WALK )
		end
		self:SetNWBool( "IsInRagdoll", true )
		self:StripWeapons()
		self:DrawViewModel( false )
		self:DrawWorldModel( false )
		self:SetColor( 255, 255, 255, 0 )
		
		PlayerRagdoll = ents.Create( "prop_ragdoll" )
		PlayerRagdoll:SetPos( TO_RAG:GetPos() )
		PlayerRagdoll:SetModel( TO_RAG:GetModel() )
		PlayerRagdoll:SetAngles( TO_RAG:GetAngles() )
		PlayerRagdoll:Spawn()
		PlayerRagdoll:Activate()
		
		self:Spectate( OBS_MODE_ROAMING )
		self:Freeze( true )
		duration = duration or 30
		timer.Create( "RagdollTimer"..tostring( self:UniqueID() ).."", , 1, function()
			if( self:GetNWBool( "IsInRagdoll") ) then
				self:SetNWBool( "IsInRagdoll", false )
				self:Incapacitate()
			end
		end )
	end
end
function Player:IsIncapacitated()
	return self:GetNWBool( "IsInRagdoll" )

















