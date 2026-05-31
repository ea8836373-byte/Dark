local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "BestHub | Ninja legends v2",
    LoadingTitle = "Ninja Legends Hub",
    LoadingSubtitle = "by KyoYT",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local main = Window:CreateTab("Main", 6026568198)
local farm = Window:CreateTab("Auto Farm", 7044284832)
local tp = Window:CreateTab("Teleport", 6035190846)
local egg = Window:CreateTab("Crystal", 6031265976)
local misc = Window:CreateTab("Misc", 6034509993)

local TimeLabel = main:CreateLabel("[GameTime] : Loading...")

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local GameTime = math.floor(workspace.DistributedGameTime+0.5)
            local Hour = math.floor(GameTime/(60^2))%24
            local Minute = math.floor(GameTime/(60^1))%60
            local Second = math.floor(GameTime/(60^0))%60
            TimeLabel:Set("[GameTime] : Hours : "..Hour.." Minutes : "..Minute.." Seconds : "..Second)
        end)
    end
end)

local FpsLabel = main:CreateLabel("[Fps] : Loading...")

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local Fps = math.floor(workspace:GetRealPhysicsFPS())
            FpsLabel:Set("[Fps] : "..Fps)
        end)
    end
end)

local PingLabel = main:CreateLabel("[Ping] : Loading...")

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
            PingLabel:Set("[Ping] : "..Ping)
        end)
    end
end)

main:CreateSection("Main")

main:CreateButton({
    Name = "Disable Trading",
    Callback = function()
        local args = { [1] = "disableTrading" }
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))
    end
})

main:CreateButton({
    Name = "Enable Trading",
    Callback = function()
        local args = { [1] = "enableTrading" }
        game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer(unpack(args))
    end
})

local function GetPlayerListWithDisplay()
    local list = {}
    local mapping = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            local displayText = v.DisplayName .. " (@" .. v.Name .. ")"
            table.insert(list, displayText)
            mapping[displayText] = v.Name
        end
    end
    return list, mapping
end

local PlayerList, PlayerMapping = GetPlayerListWithDisplay()
local TpPlayer = nil

local PlayerDropdown = main:CreateDropdown({
    Name = "Select Player",
    Options = PlayerList,
    CurrentOption = {},
    MultipleOptions = false,
    Callback = function(Option)
        TpPlayer = PlayerMapping[Option]
    end
})

Players.PlayerAdded:Connect(function(plr)
    task.wait(0.5)
    PlayerList, PlayerMapping = GetPlayerListWithDisplay()
    pcall(function() PlayerDropdown:Refresh(PlayerList) end)
end)

Players.PlayerRemoving:Connect(function(plr)
    task.wait(0.5)
    PlayerList, PlayerMapping = GetPlayerListWithDisplay()
    if TpPlayer == plr.Name then TpPlayer = nil end
    pcall(function() PlayerDropdown:Refresh(PlayerList) end)
end)

main:CreateButton({
    Name = "Refresh Player List",
    Callback = function()
        PlayerList, PlayerMapping = GetPlayerListWithDisplay()
        pcall(function() PlayerDropdown:Refresh(PlayerList) end)
        Rayfield:Notify({Title = "Success", Content = "Player list refreshed!", Duration = 2})
    end
})

main:CreateButton({
    Name = "Teleport To Player",
    Callback = function()
        if not TpPlayer then
            Rayfield:Notify({Title = "Error", Content = "Please select a player first!", Duration = 3})
            return
        end
        local targetPlayer = Players:FindFirstChild(TpPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 1)
            end)
        else
            Rayfield:Notify({Title = "Error", Content = "Target or your character data missing!", Duration = 3})
        end
    end
})

main:CreateSlider({
    Name = "Speed",
    Range = {0, 1000},
    Increment = 1,
    Suffix = "",
    CurrentValue = 16,
    Callback = function(v)
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = v end)
    end
})

main:CreateSlider({
    Name = "Jump",
    Range = {0, 1000},
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    Callback = function(v)
        pcall(function() LocalPlayer.Character.Humanoid.JumpPower = v end)
    end
})

main:CreateToggle({
    Name = "Disable PopUp Coin & Chi",
    CurrentValue = false,
    Callback = function(state)
        pcall(function()
            LocalPlayer.PlayerGui.statEffectsGui.Enabled = not state
            LocalPlayer.PlayerGui.hoopGui.Enabled = not state
        end)
    end
})

main:CreateToggle({
    Name = "Invisibility",
    CurrentValue = false,
    Callback = function(state)
        _G.invis = state
        if state then
            task.spawn(function()
                while _G.invis do
                    pcall(function()
                        LocalPlayer.ninjaEvent:FireServer("goInvisible")
                    end)
                    task.wait(0.2)
                end
            end)
        end
    end
})

farm:CreateSection("Auto Farm")

farm:CreateToggle({
    Name = "Auto Swing",
    CurrentValue = false,
    Callback = function(state)
        _G.swing = state
        if state then
            task.spawn(function()
                while _G.swing do
                    pcall(function()
                        LocalPlayer.ninjaEvent:FireServer("swingKatana")
                    end)
                    task.wait(0.05)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Sell",
    CurrentValue = false,
    Callback = function(state)
        _G.sell = state
        if state then
            task.spawn(function()
                while _G.sell do
                    pcall(function()
                        if workspace.sellAreaCircles:FindFirstChild("sellAreaCircle15") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            workspace.sellAreaCircles["sellAreaCircle15"].circleInner.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                            task.wait(0.1)
                            workspace.sellAreaCircles["sellAreaCircle15"].circleInner.CFrame = workspace.Part.CFrame
                        end
                    end)
                    task.wait(0.2)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Sell When Full",
    CurrentValue = false,
    Callback = function(state)
        _G.sellFull = state
        if state then
            task.spawn(function()
                while _G.sellFull do
                    pcall(function()
                        if LocalPlayer.PlayerGui.gameGui.maxNinjitsuMenu.Visible and workspace.sellAreaCircles:FindFirstChild("sellAreaCircle15") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            workspace.sellAreaCircles["sellAreaCircle15"].circleInner.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                            task.wait(0.1)
                            workspace.sellAreaCircles["sellAreaCircle15"].circleInner.CFrame = workspace.Part.CFrame
                        end
                    end)
                    task.wait(0.5)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Buy Sword",
    CurrentValue = false,
    Callback = function(state)
        _G.sw = state
        if state then
            task.spawn(function()
                while _G.sw do
                    pcall(function() LocalPlayer.ninjaEvent:FireServer("buyAllSwords", "Blazing Vortex Island") end)
                    task.wait(0.5)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Buy Belts",
    CurrentValue = false,
    Callback = function(state)
        _G.belt = state
        if state then
            task.spawn(function()
                while _G.belt do
                    pcall(function() LocalPlayer.ninjaEvent:FireServer("buyAllBelts", "Blazing Vortex Island") end)
                    task.wait(0.5)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Buy Skills",
    CurrentValue = false,
    Callback = function(state)
        _G.sk = state
        if state then
            task.spawn(function()
                while _G.sk do
                    pcall(function() LocalPlayer.ninjaEvent:FireServer("buyAllSkills", "Blazing Vortex Island") end)
                    task.wait(0.5)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Buy Ranks",
    CurrentValue = false,
    Callback = function(state)
        _G.r = state
        if state then
            task.spawn(function()
                while _G.r do
                    pcall(function()
                        local oh2 = game:GetService("ReplicatedStorage").Ranks.Ground:GetChildren()
                        for i = 1, #oh2 do
                            if not _G.r then break end
                            LocalPlayer.ninjaEvent:FireServer("buyRank", oh2[i].Name)
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Buy Shurikens",
    CurrentValue = false,
    Callback = function(state)
        _G.sh = state
        if state then
            task.spawn(function()
                while _G.sh do
                    pcall(function() LocalPlayer.ninjaEvent:FireServer("buyAllShurikens", "Blazing Vortex Island") end)
                    task.wait(0.5)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Farm Chi",
    CurrentValue = false,
    Callback = function(state)
        _G.c = state
        if state then
            task.spawn(function()
                while _G.c do
                    pcall(function()
                        if game.Workspace.spawnedCoins:FindFirstChild("Valley") then
                            for _, v in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
                                if not _G.c then break end
                                if v.Name == "Blue Chi Crate" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                                    task.wait(0.2)
                                end
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Farm Coin",
    CurrentValue = false,
    Callback = function(state)
        _G.co = state
        if state then
            task.spawn(function()
                while _G.co do
                    pcall(function()
                        if game.Workspace.spawnedCoins:FindFirstChild("Valley") then
                            for _, v in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
                                if not _G.co then break end
                                if v.Name == "Purple Coin Crate" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                                    task.wait(0.2)
                                end
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end
})

farm:CreateToggle({
    Name = "Auto Hoops",
    CurrentValue = false,
    Callback = function(state)
        _G.hoops = state
        if state then
            task.spawn(function()
                while _G.hoops do
                    pcall(function()
                        if workspace:FindFirstChild("Hoops") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            for _, v in pairs(workspace.Hoops:GetDescendants()) do
                                if not _G.hoops then break end
                                if v.ClassName == "MeshPart" and v:FindFirstChild("touchPart") then
                                    v.touchPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                                end
                            end
                        end
                    end)
                    task.wait(0.3)
                end
            end)
        end
    end
})

local ISLAND = {}
pcall(function()
    for _, v in pairs(game.workspace.islandUnlockParts:GetChildren()) do
        table.insert(ISLAND, v.Name)
    end
end)

tp:CreateSection("Island")

tp:CreateDropdown({
    Name = "Teleports",
    Options = ISLAND,
    CurrentOption = {},
    MultipleOptions = false,
    Callback = function(a)
        pcall(function()
            if game.Workspace.islandUnlockParts:FindFirstChild(a) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.islandUnlockParts[a].islandSignPart.CFrame
            end
        end)
    end
})

tp:CreateButton({
    Name = "Unlock All Island",
    Callback = function()
        task.spawn(function()
            for _, v in next, game.workspace.islandUnlockParts:GetChildren() do
                pcall(function()
                    if v and v:FindFirstChild("islandSignPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame
                    end
                end)
                task.wait(0.3)
            end
        end)
    end
})

egg:CreateSection("Crystal")

local Crystal = {}
pcall(function()
    for _, v in pairs(game.workspace.mapCrystalsFolder:GetChildren()) do
        table.insert(Crystal, v.Name)
    end
end)

egg:CreateDropdown({
    Name = "Select Crystal",
    Options = Crystal,
    CurrentOption = {},
    MultipleOptions = false,
    Callback = function(value)
        _G.cryEgg = value
    end
})

egg:CreateToggle({
    Name = "Open Crystal",
    CurrentValue = false,
    Callback = function(state)
        _G.cCry = state
        if state then
            task.spawn(function()
                while _G.cCry do
                    pcall(function()
                        if _G.cryEgg then
                            game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", _G.cryEgg)
                        end
                    end)
                    task.wait(0.3)
                end
            end)
        end
    end
})

egg:CreateToggle({
    Name = "Auto Evolved Pet",
    CurrentValue = false,
    Callback = function(state)
        _G.ePet = state
        if state then
            task.spawn(function()
                while _G.ePet do
                    pcall(function()
                        if LocalPlayer:FindFirstChild("petsFolder") then
                            for _, v in pairs(LocalPlayer.petsFolder:GetChildren()) do
                                for _, x in pairs(v:GetChildren()) do
                                    if not _G.ePet then break end
                                    game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", x.Name)
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

misc:CreateSection("Misc")

misc:CreateToggle({
    Name = "Inf Double Jump",
    CurrentValue = false,
    Callback = function(state)
        _G.iJump = state
        if state then
            task.spawn(function()
                while _G.iJump do
                    pcall(function()
                        if LocalPlayer:FindFirstChild("multiJumpCount") then
                            LocalPlayer.multiJumpCount.Value = 9999999
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end
})

misc:CreateButton({
    Name = "Get All Elements",
    Callback = function()
        pcall(function()
            local elements = {"Frost", "Inferno", "Lightning", "Electral Chaos", "Masterful Wrath", "Shadow Charge", "Shadowfire", "Eternity Storm", "Blazing Entity"}
            for _, el in pairs(elements) do
                game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(el)
            end
        end)
    end
})

local InfiniteJumpEnabled = false
misc:CreateToggle({
    Name = "Inf Jump",
    CurrentValue = false,
    Callback = function(state)
        InfiniteJumpEnabled = state
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
            end
        end)
    end
end)

misc:CreateButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

Rayfield:LoadConfiguration()
