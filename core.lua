-- MANGO PVP MODE GUI - SkibidiScript

-- Rainbow Function
local function rainbowText(label)
    coroutine.wrap(function()
        local hue = 0
        while true do
            hue = (hue + 0.01) % 1
            label.TextColor3 = Color3.fromHSV(hue, 1, 1)
            task.wait()
        end
    end)()
end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "MangoPVP"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 300, 0, 100)
Frame.Position = UDim2.new(0.5, -150, 0.8, 0)
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.3
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Text = "MANGO PVP MODE"
Title.Size = UDim2.new(1, 0, 0.3, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 0, 0)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack

local ToggleBtn = Instance.new("TextButton", Frame)
ToggleBtn.Size = UDim2.new(1, 0, 0.4, 0)
ToggleBtn.Position = UDim2.new(0, 0, 0.3, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = "MANGO PVP: OFF"
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextColor3 = Color3.new(1, 0, 0)

local RainbowLabel = Instance.new("TextLabel", Frame)
RainbowLabel.Size = UDim2.new(1, 0, 0.3, 0)
RainbowLabel.Position = UDim2.new(0, 0, 0.7, 0)
RainbowLabel.BackgroundTransparency = 1
RainbowLabel.Text = "Made by: @SkibidiScript"
RainbowLabel.Font = Enum.Font.GothamBlack
RainbowLabel.TextScaled = true
rainbowText(RainbowLabel)

-- Toggle Logic
_G.MangoPVP = false
ToggleBtn.MouseButton1Click:Connect(function()
    _G.MangoPVP = not _G.MangoPVP
    if _G.MangoPVP then
        ToggleBtn.Text = "MANGO PVP: ON"
        ToggleBtn.TextColor3 = Color3.new(1, 0, 0)
        print("PvP is now ON - Start logic")
    else
        ToggleBtn.Text = "MANGO PVP: OFF"
        ToggleBtn.TextColor3 = Color3.new(1, 0, 0)
        print("PvP is now OFF")
    end
end)
