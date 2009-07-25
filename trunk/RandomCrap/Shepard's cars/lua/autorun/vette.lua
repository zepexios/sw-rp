//Shepard's cars

local Category = "Shepard's cars"

local V = { 	
				// Required information
				Name = "Vette", 
				Class = "prop_vehicle_jeep",
				Category = "Shepard's cars",

				// Optional information
				Author = "Shepard",
				Information = "Corvette C6",
				Model = "models/corvette/corvette.mdl",
				
				KeyValues = {
								vehiclescript	=	"scripts/vehicles/corvette.txt"
							}
			}

list.Set( "Vehicles", "vette", V )