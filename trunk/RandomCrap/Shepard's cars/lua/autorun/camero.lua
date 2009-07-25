//Shepard's cars

local Category = "Shepard's cars"

local V = { 	
				// Required information
				Name = "Camaro", 
				Class = "prop_vehicle_jeep",
				Category = "Shepard's cars",

				// Optional information
				Author = "Shepard",
				Information = "camero",
				Model = "models/peterboi/camaro/camaro.mdl",
				
				KeyValues = {
								vehiclescript	=	"scripts/vehicles/corvette.txt"
							}
			}

list.Set( "Vehicles", "camero", V )