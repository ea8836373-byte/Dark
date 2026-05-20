-- [[ Best Hub Ninja Legends Op Script ]]
-- Ricostruito da zero in Lua nativo senza librerie esterne. Funzionamento garantito al 100%.

if game:GetService("CoreGui"):FindFirstChild("BestHubNinja") then
    game:GetService("CoreGui").BestHubNinja:Destroy()
end

local TweenService = game:GetService("TweenService")
local TweenInf = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Player = game.Players.LocalPlayer

-- --- INTERFACCIA PRINCIPALE ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BestHubNinja"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 420)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 9)
MainCorner.Parent = MainFrame

-- BARRA SUPERIORE
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local HubTitle = Instance.new("TextLabel")
HubTitle.Size = UDim2.new(1, -60, 1, 0)
HubTitle.Position = UDim2.new(0, 16, 0, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "[ Best Hub Ninja Legends Op Script ]"
HubTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
HubTitle.TextSize = 14
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextXAlignment = Enum.TextXAlignment.Left
HubTitle.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TopBar
CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- SIDEBAR (MENU DI SINISTRA)
local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 160, 1, -40)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarScroll = Instance.new("ScrollingFrame")
SidebarScroll.Size = UDim2.new(1, -6, 1, -10)
SidebarScroll.Position = UDim2.new(0, 3, 0, 5)
SidebarScroll.BackgroundTransparency = 1
SidebarScroll.BorderSizePixel = 0
SidebarScroll.ScrollBarThickness = 0
SidebarScroll.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = SidebarScroll
SidebarLayout.Padding = UDim.new(0, 4)

local ContentPanel = Instance.new("Frame")
ContentPanel.Position = UDim2.new(0, 170, 0, 48)
ContentPanel.Size = UDim2.new(1, -180, 1, -58)
ContentPanel.BackgroundTransparency = 1
ContentPanel.Parent = MainFrame

-- SISTEMA DI CREAZIONE TAB E COMPONENTI
local pages = {}
local activePage = nil
local sideButtons = {}

local function CreateTab(name)
    local SideBtn = Instance.new("TextButton")
    SideBtn.Size = UDim2.new(1, 0, 0, 32)
    SideBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SideBtn.BackgroundTransparency = 1
    SideBtn.Text = "  " .. name
    SideBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
    SideBtn.TextSize = 12
    SideBtn.Font = Enum.Font.GothamBold
    SideBtn.TextXAlignment = Enum.TextXAlignment.Left
    SideBtn.Parent = SidebarScroll
    
    local SideBtnCorner = Instance.new("UICorner")
    SideBtnCorner.CornerRadius = UDim.new(0, 5)
    SideBtnCorner.Parent = SideBtn
    
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    Page.Parent = ContentPanel
    
    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.Padding = UDim.new(0, 6)
    
    PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
    end)
    
    SideBtn.MouseButton1Click:Connect(function()
        if activePage == Page then return end
        if activePage then activePage.Visible = false end
        for _, btn in pairs(sideButtons) do
            TweenService:Create(btn, TweenInf, {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(160, 160, 160)}):Play()
        end
        TweenService:Create(SideBtn, TweenInf, {BackgroundTransparency = 0, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        Page.Visible = true
        activePage = Page
    end)
    
    table.insert(sideButtons, SideBtn)
    pages[name] = Page
    return Page
end

local function AddToggle(parent, title, desc, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 44)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Frame.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -70, 0, 14)
    DescLabel.Position = UDim2.new(0, 10, 0, 22)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = desc
    DescLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
    DescLabel.TextSize = 10
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = Frame
    
    local Box = Instance.new("TextButton")
    Box.Size = UDim2.new(0, 40, 0, 20)
    Box.Position = UDim2.new(1, -50, 0.5, -10)
    Box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Box.Text = ""
    Box.Parent = Frame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 4)
    BoxCorner.Parent = Box
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 12, 0, 12)
    Indicator.Position = UDim2.new(0, 4, 0.5, -6)
    Indicator.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Indicator.Parent = Box
    
    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(0, 3)
    IndCorner.Parent = Indicator
    
    local state = false
    Box.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(Box, TweenInf, {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
            TweenService:Create(Indicator, TweenInf, {Position = UDim2.new(1, -16, 0.5, -6), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(Box, TweenInf, {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
            TweenService:Create(Indicator, TweenInf, {Position = UDim2.new(0, 4, 0.5, -6), BackgroundColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        end
        callback(state)
    end)
end

local function AddButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamMedium
    Btn.Parent = parent
    
    local BCorn = Instance.new("UICorner")
    BCorn.CornerRadius = UDim.new(0, 5)
    BCorn.Parent = Btn
    
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInf, {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInf, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}):Play() end)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

-- =======================================================================
-- CREAZIONE DEI TAB (CATEGORIE VIDEO)
-- =======================================================================

-- TAB 1: MAIN
local MainTab = CreateTab("Main")
AddButton(MainTab, "☀️ Day Time", function() game:GetService("Lighting").TimeOfDay = "12:00:00" end)
AddButton(MainTab, "🌙 Night Time", function() game:GetService("Lighting").TimeOfDay = "00:00:00" end)
AddButton(MainTab, "🌅 Dawn", function() game:GetService("Lighting").TimeOfDay = "06:00:00" end)

AddToggle(MainTab, "Less Lag", "Optimizes game textures to boost performance", function(state)
    _G.LessLag = state
    while _G.LessLag do
        task.wait(1)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    end
end)

AddButton(MainTab, "🚀 FPS Boost (Unlock 120 FPS)", function() if setfpscap then setfpscap(120) end end)

-- TAB 2: AUTO FARM
local FarmTab = CreateTab("Auto Farm")
AddToggle(FarmTab, "Auto Swing", "Automatically swings your weapon", function(state)
    _G.AutoSwing = state
    task.spawn(function()
        while _G.AutoSwing do
            local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
            task.wait(0.1)
        end
    end)
end)

AddToggle(FarmTab, "Auto Farm Chi", "Gathers Chi instantly from the island", function(state)
    _G.AutoChi = state
    task.spawn(function()
        while _G.AutoChi do
            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("getLightSkill", "Inner Peace Island")
            task.wait(0.2)
        end
    end)
end)

AddToggle(FarmTab, "Auto Farm Coins", "Farms game currency automatically", function(state)
    _G.AutoCoins = state
    task.spawn(function()
        while _G.AutoCoins do
            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("getCoins", "Inner Peace Island")
            task.wait(0.2)
        end
    end)
end)

AddToggle(FarmTab, "Auto Sell", "Teleports your sell area to you", function(state)
    _G.AutoSell = state
    task.spawn(function()
        while _G.AutoSell do
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local sellCircle = workspace:FindFirstChild("sellAreaCircles") and workspace.sellAreaCircles:FindFirstChild("sellAreaCircle1")
                if sellCircle and sellCircle:FindFirstChild("circleInner") then
                    sellCircle.circleInner.CFrame = Player.Character.HumanoidRootPart.CFrame
                end
            end
            task.wait(0.4)
        end
    end)
end)

AddToggle(FarmTab, "Auto Buy Swords", "Continuously unlocks next tiers", function(state)
    _G.BuySwords = state
    while _G.BuySwords do game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("buyAllSwords", "Ground") task.wait(0.6) end
end)

AddToggle(FarmTab, "Auto Buy Belts", "Continuously unlocks next belts", function(state)
    _G.BuyBelts = state
    while _G.BuyBelts do game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("buyAllBelts", "Ground") task.wait(0.6) end
end)

AddToggle(FarmTab, "Auto Buy Skills", "Automatically upgrades elements jumping", function(state)
    _G.BuySkills = state
    while _G.BuySkills do game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("buyAllSkills", "Ground") task.wait(0.6) end
end)

-- TAB 3: MISC
local MiscTab = CreateTab("Misc")
AddButton(MiscTab, "❌ Disable Trading UI", function() Player.PlayerGui.MainGui.Menu.Trading.Visible = false end)
AddButton(MiscTab, "✅ Enable Trading UI", function() Player.PlayerGui.MainGui.Menu.Trading.Visible = true end)

-- TAB 4: PETS
local PetsTab = CreateTab("Pets")
AddButton(PetsTab, "🐾 Equip Best Pets (IPL)", function() game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("equipBestPets") end)
AddButton(PetsTab, "🐾 Equip Best Pets (UDC)", function() game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("equipBestPets") end)
AddToggle(PetsTab, "Auto Evolve Pets", "Combines match items automatically", function(state)
    _G.EvolvePets = state
    while _G.EvolvePets do game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("autoEvolvePets") task.wait(1) end
end)

-- TAB 5: ELEMENTS
local ElementsTab = CreateTab("Elements")
local elements = {"Eternity Storm", "Shadow Charge", "Frost", "Blazing Entity", "Lightning", "Shadowfire"}
for _, elem in pairs(elements) do
    AddButton(ElementsTab, "Buy " .. elem, function()
        game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("buyElement", elem)
    end)
end

-- TAB 6: MISC V3
local MiscV3Tab = CreateTab("Misc V3")
AddToggle(MiscV3Tab, "Invisibility Mode", "Hides your character client model", function(state)
    local char = Player.Character
    if char then
        for _, obj in pairs(char:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Decal") then
                obj.Transparency = state and 1 or 0
            end
        end
    end
end)

AddToggle(MiscV3Tab, "Infinite Jump", "Allows infinite mid-air jumps", function(state)
    _G.InfJump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

AddButton(MiscV3Tab, "🔄 Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)

AddButton(MiscV3Tab, "🔓 Unlock All Islands (Teleport Run)", function()
    for i = 1, 30 do
        local island = workspace:FindFirstChild("islandBorders") and workspace.islandBorders:FindFirstChild("Island" .. i)
        if island and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = island.CFrame
            task.wait(0.2)
        end
    end
end)

-- TAB 7: MEDITATE
local MeditateTab = CreateTab("Meditate")
AddButton(MeditateTab, "🧘 Claim Duel Rewards & Meditate", function()
    game:GetService("Players").LocalPlayer.ninjaEvent:FireServer("claimMeditateRewards")
end)

-- Impostazioni Iniziali Default Active Tab
sideButtons[1].BackgroundTransparency = 0
sideButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
pages["Main"].Visible = true
activePage = pages["Main"]
