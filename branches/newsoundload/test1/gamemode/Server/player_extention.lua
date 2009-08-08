
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
		--@meeces2911
		-- Why is this here ? what is it doing ? creating a new local table EACH time, and then merging the current
		--Character table, and then .... what ? what is this actually doing ?!!
		
		local CharsTable = {}
		--table.Merge(CharsTable, CharTable)

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

		self.Chars = CharsTable
		file.Write(FilePath,util.TableToKeyValues(CharTable))
		--SHouldn't be required as contents is LOCAL only, and reasigned every time.
		--contents = CharTable
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
	self:KillSilent()
end

function LoadPlyCon(ply, cmd, args)
	local lol = string.Implode(" ", args)
	local lol = string.lower(lol)
	PrintTable(args)
	print(lol)
	ply.Char = ply.Chars[lol]
end
concommand.Add("SWOLoadChar", LoadPlyCon)

function Player:GiveAllWeapons()
end
function Player:GiveAllAmmo()
end

function Player:GetClass()
	return CLASS_JEDI
end
function Player:GetForce()
	self.Char.Force = self.Char.Force or 100
	return self.Char.Force
end
function Player:TakeForce( NumForce, DontRegen )
	if( !NumForce ) then
		NumForce = 1
	end
	self.Char.Force = self.Char.Force - NumForce
	if( self.Char.Force < 0 ) then
		self.Char.Force = 0
	end
	if( DontRegen != true ) then
		if( timer.IsTimer( "ForceBackUpTimer" ) ) then
			timer.Destroy( "ForceBackUpTimer" )
			timer.Create( "ForceBackUpTimer", 0.1, 0, function()
				self:AddForce( 1 )
				self:SetNWInt( "PlayerForce", self:GetForce() )
				self:SetNWInt( "PlayerMaxForce", self:GetMaxForce() )
				if( self:GetForce() >= self:GetMaxForce() ) then
					timer.Destroy( "ForceBackUpTimer" )
				end
			end )
		else
			timer.Create( "ForceBackUpTimer", 0.1, 0, function()
				self:AddForce( 1 )
				self:SetNWInt( "PlayerForce", self:GetForce() )
				self:SetNWInt( "PlayerMaxForce", self:GetMaxForce() )
				if( self:GetForce() >= self:GetMaxForce() ) then
					timer.Destroy( "ForceBackUpTimer" )
				end
			end )
		end
	end
	self:SetNWInt( "PlayerForce", self:GetForce() )
end

function Player:AddForce( NumForce )
	self.Char.Force = self.Char.Force + NumForce
	if( self.Char.Force > self:GetMaxForce() ) then
		self.Char.Force = self:GetMaxForce()
	end
end

function Player:GetMaxForce()
	--@meeces2911 SHOULD be MaxForce, but seems to be added to table as 'force' and i cant find where
	-- it has been added.
	return SWO.Round(self.Char.force,1) or 100
end

function Player:GetTakeForce()
--@meeces2911
--makes sure 0.3 is rounded to 0.3, not 0.299xxxxxxxxx lua/gmod numbers fails :(
	return SWO.Round(self.Char.takeforce,1) or 1;
end
