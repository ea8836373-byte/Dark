-- =======================================================================
-- 👑 SERVIZI DI SISTEMA ROBLOX NATIVI
-- =======================================================================
local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local StatsService = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RealAntiAFKEnabled = false
local CurrentFPS = 60
local InputKeyData = "" 
local HubUnlocked = false 

-- CALCOLO FPS REALI AD ALTA PRECISIONE
task.spawn(function()
    local LastTime = os.clock()
    RunService.RenderStepped:Connect(function()
        local CurrentTime = os.clock()
        local TimeDelta = CurrentTime - LastTime
        LastTime = CurrentTime
        if TimeDelta > 0 then
            CurrentFPS = math.floor(1 / TimeDelta)
        end
    end)
end)

-- ANTI-AFK ENGINE ANTI-KICK
RunService.Stepped:Connect(function()
    if RealAntiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end
end)

-- FUNZIONE DI CONTROLLO OCCUPAZIONE REALE DELLA MACCHINA
local function isMachineOccupied(machine)
    if not machine then return true end
    
    local inUse = machine:FindFirstChild("InUse") or machine:FindFirstChild("Occupied")
    if inUse and inUse.Value == true and inUse.Value ~= LocalPlayer.Name then
        return true
    end
    
    local seat = machine:FindFirstChildOfClass("Seat") or machine:FindFirstChildOfClass("VehicleSeat")
    if seat and seat.Occupant then
        return true
    end
    
    return false
end

-- CARICAMENTO LIBRERIA RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "💪 Divine Hub | Muscle Masters",
   LoadingTitle = "Divine Hub Loader",
   LoadingSubtitle = "by @Sulfrax",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   DisableRayfieldPrompts = true,
   NoIntro = true, 
   Theme = "CustomTheme",
   CustomTheme = {
       TextColor = Color3.fromRGB(255, 255, 255),
       AccentColor = Color3.fromRGB(255, 75, 75),
       BackgroundColor = Color3.fromRGB(15, 15, 15),
       BackgroundSecondary = Color3.fromRGB(25, 25, 25),
       ElementColor = Color3.fromRGB(35, 30, 30)
   }
})

-- ==========================================
-- 🔑 CREAZIONE TAB KEY SYSTEM INTEGRATA
-- ==========================================
local KeyTab = Window:CreateTab("🔑 Key System", 4483362458)

local FarmTab, StatsTab, SettingsTab
local AutoStrength = false
local AutoSpin = false
local AutoGlitch = false
local AutoRewards = false
local AutoChocolate = false
local AutoRebirth = false

KeyTab:CreateSection("Verify your Identity")

KeyTab:CreateInput({
   Name = "Enter Secret Key",
   PlaceholderText = "Paste your key here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      InputKeyData = Text
   end,
})

KeyTab:CreateButton({
   Name = "Verify Key",
   Callback = function()
      if HubUnlocked then return end

      if InputKeyData == "DivineHub" then
         HubUnlocked = true 
         
         Rayfield:Notify({
            Title = "🔑 KEY CORRECT!",
            Content = "Unlocking Divine Hub... Please wait.",
            Duration = 3,
            Image = 4483362458,
         })
         
         task.wait(0.5)
         
         -- ==========================================
         -- 🔓 SBLOCCO DELLE TAB (Generazione e Forzatura Refresh Grafico)
         -- ==========================================
         FarmTab = Window:CreateTab("🏠 Farm", 4483362458)
         StatsTab = Window:CreateTab("📊 Stats", 4483362458)
         SettingsTab = Window:CreateTab("⚙️ Settings", 4483362458)

         -- ------------------------------------------
         -- CONTENUTO TAB 1: FARM
         -- ------------------------------------------
         FarmTab:CreateToggle({
            Name = "Auto Strength Lift",
            CurrentValue = false,
            Flag = "ToggleStrength",
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
            end,
         })

         FarmTab:CreateToggle({
            Name = "Auto Spin",
            CurrentValue = false,
            Flag = "ToggleSpin",
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
            end,
         })

         FarmTab:CreateToggle({
            Name = "Auto Glitch",
            CurrentValue = false,
            Flag = "ToggleGlitch",
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
            end,
          })

         FarmTab:CreateToggle({
            Name = "Auto Claim Rewards",
            CurrentValue = false,
            Flag = "ToggleRewards",
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
            end,
         })

         FarmTab:CreateToggle({
            Name = "Auto Eat Chocolate",
            CurrentValue = false,
            Flag = "ToggleChocolate",
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
            end,
         })

         FarmTab:CreateToggle({
            Name = "Auto Rebirth",
            CurrentValue = false,
            Flag = "ToggleRebirth",
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
            end,
         })

         -- ------------------------------------------
         -- CONTENUTO TAB 2: STATS
         -- ------------------------------------------
         StatsTab:CreateSection("👤 Muscle Masters Live Profile")
         local StrengthLabel = StatsTab:CreateLabel("💪 Strength: 0")
         local EnduranceLabel = StatsTab:CreateLabel("🔋 Endurance: 0")
         local MobilityLabel = StatsTab:CreateLabel("⚡ Mobility: 0")
         local RebirthsLabel = StatsTab:CreateLabel("✨ Rebirths: 0")
         local KillsLabel = StatsTab:CreateLabel("⚔️ Kills: 0")

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
                 local str = getMuscleStat("Strength") or "0"
                 local endur = getMuscleStat("Endurance") or "0"
                 local mob = getMuscleStat("Mobility") or "0"
                 local reb = getMuscleStat("Rebirths") or "0"
                 local kils = getMuscleStat("Kills") or "0"

                 StrengthLabel:Set("💪 Strength: " .. str)
                 EnduranceLabel:Set("🔋 Endurance: " .. endur)
                 MobilityLabel:Set("⚡ Mobility: " .. mob)
                 RebirthsLabel:Set("✨ Rebirths: " .. reb)
                 KillsLabel:Set("⚔️ Kills: " .. kils)
                 task.wait(0.3)
             end
         end)

         -- ------------------------------------------
         -- CONTENUTO TAB 3: SETTINGS & ANTI-AFK WINDOW
         -- ------------------------------------------
         SettingsTab:CreateSection("💤 AFK Framework")
         SettingsTab:CreateButton({
            Name = "Activate Real Anti-AFK Window",
            Callback = function()
               if CoreGui:FindFirstChild("Divine_AntiAFK") then return end
               RealAntiAFKEnabled = true
               
               local ScreenGui = Instance.new("ScreenGui")
               local MainFrame = Instance.new("Frame")
               local Title = Instance.new("TextLabel")
               local FpsLabel = Instance.new("TextLabel")
               local PingLabel = Instance.new("TextLabel")
               local StatusLabel = Instance.new("TextLabel")
               local DeactivateBtn = Instance.new("TextButton")
               local Corner = Instance.new("UICorner")
               local BtnCorner = Instance.new("UICorner")

               ScreenGui.Name = "Divine_AntiAFK"
               ScreenGui.Parent = CoreGui
               ScreenGui.ResetOnSpawn = false

               MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
               MainFrame.BorderColor3 = Color3.fromRGB(255, 75, 75)
               MainFrame.BorderSizePixel = 2
               MainFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
               MainFrame.Size = UDim2.new(0, 300, 0, 220)
               MainFrame.Active = true
               MainFrame.Draggable = true
               MainFrame.Parent = ScreenGui

               Corner.CornerRadius = UDim.new(0, 12)
               Corner.Parent = MainFrame

               Title.Name = "AntiAFKTitle"
               Title.Size = UDim2.new(1, 0, 0, 40)
               Title.BackgroundTransparency = 1
               Title.Text = "Divine ANTI-AFK"
               Title.TextColor3 = Color3.fromRGB(255, 75, 75)
               Title.TextSize = 20
               Title.Font = Enum.Font.SourceSansBold
               Title.Parent = MainFrame

               StatusLabel.Position = UDim2.new(0, 0, 0, 45)
               StatusLabel.Size = UDim2.new(1, 0, 0, 25)
               StatusLabel.BackgroundTransparency = 1
               StatusLabel.Text = "ANTI-KICK WORK: ACTIVE ✅"
               StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
               StatusLabel.TextSize = 15
               StatusLabel.Font = Enum.Font.SourceSansSemibold
               StatusLabel.Parent = MainFrame

               FpsLabel.Position = UDim2.new(0, 0, 0, 80)
               FpsLabel.Size = UDim2.new(1, 0, 0, 30)
               FpsLabel.BackgroundTransparency = 1
               FpsLabel.Text = "FPS: 60"
               FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
               FpsLabel.TextSize = 16
               FpsLabel.Font = Enum.Font.SourceSans
               FpsLabel.Parent = MainFrame

               PingLabel.Position = UDim2.new(0, 0, 0, 115)
               PingLabel.Size = UDim2.new(1, 0, 0, 30)
               PingLabel.BackgroundTransparency = 1
               PingLabel.Text = "PING: -- ms"
               PingLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
               PingLabel.TextSize = 16
               PingLabel.Font = Enum.Font.SourceSans
               PingLabel.Parent = MainFrame

               DeactivateBtn.Position = UDim2.new(0.1, 0, 0.73, 0)
               DeactivateBtn.Size = UDim2.new(0, 240, 0, 40)
               DeactivateBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
               DeactivateBtn.Text = "Turn Off AFK"
               DeactivateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
               DeactivateBtn.TextSize = 16
               DeactivateBtn.Font = Enum.Font.SourceSansBold
               DeactivateBtn.Parent = MainFrame
               
               BtnCorner.CornerRadius = UDim.new(0, 8)
               BtnCorner.Parent = DeactivateBtn

               local updateConnection
               updateConnection = RunService.Heartbeat:Connect(function()
                   if not RealAntiAFKEnabled or not ScreenGui.Parent then
                       if updateConnection then updateConnection:Disconnect() end
                       return
                   end
                   local rawPing = StatsService.Network.ServerToClientPing:GetValue() * 1000
                   PingLabel.Text = "PING: " .. string.format("%.0f", rawPing) .. " ms"
                   FpsLabel.Text = "FPS: " .. tostring(CurrentFPS)
               end)

               DeactivateBtn.MouseButton1Click:Connect(function()
                   RealAntiAFKEnabled = false
                   if updateConnection then updateConnection:Disconnect() end
                   ScreenGui:Destroy()
                   Rayfield:Notify({Title = "Divine Hub", Content = "Anti-AFK deactivated.", Duration = 3})
               end)
            end
         })

         -- CRITICO: Forza Rayfield a spostarsi sulla Tab Farm e a ricostruire la sidebar dei bottoni
         task.wait(0.1)
         FarmTab:Select()
         
         -- Rimuove la tab del key system vecchio dal menu per pulizia completa
         KeyTab:Destroy()
      else
         Rayfield:Notify({
            Title = "❌ ACCESS DENIED",
            Content = "The key entered is incorrect. Try again!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})
