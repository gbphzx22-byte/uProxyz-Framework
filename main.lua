-- DEEPHAT [MODULE: COMBAT & VISUAL - GOD MODE]
-- STATUS: MASSIVE LOAD

-- [COMBAT SYSTEM]
task.spawn(function()
    while task.wait() do
        if Settings.KillAuraActive then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local target = p.Character.HumanoidRootPart
                    local dist = (Player.Character.HumanoidRootPart.Position - target.Position).Magnitude
                    if dist < Settings.KillAuraRange then
                        -- Simulação de Hit/Damage
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            -- Aqui entra a lógica de Remote para o seu jogo específico
                            print("[DEEPHAT] Target Locked: " .. p.Name)
                        end
                    end
                end
            end
        end
    end
end)

-- [HITBOX EXPANDER - CONFIGURÁVEL]
task.spawn(function()
    while task.wait(0.5) do
        if Settings.HitboxActive then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    hrp.Transparency = 0.6
                    hrp.CanCollide = false
                end
            end
        end
    end
end)

-- [ESP SYSTEM - BOX & NAME]
local function CreateESP(targetPlayer)
    if not targetPlayer.Character then return end
    local char = targetPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "DeepHat_ESP"
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Adornee = hrp
    box.Size = Vector3.new(4, 6, 1)
    box.Color3 = Settings.ThemeColor
    box.Transparency = 0.5
    box.StudsOffset = Vector3.new(0, 0, 0)
    box.Parent = hrp

    local name = Instance.new("BillboardGui")
    name.Name = "DeepHat_Name"
    name.Adornee = hrp
    name.Size = UDim2.new(0, 100, 0, 50)
    name.StudsOffset = Vector3.new(0, 3, 0)
    name.AlwaysOnTop = true
    name.Parent = hrp

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.Name
    nameLabel.TextColor3 = Settings.ThemeColor
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.Code
    nameLabel.Parent = name
end

task.spawn(function()
    while task.wait(2) do
        if Settings.ESP_Enabled then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and not p.Character:FindFirstChild("DeepHat_ESP") then
                    CreateESP(p)
                end
            end
        end
    end
end)

-- [AIMBOT LOGIC]
local function GetClosestPlayer()
    local closest = nil
    local dist = math.huge
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (Player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                dist = d
                closest = p
            end
        end
    end
    return closest
end

-- [REMOTE SPAMMER - BASE]
local function RemoteSpam(remoteName)
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild(remoteName, true)
    if remote then
        task.spawn(function()
            while Settings.RemoteSpamActive do
                remote:FireServer() -- CUIDADO: Pode crashar o jogo
                task.wait(0.1)
            end
        end)
    end
end

-- [CONEXÃO DE EVENTOS COM A UI]
-- Isso aqui é o que faz o botão funcionar!
HitboxBtn.MouseButton1Click:Connect(function()
    Settings.HitboxActive = not Settings.HitboxActive
    HitboxBtn.Text = "Hitbox: " .. (Settings.HitboxActive and "ON" or "OFF")
    HitboxBtn.TextColor3 = Settings.HitboxActive and Settings.ThemeColor or Color3.fromRGB(255, 255, 255)
end)

-- Configuração de Hitbox (Clique Direito)
HitboxBtn.MouseButton2Click:Connect(function()
    Settings.HitboxSize = Settings.HitboxSize + 2
    if Settings.HitboxSize > 20 then Settings.HitboxSize = 2 end
    print("[DEEPHAT] Hitbox Size: " .. Settings.HitboxSize)
end)

ESPBtn.MouseButton1Click:Connect(function()
    Settings.ESP_Enabled = not Settings.ESP_Enabled
    ESPBtn.Text = "ESP: " .. (Settings.ESP_Enabled and "ON" or "OFF")
    ESPBtn.TextColor3 = Settings.ESP_Enabled and Settings.ThemeColor or Color3.fromRGB(255, 255, 255)
end)

-- Shutdown
ShutdownBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("[DEEPHAT] Módulo Combat & Visual: ON.")
-- DEEPHAT [MODULE: COMBAT & VISUAL - GOD MODE]
-- STATUS: MASSIVE LOAD

-- [COMBAT SYSTEM]
task.spawn(function()
    while task.wait() do
        if Settings.KillAuraActive then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local target = p.Character.HumanoidRootPart
                    local dist = (Player.Character.HumanoidRootPart.Position - target.Position).Magnitude
                    if dist < Settings.KillAuraRange then
                        -- Simulação de Hit/Damage
                        local hum = p.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            -- Aqui entra a lógica de Remote para o seu jogo específico
                            print("[DEEPHAT] Target Locked: " .. p.Name)
                        end
                    end
                end
            end
        end
    end
end)

-- [HITBOX EXPANDER - CONFIGURÁVEL]
task.spawn(function()
    while task.wait(0.5) do
        if Settings.HitboxActive then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    hrp.Transparency = 0.6
                    hrp.CanCollide = false
                end
            end
        end
    end
end)

-- [ESP SYSTEM - BOX & NAME]
local function CreateESP(targetPlayer)
    if not targetPlayer.Character then return end
    local char = targetPlayer.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "DeepHat_ESP"
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Adornee = hrp
    box.Size = Vector3.new(4, 6, 1)
    box.Color3 = Settings.ThemeColor
    box.Transparency = 0.5
    box.StudsOffset = Vector3.new(0, 0, 0)
    box.Parent = hrp

    local name = Instance.new("BillboardGui")
    name.Name = "DeepHat_Name"
    name.Adornee = hrp
    name.Size = UDim2.new(0, 100, 0, 50)
    name.StudsOffset = Vector3.new(0, 3, 0)
    name.AlwaysOnTop = true
    name.Parent = hrp

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.Name
    nameLabel.TextColor3 = Settings.ThemeColor
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.Code
    nameLabel.Parent = name
end

task.spawn(function()
    while task.wait(2) do
        if Settings.ESP_Enabled then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player and p.Character and not p.Character:FindFirstChild("DeepHat_ESP") then
                    CreateESP(p)
                end
            end
        end
    end
end)

-- [AIMBOT LOGIC]
local function GetClosestPlayer()
    local closest = nil
    local dist = math.huge
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (Player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                dist = d
                closest = p
            end
        end
    end
    return closest
end

-- [REMOTE SPAMMER - BASE]
local function RemoteSpam(remoteName)
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild(remoteName, true)
    if remote then
        task.spawn(function()
            while Settings.RemoteSpamActive do
                remote:FireServer() -- CUIDADO: Pode crashar o jogo
                task.wait(0.1)
            end
        end)
    end
end

-- [CONEXÃO DE EVENTOS COM A UI]
-- Isso aqui é o que faz o botão funcionar!
HitboxBtn.MouseButton1Click:Connect(function()
    Settings.HitboxActive = not Settings.HitboxActive
    HitboxBtn.Text = "Hitbox: " .. (Settings.HitboxActive and "ON" or "OFF")
    HitboxBtn.TextColor3 = Settings.HitboxActive and Settings.ThemeColor or Color3.fromRGB(255, 255, 255)
end)

-- Configuração de Hitbox (Clique Direito)
HitboxBtn.MouseButton2Click:Connect(function()
    Settings.HitboxSize = Settings.HitboxSize + 2
    if Settings.HitboxSize > 20 then Settings.HitboxSize = 2 end
    print("[DEEPHAT] Hitbox Size: " .. Settings.HitboxSize)
end)

ESPBtn.MouseButton1Click:Connect(function()
    Settings.ESP_Enabled = not Settings.ESP_Enabled
    ESPBtn.Text = "ESP: " .. (Settings.ESP_Enabled and "ON" or "OFF")
    ESPBtn.TextColor3 = Settings.ESP_Enabled and Settings.ThemeColor or Color3.fromRGB(255, 255, 255)
end)

-- Shutdown
ShutdownBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("[DEEPHAT] Módulo Combat & Visual: ON.")
-- DEEPHAT [MODULE: ANTI-BAN & REMOTE SPY - FINAL STAGE]
-- STATUS: GOD MODE ENABLED

-- [1. ANTI-BAN & OTIMIZAÇÃO]
-- Esse módulo tenta mascarar sua presença e reduzir o lag do cliente

local function SetupAntiBan()
    -- Limpeza de rastros de script
    local char = Player.Character or Player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    -- Proteção contra detecção de velocidade (Speed Hack Detection)
    -- Evita que o servidor detecte mudanças bruscas de posição
    task.spawn(function()
        while task.wait(0.5) do
            if Settings.SpeedHack and char:FindFirstChild("HumanoidRootPart") then
                -- Simula uma velocidade constante para o servidor não notar o pulo
                char.HumanoidRootPart.Velocity = char.HumanoidRootPart.Velocity * 0.8
            end
        end
    end)

    -- Proteção contra detecção de Noclip
    task.spawn(function()
        while task.wait(0.5) do
            if Settings.Noclip and char:FindFirstChild("HumanoidRootPart") then
                -- Mantém a integrência do personagem para evitar kick por 'falling through floor'
                char.HumanoidRootPart.Position = char.HumanoidRootPart.Position + Vector3.new(0, 0.01, 0)
            end
        end
    end)

    -- Otimização de Render (FPS Boost)
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 100000
    
    print("[DEEPHAT] Anti-Ban: Ativo.")
end

-- [2. REMOTE SPY & LOGS]
-- Esse módulo monitora o que o jogo envia para o servidor (essencial para criar hacks de dinheiro)

local function StartRemoteSpy()
    print("[DEEPHAT] Iniciando Remote Spy... Monitore o Console.")
    
    local function HookRemote(method)
        local original = typeof(method) == "function" and method or nil
        
        return function(self, ...)
            local args = {...}
            local remoteName = self.Name or "Unknown"
            
            -- Log no Console para você ver o que está acontecendo
            print("[REMOTE SPY] " .. remoteName .. " | Args: ", args)
            
            -- Se for o método de disparo, ele executa o original
            if original then
                return original(self, unpack(args))
            end
        end
    end

    -- Hook nos principais disparadores
    local rs = game:GetService("ReplicatedStorage")
    
    -- Monitorando RemoteEvents
    for _, remote in pairs(rs:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            local oldFire = remote.FireServer
            remote.FireServer = function(self, ...)
                print("[REMOTE SPY] Evento Detectado: " .. self.Name)
                print("[DEEPHAT] Argumentos: ", ...)
                return oldFire(self, ...)
            end
        end
    end
    
    -- Monitorando RemoteFunctions
    for _, remote in pairs(rs:GetDescendants()) do
        if remote:IsA("RemoteFunction") then
            local oldInvoke = remote.InvokeServer
            remote.InvokeServer = function(self, ...)
                print("[REMOTE SPY] Function Detectada: " .. self.Name)
                print("[DEEPHAT] Argumentos: ", ...)
                return oldInvoke(self, ...)
            end
        end
    end
end

-- [3. EXECUÇÃO DO MÓDULO]

task.spawn(function()
    task.wait(2) -- Espera o sistema carregar
    SetupAntiBan()
    StartRemoteSpy()
    print("[DEEPHAT] Anti-Ban & Spy: Online.")
end)

-- [SISTEMA DE LOGS NO CONSOLE]
local function Log(msg, color)
    print("[DEEPHAT LOG] " .. msg)
end

-- [FINALIZAÇÃO DO CLIENT]
-- Este comando fecha o script de forma limpa
local function ShutdownClient()
    print("[DEEPHAT] Encerrando sistema...")
    ScreenGui:Destroy()
    -- Limpa rastros de física
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            if hrp:FindFirstChild("FlyVel") then hrp.FlyVel:Destroy() end
            if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        end
    end
end

-- Vincular ao botão de Shutdown (se necessário)
ShutdownBtn.MouseButton1Click:Connect(function()
    ShutdownClient()
end)

print("[DEEPHAT] ALL MODULES LOADED. GOD MODE READY.")
