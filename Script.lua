local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local torso = char:WaitForChild("Torso")
local mouse = lp:GetMouse()
local UIS = game:GetService("UserInputService")

local transformed, flying, attacking = false, false, false
local katanaOn, gunOn = false, false
local katana, gun

-- --- ESTETICA ---
local function ApplyLook()
    if char.Head:FindFirstChild("face") then char.Head.face:Destroy() end
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") then v.Color = Color3.new(0,0,0); v.Material = Enum.Material.SmoothPlastic end
        if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Destroy() end
    end
    local function Eye(side)
        local e = Instance.new("Part", char)
        e.Size = Vector3.new(0.4, 0.4, 0.4); e.Color = Color3.new(1,0,0); e.Material = Enum.Material.Neon; e.CanCollide = false
        local m = Instance.new("SpecialMesh", e); m.MeshType = Enum.MeshType.Sphere
        local w = Instance.new("Weld", e); w.Part0 = char.Head; w.Part1 = e; w.C0 = CFrame.new(side * 0.25, 0.2, -0.6)
    end
    Eye(1) Eye(-1)
end

-- --- MOTORE ANIMAZIONI ---
task.spawn(function()
    while task.wait() do
        if transformed and not attacking then
            local rS = torso:FindFirstChild("Right Shoulder")
            local lS = torso:FindFirstChild("Left Shoulder")
            local rJ = root:FindFirstChild("RootJoint")
            
            if flying and rS and lS and rJ then
                -- SUPERMAN POSITION
                rJ.C0 = rJ.C0:Lerp(CFrame.Angles(math.rad(-90), 0, 0), 0.1)
                rS.C0 = rS.C0:Lerp(CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(180), 0, 0), 0.1)
                lS.C0 = lS.C0:Lerp(CFrame.new(-1.5, 0.5, 0), 0.1)
            elseif rS and lS and rJ then
                -- IDLE POSES
                rJ.C0 = rJ.C0:Lerp(CFrame.new(0,0,0) * CFrame.Angles(math.rad(-90), 0, math.rad(180)), 0.1)
                if katanaOn then
                    rS.C0 = rS.C0:Lerp(CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), 0, 0), 0.1)
                elseif gunOn then
                    rS.C0 = rS.C0:Lerp(CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(90), math.rad(90), 0), 0.1)
                else
                    rS.C0 = rS.C0:Lerp(CFrame.new(1.5, 0.5, 0), 0.1)
                end
                lS.C0 = lS.C0:Lerp(CFrame.new(-1.5, 0.5, 0), 0.1)
            end
        end
    end
end)

-- --- EQUIPAGGIAMENTO ---
local function ToggleKatana()
    if not transformed or flying then return end
    if katanaOn then katana:Destroy(); katanaOn = false else
        if gunOn then gun:Destroy(); gunOn = false end
        katanaOn = true
        katana = Instance.new("Part", char)
        katana.Name = "Katana"
        katana.Size = Vector3.new(1, 1, 5)
        katana.Color = Color3.new(1, 0, 0)
        katana.Material = Enum.Material.Neon
        katana.CanCollide = false
        local m = Instance.new("SpecialMesh", katana)
        m.MeshId = "rbxassetid://11442510"
        m.Scale = Vector3.new(0.1, 0.25, 0.08)
        local w = Instance.new("Weld", katana)
        w.Part0 = char["Right Arm"]
        w.Part1 = katana
        w.C0 = CFrame.new(0, -2, 0) * CFrame.Angles(math.rad(90), 0, math.rad(180))
        
        katana.Touched:Connect(function(hit)
            if attacking and hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= char then
                local eRoot = hit.Parent:FindFirstChild("HumanoidRootPart")
                if eRoot then -- EFFETTO FLING
                    local v = Instance.new("BodyVelocity", eRoot)
                    v.MaxForce = Vector3.new(1e8, 1e8, 1e8)
                    v.Velocity = (eRoot.Position - root.Position).unit * 300 + Vector3.new(0, 50, 0)
                    game:GetService("Debris"):AddItem(v, 0.2)
                end
            end
        end)
    end
end

local function ToggleGun()
    if not transformed or flying then return end
    if gunOn then gun:Destroy(); gunOn = false else
        if katanaOn then katana:Destroy(); katanaOn = false end
        gunOn = true
        gun = Instance.new("Part", char)
        gun.Size = Vector3.new(1, 1, 2)
        gun.Color = Color3.new(0.1, 0.1, 0.1)
        gun.CanCollide = false
        local m = Instance.new("SpecialMesh", gun)
        m.MeshId = "rbxassetid://4302196603"
        m.Scale = Vector3.new(0.012, 0.012, 0.012)
        local w = Instance.new("Weld", gun)
        w.Part0 = char["Right Arm"]
        w.Part1 = gun
        w.C0 = CFrame.new(0, -1, -0.8) * CFrame.Angles(0, math.rad(180), 0)
    end
end

-- --- ATTACCHI ---
local function AttackSpada() -- ANIMAZIONE CLASSICA VELOCE
    if not katanaOn or attacking then return end
    attacking = true
    local rs = torso["Right Shoulder"]
    local oldC0 = rs.C0
    -- Fendente veloce
    rs.C0 = oldC0 * CFrame.Angles(math.rad(120), 0, 0)
    task.wait(0.1)
    rs.C0 = oldC0 * CFrame.Angles(math.rad(-60), 0, 0)
    task.wait(0.2)
    rs.C0 = oldC0
    attacking = false
end

local function ShootPistola() -- SPIN + KILL
    if not gunOn or attacking then return end
    attacking = true
    local rs = torso["Right Shoulder"]
    
    -- SPIN BRACCIO (Ogni colpo)
    for i = 1, 10 do
        rs.C0 = rs.C0 * CFrame.Angles(math.rad(36), 0, 0)
        task.wait(0.01)
    end
    
    -- PROIETTILE KILL
    local b = Instance.new("Part", workspace)
    b.Size = Vector3.new(0.5, 0.5, 4)
    b.Color = Color3.new(1, 0, 0)
    b.Material = Enum.Material.Neon
    b.CanCollide = false
    b.CFrame = CFrame.new(gun.Position, mouse.Hit.p)
    local bv = Instance.new("BodyVelocity", b)
    bv.Velocity = b.CFrame.LookVector * 1000
    
    b.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChild("Humanoid") and hit.Parent ~= char then
            hit.Parent:BreakJoints() -- KILL FE
            b:Destroy()
        end
    end)
    game:GetService("Debris"):AddItem(b, 2)
    task.wait(0.1)
    attacking = false
end

-- --- VOLO ---
local function ToggleFly()
    if not transformed then return end
    flying = not flying
    if flying then
        if katanaOn then katana:Destroy(); katanaOn = false end
        if gunOn then gun:Destroy(); gunOn = false end
        local bp = Instance.new("BodyPosition", root)
        bp.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bp.Position = root.Position + Vector3.new(0, 50, 0)
        local bg = Instance.new("BodyGyro", root)
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        hum.PlatformStand = true
        task.spawn(function()
            while flying do
                bp.Position = root.Position + (hum.MoveDirection * 15) + Vector3.new(0, 1, 0)
                bg.CFrame = CFrame.new(root.Position, mouse.Hit.p) * CFrame.Angles(math.rad(-90), 0, 0)
                task.wait()
            end
            bp:Destroy(); bg:Destroy(); hum.PlatformStand = false
        end)
    end
end

-- --- INPUTS ---
UIS.InputBegan:Connect(function(k, g)
    if g then return end
    if k.KeyCode == Enum.KeyCode.T then transformed = true; ApplyLook(); hum.WalkSpeed = 65 end
    if k.KeyCode == Enum.KeyCode.Q then ToggleKatana() end
    if k.KeyCode == Enum.KeyCode.N then ToggleGun() end
    if k.KeyCode == Enum.KeyCode.P then AttackSpada() end
    if k.KeyCode == Enum.KeyCode.B then ShootPistola() end
    if k.KeyCode == Enum.KeyCode.K then ToggleFly() end
end)
