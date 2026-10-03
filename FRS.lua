-- ================================================================= --
--            RIVALS ADVANCED ENGINE & MULTI-LANG FRAMEWORK           --
--      DUAL-LANGUAGE (AR/EN) + MINI & CLOSE SYSTEM (DELTA COMPATIBLE) --
-- ================================================================= --

local Services = {
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    CoreGui = game:GetService("CoreGui"),
    Workspace = game:GetService("Workspace"),
    Lighting = game:GetService("Lighting"),
    TweenService = game:GetService("TweenService")
}

local LocalPlayer = Services.Players.LocalPlayer
local Camera = Services.Workspace.CurrentCamera

if Services.CoreGui:FindFirstChild("RivalsUltimateEngine") then
    Services.CoreGui:FindFirstChild("RivalsUltimateEngine"):Destroy()
end

local State = {
    CurrentLanguage = "ar",
    ActiveTab = "Combat"
}

local Config = {
    AimbotEnabled = false,
    AimbotFOV = 150,
    AimbotPart = "Head",
    ShowFOV = false,
    HitboxEnabled = false,
    HitboxSize = 4,
    
    ESPEnabled = false,
    ESPBoxes = false,
    ESPTracers = false,
    ESPNames = false,
    ESPChams = false,
    
    SpeedEnabled = false,
    WalkSpeed = 32,
    JumpEnabled = false,
    JumpPower = 100,
    InfJump = false,
    Noclip = false,
    
    LowGravity = false,
    Fullbright = false,
    NoFog = false
}

local Translation = {
    ar = {
        Title = "⚡ محرك رايفلز v2.0 ⚡",
        LangBtn = "العربية 🇸🇦",
        
        TabCombat = "القتال",
        TabVisuals = "الكاشف",
        TabMovement = "الحركة",
        TabWorld = "العالم",
        
        Aimbot = "تثبيت الأيم (Aimbot)",
        AimbotFOV = "إظهار دائرة الأيم (FOV)",
        Hitbox = "توسيع هيد الخصم (Hitbox)",
        
        ESP = "الكاشف العام (ESP)",
        ESPBoxes = "مربعات على الأعداء (Boxes)",
        ESPTracers = "خطوط التتبع (Tracers)",
        ESPNames = "إظهار أسماء الأعداء",
        ESPChams = "تلوين الخصوم خلف الجدار (Chams)",
        
        Speed = "زيادة السرعة (WalkSpeed)",
        Jump = "زيادة القفز (JumpPower)",
        InfJump = "القفز الهوائي اللانهائي",
        Noclip = "اختراق الجدران (Noclip)",
        
        LowGrav = "تخفيف الجاذبية الأرضية",
        Fullbright = "إلغاء الظلام بالكامل",
        NoFog = "إزالة الضباب والرؤية الضبابية",
        
        On = "مفعل",
        Off = "معطل"
    },
    en = {
        Title = "⚡ RIVALS ENGINE v2.0 ⚡",
        LangBtn = "English 🇺🇸",
        
        TabCombat = "Combat",
        TabVisuals = "Visuals",
        TabMovement = "Movement",
        TabWorld = "World",
        
        Aimbot = "Auto Aim Lock (Aimbot)",
        AimbotFOV = "Draw FOV Circle",
        Hitbox = "Expand Head Hitbox",
        
        ESP = "Master ESP Toggle",
        ESPBoxes = "Enemy Bounding Boxes",
        ESPTracers = "Snapline Tracers",
        ESPNames = "Draw Player Names",
        ESPChams = "Highlight Wall Chams",
        
        Speed = "WalkSpeed Mod",
        Jump = "JumpPower Mod",
        InfJump = "Infinite Air Jump",
        Noclip = "Collision Pass (Noclip)",
        
        LowGrav = "Low Gravity Physics",
        Fullbright = "Remove All Darkness",
        NoFog = "Disable World Fog",
        
        On = "ENABLED",
        Off = "DISABLED"
    }
}

-- ================================================================= --
--                           GUI ENGINE                              --
-- ================================================================= --

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RivalsUltimateEngine"
ScreenGui.Parent = Services.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 360, 0, 440)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(0.45, 0, 1, 0)
TitleLabel.Position = UDim2.new(0.03, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(0, 210, 255)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- زر تغيير اللغة
local LangButton = Instance.new("TextButton")
LangButton.Name = "LangButton"
LangButton.Parent = TitleBar
LangButton.Size = UDim2.new(0.22, 0, 0.65, 0)
LangButton.Position = UDim2.new(0.48, 0, 0.175, 0)
LangButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
LangButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LangButton.Font = Enum.Font.SourceSansBold
LangButton.TextSize = 10

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 5)
LangCorner.Parent = LangButton

-- زر التصغير (-)
local MiniBtn = Instance.new("TextButton")
MiniBtn.Name = "MiniBtn"
MiniBtn.Parent = TitleBar
MiniBtn.Size = UDim2.new(0, 24, 0, 24)
MiniBtn.Position = UDim2.new(1, -56, 0, 8)
MiniBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
MiniBtn.Text = "-"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.Font = Enum.Font.SourceSansBold
MiniBtn.TextSize = 16

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 4)
MiniCorner.Parent = MiniBtn

-- زر الإغلاق (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = TitleBar
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 13

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

-- الأيقونة العائمة عند التصغير
local OpenIcon = Instance.new("TextButton")
OpenIcon.Name = "OpenIcon"
OpenIcon.Parent = ScreenGui
OpenIcon.Size = UDim2.new(0, 45, 0, 45)
OpenIcon.Position = UDim2.new(0.03, 0, 0.2, 0)
OpenIcon.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
OpenIcon.Text = "⚡"
OpenIcon.TextSize = 22
OpenIcon.Visible = false
OpenIcon.Active = true
OpenIcon.Draggable = true

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(0, 10)
IconCorner.Parent = OpenIcon

-- ربط وظائف الإغلاق والتصغير
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MiniBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenIcon.Visible = true
end)

OpenIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenIcon.Visible = false
end)

-- حاويات التبويبات
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.Size = UDim2.new(1, -20, 0, 32)
TabContainer.Position = UDim2.new(0, 10, 0, 48)
TabContainer.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 5)

local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.Size = UDim2.new(1, -20, 1, -90)
ContentContainer.Position = UDim2.new(0, 10, 0, 85)
ContentContainer.BackgroundTransparency = 1

-- ================================================================= --
--                        TAB REGISTRATION                           --
-- ================================================================= --

local Tabs = {}
local TabButtons = {}
local Updaters = {}

local function CreateTab(nameKey)
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Name = nameKey .. "Tab"
    tabScroll.Parent = ContentContainer
    tabScroll.Size = UDim2.new(1, 0, 1, 0)
    tabScroll.BackgroundTransparency = 1
    tabScroll.CanvasSize = UDim2.new(0, 0, 0, 450)
    tabScroll.Visible = false
    tabScroll.ScrollBarThickness = 3

    local layout = Instance.new("UIListLayout")
    layout.Parent = tabScroll
    layout.Padding = UDim.new(0, 6)

    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = nameKey .. "Btn"
    tabBtn.Parent = TabContainer
    tabBtn.Size = UDim2.new(0.23, 0, 1, 0)
    tabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    tabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabBtn.Font = Enum.Font.SourceSansBold
    tabBtn.TextSize = 12

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = tabBtn

    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        for _, b in pairs(TabButtons) do 
            b.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
            b.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        tabScroll.Visible = true
        tabBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        State.ActiveTab = nameKey
    end)

    Tabs[nameKey] = tabScroll
    TabButtons[nameKey] = tabBtn

    return tabScroll
end

local CombatTabFrame = CreateTab("Combat")
local VisualsTabFrame = CreateTab("Visuals")
local MovementTabFrame = CreateTab("Movement")
local WorldTabFrame = CreateTab("World")

-- ================================================================= --
--                      TOGGLE & CONTROL BUILDER                     --
-- ================================================================= --

local function AddToggle(parentTab, textKey, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = parentTab
    btn.Size = UDim2.new(0.98, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 13

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = btn

    local state = false

    local function updateText()
        local langData = Translation[State.CurrentLanguage]
        local status = state and langData.On or langData.Off
        btn.Text = "  " .. langData[textKey] .. " : [ " .. status .. " ]"
        
        if state then
            btn.TextColor3 = Color3.fromRGB(80, 255, 120)
            btn.BackgroundColor3 = Color3.fromRGB(30, 45, 35)
        else
            btn.TextColor3 = Color3.fromRGB(255, 90, 90)
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        end
    end

    btn.MouseButton1Click:Connect(function()
        state = not state
        updateText()
        callback(state)
    end)

    table.insert(Updaters, updateText)
    updateText()
end

-- ================================================================= --
--                       REGISTERING CONTROLS                        --
-- ================================================================= --

AddToggle(CombatTabFrame, "Aimbot", function(s) Config.AimbotEnabled = s end)
AddToggle(CombatTabFrame, "AimbotFOV", function(s) Config.ShowFOV = s end)
AddToggle(CombatTabFrame, "Hitbox", function(s)
    Config.HitboxEnabled = s
    for _, p in pairs(Services.Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            if s then
                p.Character.Head.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                p.Character.Head.Transparency = 0.5
            else
                p.Character.Head.Size = Vector3.new(1.2, 1.2, 1.2)
                p.Character.Head.Transparency = 0
            end
        end
    end
end)

AddToggle(VisualsTabFrame, "ESP", function(s) Config.ESPEnabled = s end)
AddToggle(VisualsTabFrame, "ESPBoxes", function(s) Config.ESPBoxes = s end)
AddToggle(VisualsTabFrame, "ESPTracers", function(s) Config.ESPTracers = s end)
AddToggle(VisualsTabFrame, "ESPNames", function(s) Config.ESPNames = s end)
AddToggle(VisualsTabFrame, "ESPChams", function(s)
    Config.ESPChams = s
    for _, p in pairs(Services.Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if s then
                if not p.Character:FindFirstChild("RivalsChams") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "RivalsChams"
                    hl.FillColor = Color3.fromRGB(255, 30, 30)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = p.Character
                end
            else
                if p.Character:FindFirstChild("RivalsChams") then
                    p.Character.RivalsChams:Destroy()
                end
            end
        end
    end
end)

AddToggle(MovementTabFrame, "Speed", function(s) Config.SpeedEnabled = s end)
AddToggle(MovementTabFrame, "Jump", function(s) Config.JumpEnabled = s end)
AddToggle(MovementTabFrame, "InfJump", function(s) Config.InfJump = s end)
AddToggle(MovementTabFrame, "Noclip", function(s) Config.Noclip = s end)

AddToggle(WorldTabFrame, "LowGrav", function(s)
    Services.Workspace.Gravity = s and 50 or 196.2
end)

AddToggle(WorldTabFrame, "Fullbright", function(s)
    Config.Fullbright = s
    if s then
        Services.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Services.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Services.Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        Services.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    end
end)

AddToggle(WorldTabFrame, "NoFog", function(s)
    Config.NoFog = s
    if s then
        Services.Lighting.FogEnd = 1e10
    else
        Services.Lighting.FogEnd = 1000
    end
end)

-- ================================================================= --
--                       DYNAMIC TRANSLATOR                          --
-- ================================================================= --

local function RefreshAllUI()
    local langData = Translation[State.CurrentLanguage]
    
    TitleLabel.Text = langData.Title
    LangButton.Text = langData.LangBtn
    
    TabButtons.Combat.Text = langData.TabCombat
    TabButtons.Visuals.Text = langData.TabVisuals
    TabButtons.Movement.Text = langData.TabMovement
    TabButtons.World.Text = langData.TabWorld
    
    for _, fn in ipairs(Updaters) do
        fn()
    end
end

LangButton.MouseButton1Click:Connect(function()
    State.CurrentLanguage = (State.CurrentLanguage == "ar") and "en" or "ar"
    RefreshAllUI()
end)

Tabs.Combat.Visible = true
TabButtons.Combat.BackgroundColor3 = Color3.fromRGB(0, 140, 230)
TabButtons.Combat.TextColor3 = Color3.fromRGB(255, 255, 255)

RefreshAllUI()

-- ================================================================= --
--                         DRAWING & FOV                             --
-- ================================================================= --

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Filled = false
FOVCircle.Transparency = 0.8
FOVCircle.Color = Color3.fromRGB(0, 210, 255)

local function UpdateFOVCircle()
    if Config.ShowFOV and Config.AimbotEnabled then
        FOVCircle.Visible = true
        FOVCircle.Radius = Config.AimbotFOV
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        FOVCircle.Visible = false
    end
end

-- ================================================================= --
--                         ESP & TRACERS                             --
-- ================================================================= --

local ESPData = {}

local function CreateESPForPlayer(player)
    if player == LocalPlayer then return end

    local box = Drawing.new("Square")
    box.Thickness = 1.5
    box.Filled = false
    box.Color = Color3.fromRGB(255, 50, 50)

    local tracer = Drawing.new("Line")
    tracer.Thickness = 1
    tracer.Color = Color3.fromRGB(255, 220, 0)

    local nameTag = Drawing.new("Text")
    nameTag.Size = 13
    nameTag.Center = true
    nameTag.Outline = true
    nameTag.Color = Color3.fromRGB(255, 255, 255)

    ESPData[player] = {Box = box, Tracer = tracer, NameTag = nameTag}
end

local function RemoveESPForPlayer(player)
    if ESPData[player] then
        ESPData[player].Box:Remove()
        ESPData[player].Tracer:Remove()
        ESPData[player].NameTag:Remove()
        ESPData[player] = nil
    end
end

for _, p in pairs(Services.Players:GetPlayers()) do
    CreateESPForPlayer(p)
end

Services.Players.PlayerAdded:Connect(CreateESPForPlayer)
Services.Players.PlayerRemoving:Connect(RemoveESPForPlayer)

local function RenderESP()
    for player, objs in pairs(ESPData) do
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local head = char and char:FindFirstChild("Head")

        if Config.ESPEnabled and char and root and head and char:FindFirstChildOfClass("Humanoid").Health > 0 then
            local rootPos, rootVis = Camera:WorldToViewportPoint(root.Position)
            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
            local legPos = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

            if rootVis then
                if Config.ESPBoxes then
                    local height = math.abs(headPos.Y - legPos.Y)
                    local width = height * 0.6
                    objs.Box.Size = Vector2.new(width, height)
                    objs.Box.Position = Vector2.new(rootPos.X - width / 2, headPos.Y)
                    objs.Box.Visible = true
                else
                    objs.Box.Visible = false
                end

                if Config.ESPTracers then
                    objs.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    objs.Tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                    objs.Tracer.Visible = true
                else
                    objs.Tracer.Visible = false
                end

                if Config.ESPNames then
                    objs.NameTag.Text = player.Name
                    objs.NameTag.Position = Vector2.new(rootPos.X, headPos.Y - 16)
                    objs.NameTag.Visible = true
                else
                    objs.NameTag.Visible = false
                end
            else
                objs.Box.Visible = false
                objs.Tracer.Visible = false
                objs.NameTag.Visible = false
            end
        else
            objs.Box.Visible = false
            objs.Tracer.Visible = false
            objs.NameTag.Visible = false
        end
    end
end

-- ================================================================= --
--                           MAIN LOOP                               --
-- ================================================================= --

Services.RunService.RenderStepped:Connect(function()
    UpdateFOVCircle()
    RenderESP()

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        if Config.SpeedEnabled then hum.WalkSpeed = Config.WalkSpeed end
        if Config.JumpEnabled then hum.JumpPower = Config.JumpPower end
    end

    if Config.Noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    if Config.AimbotEnabled then
        local target = nil
        local shortestDist = Config.AimbotFOV

        for _, p in pairs(Services.Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local pos, visible = Camera:WorldToViewportPoint(head.Position)

                if visible then
                    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude

                    if dist < shortestDist then
                        target = head
                        shortestDist = dist
                    end
                end
            end
        end

        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)

Services.UserInputService.JumpRequest:Connect(function()
    if Config.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)
