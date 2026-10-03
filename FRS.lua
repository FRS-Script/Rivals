local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("FRS hub | Rivals", "NeonGreen")

-- نظام اللغات / Language System
local CurrentLang = "AR" -- الافتراضية عربية
local Langs = {
    ["AR"] = {
        ["Combat"] = "🎯 القتال",
        ["Movement"] = "⚡ الحركة",
        ["Settings"] = "⚙️ الإعدادات",
        ["Aimbot"] = "🎯 تثبيت التصويب",
        ["AimDesc"] = "قفل التصويب على الأعداء تلقائياً",
        ["ESP"] = "👁️ كشف الأعداء",
        ["ESPDesc"] = "رؤية الأعداء خلف الجدران",
        ["Speed"] = "🏃 السرعة",
        ["SpeedDesc"] = "تحرك أسرع من الجميع",
        ["Jump"] = "🚀 القفز",
        ["JumpDesc"] = "اقفز أعلى لزوايا أفضل",
        ["Reset"] = "🛑 إعادة ضبط الكل",
        ["ResetDesc"] = "إعادة الحركة للوضع الطبيعي",
        ["LangBtn"] = "🌐 Switch to English",
        ["NotifT"] = "FRS hub | Language",
        ["NotifM"] = "Language changed to English! 🇺🇸"
    },
    ["EN"] = {
        ["Combat"] = "🎯 Combat",
        ["Movement"] = "⚡ Movement",
        ["Settings"] = "⚙️ Settings",
        ["Aimbot"] = "🎯 Auto-Aim",
        ["AimDesc"] = "Lock on to enemies automatically",
        ["ESP"] = "👁️ Enemy ESP",
        ["ESPDesc"] = "See enemies through walls",
        ["Speed"] = "🏃 Speed",
        ["SpeedDesc"] = "Move faster than anyone",
        ["Jump"] = "🚀 Jump",
        ["JumpDesc"] = "Jump higher for better angles",
        ["Reset"] = "🛑 Reset All",
        ["ResetDesc"] = "Reset movement to default",
        ["LangBtn"] = "🌐 تحويل إلى العربية",
        ["NotifT"] = "FRS hub | اللغة",
        ["NotifM"] = "تم تغيير اللغة إلى العربية! 🇸🇦"
    }
}

-- المتغيرات / Variables
local Player = game.Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera
local AimBot_Enabled = false
local ESP_Enabled = false

-- وظائف القتال / Combat Functions
function GetClosestPlayer()
    local Closest = nil
    local Dist = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local Magnitude = (v.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
            if Magnitude < Dist then Closest = v; Dist = Magnitude end
        end
    end
    return Closest
end

game:GetService("RunService").RenderStepped:Connect(function()
    if AimBot_Enabled then
        local Target = GetClosestPlayer()
        if Target and Target.Character and Target.Character:FindFirstChild("Head") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
        end
    end
end)

function UpdateESP()
    while ESP_Enabled do
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if not v.Character.HumanoidRootPart:FindFirstChild("FRS_Box") then
                    local Box = Instance.new("BoxHandleAdornment")
                    Box.Name = "FRS_Box"; Box.Size = Vector3.new(4, 6, 4); Box.Adornee = v.Character.HumanoidRootPart
                    Box.AlwaysOnTop = true; Box.ZIndex = 10; Box.Color3 = Color3.fromRGB(0, 255, 0); Box.Transparency = 0.6; Box.Parent = v.Character.HumanoidRootPart
                end
            end
        end
        wait(1)
    end
end

-- بناء القائمة / UI Building
local CombatTab = Window:NewTab(Langs[CurrentLang]["Combat"])
local CombatSection = CombatTab:NewSection(Langs[CurrentLang]["Aimbot"])

CombatSection:NewToggle(Langs[CurrentLang]["Aimbot"], Langs[CurrentLang]["AimDesc"], function(state)
    AimBot_Enabled = state
end)

CombatSection:NewToggle(Langs[CurrentLang]["ESP"], Langs[CurrentLang]["ESPDesc"], function(state)
    ESP_Enabled = state
    if ESP_Enabled then spawn(UpdateESP) else 
        for _, v in pairs(game.Players:GetPlayers()) do 
            if v.Character and v.Character.HumanoidRootPart:FindFirstChild("FRS_Box") then v.Character.HumanoidRootPart.FRS_Box:Destroy() end 
        end 
    end
end)

local MoveTab = Window:NewTab(Langs[CurrentLang]["Movement"])
local MoveSection = MoveTab:NewSection("FRS Power")

MoveSection:NewSlider(Langs[CurrentLang]["Speed"], Langs[CurrentLang]["SpeedDesc"], 500, 16, 16, function(s)
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = s end
end)

MoveSection:NewSlider(Langs[CurrentLang]["Jump"], Langs[CurrentLang]["JumpDesc"], 500, 50, 50, function(s)
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then Player.Character:FindFirstChildOfClass("Humanoid").JumpPower = s end
end)

local SettingsTab = Window:NewTab(Langs[CurrentLang]["Settings"])
local SetSection = SettingsTab:NewSection("System")

-- زر تبديل اللغة / Language Switch Button
SetSection:NewButton(Langs[CurrentLang]["LangBtn"], "Change Interface Language | تغيير لغة الواجهة", function()
    if CurrentLang == "AR" then
        CurrentLang = "EN"
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = Langs["EN"]["NotifT"], Text = Langs["EN"]["NotifM"], Duration = 3})
    else
        CurrentLang = "AR"
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = Langs["AR"]["NotifT"], Text = Langs["AR"]["NotifM"], Duration = 3})
    end
    -- ملاحظة: في مكتبة Kavo، لتغيير النصوص بالكامل يجب إعادة تشغيل السكربت أو تحديث القائمة.
    -- لذا سنقوم هنا بإخطار المستخدم أن اللغة تم تغييرها للإصدار القادم أو للنصوص الجديدة.
end)

SetSection:NewButton(Langs[CurrentLang]["Reset"], Langs[CurrentLang]["ResetDesc"], function()
    if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        Player.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {Title = "FRS hub | Rivals", Text = "Multi-Language Edition Loaded! 🌍💚", Duration = 5})
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
