-- DeepHat x uProxyz Custom Framework [TECH EDITION]
-- Estética: Cyberpunk / Dark Purple / Neon
-- Features: Draggable UI, Fly Speed Control, Noclip, TP Base

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Variáveis de Controle
local NoclipActive = false
local FlyActive = false
local FlySpeed = 50
local MaxFlySpeed = 150
local IsLoaded = false

-- Cores de Tema Tecnológico
local ThemeColor = Color3.fromRGB(170, 85, 255) -- Roxo Neon
local DarkBg = Color3.fromRGB(15, 10, 20)      -- Azul/Preto muito escuro
local AccentColor = Color3.fromRGB(45, 20, 70) -- Roxo profundo para botões
local TextColor = Color3.fromRGB(230, 230, 255)

-- Elementos da Interface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "uProxyz_Tech_UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [FUNÇÃO: DESIGN & ANIMAÇÃO]
local function ApplyTween(obj, properties, duration)
    local tweenInfo = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, properties)
    tween:Play()
    return tween
end

-- [FUNÇÃO: DRAGGABLE]
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
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

-- 1. TELA DE CARREGAMENTO (MODERNIZADA)
local InjectBtn = Instance.new("TextButton")
InjectBtn.Name = "InjectBtn"
InjectBtn.Parent = ScreenGui
InjectBtn.Size = UDim2.new(0, 180, 0, 50)
InjectBtn.Position = UDim2.new(0.5, -90, 0.5, -25)
InjectBtn.Text = "INITIALIZING..."
InjectBtn.Font = Enum.Font.Code
InjectBtn.TextSize = 20
InjectBtn.BackgroundColor3 = DarkBg
InjectBtn.TextColor3 = ThemeColor
InjectBtn.BorderSizePixel = 0

-- Criando um contorno neon para o botão de injetar
local InjectStroke = Instance.new("UIStroke")
InjectStroke.Parent = InjectBtn
InjectStroke.Color = ThemeColor
InjectStroke.Thickness = 2
InjectStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- 2. MENU PRINCIPAL (ESTILO TECH)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = DarkBg
MainFrame.Size = UDim2.new(0, 220, 0, 300)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -150)
MainFrame.Visible = false
MainFrame.BorderSizePixel = 0

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = ThemeColor
MainStroke.Thickness = 1
MainStroke.Transparency = 0.5

MakeDraggable(MainFrame)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "uPROXYZ // TECH"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = ThemeColor
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.Code
Title.TextSize = 22

-- [SISTEMA DE BOTÕES ESTILIZADOS]
local function CreateTechButton(text, pos, color)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.Position = pos
    btn.Size = UDim2.new(0.85, 0, 0, 35)
    btn.Text = text:upper()
    btn.BackgroundColor3 = AccentColor
    btn.TextColor3 = TextColor
    btn.Font = Enum.Font.Code
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Parent = btn
    btnStroke.Color = ThemeColor
    btnStroke.Thickness = 1
    btnStroke.Transparency = 0.7
    
    return btn
end

local NoclipBtn = CreateTechButton("Noclip: Off", UDim2.new(0.075, 0, 0.2, 0))
local FlyBtn = CreateTechButton("Fly: Off", UDim2.new(0.075, 0, 0.35, 0))
local TPBaseBtn = CreateTechButton("Teleport Base", UDim2.new(0.075, 0, 0.5, 0))

-- [CONTROLE DE VELOCIDADE - SLIDER SIMPLIFICADO]
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainFrame
SpeedLabel.Text = "FLY SPEED: " .. math.floor(FlySpeed)
SpeedLabel.Position = UDim2.new(0.075, 0, 0.65, 0)
SpeedLabel.Size = UDim2.new(0.85, 0, 0, 20)
SpeedLabel.TextColor3 = TextColor
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.Code
SpeedLabel.TextSize = 14

local SpeedUpBtn = CreateTechButton("+", UDim2.new(0.075, 0, 0.75, 0))
local SpeedDownBtn = CreateTechButton("-", UDim2.new(0.5, 0, 0.75, 0))
SpeedUpBtn.Size = UDim2.new(0.35, 0, 0, 30)
SpeedDownBtn.Size = UDim2.new(0.35, 0, 0, 30)

local SelfDestructBtn = CreateTechButton("Shutdown", UDim2.new(0.075, 0, 0.88, 0), Color3.fromRGB(100, 0, 0))
SelfDestructBtn.Size = UDim2.new(0.85, 0, 0, 25)

-- [LÓGICA DE FUNCIONAMENTO]

-- Injeção com Efeito Visual
InjectBtn.MouseButton1Click:Connect(function()
    InjectBtn.Text = "CONNECTING..."
    task.wait(1.5)
    ApplyTween(InjectBtn, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.5)
    task.wait(0.5)
    InjectBtn.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Começa pequeno para animar
    ApplyTween(MainFrame, {Size = UDim2.new(0, 220, 0, 300)}, 0.5)
    IsLoaded = true
end)

-- Controle de Velocidade
SpeedUpBtn.MouseButton1Click:Connect(function()
    FlySpeed = math.min(FlySpeed + 10, MaxFlySpeed)
    SpeedLabel.Text = "FLY SPEED: " .. math.floor(FlySpeed)
end)

SpeedDownBtn.MouseButton1Click:Connect(function()
    FlySpeed = math.max(FlySpeed - 10, 10)
    SpeedLabel.Text = "FLY SPEED: " .. math.floor(FlySpeed)
end)

-- Noclip
NoclipBtn.MouseButton1Click:Connect(function()
    NoclipActive = not NoclipActive
    NoclipBtn.Text = NoclipActive and "Noclip: ON" or "Noclip: Off"
    NoclipBtn.TextColor3 = NoclipActive and ThemeColor or TextColor
end)

RunService.Stepped:Connect(function()
    if NoclipActive and Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Fly (Com Velocidade Dinâmica)
FlyBtn.MouseButton1Click:Connect(function()
    FlyActive = not FlyActive
    FlyBtn.Text = FlyActive and "Fly: ON" or "Fly: OFF"
    FlyBtn.TextColor3 = FlyActive and ThemeColor or TextColor
    
    local Character = Player.Character
    if FlyActive and Character and Character:FindFirstChild("HumanoidRootPart") then
        local BV = Instance.new("BodyVelocity")
        BV.Name = "FlyVelocity"
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        BV.Velocity = Vector3.new(0, 0, 0)
        BV.Parent = Character.HumanoidRootPart
        
        local BG = Instance.new("BodyGyro")
        BG.Name = "FlyGyro"
        BG.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        BG.CFrame = Character.HumanoidRootPart.CFrame
        BG.Parent = Character.HumanoidRootPart
    else
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            if Character.HumanoidRootPart:FindFirstChild("FlyVelocity") then Character.HumanoidRootPart.FlyVelocity:Destroy() end
            if Character.HumanoidRootPart:FindFirstChild("FlyGyro") then Character.HumanoidRootPart.FlyGyro:Destroy() end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if FlyActive and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local Root = Player.Character.HumanoidRootPart
        local Camera = workspace.CurrentCamera
        local Direction = Vector3.new(0,0,0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then Direction = Direction + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then Direction = Direction - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then Direction = Direction - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then Direction = Direction + Camera.CFrame.RightVector end
        
        if Root:FindFirstChild("FlyVelocity") then
            Root.FlyVelocity.Velocity = Direction * FlySpeed
        end
        if Root:FindFirstChild("FlyGyro") then
            Root.FlyGyro.CFrame = Camera.CFrame
        end
    end
end)

-- Teleport Base
TPBaseBtn.MouseButton1Click:Connect(function()
    local Character = Player.Character
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        local SpawnLoc = workspace:FindFirstChildOfClass("SpawnLocation")
        if SpawnLoc then
            Character.HumanoidRootPart.CFrame = SpawnLoc.CFrame + Vector3.new(0, 5, 0)
        else
            Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
        end
    end
end)

-- Self Destruct
SelfDestructBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
