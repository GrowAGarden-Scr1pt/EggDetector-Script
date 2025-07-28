-- Pet ESP + GUI Script with Toggleable Pets Spawner

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

local function highlightPet(pet)
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = pet
    highlight.Parent = pet
end

local function findAndHighlightPets()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and petTable[v.Name] then
            highlightPet(v)
        end
    end
end

findAndHighlightPets()

-- GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetESPGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 300)
frame.Position = UDim2.new(0.5, -125, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Text = "🐾 Pet ESP Control Panel"
title.Font = Enum.Font.FredokaOne
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Auto Randomize Button
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(1, -20, 0, 30)
autoBtn.Position = UDim2.new(0, 10, 0, 50)
autoBtn.BackgroundColor3 = Color3.fromRGB(120, 180, 100)
autoBtn.Text = "🔀 Auto Randomize Pets"
autoBtn.TextSize = 16
autoBtn.Font = Enum.Font.FredokaOne
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

autoBtn.MouseButton1Click:Connect(function()
    for eggType, pets in pairs(petTable) do
        local randomPet = pets[math.random(1, #pets)]
        print("Auto-Randomized: ", eggType, "->", randomPet)
    end
end)

-- 🐾 Pets Spawner (TOGGLEABLE)
local spawnerBtn = Instance.new("TextButton", frame)
spawnerBtn.Size = UDim2.new(1, -20, 0, 30)
spawnerBtn.Position = UDim2.new(0, 10, 1, -115)
spawnerBtn.BackgroundColor3 = Color3.fromRGB(200, 90, 60)
spawnerBtn.Text = "🐾 Pets Spawner: OFF"
spawnerBtn.TextSize = 16
spawnerBtn.Font = Enum.Font.FredokaOne
spawnerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnerBtn.Parent = frame

local petsGuiName = "Kennz_Hub"
local petsSpawnerLoaded = false
local petsGui = nil

spawnerBtn.MouseButton1Click:Connect(function()
    if not petsSpawnerLoaded then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ranzurg/GrowaGarden/refs/heads/main/KaruHub.lua"))()
        petsSpawnerLoaded = true
        spawnerBtn.Text = "🐾 Pets Spawner: Loading..."

        for i = 1, 50 do
            petsGui = game:GetService("CoreGui"):FindFirstChild(petsGuiName) or player:FindFirstChild("PlayerGui"):FindFirstChild(petsGuiName)
            if petsGui then break end
            wait(0.1)
        end

        if petsGui then
            spawnerBtn.Text = "🐾 Pets Spawner: ON"
        else
            spawnerBtn.Text = "🐾 Pets Spawner: FAILED"
        end
    else
        if petsGui and petsGui.Parent then
            petsGui.Enabled = not petsGui.Enabled
            spawnerBtn.Text = petsGui.Enabled and "🐾 Pets Spawner: ON" or "🐾 Pets Spawner: OFF"
        end
    end
end)

-- 🧬 Pet Mutation ESP Button
local loadPetBtn = Instance.new("TextButton", frame)
loadPetBtn.Size = UDim2.new(1, -20, 0, 30)
loadPetBtn.Position = UDim2.new(0, 10, 1, -75)
loadPetBtn.BackgroundColor3 = Color3.fromRGB(100, 90, 200)
loadPetBtn.Text = "Pet Mutation Esp Script"
loadPetBtn.TextSize = 16
loadPetBtn.Font = Enum.Font.FredokaOne
loadPetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loadPetBtn.Parent = frame

loadPetBtn.MouseButton1Click:Connect(function()
    -- Replace with your mutation ESP script or loadstring
    print("Pet Mutation ESP Loaded")
end)

-- 🐶 Pet Age Loader
local loadAgeBtn = Instance.new("TextButton", frame)
loadAgeBtn.Size = UDim2.new(1, -20, 0, 30)
loadAgeBtn.Position = UDim2.new(0, 10, 1, -35)
loadAgeBtn.BackgroundColor3 = Color3.fromRGB(100, 90, 200)
loadAgeBtn.Text = "🐶Pet Age instant Lvl"
loadAgeBtn.TextSize = 16
loadAgeBtn.Font = Enum.Font.FredokaOne
loadAgeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loadAgeBtn.Parent = frame

loadAgeBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/GrowAGarden-Scr1pt/ZusumeHub/refs/heads/main/Pet-age_insantlvl.lua"))()
end)

-- 💬 Credit/Note
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 0, 22)
credit.BackgroundTransparency = 1
credit.Text = "Madeby Kennz (Rejoin Server if not Works)"
credit.Font = Enum.Font.FredokaOne
credit.TextSize = 13
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.Parent = frame
