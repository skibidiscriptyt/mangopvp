-- Mango PvP v1.2 by SkibidiScript

-- Sea Check (Works only in Second or Third Sea)
local placeId = game.PlaceId
local allowedPlaceIds = {
    [2753915549] = false, -- First Sea (Old World)
    [4442272183] = true,  -- Second Sea
    [7449423635] = true,  -- Third Sea
}

if not allowedPlaceIds[placeId] then
    game.Players.LocalPlayer:Kick("Script only works in Sea 2,3")
    return
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 200, 0, 100)
Main.Position = UDim2.new(0.4, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.BackgroundTransparency = 1
Title.Text = "Mango PvP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

local ToggleButton = Instance.new("TextButton", Main)
ToggleButton.Size = UDim2.new(0.8, 0, 0.35, 0)
ToggleButton.Position = UDim2.new(0.1, 0, 0.5, 0)
ToggleButton.Text = "PvP: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextScaled = true
Instance.new("UICorner", ToggleButton)

-- PvP Logic
local PvPEnabled = false

ToggleButton.MouseButton1Click:Connect(function()
	PvPEnabled = not PvPEnabled
	ToggleButton.Text = PvPEnabled and "PvP: ON" or "PvP: OFF"
end)

task.spawn(function()
	while true do
		if PvPEnabled then
			local myChar = LocalPlayer.Character
			if myChar and myChar:FindFirstChild("HumanoidRootPart") then
				for _, player in pairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						local targetHRP = player.Character.HumanoidRootPart
						local myHRP = myChar.HumanoidRootPart
						local distance = (targetHRP.Position - myHRP.Position).Magnitude

						if distance < 50 then
							local tool = myChar:FindFirstChildOfClass("Tool")
							if tool then
								tool:Activate()
							end
						end
					end
				end
			end
		end
		task.wait(0.3)
	end
end)
