-- 🟠 Randomize Button
local randomizeBtn = Instance.new("TextButton", frame)
randomizeBtn.Size = UDim2.new(1, -20, 0, 40)
randomizeBtn.Position = UDim2.new(0, 10, 0, 40)
randomizeBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
randomizeBtn.Text = "Randomize Pets"
randomizeBtn.TextSize = 20
randomizeBtn.Font = Enum.Font.FredokaOne
randomizeBtn.TextColor3 = Color3.new(1, 1, 1)
randomizeBtn.MouseButton1Click:Connect(function()
    countdownAndRandomize(randomizeBtn)
end)

-- 🟡 Toggle ESP
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Size = UDim2.new(1, -20, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 90)
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

-- 🟢 Auto Randomize
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(1, -20, 0, 35)
autoBtn.Position = UDim2.new(0, 10, 0, 135)
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

-- 🐶 Spawn Pet Script Button
local spawnBtn = Instance.new("TextButton", frame)
spawnBtn.Size = UDim2.new(1, -20, 0, 30)
spawnBtn.Position = UDim2.new(0, 10, 0, 180)
spawnBtn.BackgroundColor3 = Color3.fromRGB(120, 200, 100)
spawnBtn.Text = "🐶 Spawn Pet Script"
spawnBtn.TextSize = 16
spawnBtn.Font = Enum.Font.FredokaOne
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/veryimportantrr/x/refs/heads/main/gag_visual.lua", true))("discord.gg/csxu2nCkw9")
    end)
end)

-- 🧬 Load Mutation ESP
local loadPetBtn = Instance.new("TextButton", frame)
loadPetBtn.Size = UDim2.new(1, -20, 0, 30)
loadPetBtn.Position = UDim2.new(0, 10, 0, 215)
loadPetBtn.BackgroundColor3 = Color3.fromRGB(100, 90, 200)
loadPetBtn.Text = "Pet Mutation Esp Script"
loadPetBtn.TextSize = 16
loadPetBtn.Font = Enum.Font.FredokaOne
loadPetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loadPetBtn.MouseButton1Click:Connect(function()
    -- Your existing Mutation ESP script here...
end)

-- ⏳ Load Pet Age 50
local loadAgeBtn = Instance.new("TextButton", frame)
loadAgeBtn.Size = UDim2.new(1, -20, 0, 30)
loadAgeBtn.Position = UDim2.new(0, 10, 0, 250)
loadAgeBtn.BackgroundColor3 = Color3.fromRGB(100, 90, 200)
loadAgeBtn.Text = "Load Pet Age 50 Script"
loadAgeBtn.TextSize = 16
loadAgeBtn.Font = Enum.Font.FredokaOne
loadAgeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
loadAgeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://xaphy.io/load", true))()
    end)
end)
