local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "QStyleLoading"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local function roundify(gui, radius)
	local uic = Instance.new("UICorner")
	uic.CornerRadius = UDim.new(0, radius)
	uic.Parent = gui
end

-- Background
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
bg.BackgroundTransparency = 0.4
bg.BorderSizePixel = 0
bg.Parent = screenGui

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 5, 30)
frame.BorderSizePixel = 0
frame.Parent = bg
roundify(frame, 12)

-- Neon Stroke
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(200, 0, 255)
stroke.Thickness = 3
stroke.Transparency = 0.25
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

TweenService:Create(stroke, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
	Transparency = 0.05
}):Play()

-- Avatar Image
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0, 60, 0, 60)
avatar.Position = UDim2.new(0.5, -30, 0.05, 0)
avatar.BackgroundTransparency = 1
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
roundify(avatar, 999)
avatar.Parent = frame

-- Pulse Animation
task.spawn(function()
	while avatar.Parent do
		local grow = TweenService:Create(avatar, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 68, 0, 68),
			Position = UDim2.new(0.5, -34, 0.05, -4),
			ImageTransparency = 0.05
		})
		local shrink = TweenService:Create(avatar, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 60, 0, 60),
			Position = UDim2.new(0.5, -30, 0.05, 0),
			ImageTransparency = 0
		})
		grow:Play()
		grow.Completed:Wait()
		shrink:Play()
		shrink.Completed:Wait()
	end
end)

-- Main Text
local mainLabel = Instance.new("TextLabel")
mainLabel.Size = UDim2.new(1, 0, 0.2, 0)
mainLabel.Position = UDim2.new(0, 0, 0.5, -10)
mainLabel.BackgroundTransparency = 1
mainLabel.Text = "Loading Script, Please Wait..."
mainLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
mainLabel.Font = Enum.Font.FredokaOne
mainLabel.TextScaled = true
mainLabel.Parent = frame

-- Percent
local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 0.15, 0)
percentLabel.Position = UDim2.new(0, 0, 0.68, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.Font = Enum.Font.FredokaOne
percentLabel.TextScaled = true
percentLabel.Parent = frame

-- Progress Bar
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -40, 0, 10)
barBg.Position = UDim2.new(0, 20, 0.85, 0)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
barBg.BorderSizePixel = 0
barBg.Parent = frame
roundify(barBg, 8)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
roundify(barFill, 8)

-- 30-second loading logic
local duration = 10
local steps = 100
for i = 1, steps do
	local percent = i / steps
	barFill.Size = UDim2.new(percent, 0, 1, 0)
	percentLabel.Text = i .. "%"
	wait(duration / steps)
end

-- Fade Out
TweenService:Create(bg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(frame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(mainLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
TweenService:Create(percentLabel, TweenInfo.new(1), {TextTransparency = 1}):Play()
TweenService:Create(barBg, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(barFill, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
TweenService:Create(avatar, TweenInfo.new(1), {ImageTransparency = 1}):Play()
wait(1.2)
screenGui:Destroy()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local petTable = {
    ["Common Egg"] = { "Dog", "Bunny", "Golden Lab" },
    ["Uncommon Egg"] = { "Chicken", "Black Bunny", "Cat", "Deer" },
    ["Rare Egg"] = { "Pig", "Monkey", "Rooster", "Orange Tabby", "Spotted Deer" },
    ["Legendary Egg"] = { "Cow", "Polar Bear", "Sea Otter", "Turtle", "Silver Monkey" },
    ["Mythical Egg"] = { "Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant" },
    ["Bug Egg"] = { "Snail", "Caterpillar", "Giant Ant", "Praying Mantis" },
    ["Night Egg"] = { "Frog", "Hedgehog", "Mole", "Echo Frog", "Night Owl", },
    ["Bee Egg"] = { "Bee", "Honey Bee", "Bear Bee", "Petal Bee" },
    ["Anti Bee Egg"] = { "Wasp", "Moth", "Tarantula Hawk" },
    ["Oasis Egg"] = { "Meerkat", "Sand Snake", "Axolotl" },
    ["Paradise Egg"] = { "Ostrich", "Peacock", "Capybara" },
    ["Dinosaur Egg"] = { "Raptor", "Triceratops", "Stegosaurus" },
    ["Primal Egg"] = { "Parasaurolophus", "Iguanodon", "Pachycephalosaurus" },
    ["Zen Egg"] = { "Tanchozuru", "Kappa", "Kitsune", "Tanuki", "NihonZaru" },
}

local espEnabled = true
local truePetMap = {}

local function glitchLabelEffect(label)
    coroutine.wrap(function()
        local original = label.TextColor3
        for i = 1, 2 do
            label.TextColor3 = Color3.new(1, 0, 0)
            wait(0.07)
            label.TextColor3 = original
            wait(0.07)
        end
    end)()
end

local function applyEggESP(eggModel, petName)
    local existingLabel = eggModel:FindFirstChild("PetBillboard", true)
    if existingLabel then existingLabel:Destroy() end
    local existingHighlight = eggModel:FindFirstChild("ESPHighlight")
    if existingHighlight then existingHighlight:Destroy() end
    if not espEnabled then return end

    local basePart = eggModel:FindFirstChildWhichIsA("BasePart")
    if not basePart then return end

    local hatchReady = true
    local hatchTime = eggModel:FindFirstChild("HatchTime")
    local readyFlag = eggModel:FindFirstChild("ReadyToHatch")

    if hatchTime and hatchTime:IsA("NumberValue") and hatchTime.Value > 0 then
        hatchReady = false
    elseif readyFlag and readyFlag:IsA("BoolValue") and not readyFlag.Value then
        hatchReady = false
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetBillboard"
    billboard.Size = UDim2.new(0, 270, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 500
    billboard.Parent = basePart

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = eggModel.Name .. " | " .. petName
    if not hatchReady then
        label.Text = eggModel.Name .. " | " .. petName .. " (Not Ready)"
        label.TextColor3 = Color3.fromRGB(160, 160, 160)
        label.TextStrokeTransparency = 0.5
    else
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextStrokeTransparency = 0
    end
    label.TextScaled = true
    label.Font = Enum.Font.FredokaOne
    label.Parent = billboard

    glitchLabelEffect(label)

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.FillColor = Color3.fromRGB(255, 200, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.7
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Adornee = eggModel
    highlight.Parent = eggModel
end

local function removeEggESP(eggModel)
    local label = eggModel:FindFirstChild("PetBillboard", true)
    if label then label:Destroy() end
    local highlight = eggModel:FindFirstChild("ESPHighlight")
    if highlight then highlight:Destroy() end
end

local function getPlayerGardenEggs(radius)
    local eggs = {}
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return eggs end

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and petTable[obj.Name] then
            local dist = (obj:GetModelCFrame().Position - root.Position).Magnitude
            if dist <= (radius or 60) then
                if not truePetMap[obj] then
                    local pets = petTable[obj.Name]
                    local chosen = pets[math.random(1, #pets)]
                    truePetMap[obj] = chosen
                end
                table.insert(eggs, obj)
            end
        end
    end
    return eggs
end

local function randomizeNearbyEggs()
    local eggs = getPlayerGardenEggs(60)
    for _, egg in ipairs(eggs) do
        local pets = petTable[egg.Name]
        local chosen = pets[math.random(1, #pets)]
        truePetMap[egg] = chosen
        applyEggESP(egg, chosen)
    end
    print("Randomized", #eggs, "eggs.")
end

local function flashEffect(button)
    local originalColor = button.BackgroundColor3
    for i = 1, 5 do
        button.BackgroundColor3 = Color3.new(1, 1, 1)
        wait(0.05)
        button.BackgroundColor3 = originalColor
        wait(0.05)
    end
end

local function countdownAndRandomize(button)
    for i = 10, 1, -1 do
        button.Text = "Randomize in: " .. i
        wait(1)
    end
    flashEffect(button)
    randomizeNearbyEggs()
    button.Text = "Randomize Pets"
end

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetHatchGui"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 260)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(105, 80, 60)
frame.BorderSizePixel = 0
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Pet Randomizer"
title.Font = Enum.Font.FredokaOne
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local drag = Instance.new("TextButton", title)
drag.Size = UDim2.new(1, 0, 1, 0)
drag.Text = ""
drag.BackgroundTransparency = 1

local dragging, offset
drag.MouseButton1Down:Connect(function()
    dragging = true
    offset = Vector2.new(mouse.X - frame.Position.X.Offset, mouse.Y - frame.Position.Y.Offset)
end)
UserInputService.InputEnded:Connect(function()
    dragging = false
end)
RunService.RenderStepped:Connect(function()
    if dragging then
        frame.Position = UDim2.new(0, mouse.X - offset.X, 0, mouse.Y - offset.Y)
    end
end)

local randomizeBtn = Instance.new("TextButton", frame)
randomizeBtn.Size = UDim2.new(1, -20, 0, 50)
randomizeBtn.Position = UDim2.new(0, 10, 0, 40)
randomizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
randomizeBtn.Text = "Randomize Pets Please wait.."
randomizeBtn.TextSize = 20
randomizeBtn.Font = Enum.Font.FredokaOne
randomizeBtn.TextColor3 = Color3.new(1, 1, 1)
randomizeBtn.MouseButton1Click:Connect(function()
    countdownAndRandomize(randomizeBtn)
end)

local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(1, -20, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 100)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleBtn.Text = "ESP: ON"
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.FredokaOne
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    toggleBtn.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    for _, egg in pairs(getPlayerGardenEggs(60)) do
        if espEnabled then
            applyEggESP(egg, truePetMap[egg])
        else
            removeEggESP(egg)
        end
    end
end)

for _, egg in pairs(getPlayerGardenEggs(60)) do
    applyEggESP(egg, truePetMap[egg])
end

local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(1, -20, 0, 30)
autoBtn.Position = UDim2.new(0, 10, 0, 145)
autoBtn.BackgroundColor3 = Color3.fromRGB(80, 150, 60)
autoBtn.Text = "Auto Randomize: OFF"
autoBtn.TextSize = 16
autoBtn.Font = Enum.Font.FredokaOne
autoBtn.TextColor3 = Color3.new(1, 1, 1)

local autoRunning = false
local bestPets = {
    ["Raccoon"] = true, ["Dragonfly"] = true, ["Queen Bee"] = true,
    ["Disco Bee"] = true, ["Fennec Fox"] = true, ["Fox"] = true,
    ["Mimic Octopus"] = true, ["Kitsune"] = true
}

autoBtn.MouseButton1Click:Connect(function()
    autoRunning = not autoRunning
    autoBtn.Text = autoRunning and "Auto Randomize: ON" or "Auto Randomize: OFF"
    coroutine.wrap(function()
        while autoRunning do
            countdownAndRandomize(randomizeBtn)
            for _, petName in pairs(truePetMap) do
                if bestPets[petName] then
                    autoRunning = false
                    autoBtn.Text = "Auto Randomize: OFF"
                    return
                end
            end
            wait(1)
        end
    end)()
end)

local loadPetBtn = Instance.new("TextButton", frame)
loadPetBtn.Size = UDim2.new(1, -20, 0, 30)
loadPetBtn.Position = UDim2.new(0, 10, 1, -75)
loadPetBtn.BackgroundColor3 = Color3.fromRGB(100, 90, 200)
loadPetBtn.Text = "🧬 Pet Mutation Esp Script"
loadPetBtn.TextSize = 16
loadPetBtn.Font = Enum.Font.FredokaOne
loadPetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

loadPetBtn.MouseButton1Click:Connect(function()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local mutations = {
    "Shiny", "Inverted", "Frozen", "Windy", "Golden", "Mega", "Tiny",
    "Tranquil", "IronSkin", "Radiant", "Rainbow", "Shocked", "Ascended"
}
local currentMutation = mutations[math.random(#mutations)]
local espVisible = true

local gui = Instance.new("ScreenGui")
gui.Name = "PetMutationFinder"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 185)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.BorderColor3 = Color3.fromRGB(80, 80, 90)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(100, 100, 110)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "Pet Mutation Finder📡"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local function createButton(text, yPos, color)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Position = UDim2.new(0.05, 0, 0, yPos)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 16
	btn.TextColor3 = Color3.new(0, 0, 0)
	btn.AutoButtonColor = false

	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.Thickness = 1.2

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.2)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
	end)

	btn.Parent = frame
	return btn
end

local reroll = createButton("Reroll Mutation", 45, Color3.fromRGB(140, 200, 255))
local toggle = createButton("Toggle Mutation Esp", 90, Color3.fromRGB(180, 255, 180))

local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 1, -20)
credit.Text = "Made by @kennz_hub"
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.BackgroundTransparency = 1
credit.Font = Enum.Font.Gotham
credit.TextSize = 13

local function findMachine()
	for _, obj in pairs(Workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find("mutation") then
			return obj
		end
	end
end

local machine = findMachine()
if not machine or not machine:FindFirstChildWhichIsA("BasePart") then
	warn("Pet Mutation Machine not found.")
	return
end

local basePart = machine:FindFirstChildWhichIsA("BasePart")

local espGui = Instance.new("BillboardGui", basePart)
espGui.Name = "🧬MutationESP"
espGui.Adornee = basePart
espGui.Size = UDim2.new(0, 200, 0, 40)
espGui.StudsOffset = Vector3.new(0, 3, 0)
espGui.AlwaysOnTop = true

local espLabel = Instance.new("TextLabel", espGui)
espLabel.Size = UDim2.new(1, 0, 1, 0)
espLabel.BackgroundTransparency = 1
espLabel.Font = Enum.Font.GothamBold
espLabel.TextSize = 24
espLabel.TextStrokeTransparency = 0.3
espLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
espLabel.Text = currentMutation

local hue = 0
RunService.RenderStepped:Connect(function()
	if espVisible then
		hue = (hue + 0.01) % 1
		espLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
	end
end)

local function animateMutationReroll()
	reroll.Text = "Rerolling..."
	local duration = 2
	local interval = 0.1
	for i = 1, math.floor(duration / interval) do
		espLabel.Text = mutations[math.random(#mutations)]
		wait(interval)
	end
	currentMutation = mutations[math.random(#mutations)]
	espLabel.Text = currentMutation
	reroll.Text = "🎲Reroll Mutation"
end

toggle.MouseButton1Click:Connect(function()
	espVisible = not espVisible
	espGui.Enabled = espVisible
end)

reroll.MouseButton1Click:Connect(animateMutationReroll)
end)
local loadAgeBtn = Instance.new("TextButton", frame)
loadAgeBtn.Size = UDim2.new(1, -20, 0, 30)
loadAgeBtn.Position = UDim2.new(0, 10, 1, -35)
loadAgeBtn.BackgroundColor3 = Color3.fromRGB(100, 90, 200)
loadAgeBtn.Text = "🧬 Instant Pets Age 50"
loadAgeBtn.TextSize = 16
loadAgeBtn.Font = Enum.Font.FredokaOne
loadAgeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

loadAgeBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GrowAGarden-Scr1pt/ZusumeHub/refs/heads/main/Pet-age_insantlvl.lua"))()
end)

-- 🌱 Pet Spawner Button (new)
local spawnerBtn = Instance.new("TextButton", frame)
spawnerBtn.Size = UDim2.new(1, -20, 0, 30)
spawnerBtn.Position = UDim2.new(0, 10, 1, -115)
spawnerBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 80)
spawnerBtn.Text = "🐶 Pets Spawner Script"
spawnerBtn.TextSize = 16
spawnerBtn.Font = Enum.Font.FredokaOne
spawnerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

spawnerBtn.MouseButton1Click:Connect(function()
        local Spawner = loadstring(game:HttpGet("https://codeberg.org/darkdarkdark/roblox/raw/branch/main/Spawner.lua"))()
	end)

-- Credit Note
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 0, 22)
credit.BackgroundTransparency = 1
credit.Text = "Made by- Kennz_Hub"
credit.Font = Enum.Font.FredokaOne
credit.TextSize = 14
credit.TextColor3 = Color3.fromRGB(200, 200, 200)

-- 🌟 Main Toggle Button (top-right corner, draggable)
local mainToggleGui = Instance.new("ScreenGui")
mainToggleGui.Name = "MainToggleGUI"
mainToggleGui.Parent = player:WaitForChild("PlayerGui")

local mainToggleBtn = Instance.new("TextButton")
mainToggleBtn.Size = UDim2.new(0, 120, 0, 40)
mainToggleBtn.Position = UDim2.new(1, -130, 0, 10)
mainToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainToggleBtn.Text = "Script: ON"
mainToggleBtn.TextColor3 = Color3.new(1, 1, 1)
mainToggleBtn.Font = Enum.Font.FredokaOne
mainToggleBtn.TextSize = 18
mainToggleBtn.Parent = mainToggleGui
Instance.new("UICorner", mainToggleBtn).CornerRadius = UDim.new(0, 8)

-- Dragging variables
local dragging = false
local dragInput, mousePos, framePos

mainToggleBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		mousePos = input.Position
		framePos = mainToggleBtn.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainToggleBtn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		mainToggleBtn.Position = UDim2.new(
			framePos.X.Scale, framePos.X.Offset + delta.X,
			framePos.Y.Scale, framePos.Y.Offset + delta.Y
		)
	end
end)

-- Toggle function
local scriptEnabled = true

mainToggleBtn.MouseButton1Click:Connect(function()
	if dragging then return end -- prevent toggle while dragging
	scriptEnabled = not scriptEnabled
	mainToggleBtn.Text = scriptEnabled and "Script: ON" or "Script: OFF"
	
	-- Hide/Show your main pet GUI
	screenGui.Enabled = scriptEnabled
	
	-- Toggle ESP globally
	espEnabled = scriptEnabled
	if not scriptEnabled then
		-- Remove ESP from all eggs
		for _, egg in pairs(getPlayerGardenEggs(60)) do
			removeEggESP(egg)
		end
	else
		-- Restore ESP
		for _, egg in pairs(getPlayerGardenEggs(60)) do
			applyEggESP(egg, truePetMap[egg])
		end
	end
end)
