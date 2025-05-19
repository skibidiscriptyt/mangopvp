-- Mango PvP v1.3 by @SkibidiScript

-- Only works in Second or Third Sea
local allowedPlaceIds = {
    [4442272183] = true,  -- Second Sea
    [7449423635] = true,  -- Third Sea
}

if not allowedPlaceIds[game.PlaceId] then
    game.Players.LocalPlayer:Kick("Script only works in Sea 2,3")
    return
end

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- GUI Setup
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "MangoPvP_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 110)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.BackgroundTransparency = 1
title.Text = "Mango PvP"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0.2, 0)
credit.Position = UDim2.new(0, 0, 0.8, 0)
credit.BackgroundTransparency = 1
credit.Text = "Made by: @SkibidiScript"
credit.Font = Enum.Font.GothamBold
credit.TextScaled = true

local toggle = Instance.new("TextButton", frame)
toggle.Size = UDim2.new(0.8, 0, 0.3, 0)
toggle.Position = UDim2.new(0.1, 0, 0.45, 0)
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.Text = "PvP: OFF"
toggle.TextScaled = true
Instance.new("UICorner", toggle)

-- Rainbow Text
task.spawn(function()
	while true do
		local t = tick() * 2
		credit.TextColor3 = Color3.fromHSV((t % 5) / 5, 1, 1)
		task.wait(0.1)
	end
end)

-- PvP Logic
local PvPEnabled = false
toggle.MouseButton1Click:Connect(function()
	PvPEnabled = not PvPEnabled
	toggle.Text = PvPEnabled and "PvP: ON" or "PvP: OFF"
end)

-- Server Hop Function
local function hopServer()
	local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
	for _, server in pairs(servers.data) do
		if server.playing < server.maxPlayers then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
			break
		end
	end
end

-- Attack Logic
task.spawn(function()
	while true do
		if PvPEnabled then
			local myChar = LocalPlayer.Character
			local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
			local myLevel = LocalPlayer:FindFirstChild("Data") and LocalPlayer.Data.Level.Value or 0

			local targetFound = false

			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local theirLevel = player:FindFirstChild("Data") and player.Data:FindFirstChild("Level") and player.Data.Level.Value
					if theirLevel and math.abs(theirLevel - myLevel) <= 10 then
						local distance = (player.Character.HumanoidRootPart.Position - myHRP.Position).Magnitude
						if distance <= 50 then
							local tool = myChar:FindFirstChildOfClass("Tool")
							if tool then
								tool:Activate()
							end
							targetFound = true
						end
					end
				end
			end

			if not targetFound then
				task.wait(10)
				hopServer()
			end
		end
		task.wait(0.5)
	end
end)
