-- =======================================================================
-- 👑 BESTHUB | OP SCRIPT (VISUAL INVISIBILITY & NEW HOME UPDATED)
-- =======================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local AutoGrabEnabled = false
local SuperJumpEnabled = false
local VisualInvisEnabled = false

-- NUOVE COORDINATE RICHIESTE
local FixedHomeCoords = Vector3.new(-347.99, -6.54, -101.49)

-- Pulizia vecchie istanze della GUI
if PlayerGui:FindFirstChild("BestHub_SafeSuite") then
    PlayerGui.BestHub_SafeSuite:Destroy()
end

-- ==========================================
-- 🛠️ INTERFACCIA UTENTE
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BestHub_SafeSuite"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 310)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Topbar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -10, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BestHub | Op Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Griglia Bottoni
local ButtonGrid = Instance.new("Frame")
ButtonGrid.Size = UDim2.new(1, -20, 1, -50)
ButtonGrid.Position = UDim2.new(0, 10, 0, 45)
ButtonGrid.BackgroundTransparency = 1
ButtonGrid.Parent = MainFrame

local UIGridLayout = Instance.new("UIGridLayout")
UIGridLayout.CellSize = UDim2.new(0, 145, 0, 80)
UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
UIGridLayout.Parent = ButtonGrid

-- Lista Giocatori (Auto TP)
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Size = UDim2.new(0, 200, 0, 240)
PlayerListFrame.Position = UDim2.new(1, 10, 0, 0)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
PlayerListFrame.Visible = false
PlayerListFrame.Parent = MainFrame

local PLCorner = Instance.new("UICorner")
PLCorner.CornerRadius = UDim.new(0, 8)
PLCorner.Parent = PlayerListFrame

local PLTitle = Instance.new("TextLabel")
PLTitle.Size = UDim2.new(1, 0, 0, 30)
PLTitle.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
PLTitle.Text = "Select Player 👤"
PLTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
PLTitle.Font = Enum.Font.GothamBold
PLTitle.TextSize = 12
PLTitle.Parent = PlayerListFrame

local Scroller = Instance.new("ScrollingFrame")
Scroller.Size = UDim2.new(1, -10, 1, -40)
Scroller.Position = UDim2.new(0, 5, 0, 35)
Scroller.BackgroundTransparency = 1
Scroller.ScrollBarThickness = 4
Scroller.Parent = PlayerListFrame

local ScrollerLayout = Instance.new("UIListLayout")
ScrollerLayout.Padding = UDim.new(0, 4)
ScrollerLayout.Parent = Scroller

-- ==========================================
-- ⚙️ FUNZIONI E LOGICA DI SISTEMA
-- ==========================================

local function SafeTeleport(targetCFrame)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = targetCFrame
    end
end

local function UpdatePlayerList()
    for _, child in ipairs(Scroller:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local PBtn = Instance.new("TextButton")
            PBtn.Size = UDim2.new(1, -10, 0, 30)
            PBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            PBtn.Text = p.Name
            PBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            PBtn.Font = Enum.Font.Gotham
            PBtn.TextSize = 12
            PBtn.Parent = Scroller
            
            local PBCorner = Instance.new("UICorner")
            PBCorner.CornerRadius = UDim.new(0, 4)
            PBCorner.Parent = PBtn

            PBtn.MouseButton1Click:Connect(function()
                local targetChar = p.Character
                if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                    SafeTeleport(targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
                end
            end)
        end
    end
    Scroller.CanvasSize = UDim2.new(0, 0, 0, ScrollerLayout.AbsoluteContentSize.Y + 10)
end

-- Ciclo Continuo per Invisibilità Visual (Skin + Brainrots in locale)
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then
                    -- Se attivo mette la trasparenza a 1 (invisibile), altrimenti torna a 0 (visibile)
                    part.Transparency = VisualInvisEnabled and 1 or 0
                end
            end
        end
    end
end)

-- Auto Grab con Hold continuo
task.spawn(function()
    local currentPrompt = nil
    while true do
        if AutoGrabEnabled then
            local promptTrovato = false
            for _, oggetto in ipairs(Workspace:GetDescendants()) do
                if oggetto:IsA("ProximityPrompt") and (oggetto.ObjectText:find("Brainrot") or oggetto.ActionText:find("Grab")) then
                    promptTrovato = true
                    if currentPrompt ~= oggetto then
                        if currentPrompt then currentPrompt:InputHoldEnd() end
                        currentPrompt = oggetto
                        oggetto:InputHoldBegin()
                    end
                    break
                end
            end
            if not promptTrovato and currentPrompt then
                currentPrompt:InputHoldEnd()
                currentPrompt = nil
            end
        else
            if currentPrompt then
                currentPrompt:InputHoldEnd()
                currentPrompt = nil
            end
        end
        task.wait(0.1)
    end
end)

local function ToggleSuperJump(state)
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if state then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = 115
        else
            humanoid.JumpPower = 50
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if SuperJumpEnabled then
        local humanoid = char:WaitForChild("Humanoid")
        humanoid.UseJumpPower = true
        humanoid.JumpPower = 115
    end
end)

-- ==========================================
-- 🧱 GENERAZIONE CONFIGURAZIONE BOTTONI
-- ==========================================

local function CreateMenuButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = (color == Color3.new(1,1,1)) and Color3.new(0,0,0) or Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = ButtonGrid
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
end

-- 1. Invisibility (Bianco - Interruttore Visual On/Off)
CreateMenuButton("💀 Invisibility", Color3.fromRGB(255, 255, 255), function()
    VisualInvisEnabled = not VisualInvisEnabled
end)

-- 2. Auto TP (Verde)
CreateMenuButton("🗺️ Auto TP", Color3.fromRGB(0, 180, 80), function()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
    if PlayerListFrame.Visible then
        UpdatePlayerList()
    end
end)

-- 3. Auto Grab (Blu)
CreateMenuButton("🧠 Auto Grab", Color3.fromRGB(0, 100, 255), function()
    AutoGrabEnabled = not AutoGrabEnabled
end)

-- 4. Auto Home (Rosso - Sincronizzato con le tue nuove coordinate precise)
CreateMenuButton("🏠 Auto Home", Color3.fromRGB(255, 50, 50), function()
    SafeTeleport(CFrame.new(FixedHomeCoords))
end)

-- 5. Super Jump (Rosa)
CreateMenuButton("🚀 Super Jump", Color3.fromRGB(255, 105, 180), function()
    SuperJumpEnabled = not SuperJumpEnabled
    ToggleSuperJump(SuperJumpEnabled)
end)
