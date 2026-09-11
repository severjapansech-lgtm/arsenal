-- Global Team Configuration
getgenv().team = getgenv().team or "Pirates" -- Options: "Pirates" , "Marines"

-- Auto-Join Team Logic
local function AutoJoinTeam()
    local player = game:GetService("Players").LocalPlayer
    local targetTeam = getgenv().team
    
    if player.Team == nil or player.Team.Name ~= targetTeam then
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local commF = replicatedStorage:FindFirstChild("CommF_", true)
        
        if commF then
            pcall(function()
                if targetTeam == "Pirates" then
                    commF:InvokeServer("SetTeam", "Pirates")
                elseif targetTeam == "Marines" then
                    commF:InvokeServer("SetTeam", "Marines")
                end
            end)
        end
    end
end

-- Execute Team Join
task.spawn(AutoJoinTeam)

-- Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- Configuration Persistence Engine
local ConfigFile = "binxdev_chest_config.json"

local DefaultConfig = {
    Mode = "Fly",
    AutoFarm = true,
    FlySpeed = 120,
    TeleportDelay = 0.8,
    AutoServerHop = true,
    Team = getgenv().team
}

local function SaveSettings(config)
    if writefile then
        writefile(ConfigFile, HttpService:JSONEncode(config))
    end
end

local function LoadSettings()
    if readfile and isfile and isfile(ConfigFile) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(ConfigFile))
        end)
        if success and type(result) == "table" then
            return result
        end
    end
    return DefaultConfig
end

local State = LoadSettings()
getgenv().team = State.Team or getgenv().team

-- Queue Script Re-Execution Across Server Hop
local function QueueScriptOnTeleport()
    local queueFunction = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
    if queueFunction then
        local autoExecScript = string.format([[
            getgenv().team = "%s"
            task.wait(3)
            loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
        ]], getgenv().team)
        
        -- Note: Replace URL below with your raw GitHub/Gist script link if hosting externally
        queueFunction([[
            getgenv().team = "]] .. getgenv().team .. [["
            print("[binxdev] Auto-reloaded script after server hop, boss man.")
        ]])
    end
end

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Movement Handle
local CurrentTween = nil

-- UI Setup
local Window = Rayfield:CreateWindow({
    Name = "binxdev | Chest Collector Pro",
    LoadingTitle = "binxdev Framework",
    LoadingSubtitle = "Blox Fruits Utility",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Auto Farm", 4483362458)
local ConfigTab = Window:CreateTab("Settings", 4483362458)

-- Helper: Retrieve Character Root
local function GetRoot()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        return char.HumanoidRootPart
    end
    return nil
end

-- Helper: Count Remaining Chests
local function GetChests()
    local chestModels = Workspace:FindFirstChild("ChestModels")
    if not chestModels then return {} end
    
    local validChests = {}
    for _, chest in ipairs(chestModels:GetChildren()) do
        if chest:IsA("BasePart") or chest:IsA("Model") then
            table.insert(validChests, chest)
        end
    end
    return validChests
end

-- Movement Engine: Instant Teleport
local function TeleportTo(targetCFrame)
    local root = GetRoot()
    if root then
        root.CFrame = targetCFrame
    end
end

-- Movement Engine: Smooth Fly (TweenService)
local function FlyTo(targetCFrame)
    local root = GetRoot()
    if not root then return false end

    local distance = (targetCFrame.Position - root.Position).Magnitude
    local duration = distance / math.max(State.FlySpeed, 20)

    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    CurrentTween = TweenService:Create(root, tweenInfo, { CFrame = targetCFrame })
    CurrentTween:Play()

    local startTime = tick()
    while tick() - startTime < duration do
        if not State.AutoFarm or State.Mode ~= "Fly" then
            if CurrentTween then CurrentTween:Cancel() end
            return false
        end
        task.wait(0.05)
    end
    return true
end

-- Server Hop Engine
local function HopServer()
    SaveSettings(State)
    QueueScriptOnTeleport()

    Rayfield:Notify({
        Title = "Server Hop",
        Content = "Hopping server & saving config, boss man...",
        Duration = 5,
        Image = 4483362458,
    })
    
    task.wait(1.5)
    
    local placeId = game.PlaceId
    local serversApi = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(serversApi))
    end)
    
    if success and result and result.data then
        for _, server in ipairs(result.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(placeId, server.id, LocalPlayer)
                return
            end
        end
    end
    
    TeleportService:Teleport(placeId, LocalPlayer)
end

-- Primary Execution Loop
task.spawn(function()
    while true do
        task.wait(0.5)

        if State.AutoFarm then
            local chests = GetChests()

            if #chests == 0 then
                if State.AutoServerHop then
                    HopServer()
                    break
                else
                    Rayfield:Notify({
                        Title = "Chest Status",
                        Content = "All chests collected on this server, boss man.",
                        Duration = 4,
                        Image = 4483362458,
                    })
                    State.AutoFarm = false
                    SaveSettings(State)
                end
            else
                for _, chest in ipairs(chests) do
                    if not State.AutoFarm then break end

                    local targetPart = chest:IsA("BasePart") and chest or (chest.PrimaryPart or chest:FindFirstChildWhichIsA("BasePart"))

                    if targetPart then
                        local destination = targetPart.CFrame * CFrame.new(0, 3, 0)

                        if State.Mode == "Fly" then
                            local arrived = FlyTo(destination)
                            if arrived then task.wait(0.2) end
                        elseif State.Mode == "Teleport" then
                            TeleportTo(destination)
                            task.wait(State.TeleportDelay)
                        end
                    end
                end
            end
        end
    end
end)

-- Main Controls UI
MainTab:CreateToggle({
    Name = "Enable Auto Chest Farm",
    CurrentValue = State.AutoFarm,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        State.AutoFarm = Value
        if not Value and CurrentTween then
            CurrentTween:Cancel()
        end
        SaveSettings(State)
    end,
})

MainTab:CreateDropdown({
    Name = "Select Team",
    Options = {"Pirates", "Marines"},
    CurrentOption = State.Team,
    Flag = "TeamDropdown",
    Callback = function(Option)
        local selected = type(Option) == "table" and Option[1] or Option
        getgenv().team = selected
        State.Team = selected
        AutoJoinTeam()
        SaveSettings(State)
    end,
})

MainTab:CreateDropdown({
    Name = "Movement Mode",
    Options = {"Fly", "Teleport"},
    CurrentOption = State.Mode,
    Flag = "ModeDropdown",
    Callback = function(Option)
        State.Mode = type(Option) == "table" and Option[1] or Option
        if CurrentTween then CurrentTween:Cancel() end
        SaveSettings(State)
    end,
})

MainTab:CreateToggle({
    Name = "Auto Server Hop When Finished",
    CurrentValue = State.AutoServerHop,
    Flag = "AutoHopToggle",
    Callback = function(Value)
        State.AutoServerHop = Value
        SaveSettings(State)
    end,
})

-- Configuration Settings Controls
ConfigTab:CreateSlider({
    Name = "Fly Speed (Studs/sec)",
    Range = {30, 350},
    Increment = 10,
    Suffix = " studs/s",
    CurrentValue = State.FlySpeed,
    Flag = "FlySpeedSlider",
    Callback = function(Value)
        State.FlySpeed = Value
        SaveSettings(State)
    end,
})

ConfigTab:CreateSlider({
    Name = "Teleport Delay (Seconds)",
    Range = {0.1, 2.0},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = State.TeleportDelay,
    Flag = "TPDelaySlider",
    Callback = function(Value)
        State.TeleportDelay = Value
        SaveSettings(State)
    end,
})

ConfigTab:CreateButton({
    Name = "Manual Server Hop",
    Callback = function()
        HopServer()
    end,
})

-- Notification
Rayfield:Notify({
    Title = "binxdev Chest Pro",
    Content = "Settings restored. Team set to " .. getgenv().team .. ", boss man.",
    Duration = 5,
    Image = 4483362458,
})
