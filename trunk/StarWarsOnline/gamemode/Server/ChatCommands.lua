function GM:PlayerSay( ply, text, global )
	if( string.find( text, "!Encode:" ) == 1 )then
		Message = string.sub( text, 8 )
		if( string.sub( Message, 1, 1 ) == "%s" ) then
			return base64:enc( Message )
		else
			Message = string.sub( Message, 2 )
			return base64:enc( Message )
		end
	end
	if( string.find( text, "!Decode:" ) == 1 )then
		Message = string.sub( text, 8 )
		if( string.sub( Message, 1, 1 ) == "%s" ) then
			return base64:dec( Message )
		else
			Message = string.sub( Message, 2 )
			return base64:dec( Message )
		end
	end
end

