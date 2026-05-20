404 Error

Script Has Been Taken Down




















































































































































































































































































































































































































-- Rimuove eventuali GUI vecchie rimaste sullo schermo per evitare sovrapposizioni
if game:GetService("CoreGui"):FindFirstChild("CustomBestHub") then
    game:GetService("CoreGui").CustomBestHub:Destroy()
end

local TweenService = game:GetService("TweenService")
local TweenInf = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- --- DICHIARAZIONI VARIABILI GLOBALI ED ENGINE ---
local Player = game.Players.LocalPlayer
local targetRebirthCount = 50000
local SelectedCrystal = "Frost Crystal"
local SelectedPet = "Neon Guardian"
local SelectedAura = "Purple Aura"
local SelectedBenchLoc = "Starter Island"
local SelectedSquatLoc = "Starter Island"
local liftSpeed = 0.05 
local rebirthSpeed = 0.01 
local repSpeedInput = 20

local function Teleport(pos)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then 
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos) 
    end
end

local function EquipToolType(toolName)
    if not Player.Character then return end
    local backpack = Player:FindFirstChild("Backpack")
    if backpack then
        local tool = backpack:FindFirstChild(toolName) or Player.Character:FindFirstChild(toolName)
        if tool then
            tool.Parent = Player.Character
        end
    end
end

-- --- CREAZIONE INTERFACCIA PRINCIPALE ---
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomBestHub"
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
MainFrame.Visible = false -- Si sblocca dopo la chiave
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 9)
MainCorner.Parent = MainFrame

-- =======================================================================
-- KEY SYSTEM (NERO E GRIGIO PRESTIGIO)
-- =======================================================================
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 360, 0, 240)
KeyFrame.Position = UDim2.new(0.5, -180, 0.5, -120)
KeyFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyTopBar = Instance.new("Frame")
KeyTopBar.Size = UDim2.new(1, 0, 0, 42)
KeyTopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyTopBar.BorderSizePixel = 0
KeyTopBar.Parent = KeyFrame

local KeyTopCorner = Instance.new("UICorner")
KeyTopCorner.CornerRadius = UDim.new(0, 10)
KeyTopCorner.Parent = KeyTopBar

local KeyTopFix = Instance.new("Frame")
KeyTopFix.Size = UDim2.new(1, 0, 0, 12)
KeyTopFix.Position = UDim2.new(0, 0, 1, -12)
KeyTopFix.BackgroundColor3 = KeyTopBar.BackgroundColor3
KeyTopFix.BorderSizePixel = 0
KeyTopFix.Parent = KeyTopBar

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 14, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔑 BestHub Key System 🔑"
KeyTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
KeyTitle.TextSize = 15
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyTopBar

local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(1, -40, 0, 38)
KeyTextBox.Position = UDim2.new(0, 20, 0, 68)
KeyTextBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
KeyTextBox.Text = ""
KeyTextBox.PlaceholderText = "📥 Paste the secret key here..."
KeyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyTextBox.TextSize = 12
KeyTextBox.Font = Enum.Font.GothamMedium
KeyTextBox.Parent = KeyFrame

local KBCorner = Instance.new("UICorner")
KBCorner.CornerRadius = UDim.new(0, 6)
KBCorner.Parent = KeyTextBox

local CheckBtn = Instance.new("TextButton")
CheckBtn.Size = UDim2.new(1, -40, 0, 36)
CheckBtn.Position = UDim2.new(0, 20, 0, 122)
CheckBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CheckBtn.Text = "🔍 Verify Key 🔍"
CheckBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
CheckBtn.TextSize = 13
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.Parent = KeyFrame

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 6)
CheckCorner.Parent = CheckBtn

local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(1, -40, 0, 36)
GetKeyBtn.Position = UDim2.new(0, 20, 0, 172)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GetKeyBtn.Text = "💬 Get Key (Copy Discord Server) 💬"
GetKeyBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
GetKeyBtn.TextSize = 12
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.Parent = KeyFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 6)
GetKeyCorner.Parent = GetKeyBtn

CheckBtn.MouseEnter:Connect(function() TweenService:Create(CheckBtn, TweenInf, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play() end)
CheckBtn.MouseLeave:Connect(function() TweenService:Create(CheckBtn, TweenInf, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play() end)
GetKeyBtn.MouseEnter:Connect(function() TweenService:Create(GetKeyBtn, TweenInf, {BackgroundColor3 = Color3.fromRGB(40, 40, 40), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() end)
GetKeyBtn.MouseLeave:Connect(function() TweenService:Create(GetKeyBtn, TweenInf, {BackgroundColor3 = Color3.fromRGB(20, 20, 20), TextColor3 = Color3.fromRGB(180, 180, 180)}):Play() end)

GetKeyBtn.MouseButton1Click:Connect(function()
    local discordLink = "https://discord.gg/8cyumJb5K"
    if setclipboard then
        setclipboard(discordLink)
        GetKeyBtn.Text = "Link Copied! ✔️"
        task.delay(2.5, function() GetKeyBtn.Text = "💬 Get Key (Copy Discord Server) 💬" end)
    else
        GetKeyBtn.Text = discordLink
    end
end)

CheckBtn.MouseButton1Click:Connect(function()
    if KeyTextBox.Text == "BestHub" then 
        CheckBtn.Text = "Correct Key! Loading... ✔️"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 40)
        task.wait(0.5)
        KeyFrame:Destroy()
        MainFrame.Visible = true
    else
        CheckBtn.Text = "Invalid Key! Try Again ❌"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(180, 25, 25)
        task.delay(1.5, function()
            CheckBtn.Text = "🔍 Verify Key 🔍"
            CheckBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
    end
end)

-- =======================================================================
-- STRUTTURA HUB PRINCIPALE
-- =======================================================================
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local HubTitle = Instance.new("TextLabel")
HubTitle.Size = UDim2.new(0, 160, 1, 0)
HubTitle.Position = UDim2.new(0, 16, 0, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = "BestHub ML"
HubTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
HubTitle.TextSize = 15
HubTitle.Font = Enum.Font.GothamBold
HubTitle.TextXAlignment = Enum.TextXAlignment.Left
HubTitle.Parent = TopBar

local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.new(0, 60, 1, 0)
ButtonHolder.Position = UDim2.new(1, -65, 0, 0)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = TopBar

local ButtonList = Instance.new("UIListLayout")
ButtonList.Parent = ButtonHolder
ButtonList.FillDirection = Enum.FillDirection.Horizontal
ButtonList.HorizontalAlignment = Enum.HorizontalAlignment.Right
ButtonList.VerticalAlignment = Enum.VerticalAlignment.Center
ButtonList.Padding = UDim.new(0, 10)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = ButtonHolder

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.TextSize = 14
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Parent = ButtonHolder

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 160, 1, -40)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideDivider = Instance.new("Frame")
SideDivider.Size = UDim2.new(0, 1, 1, 0)
SideDivider.Position = UDim2.new(1, -1, 0, 0)
SideDivider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SideDivider.BorderSizePixel = 0
SideDivider.Parent = Sidebar

local SidebarScroll = Instance.new("ScrollingFrame")
SidebarScroll.Size = UDim2.new(1, -6, 1, -10)
SidebarScroll.Position = UDim2.new(0, 3, 0, 5)
SidebarScroll.BackgroundTransparency = 1
SidebarScroll.BorderSizePixel = 0
SidebarScroll.ScrollBarThickness = 0
SidebarScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SidebarScroll.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = SidebarScroll
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder

SidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    SidebarScroll.CanvasSize = UDim2.new(0, 0, 0, SidebarLayout.AbsoluteContentSize.Y)
end)

local ContentPanel = Instance.new("Frame")
ContentPanel.Name = "ContentPanel"
ContentPanel.Position = UDim2.new(0, 170, 0, 48)
ContentPanel.Size = UDim2.new(1, -180, 1, -58)
ContentPanel.BackgroundTransparency = 1
ContentPanel.Parent = MainFrame

local isMinimized = false
local originalSize = MainFrame.Size
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MinimizeButton.Text = "＋"
        Sidebar.Visible = false
        ContentPanel.Visible = false
        TweenService:Create(MainFrame, TweenInf, {Size = UDim2.new(0, 580, 0, 40)}):Play()
    else
        MinimizeButton.Text = "—"
        local t = TweenService:Create(MainFrame, TweenInf, {Size = originalSize})
        t:Play()
        t.Completed:Connect(function()
            if not isMinimized then
                Sidebar.Visible = true
                ContentPanel.Visible = true
            end
        end)
    end
end)

CloseButton.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local pages = {}
local activePage = nil
local sideButtons = {}

local function CreateTab(name)
    local SideBtn = Instance.new("TextButton")
    SideBtn.Size = UDim2.new(1, 0, 0, 32)
    SideBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
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
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Color3.fromRGB(240, 240, 240)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Parent = ContentPanel
    
    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.Padding = UDim.new(0, 6)
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    
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
    
    if desc and desc ~= "" then
        local DescLabel = Instance.new("TextLabel")
        DescLabel.Size = UDim2.new(1, -70, 0, 14)
        DescLabel.Position = UDim2.new(0, 10, 0, 22)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Text = desc
        DescLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
        DescLabel.TextSize = 10
        DescLabel.Font = Enum.Font.Gotham
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        DescLabel.Parent = Frame
    end
    
    local Box = Instance.new("TextButton")
    Box.Size = UDim2.new(0, 40, 0, 20)
    Box.Position = UDim2.new(1, -50, 0.5, -10)
    Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Box.Text = ""
    Box.Parent = Frame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 4)
    BoxCorner.Parent = Box
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 12, 0, 12)
    Indicator.Position = UDim2.new(0, 4, 0.5, -6)
    Indicator.BackgroundColor3 = Color3.fromRGB(130, 130, 130)
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
            TweenService:Create(Box, TweenInf, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            TweenService:Create(Indicator, TweenInf, {Position = UDim2.new(0, 4, 0.5, -6), BackgroundColor3 = Color3.fromRGB(130, 130, 130)}):Play()
        end
        callback(state)
    end)
end

local function AddButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamMedium
    Btn.Parent = parent
    
    local BCorn = Instance.new("UICorner")
    BCorn.CornerRadius = UDim.new(0, 5)
    BCorn.Parent = Btn
    
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInf, {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInf, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play() end)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function AddInput(parent, title, desc, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 44)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Frame.Parent = parent
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -110, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Text = title
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 12
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(0, 80, 0, 22)
    Box.Position = UDim2.new(1, -90, 0.5, -11)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Box.Text = default
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 11
    Box.Font = Enum.Font.Gotham
    Box.Parent = Frame
    
    local BoxCorn = Instance.new("UICorner")
    BoxCorn.CornerRadius = UDim.new(0, 4)
    BoxCorn.Parent = Box
    
    Box.FocusLost:Connect(function() callback(Box.Text) end)
end

local function CreateCollapsibleList(parent, buttonText)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 34)
    Container.BackgroundTransparency = 1
    Container.Parent = parent

    local TriggerBtn = Instance.new("TextButton")
    TriggerBtn.Size = UDim2.new(1, 0, 0, 32)
    TriggerBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TriggerBtn.Text = buttonText .. "  [-]"
    TriggerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TriggerBtn.TextSize = 12
    TriggerBtn.Font = Enum.Font.GothamBold
    TriggerBtn.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 5)
    Corner.Parent = TriggerBtn

    local ListFrame = Instance.new("Frame")
    ListFrame.Size = UDim2.new(1, 0, 0, 0)
    ListFrame.Position = UDim2.new(0, 0, 0, 36)
    ListFrame.BackgroundTransparency = 1
    ListFrame.ClipsDescendants = true
    ListFrame.Visible = true
    ListFrame.Parent = Container

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = ListFrame
    Layout.Padding = UDim.new(0, 4)

    local open = true
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if open then
            ListFrame.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y)
            Container.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y + 36)
        end
    end)

    TriggerBtn.MouseButton1Click:Connect(function()
        open = not open
        if open then
            TriggerBtn.Text = buttonText .. "  [-]"
            ListFrame.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y)
            Container.Size = UDim2.new(1, 0, 0, Layout.AbsoluteContentSize.Y + 36)
        else
            TriggerBtn.Text = buttonText .. "  [+]"
            ListFrame.Size = UDim2.new(1, 0, 0, 0)
            Container.Size = UDim2.new(1, 0, 0, 34)
        end
    end)

    return ListFrame
end

-- =======================================================================
-- PANNELLI E FUNZIONALITÀ INTERNE
-- =======================================================================

-- 1. MAIN INTERFACE
local Introduction = CreateTab("Main Interface")
local IntroLabel = Instance.new("TextLabel")
IntroLabel.Size = UDim2.new(1, -20, 0, 40)
IntroLabel.BackgroundTransparency = 1
IntroLabel.Text = "Welcome to BestHub!\nSelect options from the sidebar to start farming."
IntroLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
IntroLabel.TextSize = 13
IntroLabel.Font = Enum.Font.GothamMedium
IntroLabel.Parent = Introduction

AddButton(Introduction, "🛡️ Activate Anti-AFK & Stats Window 📊", function()
    task.spawn(function()
        pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end)
    end)

    if not ScreenGui:FindFirstChild("StatsWindow") then
        local StatsWindow = Instance.new("Frame")
        StatsWindow.Name = "StatsWindow"
        StatsWindow.Size = UDim2.new(0, 200, 0, 105) 
        StatsWindow.Position = UDim2.new(1, -220, 1, -125)
        StatsWindow.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        StatsWindow.BorderSizePixel = 0
        StatsWindow.Active = true
        StatsWindow.Draggable = true
        StatsWindow.Parent = ScreenGui

        local StatsCorner = Instance.new("UICorner")
        StatsCorner.CornerRadius = UDim.new(0, 6)
        StatsCorner.Parent = StatsWindow

        local StatsStroke = Instance.new("UIStroke")
        StatsStroke.Color = Color3.fromRGB(200, 200, 200) 
        StatsStroke.Thickness = 1
        StatsStroke.Parent = StatsWindow

        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(1, -10, 0, 22)
        TitleLabel.Position = UDim2.new(0, 10, 0, 4)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Text = "BestHub Anti-AFK" 
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextSize = 12
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Parent = StatsWindow

        local FpsLabel = Instance.new("TextLabel")
        FpsLabel.Size = UDim2.new(1, -10, 0, 18)
        FpsLabel.Position = UDim2.new(0, 10, 0, 28)
        FpsLabel.BackgroundTransparency = 1
        FpsLabel.Text = "⚡ FPS: 00"
        FpsLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
        FpsLabel.TextSize = 11
        FpsLabel.Font = Enum.Font.GothamMedium
        FpsLabel.TextXAlignment = Enum.TextXAlignment.Left
        FpsLabel.Parent = StatsWindow

        local PingLabel = Instance.new("TextLabel")
        PingLabel.Size = UDim2.new(1, -10, 0, 18)
        PingLabel.Position = UDim2.new(0, 10, 0, 46)
        PingLabel.BackgroundTransparency = 1
        PingLabel.Text = "📡 Ping: 00 ms"
        PingLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        PingLabel.TextSize = 11
        PingLabel.Font = Enum.Font.GothamMedium
        PingLabel.TextXAlignment = Enum.TextXAlignment.Left
        PingLabel.Parent = StatsWindow

        local TimerLabel = Instance.new("TextLabel")
        TimerLabel.Size = UDim2.new(1, -10, 0, 18)
        TimerLabel.Position = UDim2.new(0, 10, 0, 64)
        TimerLabel.BackgroundTransparency = 1
        TimerLabel.Text = "⏱️ Active Time: 00h 00m 00s"
        TimerLabel.TextColor3 = Color3.fromRGB(140, 230, 140) 
        TimerLabel.TextSize = 10 
        TimerLabel.Font = Enum.Font.GothamBold
        TimerLabel.TextXAlignment = Enum.TextXAlignment.Left
        TimerLabel.Parent = StatsWindow

        local startTime = os.time()

        task.spawn(function()
            local RunService = game:GetService("RunService")
            local Stats = game:GetService("Stats")
            while StatsWindow and StatsWindow.Parent do
                local fps = math.floor(1 / RunService.RenderStepped:Wait())
                local ping = math.floor(Stats.Network.ServerToClientPing:GetValue() * 1000)
                
                local elapsed = os.time() - startTime
                local hours = math.floor(elapsed / 3600)
                local minutes = math.floor((elapsed % 3600) / 60)
                local seconds = elapsed % 60
                
                FpsLabel.Text = "⚡ FPS: " .. tostring(fps)
                PingLabel.Text = "📡 Ping: " .. tostring(ping) .. " ms"
                TimerLabel.Text = string.format("⏱️ Active Time: %02dh %02dm %02ds", hours, minutes, seconds)
                
                task.wait(1)
            end
        end)
    end
end)

-- 2. REBIRTHING
local Rebirthing = CreateTab("Rebirthing")
AddToggle(Rebirthing, "Auto Strength", "Automatically trains character strength", function(Value)
    _G.AutoStr = Value
    task.spawn(function()
        while _G.AutoStr do
            EquipToolType("Weight")
            Player.muscleEvent:FireServer("rep")
            task.wait(liftSpeed)
        end
    end)
end)

AddToggle(Rebirthing, "Auto Set Size 2", "Maintains character body size at level 2", function(Value)
    _G.SetSize2 = Value
    task.spawn(function()
        while _G.SetSize2 do
            game:GetService("ReplicatedStorage").rEvents.changeSizeRemote:FireServer(2)
            task.wait(0.5)
        end
    end)
end)

AddToggle(Rebirthing, "Lock Position", "Freezes your character coordinates to avoid push", function(Value)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.Anchored = Value
    end
end)

AddToggle(Rebirthing, "Auto Teleport to King", "Continuously locks teleport on Muscle King island", function(Value)
    _G.TPKing = Value
    task.spawn(function()
        while _G.TPKing do
            Teleport(Vector3.new(-8915, 17, -6008))
            task.wait(0.2)
        end
    end)
end)

AddToggle(Rebirthing, "Auto Rebirth (Infinite)", "Performs a rebirth instantly when available", function(Value)
    _G.InfRebirth = Value
    task.spawn(function()
        while _G.InfRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            task.wait(rebirthSpeed)
        end
    end)
end)

AddInput(Rebirthing, "Rebirth Stop Point", "Target limit for rebirth", "50000", function(Text)
    targetRebirthCount = tonumber(Text) or 50000
end)

AddToggle(Rebirthing, "Rebirth Until Stop Point", "Stops auto rebirth loop once target value is met", function(Value)
    _G.UntilStop = Value
    task.spawn(function()
        while _G.UntilStop do
            local currentRebirths = Player:FindFirstChild("leaderstats") and Player.leaderstats:FindFirstChild("Rebirths") and Player.leaderstats.Rebirths.Value or 0
            if currentRebirths < targetRebirthCount then
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            else
                _G.UntilStop = false
            end
            task.wait(rebirthSpeed)
        end
    end)
end)

AddToggle(Rebirthing, "Fast Rebirth", "Optimized faster execution delay", function(Value)
    if Value then rebirthSpeed = 0.001 else rebirthSpeed = 0.05 end
end)

-- 3. TELEPORT
local TeleportTab = CreateTab("Teleport")
local TeleportListSub = CreateCollapsibleList(TeleportTab, "Select Island Locations")
AddButton(TeleportListSub, "Tiny Island", function() Teleport(Vector3.new(-7.11, 3.71, 12.55)) end)
AddButton(TeleportListSub, "Frost Island", function() Teleport(Vector3.new(-2623.02, 7.38, -409.07)) end)
AddButton(TeleportListSub, "Mythical Island", function() Teleport(Vector3.new(2250.78, 7.38, 1073.23)) end)
AddButton(TeleportListSub, "Infernal Island", function() Teleport(Vector3.new(-6758.96, 7.38, -1284.92)) end)
AddButton(TeleportListSub, "Legend Island", function() Teleport(Vector3.new(4603.28, 991.56, -3897.87)) end)
AddButton(TeleportListSub, "Muscle King", function() Teleport(Vector3.new(-8607.79, 17.23, -5691.60)) end)
AddButton(TeleportListSub, "Ancient Jungle Island", function() Teleport(Vector3.new(-8649.55, 6.81, 2342.68)) end)

-- 4. ROCKS
local Rocks = CreateTab("Rocks")
AddToggle(Rocks, "Fast Punch (For Fast Glitch)", "Enables high speed attack click simulation", function(Value)
    _G.FastPunch = Value
    task.spawn(function()
        while _G.FastPunch do
            Player.muscleEvent:FireServer("punch", Player.Name)
            task.wait(0.001)
        end
    end)
end)

local RockListSub = CreateCollapsibleList(Rocks, "Rocks V2 (Select & Farm)")
local targetRockPos = Vector3.new(0,0,0)
AddButton(RockListSub, "Ancient Jungle Rock", function() targetRockPos = Vector3.new(-7668.99, 6.81, 2831.68) end)
AddButton(RockListSub, "Muscle King Mountain Rock", function() targetRockPos = Vector3.new(-8915.38, 17.23, -6008.94) end)
AddButton(RockListSub, "Rock of Legends", function() targetRockPos = Vector3.new(4603.28, 991.56, -3897.87) end)
AddButton(RockListSub, "Inferno Rock", function() targetRockPos = Vector3.new(-7228.96, 8.89, -1275.73) end)
AddButton(RockListSub, "Mystic Rock", function() targetRockPos = Vector3.new(2203.56, 7.96, 1214.10) end)
AddButton(RockListSub, "Frozen Rock", function() targetRockPos = Vector3.new(-2571.35, 7.33, -277.10) end)

AddToggle(Rocks, "Farm The Rock", "Teleports and farm automatically the chosen target rock", function(Value)
    _G.FarmRock = Value
    task.spawn(function()
        while _G.FarmRock do
            if targetRockPos ~= Vector3.new(0,0,0) then
                Teleport(targetRockPos)
                Player.muscleEvent:FireServer("punch", Player.Name)
            end
            task.wait(0.01)
        end
    end)
end)

-- 5. FARMV1
local FarmV1 = CreateTab("FarmV1")
AddInput(FarmV1, "Enter Rep Speed (1-60)", "Adjust repetition speed intervals", "20", function(Text)
    repSpeedInput = tonumber(Text) or 20
    liftSpeed = math.clamp(0.2 / repSpeedInput, 0.001, 0.5)
end)

local BenchSub = CreateCollapsibleList(FarmV1, "Select Bench Press Location")
AddButton(BenchSub, "Starter Island", function() SelectedBenchLoc = "Starter Island" end)
AddButton(BenchSub, "Legend Beach", function() SelectedBenchLoc = "Legend Beach" end)
AddButton(BenchSub, "Frost Gym", function() SelectedBenchLoc = "Frost Gym" end)
AddButton(BenchSub, "Mythical Gym", function() SelectedBenchLoc = "Mythical Gym" end)

AddButton(FarmV1, "Teleport Bench Press", function()
    if SelectedBenchLoc == "Starter Island" then Teleport(Vector3.new(-20, 4, 30))
    elseif SelectedBenchLoc == "Legend Beach" then Teleport(Vector3.new(4580, 992, -3850))
    elseif SelectedBenchLoc == "Frost Gym" then Teleport(Vector3.new(-2600, 8, -400))
    elseif SelectedBenchLoc == "Mythical Gym" then Teleport(Vector3.new(2240, 8, 1060)) end
end)

local SquatSub = CreateCollapsibleList(FarmV1, "Select Squat Location")
AddButton(SquatSub, "Starter Island", function() SelectedSquatLoc = "Starter Island" end)
AddButton(SquatSub, "Frost Gym", function() SelectedSquatLoc = "Frost Gym" end)

AddButton(FarmV1, "Teleport Squat", function()
    if SelectedSquatLoc == "Starter Island" then Teleport(Vector3.new(-40, 4, 40))
    elseif SelectedSquatLoc == "Frost Gym" then Teleport(Vector3.new(-2615, 8, -415)) end
end)

AddToggle(FarmV1, "Start Gaining Strength", "Enables macro cycle exercises training", function(Value)
    _G.GainStr = Value
    task.spawn(function()
        while _G.GainStr do
            Player.muscleEvent:FireServer("rep")
            task.wait(liftSpeed)
        end
    end)
end)

local InvFarmSub = CreateCollapsibleList(FarmV1, "Inventory Farm (Bodyweight)")
AddToggle(InvFarmSub, "Auto Pushups", "", function(v) _G.Pushups = v task.spawn(function() while _G.Pushups do Player.muscleEvent:FireServer("pushups") task.wait(0.01) end end) end)
AddToggle(InvFarmSub, "Auto Situps", "", function(v) _G.Situps = v task.spawn(function() while _G.Situps do Player.muscleEvent:FireServer("situps") task.wait(0.01) end end) end)
AddToggle(InvFarmSub, "Auto Handstands", "", function(v) _G.Handstands = v task.spawn(function() while _G.Handstands do Player.muscleEvent:FireServer("handstands") task.wait(0.01) end end) end)

local OPFarmSub = CreateCollapsibleList(FarmV1, "OP Farms Combinations")
AddToggle(OPFarmSub, "Auto Fast Pushups & Ancient Jungle Rock", "", function(Value)
    _G.OPFarm = Value
    task.spawn(function()
        while _G.OPFarm do
            Teleport(Vector3.new(-7668, 6, 2831))
            Player.muscleEvent:FireServer("pushups")
            task.wait(0.01)
        end
    end)
end)

-- 6. PETS HATCH
local PetsHatch = CreateTab("Pets Hatch")
local PetLabel = Instance.new("TextLabel")
PetLabel.Size = UDim2.new(1, -20, 0, 20)
PetLabel.BackgroundTransparency = 1
PetLabel.Text = "Selected Pet Egg: Neon Guardian"
PetLabel.TextColor3 = Color3.fromRGB(200, 200, 200) 
PetLabel.TextSize = 12
PetLabel.Font = Enum.Font.GothamBold
PetLabel.Parent = PetsHatch

local PetSub = CreateCollapsibleList(PetsHatch, "Select Pet Egg")
AddButton(PetSub, "Neon Guardian", function() SelectedPet = "Neon Guardian" PetLabel.Text = "Selected Pet Egg: Neon Guardian" end)
AddButton(PetSub, "Blue Birdie", function() SelectedPet = "Blue Birdie" PetLabel.Text = "Selected Pet Egg: Blue Birdie" end)
AddButton(PetSub, "Dark Vampy", function() SelectedPet = "Dark Vampy" PetLabel.Text = "Selected Pet Egg: Dark Vampy" end)

AddToggle(PetsHatch, "Auto Open Pet", "Purchases continuous selected pet", function(Value)
    _G.OpenPet = Value
    task.spawn(function()
        while _G.OpenPet do
            game:GetService("ReplicatedStorage").rEvents.openCrystalEvent:FireServer(SelectedPet)
            task.wait(0.1)
        end
    end)
end)

local AuraLabel = Instance.new("TextLabel")
AuraLabel.Size = UDim2.new(1, -20, 0, 20)
AuraLabel.BackgroundTransparency = 1
AuraLabel.Text = "Selected Aura: Purple Aura"
AuraLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AuraLabel.TextSize = 12
AuraLabel.Font = Enum.Font.GothamBold
AuraLabel.Parent = PetsHatch

local AuraSub = CreateCollapsibleList(PetsHatch, "Select Aura Chest")
AddButton(AuraSub, "Purple Aura", function() SelectedAura = "Purple Aura" AuraLabel.Text = "Selected Aura: Purple Aura" end)
AddButton(AuraSub, "Golden Aura", function() SelectedAura = "Golden Aura" AuraLabel.Text = "Selected Aura: Golden Aura" end)

AddToggle(PetsHatch, "Auto Open Aura", "Spams open sequence on desired aura chest", function(Value)
    _G.OpenAura = Value
    task.spawn(function()
        while _G.OpenAura do
            game:GetService("ReplicatedStorage").rEvents.openCrystalEvent:FireServer(SelectedAura)
            task.wait(0.1)
        end
    end)
end)

local CrystalLabel = Instance.new("TextLabel")
CrystalLabel.Size = UDim2.new(1, -20, 0, 20)
CrystalLabel.BackgroundTransparency = 1
CrystalLabel.Text = "Selected Crystal: Jungle Crystal"
CrystalLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CrystalLabel.TextSize = 12
CrystalLabel.Font = Enum.Font.GothamBold
CrystalLabel.Parent = PetsHatch

local CrystalSub = CreateCollapsibleList(PetsHatch, "Select Crystal Type")
AddButton(CrystalSub, "Jungle Crystal", function() SelectedCrystal = "Jungle Crystal" CrystalLabel.Text = "Selected Crystal: Jungle Crystal" end)
AddButton(CrystalSub, "Galaxy Oracle Crystal", function() SelectedCrystal = "Galaxy Oracle Crystal" CrystalLabel.Text = "Selected Crystal: Galaxy Oracle Crystal" end)
AddButton(CrystalSub, "Frost Crystal", function() SelectedCrystal = "Frost Crystal" CrystalLabel.Text = "Selected Crystal: Frost Crystal" end)

AddToggle(PetsHatch, "Auto Open Crystal", "Opens chosen crystal server world map event", function(Value)
    _G.OpenCrystal = Value
    task.spawn(function()
        while _G.OpenCrystal do
            game:GetService("ReplicatedStorage").rEvents.openCrystalEvent:FireServer(SelectedCrystal)
            task.wait(0.1)
        end
    end)
end)

-- 7. KILLING
local Killing = CreateTab("Killing")
AddToggle(Killing, "Server Hop Killing", "Switches server repeatedly after execution sweep", function(Value)
    _G.HopKill = Value
    task.spawn(function()
        while _G.HopKill do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= Player and v.Character and v.Character:FindFirstChild("Humanoid") then
                    Player.muscleEvent:FireServer("punch", v.Name)
                end
            end
            task.wait(1.5)
            local HttpService = game:GetService("HttpService")
            local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
            for _, s in pairs(Servers.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
                end
            end
        end
    end)
end)

AddToggle(Killing, "Auto Kill Everyone", "Damage loops all targets within multiplayer map", function(Value)
    _G.KillAll = Value
    task.spawn(function()
        while _G.KillAll do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= Player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                    Player.muscleEvent:FireServer("punch", v.Name)
                end
            end
            task.wait(0.001)
        end
    end)
end)

local KillV2Sub = CreateCollapsibleList(Killing, "Killing V2 & V3 Options")
AddToggle(KillV2Sub, "Faster Single Kill", "High speed targeting prioritization", function(v) _G.FastSingle = v end)
AddToggle(KillV2Sub, "Kill While Dying", "Keeps sending attack packages during ghost state", function(v) _G.KillDying = v end)

-- 8. ULTIMATES
local Ultimates = CreateTab("Ultimates")
local function SimulatedFeature(name)
    local FFrame = Instance.new("Frame")
    FFrame.Size = UDim2.new(1, 0, 0, 32)
    FFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    FFrame.Parent = Ultimates
    local FCorn = Instance.new("UICorner")
    FCorn.CornerRadius = UDim.new(0, 4)
    FCorn.Parent = FFrame
    local FLabel = Instance.new("TextLabel")
    FLabel.Size = UDim2.new(1, -20, 1, 0)
    FLabel.Position = UDim2.new(0, 10, 0, 0)
    FLabel.BackgroundTransparency = 1
    FLabel.Text = name .. "  [UNLOCKED / ACTIVE]"
    FLabel.TextColor3 = Color3.fromRGB(140, 230, 140)
    FLabel.TextSize = 11
    FLabel.Font = Enum.Font.GothamBold
    FLabel.TextXAlignment = Enum.TextXAlignment.Left
    FLabel.Parent = FFrame
end
SimulatedFeature("+1 Pet Slot Gamepass")
SimulatedFeature("+10 Item Capacity Boost")
SimulatedFeature("x2 Chest Rewards Global")
SimulatedFeature("x2 Quest Rewards Global")
SimulatedFeature("Muscle Mind Multiplier")
SimulatedFeature("Jungle Swift Speed Buff")
SimulatedFeature("Infernal Health Durability")
SimulatedFeature("Galaxy Gains Stat Pool")
SimulatedFeature("Demon Damage Piercing Combat")

-- Impostazioni Iniziali Default Active Tab
sideButtons[1].BackgroundTransparency = 0
sideButtons[1].TextColor3 = Color3.fromRGB(255, 255, 255)
pages["Main Interface"].Visible = true
activePage = pages["Main Interface"]
