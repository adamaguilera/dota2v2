SERVER = ""
POST_GAME_ROUTE = "/dota2v2/post-game"
TITLE_ROUTE = "/title"
function barebones:TestPost(json_payload)
  local request = CreateHTTPRequest("POST", SERVER..TITLE)
  request:SetHTTPRequestGetOrPostParameter("payload", json_payload)
  request:Send(function(result)
    print("body: "..result.Body)
  end)
end

function barebones:GetPlayerPostGameData(playerID)
  if CDOTA_PlayerResource:IsRealPlayer(playerID) then
    
  end
end
