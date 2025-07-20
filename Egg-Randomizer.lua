local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Pet Age 50 Visual Toggle",
    HidePremium = false,
    SaveConfig = false,
    IntroText = "By Kennz-hub"
})

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local active = false

local function setHeldPetAgeVisual(age)
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
        if handle then
            local existing = handle:FindFirstChild("FakeAgeBillboard")
            if existing then existing:Destroy() end

            local bb = Instance.new("BillboardGui", handle)
            bb.Name = "FakeAgeBillboard"
            bb.Size = UDim2.new(0, 100, 0, 50)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true

            local label = Instance.new("TextLabel", bb)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "Age: " .. age
            label.TextColor3 = Color3.fromRGB(255, 215, 0)
            label.TextStrokeTransparency = 0.5
            label.Font = Enum.Font.FredokaOne
            label.TextScaled = true
        end
    end
end

local function removeHeldPetAgeVisual()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
        if handle then
            local existing = handle:FindFirstChild("FakeAgeBillboard")
            if existing then existing:Destroy() end
        end
    end
end

MainTab:AddToggle({
    Name = "Toggle Held Pet Age 50 Visual",
    Default = false,
    Callback = function(Value)
        active = Value
        if active then
            setHeldPetAgeVisual(50)
        else
            removeHeldPetAgeVisual()
        end
    end
})

OrionLib:Init()
