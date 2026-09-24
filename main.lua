-- DeepHat x uProxyz Custom Framework [ULTIMATE PRO EDITION]
-- Developer: DeepHat (Kindo)
-- Estética: Minimalist Tech / Square / Cyberpunk

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- [CONFIGURAÇÕES E ESTADO]
local Settings = {
    NoclipActive = false,
    FlyActive = false,
    HitboxActive = false,
    HitboxSize = 10,
    InfJumpActive = false,
    SpeedActive = false,
    WalkSpeedValue = 50,
    ThemeColor = Color3.fromRGB(180, 50, 255),
    DarkBg = Color3.fromRGB(10, 10, 10),
    IsLoaded = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeepHat_Pro_UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [UTILITÁRIOS]
local function ApplyTween(obj, props, duration)
    local info = TweenInfo.new(duration or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

-- [1. INTERFACE DE CARREGAMENTO]
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 250, 0, 100)
LoadingFrame.Position = UDim2.new(0.5, -125, 0.5, -50)
LoadingFrame.BackgroundColor3 = Settings.DarkBg
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local LoadingStroke = Instance.new("UIStroke")
LoadingStroke.Color = Settings.ThemeColor
LoadingStroke.Thickness = 2
LoadingStroke.Parent = LoadingFrame

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1, 0, 0, 40)
LoadingTitle.Text = "INITIALIZING..."
LoadingTitle.Font = Enum.Font.Code
LoadingTitle.TextColor3 = Settings.ThemeColor
LoadingTitle.TextSize = 16
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Parent = LoadingFrame

local LoadingBarBg = Instance.new("Frame")
LoadingBarBg.Size = UDim2.new(0.8, 0, 0, 5)
LoadingBarBg.Position = UDim2.new(0.1, 0, 0.7, 0)
LoadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
LoadingBarBg.BorderSizePixel = 0
LoadingBarBg.Parent = LoadingFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Settings.ThemeColor
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = LoadingBarBg

-- [2. INTERFACE PRINCIPAL]
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 380)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -190)
MainFrame.BackgroundColor3 = Settings.DarkBg
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Settings.ThemeColor
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "DEEPHAT // PRO"
Title.Font = Enum.Font.Code
Title.TextColor3 = Settings.ThemeColor
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 70, 0, 280)
TabContainer.Position = UDim2.new(0, 5, 0, 45)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(0, 210, 0, 280)
ContentContainer.Position = UDim2.new(0, 85, 0, 45)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local function CreateTabButton(name, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.Code
    btn.TextSize = 12
    btn.Text = name:upper()
    btn.BorderSizePixel = 0
    btn.Parent = TabContainer
    return btn
end

local CombatTab = CreateTabButton("Combat", UDim2.new(0, 0, 0, 0))
local MovementTab = CreateTabButton("Move", UDim2.new(0, 0, 0, 40))
local SettingsTab = CreateTabButton("Set", UDim2.new(0, 0, 0, 80))

local CombatPage = Instance.new("Frame")
CombatPage.Size = UDim2.new(1, 0, 1, 0)
CombatPage.BackgroundTransparency = 1
CombatPage.Visible = false
CombatPage.Parent = ContentContainer

local MovementPage = Instance.new("Frame")
MovementPage.Size = UDim2.new(1, 0, 1, 0)
MovementPage.BackgroundTransparency = 1
MovementPage.Visible = false
MovementPage.Parent = ContentContainer

local SettingsPage = Instance.new("Frame")
SettingsPage.Size = UDim2.new(1, 0, 1, 0)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false
SettingsPage.Parent = ContentContainer

local function CreateOption(name, pos, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.Code
    btn.TextSize = 13
    btn.Text = name:upper()
    btn.BorderSizePixel = 0
    btn.Parent = parent
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 40, 40)
    stroke.Thickness = 1
    stroke.Parent = btn
    return btn
end

-- [OPÇÕES]
local HitboxBtn = CreateOption("Hitbox: OFF", UDim2.new(0, 0, 0, 0), CombatPage)
local TPBaseBtn = CreateOption("Teleport Base", UDim2.new(0, 0, 0, 45), CombatPage)
local NoclipBtn = CreateOption("Noclip: OFF", UDim2.new(0, 0, 0, 0), MovementPage)
local FlyBtn = CreateOption("Fly: OFF", UDim2.new(0, 0, 0, 45), MovementPage)
local InfJumpBtn = CreateOption("Inf Jump: OFF", UDim2.new(0, 0, 0, 90), MovementPage)
local SpeedBtn = CreateOption("Speed: OFF", UDim2.new(0, 0, 0, 135), MovementPage)
local ColorBtn = CreateOption("Change Theme", UDim2.new(0, 0, 0, 0), SettingsPage)
local ShutdownBtn = CreateOption("Shutdown", UDim2.new(0, 0, 0, 150), SettingsPage)
ShutdownBtn.TextColor3 = Color3.fromRGB(255, 80, 80)

-- [LÓGICA DE NAVEGAÇÃO]
local function SwitchTab(tabName)
    CombatPage.Visible = (tabName == "Combat")
    MovementPage.Visible = (tabName == "Movement")
    SettingsPage.Visible = (tabName == "Settings")
end

CombatTab.MouseButton1Click:Connect(function() SwitchTab("Combat") end)
MovementTab.MouseButton1Click:Connect(function() SwitchTab("Movement") end)
SettingsTab.MouseButton1Click:Connect(function() SwitchTab("Settings") end)

-- [DRAGGABLE]
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = gui.Position
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end
MakeDraggable(MainFrame)

-- [LÓGICA CORE]
-- Hitbox
task.spawn(function()
    while task.wait(0.5) do
        if Settings.HitboxActive then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    hrp.Transparency = 0.7
                    hrp.CanCollide = false
                end
            end
        end
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if Settings.NoclipActive and Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Inf Jump
UserInputService.JumpRequest:Connect(function()
    if Settings.InfJumpActive and Player.Character then
        local hum = Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Speed
SpeedBtn.MouseButton1Click:Connect(function()
    Settings.SpeedActive = not Settings.SpeedActive
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = Settings.SpeedActive and Settings.WalkSpeedValue or 16
    end
    SpeedBtn.Text = Settings.SpeedActive and "Speed: ON" or "Speed: OFF"
    SpeedBtn.TextColor3 = Settings.SpeedActive and Settings.ThemeColor or Color3.fromRGB(200, 200, 200)
end)

-- Fly
local function ToggleFly()
    local char = Player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    Settings.FlyActive = not Settings.FlyActive
    if Settings.FlyActive then
        local bv = Instance.new("BodyVelocity", hrp); bv.Name = "FlyVel"; bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge); bv.Velocity = Vector3.new(0,0,0)
        local bg = Instance.new("BodyGyro", hrp); bg.Name = "FlyGyro"; bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge); bg.P = 10000
    else
        if hrp:FindFirstChild("FlyVel") then hrp.FlyVel:Destroy() end
        if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
    end
end

-- [EVENTOS UI]
HitboxBtn.MouseButton1Click:Connect(function()
    Settings.HitboxActive = not Settings.HitboxActive
    HitboxBtn.Text = "Hitbox: " .. (Settings.HitboxActive and "ON" or "OFF")
    HitboxBtn.TextColor3 = Settings.HitboxActive and Settings.ThemeColor or Color3.fromRGB(200, 200, 200)
end)

NoclipBtn.MouseButton1Click:Connect(function()
    Settings.NoclipActive = not Settings.NoclipActive
    NoclipBtn.Text = "Noclip: " .. (Settings.NoclipActive and "ON" or "OFF")
    NoclipBtn.TextColor3 = Settings.NoclipActive and Settings.ThemeColor or Color3.fromRGB(200, 200, 200)
end)

InfJumpBtn.MouseButton1Click:Connect(function()
    Settings.InfJumpActive = not Settings.InfJumpActive
    InfJumpBtn.Text = "Inf Jump: " .. (Settings.InfJumpActive and "ON" or "OFF")
    InfJumpBtn.TextColor3 = Settings.InfJumpActive and Settings.ThemeColor or Color3.fromRGB(200, 200, 200)
end)

FlyBtn.MouseButton1Click:Connect(function()
    ToggleFly()
    FlyBtn.Text = "Fly: " .. (Settings.FlyActive and "ON" or "OFF")
    FlyBtn.TextColor3 = Settings.FlyActive and Settings.ThemeColor or Color3.fromRGB(200, 200, 200)
end)

TPBaseBtn.MouseButton1Click:Connect(function()
    local char = Player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
        char.HumanoidRootPart.CFrame = spawn and spawn.CFrame + Vector3.new(0, 5, 0) or CFrame.new(0, 50, 0)
    end
end)

ColorBtn.MouseButton1Click:Connect(function()
    local colors = {Color3.fromRGB(180, 50, 255), Color3.fromRGB(50, 255, 180), Color3.fromRGB(255, 50, 50), Color3.fromRGB(50, 180, 255)}
    Settings.ThemeColor = colors[math.random(1, #colors)]
    MainStroke.Color = Settings.ThemeColor
    Title.TextColor3 = Settings.ThemeColor
    LoadingStroke.Color = Settings.ThemeColor
end)

ShutdownBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- [LOOP DE MOVIMENTO FLY]
RunService.RenderStepped:Connect(function()
    if Settings.FlyActive and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = Player.Character.HumanoidRootPart
        local camera = workspace.CurrentCamera
        local direction = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
        if UserInputService:
