SERVER = ""
POST_GAME_ROUTE = "/dota2v2/post-game"
function barebones:PostGameData(json_payload)
  local request = CreateHTTPRequest("POST", SERVER..POST_GAME_ROUTE)
  request:SetHTTPRequestGetOrPostParameter("payload", json_payload)
  request:Send(function(result)
  end)
end

function barebones:GetPlayerPostGameData(playerID)
  if CDOTA_PlayerResource:IsRealPlayer(playerID) then
    
  end
end
