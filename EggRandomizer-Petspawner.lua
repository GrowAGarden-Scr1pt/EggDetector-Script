local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false
screenGui.Name = "PetESP_UI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 220, 0, 360)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "🐾 Pet ESP Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextStrokeTransparency = 0.8
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

-- Button Factory Function
local function createButton(text, positionY, bgColor, icon, onClick)
	local btn = Instance.new("TextButton", mainFrame)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, positionY)
	btn.BackgroundColor3 = bgColor
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 16
	btn.Text = icon .. "  " .. text

	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = bgColor:Lerp(Color3.new(1, 1, 1), 0.1)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = bgColor
	end)

	btn.MouseButton1Click:Connect(onClick)
	return btn
end

-- Buttons
createButton("Pet ESP", 50, Color3.fromRGB(85, 170, 255), "👁️", function()
	print("Pet ESP triggered")
end)

createButton("Pet Mutation ESP", 100, Color3.fromRGB(100, 85, 255), "🧬", function()
	print("Mutation ESP triggered")
end)

createButton("Pet Age 50 Script", 150, Color3.fromRGB(170, 85, 255), "⏳", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/age50.lua", true))()
end)

createButton("Spawn Pet", 200, Color3.fromRGB(85, 170, 255), "🐶", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/gag_visual.lua", true))("discord.gg/csxu2nCkw9")
end)

-- ❌ Close Button
createButton("Close GUI", 250, Color3.fromRGB(255, 85, 85), "❌", function()
	screenGui:Destroy()
end)
