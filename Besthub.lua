local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Best Hub | Muscle Legends",
    SubTitle = "by @rexbgod",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "dumbbell" }),
    Killer = Window:AddTab({ Title = "Killer", Icon = "skull" }),
    Pets = Window:AddTab({ Title = "Pets", Icon = "dog" }),
    Rocks = Window:AddTab({ Title = "Rocks", Icon = "mountain" }),
    Islands = Window:AddTab({ Title = "Islands", Icon = "map" }),
    Spy = Window:AddTab({ Title = "Spy", Icon = "user-search" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local targetRebirthCount = 50000

-- --- FUNZIONI UTILI ---
local function Teleport(pos)
    if Player.Character then Player.Character.HumanoidRootPart.CFrame = CFrame.new(pos) end
end

-- --- MAIN TAB ---
Tabs.Main:AddToggle("AutoSize1", {Title = "Auto Size 1", Default = false}):OnChanged(function(Value)
    _G.AutoSize = Value
    task.spawn(function()
        while _G.AutoSize do
            game:GetService("ReplicatedStorage").rEvents.changeSizeRemote:FireServer(1)
            task.wait(1)
        end
    end)
end)

Tabs.Main:AddToggle("AutoTPKing", {Title = "Auto Teleport to King", Default = false}):OnChanged(function(Value)
    _G.TPKing = Value
    task.spawn(function()
        while _G.TPKing do
            Teleport(Vector3.new(-8915.38, 17.23, -6008.94))
            task.wait(1)
        end
    end)
end)

Tabs.Main:AddInput("TargetRebirth", {
    Title = "Target Rebirth",
    Default = "50000",
    Numeric = true,
    Finished = true,
    Callback = function(Value) targetRebirthCount = tonumber(Value) or 50000 end
})

Tabs.Main:AddToggle("FastRebirths", {Title = "Fast Rebirths", Default = false}):OnChanged(function(Value)
    _G.FastReb = Value
    task.spawn(function()
        while _G.FastReb do
            if Player.leaderstats.Rebirths.Value < targetRebirthCount then
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            end
            task.wait(0.2)
        end
    end)
end)

Tabs.Main:AddToggle("AutoLift", {Title = "Auto Lift (Weight)", Default = false}):OnChanged(function(Value)
    _G.Lifting = Value
    task.spawn(function()
        while _G.Lifting do
            local tool = Player.Backpack:FindFirstChild("Weight") or Player.Character:FindFirstChild("Weight")
            if tool then Player.Character.Humanoid:EquipTool(tool) end
            Player.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end)

-- --- KILLER TAB ---
Tabs.Killer:AddToggle("AutoKillAll", {Title = "Auto Kill Everyone", Default = false}):OnChanged(function(Value)
    _G.KillAll = Value
    task.spawn(function()
        while _G.KillAll do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= Player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                    Player.muscleEvent:FireServer("punch", v.Name)
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- --- PETS TAB ---
Tabs.Pets:AddToggle("AutoEvolve", {Title = "Auto Evolve All Pets", Default = false}):OnChanged(function(Value)
    _G.AutoEvolve = Value
    task.spawn(function()
        while _G.AutoEvolve do
            game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet")
            task.wait(1.5)
        end
    end)
end)

Tabs.Pets:AddDropdown("CrystalSelect", {
    Title = "Select Crystal",
    Values = {
        "Frost Crystal", 
        "Mythical Crystal", 
        "Infernal Crystal", 
        "Legends Crystal",
        "Jungle Crystal",
        "Muscle King Crystal"
    },
    Callback = function(Value) _G.SelectedCrystal = Value end
})

Tabs.Pets:AddToggle("AutoOpenCrystal", {Title = "Auto Open Crystal", Default = false}):OnChanged(function(Value)
    _G.AutoOpen = Value
    task.spawn(function()
        while _G.AutoOpen do
            if _G.SelectedCrystal then
                game:GetService("ReplicatedStorage").rEvents.openCrystalEvent:FireServer(_G.SelectedCrystal)
            end
            task.wait(1)
        end
    end)
end)

-- --- ROCKS TAB ---
Tabs.Rocks:AddButton({Title = "Frozen Rock", Callback = function() Teleport(Vector3.new(-2571.35, 7.33, -277.10)) end})
Tabs.Rocks:AddButton({Title = "Mystic Rock", Callback = function() Teleport(Vector3.new(2203.56, 7.96, 1214.10)) end})
Tabs.Rocks:AddButton({Title = "Infernal Rock", Callback = function() Teleport(Vector3.new(-7228.96, 8.89, -1275.73)) end})
Tabs.Rocks:AddButton({Title = "Rocks of Legends", Callback = function() Teleport(Vector3.new(4603.28, 991.56, -3897.87)) end})
Tabs.Rocks:AddButton({Title = "Muscle King Mountain", Callback = function() Teleport(Vector3.new(-8915.38, 17.23, -6008.94)) end})
Tabs.Rocks:AddButton({Title = "Ancient Jungle Rock", Callback = function() Teleport(Vector3.new(-7668.99, 6.81, 2831.68)) end})

-- --- ISLANDS TAB ---
Tabs.Islands:AddButton({Title = "Frost Gym", Callback = function() Teleport(Vector3.new(-2623.02, 7.38, -409.07)) end})
Tabs.Islands:AddButton({Title = "Mythical Gym", Callback = function() Teleport(Vector3.new(2250.78, 7.38, 1073.23)) end})
Tabs.Islands:AddButton({Title = "Eternal Gym", Callback = function() Teleport(Vector3.new(-6758.96, 7.38, -1284.92)) end})
Tabs.Islands:AddButton({Title = "Legends Gym", Callback = function() Teleport(Vector3.new(4603.28, 991.56, -3897.87)) end})
Tabs.Islands:AddButton({Title = "Muscle King Gym", Callback = function() Teleport(Vector3.new(-8607.79, 17.23, -5691.60)) end})
Tabs.Islands:AddButton({Title = "Jungle Gym", Callback = function() Teleport(Vector3.new(-8649.55, 6.81, 2342.68)) end})

-- --- SPY TAB ---
local SpySelector = Tabs.Spy:AddDropdown("SpySelector", {
    Title = "Select Player to Watch",
    Values = {},
    Callback = function(Value) _G.TargetSpy = Value end
})

task.spawn(function()
    while task.wait(5) do
        local names = {}
        for _, p in pairs(game.Players:GetPlayers()) do table.insert(names, p.Name) end
        SpySelector:SetValues(names)
    end
end)

Tabs.Spy:AddButton({
    Title = "Watch Player (Spy)",
    Callback = function()
        local target = game.Players:FindFirstChild(_G.TargetSpy)
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = target.Character.Humanoid
        end
    end
})

Tabs.Spy:AddButton({Title = "Stop Watching", Callback = function() Camera.CameraSubject = Player.Character.Humanoid end})

-- --- STATS TAB ---
local StatsLabel = Tabs.Stats:AddParagraph({Title = "Live Stats", Content = "Loading..."})
task.spawn(function()
    while task.wait(1) do
        local stats = Player:FindFirstChild("leaderstats")
        if stats then
            StatsLabel:SetDesc("Strength: "..stats.Strength.Value.."\nRebirths: "..stats.Rebirths.Value.."\nKills: "..stats.Kills.Value)
        end
    end
end)

-- --- SETTINGS TAB ---
Tabs.Settings:AddButton({Title = "Anti AFK", Callback = function() 
    Player.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end})

Tabs.Settings:AddButton({
    Title = "Server Hop",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
        for _, s in pairs(Servers.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
            end
        end
    end
})

Tabs.Settings:AddButton({Title = "Rejoin Server", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId) end})
Tabs.Settings:AddButton({Title = "Remove GUI", Callback = function() Window:Destroy() end})

Window:SelectTab(1)
