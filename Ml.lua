-- =======================================================================
-- 👑 SERVIZI DI SISTEMA ROBLOX NATIVI
-- =======================================================================
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RealAntiAFKEnabled = false
local AutoStrength = false
local AutoSpin = false
local AutoGlitch = false
local AutoRewards = false
local AutoChocolate = false
local AutoRebirth = false

-- ANTI-AFK ENGINE
RunService.Stepped:Connect(function()
    if RealAntiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end
end)

-- CONTROLLO OCCUPAZIONE MACCHINE
local function isMachineOccupied(machine)
    if not machine then return true end
    local inUse = machine:FindFirstChild("InUse") or machine:FindFirstChild("Occupied")
    if inUse and inUse.Value == true and inUse.Value ~= LocalPlayer.Name then return true end
    local seat = machine:FindFirstChildOfClass("Seat") or machine:FindFirstChildOfClass("VehicleSeat")
    if seat and seat.Occupant then return true end
    return false
end

-- Pulizia istanze precedenti per evitare sovrapposizioni
if CoreGui:FindFirstChild("DivineHub_UI") then CoreGui.DivineHub_UI:Destroy() end
if CoreGui:FindFirstChild("DivineKeySystem_UI") then CoreGui.DivineKeySystem_UI:Destroy() end

-- =======================================================================
-- 🛠️ STRUTTURA INTERFACCIA DIVINE HUB & KEY SYSTEM (STILE ORION CLEAN)
-- =======================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DivineHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- FINESTRA PRINCIPALE (DIVINE HUB)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Nascosto finché non si mette la chiave
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

-- Topbar Main
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 6)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Divine Hub | Muscle Masters"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Sidebar Categorie
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 6)
SideCorner.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 4)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = Sidebar

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -130, 1, -40)
ContentFrame.Position = UDim2.new(0, 130, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- =======================================================================
-- 🔑 FINESTRA: DIVINE KEY SYSTEM (PULITA, NO ROSSO)
-- =======================================================================
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "DivineKeySystem_UI"
KeyFrame.Size = UDim2.new(0, 340, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 6)
KeyCorner.Parent = KeyFrame

local KeyTopBar = Instance.new("Frame")
KeyTopBar.Size = UDim2.new(1, 0, 0, 35)
KeyTopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyTopBar.BorderSizePixel = 0
KeyTopBar.Parent = KeyFrame

local KeyTopCorner = Instance.new("UICorner")
KeyTopCorner.CornerRadius = UDim.new(0, 6)
KeyTopCorner.Parent = KeyTopBar

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 15, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔑 Divine Key System"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyTopBar

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -30, 0, 32)
TextBox.Position = UDim2.new(0, 15, 0, 52)
TextBox.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TextBox.BorderSizePixel = 0
TextBox.Text = ""
TextBox.PlaceholderText = "Enter Access Key..."
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 13
TextBox.Font = Enum.Font.Gotham
TextBox.Parent = KeyFrame

local TextCorner = Instance.new("UICorner")
TextCorner.CornerRadius = UDim.new(0, 4)
TextCorner.Parent = TextBox

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0, 145, 0, 30)
GetKeyBtn.Position = UDim2.new(0, 15, 0, 100)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
GetKeyBtn.BorderSizePixel = 0
GetKeyBtn.Text = "Get Key (Discord)"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyFrame

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0, 4)
GetCorner.Parent = GetKeyBtn

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0, 145, 0, 30)
VerifyBtn.Position = UDim2.new(1, -160, 0, 100)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Text = "Verify Key"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 12
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.Parent = KeyFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 4)
VerifyCorner.Parent = VerifyBtn

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -30, 0, 20)
StatusLabel.Position = UDim2.new(0, 15, 1, -25)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Waiting for verification..."
StatusLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = KeyFrame

-- Funzionalità Bottoni Chiave
GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard("https://discord.gg/JqkFWVy43") end
    StatusLabel.Text = "Discord Link Copied to Clipboard!"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 220, 255)
end)

VerifyBtn.MouseButton1Click:Connect(function()
    if TextBox.Text == "DivineHub" then
        StatusLabel.Text = "Access Granted! Loading Divine Hub..."
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(0.5)
        KeyFrame:Destroy()
        MainFrame.Visible = true
    else
        StatusLabel.Text = "Invalid Key! Get it from Discord."
        StatusLabel.TextColor3 = Color3.fromRGB(240, 120, 120)
    end
end)

-- =======================================================================
-- 📦 CREAZIONE COSTRUTTORE TAB (EMULATORE ORION NATIVO)
-- =======================================================================
local allPanels = {}

local OrionLib = {}
function OrionLib:MakeTab(settings)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, 0, 0, 35)
    TabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    TabButton.BorderSizePixel = 0
    TabButton.Text = "  " .. settings.Name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 13
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.Parent = Sidebar
    
    local Panel = Instance.new("ScrollingFrame")
    Panel.Size = UDim2.new(1, -20, 1, -20)
    Panel.Position = UDim2.new(0, 10, 0, 10)
    Panel.BackgroundTransparency = 1
    Panel.CanvasSize = UDim2.new(0, 0, 0, 500)
    Panel.ScrollBarThickness = 4
    Panel.Visible = false
    Panel.Parent = ContentFrame
    
    local PanelLayout = Instance.new("UIListLayout")
    PanelLayout.Padding = UDim.new(0, 8)
    PanelLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PanelLayout.Parent = Panel
    
    table.insert(allPanels, Panel)
    
    TabButton.MouseButton1Click:Connect(function()
        for _, p in ipairs(allPanels) do p.Visible = false end
        Panel.Visible = true
    end)
    
    local Elements = {}
    
    function Elements:AddToggle(tSettings)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.Parent = Panel
        
        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 4)
        ToggleCorner.Parent = ToggleFrame
        
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -60, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = tSettings.Name
        Label.TextColor3 = Color3.fromRGB(230, 230, 230)
        Label.TextSize = 13
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame
        
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 45, 0, 22)
        Btn.Position = UDim2.new(1, -55, 0.5, -11)
        Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        Btn.Text = "OFF"
        Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 11
        Btn.Parent = ToggleFrame
        
        local toggleState = false
        Btn.MouseButton1Click:Connect(function()
            toggleState = not toggleState
            if toggleState then
                Btn.Text = "ON"
                Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                Btn.Text = "OFF"
                Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                Btn.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
            tSettings.Callback(toggleState)
        end)
    end
    
    function Elements:AddLabel(text)
        local Lbl = Instance.new("TextLabel")
        Lbl.Size = UDim2.new(1, 0, 0, 25)
        Lbl.BackgroundTransparency = 1
        Lbl.Text = text
        Lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        Lbl.TextSize = 13
        Lbl.Font = Enum.Font.Gotham
        Lbl.TextXAlignment = Enum.TextXAlignment.Left
        Lbl.Parent = Panel
        
        local labelController = {}
        function labelController:Set(newText)
            Lbl.Text = newText
        end
        return labelController
    end
    
    function Elements:AddSection(sSettings)
        local SectionLabel = Instance.new("TextLabel")
        SectionLabel.Size = UDim2.new(1, 0, 0, 20)
        SectionLabel.BackgroundTransparency = 1
        SectionLabel.Text = "--- " .. sSettings.Name .. " ---"
        SectionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        SectionLabel.TextSize = 12
        SectionLabel.Font = Enum.Font.GothamBold
        SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        SectionLabel.Parent = Panel
    end
    
    return Elements
end

-- =======================================================================
-- 🏠 GENERAZIONE DELLE TAB DI DIVINE HUB
-- =======================================================================
local FarmTab = OrionLib:MakeTab({ Name = "🏠 Main" })
local StatsTab = OrionLib:MakeTab({ Name = "📊 Stats" })
local SettingsTab = OrionLib:MakeTab({ Name = "⚙️ Settings" })

allPanels[1].Visible = true

-- -----------------------------------------------------------------------
-- 🏠 SCRIPT AUTOMAZIONI (MAIN)
-- -----------------------------------------------------------------------
FarmTab:AddToggle({
    Name = "Auto Strength Lift",
    Callback = function(Value)
        AutoStrength = Value
        if AutoStrength then
            task.spawn(function()
                while AutoStrength do
                    local remotes = ReplicatedStorage:FindFirstChild("RemotesEvent")
                    local folder = workspace:FindFirstChild("MachinesFolder")
                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if remotes and folder and root then
                        local activeEvent = remotes:FindFirstChild("MachineActiveEvent")
                        local activeFunc = remotes:FindFirstChild("MachineActiveFunction")
                        
                        if activeEvent and activeFunc then
                            local targetMachine = nil
                            for _, machine in ipairs(folder:GetChildren()) do
                                if machine.Name == "Bench Press Muscle Emperor" or machine.Name == "Pull Ups Muscle Emperor" then
                                    if not isMachineOccupied(machine) then
                                        targetMachine = machine
                                        break
                                    end
                                end
                            end
                            if targetMachine then
                                root.CFrame = targetMachine:GetPivot() * CFrame.new(0, 3, 0)
                                task.wait(0.1)
                                activeEvent:FireServer()
                                local args = { targetMachine, true }
                                activeFunc:InvokeServer(unpack(args))
                                task.wait(0.55)
                            else
                                task.wait(0.8)
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

FarmTab:AddToggle({
    Name = "Auto Spin Wheel",
    Callback = function(Value)
        AutoSpin = Value
        if AutoSpin then
            task.spawn(function()
                while AutoSpin do
                    local remotes = ReplicatedStorage:FindFirstChild("RemotesEvent")
                    if remotes then
                        local spinFunc = remotes:FindFirstChild("SpinFunction")
                        if spinFunc and spinFunc:IsA("RemoteFunction") then
                            spinFunc:InvokeServer()
                        end
                    end
                    task.wait(0.7)
                end
            end)
        end
    end
})

FarmTab:AddToggle({
    Name = "Auto Glitch Training",
    Callback = function(Value)
        AutoGlitch = Value
        if AutoGlitch then
            task.spawn(function()
                while AutoGlitch do
                    local remotes = ReplicatedStorage:FindFirstChild("RemotesEvent")
                    local folder = workspace:FindFirstChild("MachinesFolder")
                    local character = LocalPlayer.Character
                    local root = character and character:FindFirstChild("HumanoidRootPart")
                    
                    if remotes and folder and root then
                        local activeEvent = remotes:FindFirstChild("MachineActiveEvent")
                        local activeFunc = remotes:FindFirstChild("MachineActiveFunction")
                        
                        if activeEvent and activeFunc then
                            local targetMachine = nil
                            for _, machine in ipairs(folder:GetChildren()) do
                                if machine.Name == "Rock Squat Muscle Emperor" then
                                    if not isMachineOccupied(machine) then
                                        targetMachine = machine
                                        break
                                    end
                                end
                            end
                            if targetMachine then
                                root.CFrame = targetMachine:GetPivot() * CFrame.new(0, 3, 0)
                                task.wait(0.1)
                                activeEvent:FireServer()
                                local args = { targetMachine, true }
                                activeFunc:InvokeServer(unpack(args))
                                task.wait(0.5)
                            else
                                activeEvent:FireServer()
                                task.wait(0.5)
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

FarmTab:AddToggle({
    Name = "Auto Claim Rewards",
    Callback = function(Value)
        AutoRewards = Value
        if AutoRewards then
            task.spawn(function()
                while AutoRewards do
                    local remotes = ReplicatedStorage:FindFirstChild("RemotesEvent")
                    if remotes then
                        local claimEvent = remotes:FindFirstChild("rewardClaim")
                        if claimEvent and claimEvent:IsA("RemoteEvent") then
                            claimEvent:FireServer("reward1")
                            task.wait(0.5) 
                            claimEvent:FireServer("reward2")
                            task.wait(0.5)
                            claimEvent:FireServer("reward3")
                            task.wait(0.5)
                            claimEvent:FireServer("reward4")
                            task.wait(0.5)
                            claimEvent:FireServer("reward5")
                        end
                    end
                    task.wait(5.0)
                end
            end)
        end
    end
})

FarmTab:AddToggle({
    Name = "Auto Eat Chocolate",
    Callback = function(Value)
        AutoChocolate = Value
        if AutoChocolate then
            task.spawn(function()
                while AutoChocolate do
                    local character = LocalPlayer.Character
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                    local tool = LocalPlayer.Backpack:FindFirstChild("Chocolate") or (character and character:FindFirstChild("Chocolate"))
                    
                    if tool and humanoid then
                        if tool.Parent == LocalPlayer.Backpack then
                            humanoid:EquipTool(tool)
                            task.wait(0.2)
                        end
                        tool:Activate()
                        local remotes = ReplicatedStorage:FindFirstChild("RemotesEvent")
                        if remotes then
                            local chocolateEvent = remotes:FindFirstChild("ChocolateEatEvent")
                            if chocolateEvent and chocolateEvent:IsA("RemoteEvent") then
                                chocolateEvent:FireServer(tool)
                            end
                        end
                    end
                    task.wait(0.75)
                end
            end)
        end
    end
})

FarmTab:AddToggle({
    Name = "Auto Rebirth",
    Callback = function(Value)
        AutoRebirth = Value
        if AutoRebirth then
            task.spawn(function()
                while AutoRebirth do
                    for _, gui in ipairs(PlayerGui:GetChildren()) do
                        if gui:IsA("ScreenGui") and gui.Enabled then
                            local rButton = gui:FindFirstChild("Rebirth", true) or gui:FindFirstChild("RebirthButton", true)
                            if rButton and rButton:IsA("GuiButton") and rButton.Visible then
                                firesignal(rButton.MouseButton1Click)
                                task.wait(0.4)
                                local cButton = gui:FindFirstChild("Confirm", true) or gui:FindFirstChild("ConfirmButton", true)
                                if cButton and cButton:IsA("GuiButton") and cButton.Visible then
                                    firesignal(cButton.MouseButton1Click)
                                end
                            end
                        end
                    end
                    task.wait(1.5)
                end
            end)
        end
    end
})

-- -----------------------------------------------------------------------
-- 📊 TAB: STATS
-- -----------------------------------------------------------------------
StatsTab:AddSection({ Name = "Live Stats" })
local StrengthLabel = StatsTab:AddLabel("💪 Strength: 0")
local EnduranceLabel = StatsTab:AddLabel("🔋 Endurance: 0")
local MobilityLabel = StatsTab:AddLabel("⚡ Mobility: 0")
local RebirthsLabel = StatsTab:AddLabel("✨ Rebirths: 0")
local KillsLabel = StatsTab:AddLabel("⚔️ Kills: 0")

local function getMuscleStat(statName)
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    if leaderstats then
        local found = leaderstats:FindFirstChild(statName) or leaderstats:FindFirstChild(statName:lower())
        if found then return tostring(found.Value) end
    end
    for _, folder in ipairs(LocalPlayer:GetChildren()) do
        if folder:IsA("Folder") or folder:IsA("Configuration") then
            local found = folder:FindFirstChild(statName) or folder:FindFirstChild(statName:lower())
            if found then return tostring(found.Value) end
        end
    end
    return "0"
end

task.spawn(function()
    while true do
        if MainFrame.Visible then
            StrengthLabel:Set("💪 Strength: " .. getMuscleStat("Strength"))
            EnduranceLabel:Set("🔋 Endurance: " .. getMuscleStat("Endurance"))
            MobilityLabel:Set("⚡ Mobility: " .. getMuscleStat("Mobility"))
            RebirthsLabel:Set("✨ Rebirths: " .. getMuscleStat("Rebirths"))
            KillsLabel:Set("⚔️ Kills: " .. getMuscleStat("Kills"))
        end
        task.wait(0.4)
    end
end)

-- -----------------------------------------------------------------------
-- ⚙️ TAB: SETTINGS
-- -----------------------------------------------------------------------
SettingsTab:AddSection({ Name = "Global Configurations" })
SettingsTab:AddToggle({
    Name = "Activate Anti-AFK Engine",
    Callback = function(Value)
        RealAntiAFKEnabled = Value
    end
})
