// Notice

SS.Notice = {}

// Active

SS.Notice.Active = {}

// New notice

function SS.Notice.New(ID, Title, Col, BG)
	Col = Col or Color(255, 60, 60, 255)
	BG = BG or Color(0, 0, 0, 255)
	
	// Variables
	
	SS.Notice.Current = {}
	SS.Notice.Current.ID = ID
	SS.Notice.Current.BG = BG
	SS.Notice.Current.Color = Col
	SS.Notice.Current.Title = Title
	SS.Notice.Current.Content = {}
end

// Add content

function SS.Notice.Content(Line, Col)
	Col = Col or Color(255, 255, 255, 255)
	
	// Insert
	
	table.insert(SS.Notice.Current.Content, {Line, Col})
end

// Finish

function SS.Notice.Finish()
	local Insert = {ID = SS.Notice.Current.ID, Color = SS.Notice.Current.Color, BG = SS.Notice.Current.BG, Title = SS.Notice.Current.Title, Content = SS.Notice.Current.Content}
	
	// Found is false
	
	local Found = false
	
	// Loop
	
	for K, V in pairs(SS.Notice.Active) do
		if (V.ID == SS.Notice.Current.ID) then
			SS.Notice.Active[K] = Insert
			
			Found = true
		end
	end
	
	// Haven't found anything
	
	if not (Found) then
		table.insert(SS.Notice.Active, Insert)
	end
end

// Hide

function SS.Notice.Hide(ID)
	for K, V in pairs(SS.Notice.Active) do
		if (V.ID == ID) then
			SS.Notice.Active[K] = nil
		end
	end
end

// HUDDrawScoreBoard

function SS.Notice.HUDDrawScoreBoard()
	for K, V in pairs(SS.Notice.Active) do
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), V.BG)
		
		// Text
		
		draw.SimpleText(V.Title, "ServerSecureCoolvetica", (ScrW() / 2) + 1, ((ScrH() / 2) - 64) + 1, Color(0, 0, 0, 255), 1, 1)
		draw.SimpleText(V.Title, "ServerSecureCoolvetica", (ScrW() / 2), (ScrH() / 2) - 64, V.Color, 1, 1)
		
		// Loop
		
		for B, J in pairs(V.Content) do
			draw.SimpleText(J[1], "ServerSecureArial", (ScrW() / 2) + 1, ((ScrH() / 2) + (-32 + (32 * B))) + 1, Color(0, 0, 0, 255), 1, 1)
			draw.SimpleText(J[1], "ServerSecureArial", (ScrW() / 2), ((ScrH() / 2) + (-32 + (32 * B))), J[2], 1, 1)
		end
	end
end

hook.Add("HUDDrawScoreBoard", "SS.Notice.HUDDrawScoreBoard", SS.Notice.HUDDrawScoreBoard)