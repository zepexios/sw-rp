--[[------------------------NOTE----------------------------------
	Polkm: This file is for functions that add menus/gui elements to the gamemode
--------------------------NOTE----------------------------------]]

------------------------------------------------------------
require("datastream")

------------------------------------------------------------
include('shared.lua')
include('cl_hud.lua')
include('cl_charbox.lua')

------------------------------------------------------------
Chars = {}
CharPanelIsOpen = false

--Reseveing data----------------------------------------------------------
--Polkm: this is only for the char sellection panel
function ReseveChars(handler,id,encoded,decoded)
	Chars = decoded.Chars
	if CharPanelIsOpen then
		AddCharsToList()
	end
end  
datastream.Hook("chardata",ReseveChars)

--Char sellection panel----------------------------------------------------------
--Polkm: This one opens the panel
function OpenCharSelection()
	CharPanelIsOpen = true
	local Client = LocalPlayer()
	CharPanel = vgui.Create("DFrame")
	CharPanel:SetSize(200,400)
	CharPanel:Center()
	CharPanel:SetTitle("Characters")
	CharPanel:SetDraggable(false)
	CharPanel:ShowCloseButton(false)
	CharPanel:MakePopup()
		CharList = vgui.Create("DPanelList",CharPanel)
		CharList:SetPos(5,25)
		CharList:SetSize(190,370)
		CharList:SetSpacing(5)
		CharList:SetPadding(5)
		CharList:EnableHorizontal(false)
		CharList:EnableVerticalScrollbar(true)
		AddCharsToList()
end
concommand.Add("OpenCharSelection",OpenCharSelection)
--Polkm: This is called to add chars to the list
function AddCharsToList()
	CharList:Clear()
	for k,v in pairs(Chars) do
		local Charbox = vgui.Create("DCharbox")
		Charbox:SetSize(180,60)
		Charbox:SetName(v["name"])
		Charbox:SetImage(v["image"])
		CharList:AddItem(Charbox)
	end
	local newcharbutton = vgui.Create("DButton")
	newcharbutton:SetSize(180,20)
	newcharbutton:SetText("Make a new Character")
	newcharbutton.DoClick = function(newcharbutton)
		NewCharacter()
		CharPanel:Close()
	end
	CharList:AddItem(newcharbutton)
end

function NewCharacter()
	local Client = LocalPlayer()
	local NewCharPanel = vgui.Create("DFrame")
	NewCharPanel:SetSize(200,300)
	NewCharPanel:Center()
	NewCharPanel:SetTitle("New Character")
	NewCharPanel:SetDraggable(false)
	NewCharPanel:ShowCloseButton(false)
	NewCharPanel:MakePopup()
		local okbutton = vgui.Create("DButton", NewCharPanel)
		okbutton:SetSize(50,15)
		okbutton:SetPos(5, 275)
		okbutton:SetText("Ok")
		okbutton.DoClick = function(okbutton)
			NewCharPanel:Close()
		end
		
		local FactionDrop = vgui.Create("DMultiChoice",NewCharPanel)
		FactionDrop:SetText("Faction")
		FactionDrop:SetSize(240,20)
		FactionDrop:SetPos(5,25)
		FactionDrop:SetEditable(false)
		for k,v in pairs(team.GetAllTeams()) do
			if k != 0 and k != 1002 and k != 1001 then
				FactionDrop:AddChoice(v.Name)
			end
		end
		
end
