--[[
_________ _______  _______ _________ _        _        _______ 
\__   __/(  ____ )/ ___   )\__   __/( \      ( \      (  ___  )
   ) (   | (    )|\/   )  |   ) (   | (      | (      | (   ) |
   | |   | (____)|    /   )   | |   | |      | |      | (___) |
   | |   |     __)   /   /    | |   | |      | |      |  ___  |
   | |   | (\ (     /   /     | |   | |      | |      | (   ) |
___) (___| ) \ \__ /   (_/\___) (___| (____/\| (____/\| )   ( |
\_______/|/   \__/(_______/\_______/(_______/(_______/|/     \|

]]--
		-----------------------------
		--       cl_init.lua       --
		-- Made for SWO by iRzilla --
		-----------------------------

--     Require     --
require("datastream")
---------------------


--     Include     --
include('shared.lua')

include('cl_vgui.lua')
include('cl_hud.lua')
include('cl_charbox.lua')
----------------------

--    Variables    --
SWO = {}
local Chars = {}
local CharPanelIsOpen = false
CharButtons = {}
CharClassImages = {}
----------------------

surface.CreateFont("Arial",13,400,true,false,"small")
surface.CreateFont("Arial",14,400,true,false,"medium")
surface.CreateFont("Arial",16,800,true,false,"big")
surface.CreateFont("Arial",24,1200,true,false,"title")

-- Datastream Server Data Transfer --

function ReseveChars(handler,id,encoded,decoded)
	Chars = decoded.Chars
	if CharPanelIsOpen then
		AddCharsToList()
	end
end  
datastream.Hook("chardata",ReseveChars)

-- VGUI --

local PANEL = {} 
   
 /*--------------------------------------------------------- 
    Name: Init 
 ---------------------------------------------------------*/ 
 function PANEL:Init() 
 	 
 	self:SetSize( 83, 83 ) 
 	 
 	self.Label = vgui.Create ( "DLabel", self ) 
 	 
 	self:SetKeepAspect( true ) 
 	self:SetDrawBorder( true ) 
 	 
 	self.m_Image:SetPaintedManually( true ) 
 	 
 end 
   
 /*--------------------------------------------------------- 
    Name: SetNPC 
 ---------------------------------------------------------*/ 
 function PANEL:PerformLayout() 
 	 
 	self.Label:SizeToContents() 
 	 
 	self.Label:SetFont( "DefaultSmallDropShadow" ) 
 	self.Label:SetTextColor( color_white ) 
 	self.Label:SetContentAlignment( 5 ) 
 	self.Label:SetWide( self:GetWide() ) 
 	self.Label:AlignBottom( 2 ) 
 	 
 	DImageButton.PerformLayout( self ) 
 	 
 end 
   
   
 /*--------------------------------------------------------- 
    Name: PaintOver 
 ---------------------------------------------------------*/ 
 function PANEL:Paint() 
 	 
 	local w, h = self:GetSize() 
 	 
 	self.m_Image:Paint() 
 	
	if self.Selected then
		surface.SetDrawColor( 60, 60, 100, 200 ) 
	else
		surface.SetDrawColor( 30, 30, 30, 200 ) 
	end
 	surface.DrawRect( 0, h - 16, w, 16 ) 
 	 
 	DImageButton.Paint( self ) 
 	 
 	 
 end 
   

 function PANEL:SetIt( NiceName, SpawnName ) 
 	 
 	self.Label:SetText( NiceName ) 
 	
	self.Image = "VGUI/entities/"..SpawnName
 	self:SetMaterial( "VGUI/entities/"..SpawnName ) 
 	 
 	self:InvalidateLayout() 
 	 
 end 
 
 function PANEL:DoClick()
	for k, v in pairs(CharClassImages) do
		v.Selected = false
	end

	self.Selected = true
 end
   
vgui.Register("ClassImageButton", PANEL, "DImageButton")

local PANEL = {}

function PANEL:Init()
	self:SetTitle("Characters")
	gui.EnableScreenClicker(true)
end

function PANEL:ShowHide()
	if(self:IsVisible()) then
		self:Close()
	else
		self:Show()
	end
end

function PANEL:Show(Override)
	if(!self:IsVisible()) then
		if(!Override) then
			gui.EnableScreenClicker(true)
		end
		self:SetVisible(true)
	end
end

function PANEL:Close(Override)
	if(self:IsVisible()) then
		if(!Override) then
			gui.EnableScreenClicker(false)
		end
		self:SetVisible(false)
	end
end

function PANEL:SetTitle(text)
	self.lblTitle:SetText("")
	self.Text = text
end

function PANEL:Paint()
    surface.SetDrawColor(16, 16, 16, 200)
    surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	
    surface.SetDrawColor(255, 255, 0, 180)
    surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
	
	draw.SimpleText(self.Text, "title", self:GetWide() * 0.5, 15, Color( 255, 255, 255, 255 ), 1,1)
end
vgui.Register("CharsPanel", PANEL, "DFrame")

local PANEL = {}

function PANEL:Init()
	self.Text = "OH NO NAME THE BUTTON!"
end

function PANEL:SetText(text)
	self.Text = text
end

function PANEL:Paint()
	local bgColor = Color( 50, 50, 50, 255 )
	local fgColor = Color( 255, 255, 255, 255 )
	if self.Depressed then
		bgColor = Color(250, 250, 250, 200)
		fgColor = color_black
	elseif self.Hovered then
		bgColor = Color(220, 220, 220, 200)
		fgColor = color_white
	end
	
	draw.RoundedBox(0,0,0,self:GetWide(),self:GetTall(), bgColor)
	draw.SimpleText(self.Text, "small", self:GetWide() * 0.5, self:GetTall() * 0.5, fgColor, 1,1)
	return true
end

vgui.Register("SOWButton", PANEL, "Button")


-- Paint BG --

local function SWOHUDPaint()
	if !CharPanelIsOpen then return end
	
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawRect(0, 0, ScrW(), ScrH())
end
hook.Add("HUDPaint", "SWOHUDPaint", SWOHUDPaint)

-- Open Char Selection Menu --

function OpenCharSelection()
	CharPanelIsOpen = true
	CharsList = vgui.Create("CharsPanel")
	CharsList:SetSize(200, ScrH() - 10)
	CharsList:SetTitle("Character")
	CharsList:SetPos(ScrW()-205, 5)
	CharsList:ShowCloseButton(false)
	CharsList:SetDraggable(false)
	CharsList:MakePopup()
	
	CharsDList = vgui.Create("DPanelList", CharsList)
	CharsDList:SetDrawBackground(false)
	CharsDList:SetPos(5, 30)
	CharsDList:SetSize(190, ScrH()-80)
	CharsDList:SetSpacing(5)
	CharsDList:SetPadding(5)
	CharsDList:EnableHorizontal(false)
	CharsDList:EnableVerticalScrollbar(true)
	AddCharsToList()
	
	MOTDPanel = vgui.Create("CharsPanel")
	MOTDPanel:SetSize(400, ScrH()-10)
	MOTDPanel:SetTitle("Character")
	MOTDPanel:SetPos(5, 5)
	MOTDPanel:ShowCloseButton(false)
	MOTDPanel:SetTitle("MOTD")
	MOTDPanel:SetDraggable(false)
	MOTDPanel:MakePopup()
	
	MOTDHTML = vgui.Create("HTML", MOTDPanel)
	MOTDHTML:SetPos(5, 25)
	MOTDHTML:SetSize(MOTDPanel:GetWide()-10, MOTDPanel:GetTall()-30)
	MOTDHTML:SetHTML("<head><style type='text/css'>body {background-color: black} p {margin-left: 20px}</style></head><body><center><img src='http://i213.photobucket.com/albums/cc170/crazyboy342/Starwars.jpg'</center></body>")
	
	newcharbutton = vgui.Create("SOWButton", CharsList)
	newcharbutton:SetSize(180,40)
	newcharbutton:SetPos(CharsList:GetWide()/2-newcharbutton:GetWide()/2, CharsList:GetTall()-45)
	newcharbutton:SetText("New Character")
	newcharbutton.DoClick = function(newcharbutton)
		NewCharacter()
	end
	
	local SizeX = (ScrW() - 200) - 405
	
	UseCharButton = vgui.Create("SOWButton")
	UseCharButton:SetSize(SizeX - 10,40)
	UseCharButton:SetPos(410, ScrH() - 50)
	UseCharButton:SetText("Enter The Wars")
	UseCharButton.DoClick = function(UseCharButton)
		local CharText = ""
		for k, v in pairs(CharButtons) do
			if v.Selected then CharText = v.Text end
		end
		
		if CharText == "" then return end
		RunConsoleCommand("SWOLoadChar", CharText)
		CharPanelIsOpen = false
		CharsList:Close()
		MOTDPanel:Close()
		UseCharButton:SetVisible(false)
		newcharbutton:SetVisible(false)
	end
	
	--[[CharViewModel = vgui.Create( "DModelPanel" )
	CharViewModel:SetModel(LocalPlayer():GetModel())
	CharViewModel:SetPos(410, ScrH()-200)
	CharViewModel:SetSize(SizeX - 10/2, SizeX*1.5/2)
	-- CharViewModel:SetSize(100, 100)
	CharViewModel:SetAnimated( false )
	CharViewModel:SetAnimSpeed( 0.5 )
	CharViewModel:SetCamPos( Vector( 200, 200, 64 ) )
	CharViewModel:SetLookAt( Vector( 0, 0, 52 ) )
	CharViewModel:SetFOV( 250 )
	function CharViewModel:LayoutEntity( Entity )
		if self.bAnimated then self:RunAnimation() end
		Entity:SetAngles( Angle( 0, RealTime()*40,  0) )
	end]]--

	local DermaPanel = vgui.Create( "StarFrame" )
	DermaPanel:SetPos( 50,50 )
	DermaPanel:SetSize( 200, 250 )
	DermaPanel:SetTitle( "Menu" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( true )
	DermaPanel:MakePopup()
 
	local MenuButton = vgui.Create("DButton", DermaPanel)
	MenuButton:SetText( "Menu " )
	MenuButton:SetPos(25, 50)
	MenuButton:SetSize( 150, 175 )
	MenuButton.DoClick = function ( btn )
	    local MenuButtonOptions = DermaMenu() 
	    MenuButtonOptions:AddOption("quit", function() 	RunConsoleCommand("disconnect") end ) 

	    MenuButtonOptions:Open() 
end
end

concommand.Add("OpenCharSelection",OpenCharSelection)


function AddCharsToList()
	CharsDList:Clear()
	local NotFirstTime = false
	for k,v in pairs(Chars) do
		local Charbox = vgui.Create("DCharbox")
		Charbox:SetSize(180,60)
		Charbox:SetName(v["name"])
		Charbox:SetImage(v["image"])
		CharsDList:AddItem(Charbox)
		NotFirstTime = true
	end
	if !NotFirstTime then
		-- NewCharacter()
	end
end

function NewCharacter()
	local Client = LocalPlayer()
	local NewCharPanel = vgui.Create("StarFrame")
	NewCharPanel:SetSize(360,300)
	NewCharPanel:Center()
	NewCharPanel:SetTitle("New Character")
	NewCharPanel:SetDraggable(false)
	NewCharPanel:ShowCloseButton(false)
	NewCharPanel:MakePopup()
		
		CName = vgui.Create("DTextEntry",NewCharPanel)
		CName:SetText("Name Of The Character")
		CName:SetSize(190,20)
		CName:SetPos(5,45)
		CName:SetEditable(true)
		
		local ClassPictures = {}
		ClassPictures[0] = {Name = "Alyx", Image = "npc_alyx"}
		ClassPictures[1] = {Name = "GMAN", Image = "npc_gman"}
		ClassPictures[2] = {Name = "Barney", Image = "npc_barney"}
		ClassPictures[3] = {Name = "Kleiner", Image = "npc_kleiner"}
		
		for k, v in pairs(ClassPictures) do
			CharClassImages[k] = vgui.Create("ClassImageButton", NewCharPanel)
			CharClassImages[k]:SetPos(k*85+10, 75)
			CharClassImages[k]:SetIt(v.Name, v.Image)
		end
		
		FactionDrop = vgui.Create("DMultiChoice",NewCharPanel)
		FactionDrop:SetText("Proffesions")
		FactionDrop:SetSize(190,20)
		FactionDrop:SetPos(5,25)
		FactionDrop:SetEditable(false)
		for k,v in pairs(team.GetAllTeams()) do
			if k != 0 and k != 1002 and k != 1001 then
				FactionDrop:AddChoice(v.Name)
			end
		end
		
		
				local okbutton = vgui.Create("DButton", NewCharPanel)
		okbutton:SetSize(50,15)
		okbutton:SetPos(5, 275)
		okbutton:SetText("Ok")
		okbutton.DoClick = function(okbutton)
			local TheSelected = false
			for k, v in pairs(CharClassImages) do
				if v.Selected then
					TheSelected = v.Image
				end
			end
			if TheSelected != false then
				MCharTable = {}
				MCharTable[CName:GetValue()] = {}
				MCharTable[CName:GetValue()].name = CName:GetValue()
				MCharTable[CName:GetValue()].image = TheSelected
				MCharTable[CName:GetValue()].proffesion = FactionDrop:GetValue()
			
				NewCharPanel:Close()
			
				datastream.StreamToServer( "PlayerChar", MCharTable)
			else
				LocalPlayer():ChatPrint("Must Select A Image")
			end
		end
end
