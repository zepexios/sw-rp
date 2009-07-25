//Shepard's cars

local Category = "Shepard's cars"

local V = { 	
				// Required information
				Name = "Mustang", 
				Class = "prop_vehicle_jeep",
				Category = "Shepard's cars",

				// Optional information
				Author = "Shepard",
				Information = "1968 mustang fastback GT",
				Model = "models/Splayn/ford_mustang_fastback_gt.mdl",
				
				KeyValues = {
								vehiclescript	=	"scripts/vehicles/corvette.txt"
							}
			}

list.Set( "Vehicles", "mustang", V )