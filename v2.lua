local KEY_DUNG = "NgMinhAnh"

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RainbowFireKeySystem"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Nền đen mờ toàn màn hình
local background = Instance.new("Frame", gui)
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.3
background.ZIndex = 0

-- Container chính
local container = Instance.new("Frame", gui)
container.Size = UDim2.new(0, 450, 0, 320)
container.Position = UDim2.new(0.5, -225, 0.5, -160)
container.BackgroundTransparency = 1
container.ZIndex = 1

-- Hiệu ứng lửa nền
local fireBackground = Instance.new("Frame", container)
fireBackground.Size = UDim2.new(1, 0, 1, 0)
fireBackground.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
fireBackground.ZIndex = 1

local fireCorner = Instance.new("UICorner", fireBackground)
fireCorner.CornerRadius = UDim.new(0, 25)

-- Animation lửa (particles)
local fireParticles = Instance.new("Frame", fireBackground)
fireParticles.Size = UDim2.new(1, 0, 1, 0)
fireParticles.BackgroundTransparency = 1
fireParticles.ZIndex = 2

-- Tạo nhiều layer particles cho hiệu ứng lửa
for i = 1, 5 do
    local particleLayer = Instance.new("Frame", fireParticles)
    particleLayer.Size = UDim2.new(1, 0, 1, 0)
    particleLayer.BackgroundTransparency = 1
    particleLayer.ClipsDescendants = true
    
    spawn(function()
        while gui.Parent do
            local particle = Instance.new("Frame", particleLayer)
            particle.Size = UDim2.new(0, math.random(20, 60), 0, math.random(40, 80))
            particle.Position = UDim2.new(math.random(), 0, 1, 0)
            particle.BackgroundTransparency = 0.7
            particle.ZIndex = 2
            
            -- Gradient cầu vồng cho particle
            local particleGradient = Instance.new("UIGradient", particle)
            local hue = math.random() * 360
            particleGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHSV(hue/360, 0.8, 1)),
                ColorSequenceKeypoint.new(0.5, Color3.fromHSV((hue+30)/360, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV((hue+60)/360, 0.8, 0.5))
            })
            particleGradient.Rotation = 90
            
            local particleCorner = Instance.new("UICorner", particle)
            particleCorner.CornerRadius = UDim.new(1, 0)
            
            -- Animation particle bay lên
            local tween = game:GetService("TweenService"):Create(particle, TweenInfo.new(math.random(1, 2)), {
                Position = UDim2.new(particle.Position.X.Scale, particle.Position.X.Offset, -0.5, 0),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, particle.Size.X.Offset * 0.5, 0, particle.Size.Y.Offset * 0.3)
            })
            tween:Play()
            
            tween.Completed:Connect(function()
                particle:Destroy()
            end)
            
            wait(0.1 / i)
        end
    end)
end

-- Frame chính với hiệu ứng thủy tinh
local mainFrame = Instance.new("Frame", container)
mainFrame.Size = UDim2.new(1, -20, 1, -20)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 10, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.ZIndex = 3

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 20)

-- Border cầu vồng động
local rainbowBorder = Instance.new("Frame", mainFrame)
rainbowBorder.Size = UDim2.new(1, 0, 1, 0)
rainbowBorder.BackgroundTransparency = 1
rainbowBorder.ZIndex = 4

local borderGradient = Instance.new("UIGradient", rainbowBorder)
borderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 165, 0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 127, 255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238))
})

local borderStroke = Instance.new("UIStroke", rainbowBorder)
borderStroke.Thickness = 3
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Animation gradient cầu vồng
spawn(function()
    while gui.Parent do
        for i = 0, 1, 0.01 do
            borderGradient.Offset = Vector2.new(i, 0)
            wait(0.03)
        end
    end
end)

-- Title với hiệu ứng lửa
local titleContainer = Instance.new("Frame", mainFrame)
titleContainer.Size = UDim2.new(1, 0, 0, 70)
titleContainer.Position = UDim2.new(0, 0, 0, 10)
titleContainer.BackgroundTransparency = 1
titleContainer.ZIndex = 5

local title = Instance.new("TextLabel", titleContainer)
title.Size = UDim2.new(1, 0, 1, 0)
title.Text = "🔥 RAINBOW KEY ACCESS 🔥"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
title.TextStrokeTransparency = 0.7
title.TextStrokeColor3 = Color3.fromRGB(255, 100, 100)

-- Hiệu ứng title gradient
local titleGradient = Instance.new("UIGradient", title)
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 100))
})

-- Animation title gradient
spawn(function()
    while gui.Parent do
        for i = 0, 1, 0.01 do
            titleGradient.Offset = Vector2.new(i, 0)
            wait(0.05)
        end
    end
end)

local subtitle = Instance.new("TextLabel", titleContainer)
subtitle.Size = UDim2.new(1, 0, 0, 25)
subtitle.Position = UDim2.new(0, 0, 0, 45)
subtitle.Text = "Unlock the Rainbow Power"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
subtitle.BackgroundTransparency = 1
subtitle.Font = Enum.Font.GothamSemibold
subtitle.TextSize = 16
subtitle.TextTransparency = 0.3

-- Input Container với hiệu ứng lửa
local inputContainer = Instance.new("Frame", mainFrame)
inputContainer.Size = UDim2.new(1, -60, 0, 55)
inputContainer.Position = UDim2.new(0, 30, 0, 100)
inputContainer.BackgroundColor3 = Color3.fromRGB(30, 15, 40)
inputContainer.ZIndex = 5

local inputCorner = Instance.new("UICorner", inputContainer)
inputCorner.CornerRadius = UDim.new(0, 15)

-- Hiệu ứng lửa trong input container
local inputFire = Instance.new("Frame", inputContainer)
inputFire.Size = UDim2.new(1, 0, 1, 0)
inputFire.BackgroundTransparency = 1
inputFire.ZIndex = 4

spawn(function()
    while gui.Parent do
        local spark = Instance.new("Frame", inputFire)
        spark.Size = UDim2.new(0, 2, 0, math.random(10, 20))
        spark.Position = UDim2.new(math.random(), 0, 1, 0)
        spark.BackgroundColor3 = Color3.fromHSV(math.random(), 0.8, 1)
        spark.BackgroundTransparency = 0.7
        spark.ZIndex = 4
        
        local sparkCorner = Instance.new("UICorner", spark)
        sparkCorner.CornerRadius = UDim.new(1, 0)
        
        local tween = game:GetService("TweenService"):Create(spark, TweenInfo.new(0.5), {
            Position = UDim2.new(spark.Position.X.Scale, spark.Position.X.Offset, -0.2, 0),
            BackgroundTransparency = 1
        })
        tween:Play()
        
        tween.Completed:Connect(function()
            spark:Destroy()
        end)
        
        wait(0.1)
    end
end)

local keyIcon = Instance.new("ImageLabel", inputContainer)
keyIcon.Size = UDim2.new(0, 35, 0, 35)
keyIcon.Position = UDim2.new(0, 10, 0.5, -17)
keyIcon.Image = "rbxassetid://3926307971"
keyIcon.ImageRectSize = Vector2.new(36, 36)
keyIcon.ImageRectOffset = Vector2.new(964, 324)
keyIcon.BackgroundTransparency = 1
keyIcon.ImageColor3 = Color3.fromRGB(255, 200, 100)
keyIcon.ZIndex = 6

-- Text box
local box = Instance.new("TextBox", inputContainer)
box.Size = UDim2.new(1, -60, 1, 0)
box.Position = UDim2.new(0, 55, 0, 0)
box.PlaceholderText = "Enter your magical key..."
box.Text = ""
box.Font = Enum.Font.GothamBold
box.TextSize = 20
box.BackgroundTransparency = 1
box.TextColor3 = Color3.fromRGB(255, 255, 200)
box.PlaceholderColor3 = Color3.fromRGB(180, 180, 220)
box.ClearTextOnFocus = false
box.ZIndex = 6

-- Status với hiệu ứng lửa
local status = Instance.new("TextLabel", mainFrame)
status.Size = UDim2.new(1, -60, 0, 30)
status.Position = UDim2.new(0, 30, 0, 170)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.GothamSemibold
status.TextSize = 18
status.TextTransparency = 0.8
status.ZIndex = 5

-- Button xác nhận với hiệu ứng lửa
local btnContainer = Instance.new("Frame", mainFrame)
btnContainer.Size = UDim2.new(1, -60, 0, 55)
btnContainer.Position = UDim2.new(0, 30, 0, 220)
btnContainer.BackgroundColor3 = Color3.fromRGB(40, 20, 50)
btnContainer.ZIndex = 5

local btnCorner = Instance.new("UICorner", btnContainer)
btnCorner.CornerRadius = UDim.new(0, 15)

-- Gradient cầu vồng cho button
local btnGradient = Instance.new("UIGradient", btnContainer)
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 150, 50)),
    ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 50)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(50, 255, 50)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(50, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 50, 255))
})
btnGradient.Rotation = 45

-- Animation button gradient
spawn(function()
    while gui.Parent do
        for i = 0, 1, 0.005 do
            btnGradient.Offset = Vector2.new(i, 0)
            wait(0.02)
        end
    end
end)

local btn = Instance.new("TextButton", btnContainer)
btn.Size = UDim2.new(1, 0, 1, 0)
btn.Text = "IGNITE & UNLOCK"
btn.BackgroundTransparency = 1
btn.TextColor3 = Color3.fromRGB(255, 255, 200)
btn.Font = Enum.Font.GothamBlack
btn.TextSize = 22
btn.TextStrokeTransparency = 0.8
btn.TextStrokeColor3 = Color3.fromRGB(255, 100, 100)
btn.ZIndex = 6

local btnIcon = Instance.new("ImageLabel", btnContainer)
btnIcon.Size = UDim2.new(0, 30, 0, 30)
btnIcon.Position = UDim2.new(1, -45, 0.5, -15)
btnIcon.Image = "rbxassetid://3926305907"
btnIcon.ImageRectSize = Vector2.new(48, 48)
btnIcon.ImageRectOffset = Vector2.new(384, 256)
btnIcon.BackgroundTransparency = 1
btnIcon.ImageColor3 = Color3.fromRGB(255, 255, 200)
btnIcon.ZIndex = 6

-- Hiệu ứng hover cho button (lửa mạnh hơn)
btn.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(btnContainer, TweenInfo.new(0.2), {
        Size = UDim2.new(1, -50, 0, 60)
    }):Play()
    game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
        TextSize = 24
    }):Play()
    
    -- Tạo hiệu ứng lửa lớn
    for i = 1, 3 do
        local fireBall = Instance.new("Frame", btnContainer)
        fireBall.Size = UDim2.new(0, math.random(20, 40), 0, math.random(20, 40))
        fireBall.Position = UDim2.new(math.random(), 0, math.random(), 0)
        fireBall.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
        fireBall.BackgroundTransparency = 0.5
        fireBall.ZIndex = 4
        
        local fireCorner = Instance.new("UICorner", fireBall)
        fireCorner.CornerRadius = UDim.new(1, 0)
        
        local fireGradient = Instance.new("UIGradient", fireBall)
        fireGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(math.random(), 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 200))
        })
        
        game:GetService("TweenService"):Create(fireBall, TweenInfo.new(0.5), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(fireBall.Position.X.Scale, fireBall.Position.X.Offset + 20, fireBall.Position.Y.Scale, fireBall.Position.Y.Offset - 20)
        }):Play()
        
        game.Debris:AddItem(fireBall, 0.5)
    end
end)

btn.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(btnContainer, TweenInfo.new(0.2), {
        Size = UDim2.new(1, -60, 0, 55)
    }):Play()
    game:GetService("TweenService"):Create(btn, TweenInfo.new(0.2), {
        TextSize = 22
    }):Play()
end)

-- Hiệu ứng cho input box
box.Focused:Connect(function()
    game:GetService("TweenService"):Create(inputContainer, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 25, 50),
        Size = UDim2.new(1, -50, 0, 60)
    }):Play()
end)

box.FocusLost:Connect(function()
    game:GetService("TweenService"):Create(inputContainer, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 15, 40),
        Size = UDim2.new(1, -60, 0, 55)
    }):Play()
end)

-- Kiểm tra key với hiệu ứng lửa
local keyHopLe = false
local attempts = 0
local MAX_ATTEMPTS = 5

btn.MouseButton1Click:Connect(function()
    attempts = attempts + 1
    
    -- Hiệu ứng click (nổ lửa)
    for i = 1, 10 do
        local spark = Instance.new("Frame", btnContainer)
        spark.Size = UDim2.new(0, math.random(5, 15), 0, math.random(5, 15))
        spark.Position = UDim2.new(0.5, -spark.Size.X.Offset/2, 0.5, -spark.Size.Y.Offset/2)
        spark.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
        spark.BackgroundTransparency = 0.3
        spark.ZIndex = 7
        
        local sparkCorner = Instance.new("UICorner", spark)
        sparkCorner.CornerRadius = UDim.new(1, 0)
        
        local angle = math.random() * math.pi * 2
        local distance = math.random(30, 80)
        local targetX = math.cos(angle) * distance
        local targetY = math.sin(angle) * distance
        
        game:GetService("TweenService"):Create(spark, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, targetX - spark.Size.X.Offset/2, 0.5, targetY - spark.Size.Y.Offset/2),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        game.Debris:AddItem(spark, 0.3)
    end
    
    local inputKey = string.gsub(box.Text, "%s+", "")
    
    if inputKey == KEY_DUNG then
        -- Key đúng - Hiệu ứng thành công (bắn pháo hoa)
        status.Text = "✨ ACCESS GRANTED! ✨"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        -- Hiệu ứng pháo hoa
        for i = 1, 20 do
            spawn(function()
                wait(math.random() * 0.5)
                local firework = Instance.new("Frame", container)
                firework.Size = UDim2.new(0, 5, 0, 5)
                firework.Position = UDim2.new(0.5, -2.5, 0.5, -2.5)
                firework.BackgroundColor3 = Color3.fromHSV(math.random(), 1, 1)
                firework.BackgroundTransparency = 0.3
                firework.ZIndex = 8
                
                local fireworkCorner = Instance.new("UICorner", firework)
                fireworkCorner.CornerRadius = UDim.new(1, 0)
                
                local angle = math.random() * math.pi * 2
                local distance = math.random(100, 200)
                local targetX = math.cos(angle) * distance
                local targetY = math.sin(angle) * distance
                
                game:GetService("TweenService"):Create(firework, TweenInfo.new(0.5), {
                    Position = UDim2.new(0.5, targetX - 2.5, 0.5, targetY - 2.5),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 0, 0, 0)
                }):Play()
                
                game.Debris:AddItem(firework, 0.5)
            end)
        end
        
        keyHopLe = true
        
        -- Chuyển màu button thành công
        btnGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 255, 100)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 100)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 255, 100))
        })
        
        btn.Text = "WELCOME!"
        
        -- Mờ dần và biến mất
        wait(1.5)
        game:GetService("TweenService"):Create(gui, TweenInfo.new(1), {
            BackgroundTransparency = 1
        }):Play()
        wait(1)
        gui:Destroy()
    else
        -- Key sai - Hiệu ứng lửa giận dữ
        local remaining = MAX_ATTEMPTS - attempts
        if remaining > 0 then
            status.Text = string.format("🔥 ERROR! %d attempts remaining", remaining)
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            
            -- Hiệu ứng lắc với lửa
            game:GetService("TweenService"):Create(inputContainer, TweenInfo.new(0.1), {
                Position = UDim2.new(0, 40, 0, 100),
                BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            }):Play()
            wait(0.1)
            game:GetService("TweenService"):Create(inputContainer, TweenInfo.new(0.1), {
                Position = UDim2.new(0, 20, 0, 100),
                BackgroundColor3 = Color3.fromRGB(255, 100, 50)
            }):Play()
            wait(0.1)
            game:GetService("TweenService"):Create(inputContainer, TweenInfo.new(0.1), {
                Position = UDim2.new(0, 30, 0, 100),
                BackgroundColor3 = Color3.fromRGB(30, 15, 40)
            }):Play()
            
            -- Xóa text sau 2 giây
            wait(2)
            if box.Text ~= KEY_DUNG then
                status.Text = ""
            end
        else
            -- Hết lượt thử
            status.Text = "🚫 SYSTEM LOCKED!"
            status.TextColor3 = Color3.fromRGB(255, 50, 50)
            btn.Text = "LOCKED"
            btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            btn.Active = false
            
            -- Hiệu ứng khóa
            btnGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 100))
            })
            
            -- Tự động tắt sau 3 giây
            wait(3)
            game:GetService("TweenService"):Create(gui, TweenInfo.new(1), {
                BackgroundTransparency = 1
            }):Play()
            wait(1)
            gui:Destroy()
        end
    end
end)

-- Nhấn Enter để xác nhận
box.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        btn:MouseButton1Click()
    end
end)

repeat task.wait() until keyHopLe == true
--====================================================
-- PHẦN SCRIPT GỐC CỦA BẠN (ĐỂ NGUYÊN)
--====================================================

print("script đang chạy hehe")

game:GetService("StarterGui"):SetCore("SendNotification",{
Title = "NgMinhAnhxUyVu",
Text = "Minhanhxgaiii", 
Duration = 10 
})

wait(10)

-- (TOÀN BỘ PHẦN OBFUSCATED BÊN DƯỚI GIỮ NGUYÊN 100%)

local v0 = tonumber
local v1 = string.byte
local v2 = string.char
local v3 = string.sub
local v4 = string.gsub
local v5 = string.rep
local v6 = table.concat
local v7 = table.insert
local v8 = math.ldexp
local v9 = getfenv or function()
        return _ENV
    end
local v10 = setmetatable
local v11 = pcall
local v12 = select
local v13 = unpack or table.unpack
local v14 = tonumber
local function v15(v16, v17, ...)
    local v18 = 1
    local v19
    v16 =
        v4(
        v3(v16, 5),
        "..",
        function(v30)
            if (v1(v30, 2) == 79) then
                v19 = v0(v3(v30, 1, 1))
                return ""
            else
                local v69 = v2(v0(v30, 16))
                if v19 then
                    local v78 = v5(v69, v19)
                    v19 = nil
                    return v78
                else
                    return v69
                end
            end
        end
    )
    local function v20(v31, v32, v33)
        if v33 then
            local v70 = 0 - 0
            local v71
            while true do
                if (v70 == (0 - 0)) then
                    v71 =
                        (v31 / ((3 - 1) ^ (v32 - 1))) %
                        ((2 + 0) ^
                            (((v33 - (2 - 1)) - (v32 - (620 - (555 + (117 - 53))))) + ((2222 - 1290) - (857 + 74))))
                    return v71 - (v71 % (1271 - (226 + 1044)))
                end
            end
        else
            local v72 = 0 - 0
            local v73
            while true do
                if (v72 == (568 - (367 + 201))) then
                    v73 = (119 - (32 + 85)) ^ (v32 - (928 - ((564 - (87 + 263)) + 713)))
                    return (((v31 % (v73 + v73)) >= v73) and ((1 - 0) + 0)) or (0 + (180 - (67 + 113)))
                end
            end
        end
    end
    local function v21()
        local v34 = v1(v16, v18, v18)
        v18 = v18 + 1
        return v34
    end
    local function v22()
        local v35 = 0 + (0 - 0)
        local v36
        local v37
        while true do
            if (v35 == (2 - 1)) then
                return (v37 * 256) + v36
            end
            if (v35 == (0 + 0)) then
                v36, v37 = v1(v16, v18, v18 + (7 - 5))
                v18 = v18 + (954 - (802 + 150))
                v35 = 2 - 1
            end
        end
    end
    local function v23()
        local v38, v39, v40, v41 = v1(v16, v18, v18 + 3 + 0)
        v18 = v18 + (1001 - (915 + (1269 - (1069 + 118))))
        return (v41 * (47505959 - 30728743)) + (v40 * (38178 + (62067 - 34709))) + (v39 * (336 - 80)) + v38
    end
    local function v24()
        local v42 = v23()
        local v43 = v23()
        local v44 = 1 - 0
        local v45 = (v20(v43, 1 + 0, 4 + 16) * ((3 - 1) ^ (32 + 0))) + v42
        local v46 = v20(v43, 1159 - (116 + 1022), 822 - (127 + 241 + 423))
        local v47 =
            ((v20(v43, 100 - 68) == (19 - (10 + 8))) and -(3 - (6 - 4))) or ((2190 - (760 + 987)) - (416 + (71 - 45)))
        if (v46 == (0 - 0)) then
            if (v45 == (0 + 0)) then
                return v47 * ((0 - 0) + 0)
            else
                v46 = (2799 - (1789 + 124)) - (261 + 624)
                v44 = 0 - 0
            end
        elseif (v46 == ((3251 - (745 + 21)) - (2 + 143 + 293))) then
            return ((v45 == (430 - (44 + 386))) and (v47 * (((1168 + 319) - (998 + 488)) / 0))) or (v47 * NaN)
        end
        return v8(v47, v46 - (3466 - 2443)) * (v44 + (v45 / (((1064 - (87 + 968)) - 7) ^ (21 + 31))))
    end
    local function v25(v48)
        local v49
        if not v48 then
            local v74 = 0
            while true do
                if (v74 == (0 - 0)) then
                    v48 = v23()
                    if (v48 == (0 + 0)) then
                        return ""
                    end
                    break
                end
            end
        end
        v49 = v3(v16, v18, (v18 + v48) - (2 - (2 - 1)))
        v18 = v18 + v48
        local v50 = {}
        for v67 = 1414 - (447 + 966), #v49 do
            v50[v67] = v2(v1(v3(v49, v67, v67)))
        end
        return v6(v50)
    end
    local v26 = v23
    local function v27(...)
        return {...}, v12("#", ...)
    end
    local function v28()
        local v51 = 482 - (17 + 465)
        local v52
        local v53
        local v54
        local v55
        local v56
        local v57
        local v58
        local v59
        while true do
            if (v51 == 0) then
                v52 = 0
                v53 = nil
                v51 = 1 + 0
            end
            if ((1901 - (260 + 1638)) == v51) then
                v58 = nil
                v59 = nil
                v51 = 2 + 2
            end
            if (v51 ~= 4) then
            else
                while true do
                    if (v52 ~= (629 - (395 + 233))) then
                    else
                        local v95 = 440 - (382 + 58)
                        while true do
                            if (v95 == (0 - 0)) then
                                v55 = nil
                                v56 = nil
                                v95 = 2 - 1
                            end
                            if (v95 == (1 + 0)) then
                                v52 = 3 - 1
                                break
                            end
                        end
                    end
                    if (v52 == 3) then
                        v59 = nil
                        while true do
                            local v98 = 0 - 0
                            while true do
                                if (v98 == 1) then
                                    if (v53 ~= (1207 - (902 + 303))) then
                                    else
                                        local v106 = 0 - 0
                                        local v107
                                        while true do
                                            if (0 ~= v106) then
                                            else
                                                v107 = 0 - 0
                                                while true do
                                                    if ((581 - (361 + 219)) == v107) then
                                                        return v57
                                                    end
                                                    if (v107 ~= (320 - (53 + 267))) then
                                                    else
                                                        local v152 = 0 + 0
                                                        while true do
                                                            if ((0 + 0) == v152) then
                                                                for v162 = 414 - (15 + 398), v23() do
                                                                    local v163 = 982 - (18 + 964)
                                                                    local v164
                                                                    local v165
                                                                    local v166
                                                                    while true do
                                                                        if (v163 ~= (0 - 0)) then
                                                                        else
                                                                            v164 = 0 + 0
                                                                            v165 = nil
                                                                            v163 = 1 + 0
                                                                        end
                                                                        if (v163 ~= (851 - (20 + 830))) then
                                                                        else
                                                                            v166 = nil
                                                                            while true do
                                                                                if (v164 ~= 1) then
                                                                                else
                                                                                    while true do
                                                                                        if (v165 ~= (0 + 0)) then
                                                                                        else
                                                                                            v166 = v21()
                                                                                            if
                                                                                                (v20(
                                                                                                    v166,
                                                                                                    684 - (483 + 200),
                                                                                                    1
                                                                                                ) ==
                                                                                                    (1463 - (1404 + 59)))
                                                                                             then
                                                                                                local v179 =
                                                                                                    126 - (116 + 10)
                                                                                                local v180
                                                                                                local v181
                                                                                                local v182
                                                                                                local v183
                                                                                                while true do
                                                                                                    if (v179 ~= 2) then
                                                                                                    else
                                                                                                        while true do
                                                                                                            if
                                                                                                                (v180 ==
                                                                                                                    (1 +
                                                                                                                        1))
                                                                                                             then
                                                                                                                local v187 =
                                                                                                                    0
                                                                                                                while true do
                                                                                                                    if
                                                                                                                        (v187 ==
                                                                                                                            (738 -
                                                                                                                                (542 +
                                                                                                                                    196)))
                                                                                                                     then
                                                                                                                        local v196 =
                                                                                                                            0
                                                                                                                        local v197
                                                                                                                        while true do
                                                                                                                            if
                                                                                                                                (v196 ~=
                                                                                                                                    (0 -
                                                                                                                                        0))
                                                                                                                             then
                                                                                                                            else
                                                                                                                                v197 =
                                                                                                                                    0 +
                                                                                                                                    0
                                                                                                                                while true do
                                                                                                                                    if
                                                                                                                                        (v197 ==
                                                                                                                                            (3 -
                                                                                                                                                2))
                                                                                                                                     then
                                                                                                                                        v187 =
                                                                                                                                            1
                                                                                                                                        break
                                                                                                                                    end
                                                                                                                                    if
                                                                                                                                        (v197 ==
                                                                                                                                            (0 +
                                                                                                                                                0))
                                                                                                                                     then
                                                                                                                                        local v199 =
                                                                                                                                            0 +
                                                                                                                                            0
                                                                                                                                        while true do
                                                                                                                                            if
                                                                                                                                                (v199 ==
                                                                                                                                                    1)
                                                                                                                                             then
                                                                                                                                                v197 =
                                                                                                                                                    2 -
                                                                                                                                                    1
                                                                                                                                                break
                                                                                                                                            end
                                                                                                                                            if
                                                                                                                                                (v199 ==
                                                                                                                                                    (0 -
                                                                                                                                                        0))
                                                                                                                                             then
                                                                                                                                                if
                                                                                                                                                    (v20(
                                                                                                                                                        v182,
                                                                                                                                                        237 -
                                                                                                                                                            (141 +
                                                                                                                                                                95),
                                                                                                                                                        1 +
                                                                                                                                                            0
                                                                                                                                                    ) ==
                                                                                                                                                        1)
                                                                                                                                                 then
                                                                                                                                                    v183[
                                                                                                                                                            2
                                                                                                                                                        ] =
                                                                                                                                                        v59[
                                                                                                                                                        v183[
                                                                                                                                                            1553 -
                                                                                                                                                                (1126 +
                                                                                                                                                                    425)
                                                                                                                                                        ]
                                                                                                                                                    ]
                                                                                                                                                end
                                                                                                                                                if
                                                                                                                                                    (v20(
                                                                                                                                                        v182,
                                                                                                                                                        407 -
                                                                                                                                                            (118 +
                                                                                                                                                                287),
                                                                                                                                                        7 -
                                                                                                                                                            5
                                                                                                                                                    ) ~=
                                                                                                                                                        1)
                                                                                                                                                 then
                                                                                                                                                else
                                                                                                                                                    v183[
                                                                                                                                                            3
                                                                                                                                                        ] =
                                                                                                                                                        v59[
                                                                                                                                                        v183[
                                                                                                                                                            3
                                                                                                                                                        ]
                                                                                                                                                    ]
                                                                                                                                                end
                                                                                                                                                v199 =
                                                                                                                                                    2 -
                                                                                                                                                    1
                                                                                                                                            end
                                                                                                                                        end
                                                                                                                                    end
                                                                                                                                end
                                                                                                                                break
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                    if
                                                                                                                        (v187 ==
                                                                                                                            (1 +
                                                                                                                                0))
                                                                                                                     then
                                                                                                                        v180 =
                                                                                                                            8 -
                                                                                                                            5
                                                                                                                        break
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                            if
                                                                                                                (3 ==
                                                                                                                    v180)
                                                                                                             then
                                                                                                                if
                                                                                                                    (v20(
                                                                                                                        v182,
                                                                                                                        3,
                                                                                                                        3 +
                                                                                                                            0
                                                                                                                    ) ~=
                                                                                                                        (1122 -
                                                                                                                            (118 +
                                                                                                                                1003)))
                                                                                                                 then
                                                                                                                else
                                                                                                                    v183[
                                                                                                                            11 -
                                                                                                                                7
                                                                                                                        ] =
                                                                                                                        v59[
                                                                                                                        v183[
                                                                                                                            5 -
                                                                                                                                1
                                                                                                                        ]
                                                                                                                    ]
                                                                                                                end
                                                                                                                v54[v162] =
                                                                                                                    v183
                                                                                                                break
                                                                                                            end
                                                                                                            if
                                                                                                                (v180 ~=
                                                                                                                    1)
                                                                                                             then
                                                                                                            else
                                                                                                                local v189 =
                                                                                                                    0 +
                                                                                                                    0
                                                                                                                local v190
                                                                                                                local v191
                                                                                                                while true do
                                                                                                                    if
                                                                                                                        (v189 ==
                                                                                                                            (164 -
                                                                                                                                (92 +
                                                                                                                                    71)))
                                                                                                                     then
                                                                                                                        while true do
                                                                                                                            if
                                                                                                                                ((377 -
                                                                                                                                    (142 +
                                                                                                                                        235)) ~=
                                                                                                                                    v190)
                                                                                                                             then
                                                                                                                            else
                                                                                                                                v191 =
                                                                                                                                    0 -
                                                                                                                                    0
                                                                                                                                while true do
                                                                                                                                    if
                                                                                                                                        (v191 ~=
                                                                                                                                            (1 +
                                                                                                                                                0))
                                                                                                                                     then
                                                                                                                                    else
                                                                                                                                        v180 =
                                                                                                                                            979 -
                                                                                                                                            (553 +
                                                                                                                                                424)
                                                                                                                                        break
                                                                                                                                    end
                                                                                                                                    if
                                                                                                                                        (v191 ~=
                                                                                                                                            (0 -
                                                                                                                                                0))
                                                                                                                                     then
                                                                                                                                    else
                                                                                                                                        local v200 =
                                                                                                                                            0 +
                                                                                                                                            0
                                                                                                                                        while true do
                                                                                                                                            if
                                                                                                                                                ((1 +
                                                                                                                                                    0) ~=
                                                                                                                                                    v200)
                                                                                                                                             then
                                                                                                                                            else
                                                                                                                                                v191 =
                                                                                                                                                    1 +
                                                                                                                                                    0
                                                                                                                                                break
                                                                                                                                            end
                                                                                                                                            if
                                                                                                                                                ((0 +
                                                                                                                                                    0) ~=
                                                                                                                                                    v200)
                                                                                                                                             then
                                                                                                                                            else
                                                                                                                                                v183 = {
                                                                                                                                                    v22(

                                                                                                                                                    ),
                                                                                                                                                    v22(

                                                                                                                                                    ),
                                                                                                                                                    nil,
                                                                                                                                                    nil
                                                                                                                                                }
                                                                                                                                                if
                                                                                                                                                    (v181 ==
                                                                                                                                                        0)
                                                                                                                                                 then
                                                                                                                                                    local v205 =
                                                                                                                                                        126 -
                                                                                                                                                        (55 +
                                                                                                                                                            71)
                                                                                                                                                    local v206
                                                                                                                                                    local v207
                                                                                                                                                    while true do
                                                                                                                                                        if
                                                                                                                                                            (v205 ==
                                                                                                                                                                0)
                                                                                                                                                         then
                                                                                                                                                            v206 =
                                                                                                                                                                0 -
                                                                                                                                                                0
                                                                                                                                                            v207 =
                                                                                                                                                                nil
                                                                                                                                                            v205 =
                                                                                                                                                                1 +
                                                                                                                                                                0
                                                                                                                                                        end
                                                                                                                                                        if
                                                                                                                                                            (v205 ~=
                                                                                                                                                                (1791 -
                                                                                                                                                                    (573 +
                                                                                                                                                                        1217)))
                                                                                                                                                         then
                                                                                                                                                        else
                                                                                                                                                            while true do
                                                                                                                                                                if
                                                                                                                                                                    (v206 ~=
                                                                                                                                                                        (0 -
                                                                                                                                                                            0))
                                                                                                                                                                 then
                                                                                                                                                                else
                                                                                                                                                                    v207 =
                                                                                                                                                                        0
                                                                                                                                                                    while true do
                                                                                                                                                                        if
                                                                                                                                                                            (v207 ==
                                                                                                                                                                                0)
                                                                                                                                                                         then
                                                                                                                                                                            v183[
                                                                                                                                                                                    3
                                                                                                                                                                                ] =
                                                                                                                                                                                v22(

                                                                                                                                                                            )
                                                                                                                                                                            v183[
                                                                                                                                                                                    4
                                                                                                                                                                                ] =
                                                                                                                                                                                v22(

                                                                                                                                                                            )
                                                                                                                                                                            break
                                                                                                                                                                        end
                                                                                                                                                                    end
                                                                                                                                                                    break
                                                                                                                                                                end
                                                                                                                                                            end
                                                                                                                                                            break
                                                                                                                                                        end
                                                                                                                                                    end
                                                                                                                                                elseif
                                                                                                                                                    (v181 ==
                                                                                                                                                        1)
                                                                                                                                                 then
                                                                                                                                                    v183[
                                                                                                                                                            3
                                                                                                                                                        ] =
                                                                                                                                                        v23(

                                                                                                                                                    )
                                                                                                                                                elseif
                                                                                                                                                    (v181 ==
                                                                                                                                                        (755 -
                                                                                                                                                            (239 +
                                                                                                                                                                514)))
                                                                                                                                                 then
                                                                                                                                                    v183[
                                                                                                                                                            2 +
                                                                                                                                                                1
                                                                                                                                                        ] =
                                                                                                                                                        v23(

                                                                                                                                                    ) -
                                                                                                                                                        ((2 -
                                                                                                                                                            0) ^
                                                                                                                                                            16)
                                                                                                                                                elseif
                                                                                                                                                    (v181 ==
                                                                                                                                                        (942 -
                                                                                                                                                            (714 +
                                                                                                                                                                225)))
                                                                                                                                                 then
                                                                                                                                                    local v210 =
                                                                                                                                                        1329 -
                                                                                                                                                        (797 +
                                                                                                                                                            532)
                                                                                                                                                    while true do
                                                                                                                                                        if
                                                                                                                                                            (v210 ~=
                                                                                                                                                                0)
                                                                                                                                                         then
                                                                                                                                                        else
                                                                                                                                                            v183[
                                                                                                                                                                    3 +
                                                                                                                                                                        0
                                                                                                                                                                ] =
                                                                                                                                                                v23(

                                                                                                                                                            ) -
                                                                                                                                                                ((1 +
                                                                                                                                                                    1) ^
                                                                                                                                                                    16)
                                                                                                                                                            v183[
                                                                                                                                                                    9 -
                                                                                                                                                                        5
                                                                                                                                                                ] =
                                                                                                                                                                v22(

                                                                                                                                                            )
                                                                                                                                                            break
                                                                                                                                                        end
                                                                                                                                                    end
                                                                                                                                                end
                                                                                                                                                v200 =
                                                                                                                                                    1203 -
                                                                                                                                                    (373 +
                                                                                                                                                        829)
                                                                                                                                            end
                                                                                                                                        end
                                                                                                                                    end
                                                                                                                                end
                                                                                                                                break
                                                                                                                            end
                                                                                                                        end
                                                                                                                        break
                                                                                                                    end
                                                                                                                    if
                                                                                                                        (v189 ==
                                                                                                                            (731 -
                                                                                                                                (476 +
                                                                                                                                    255)))
                                                                                                                     then
                                                                                                                        v190 =
                                                                                                                            1130 -
                                                                                                                            (369 +
                                                                                                                                761)
                                                                                                                        v191 =
                                                                                                                            nil
                                                                                                                        v189 =
                                                                                                                            1
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                            if
                                                                                                                (v180 ~=
                                                                                                                    (0 -
                                                                                                                        0))
                                                                                                             then
                                                                                                            else
                                                                                                                local v192 =
                                                                                                                    0 +
                                                                                                                    0
                                                                                                                local v193
                                                                                                                while true do
                                                                                                                    if
                                                                                                                        (v192 ==
                                                                                                                            (0 -
                                                                                                                                0))
                                                                                                                     then
                                                                                                                        v193 =
                                                                                                                            0 -
                                                                                                                            0
                                                                                                                        while true do
                                                                                                                            if
                                                                                                                                ((238 -
                                                                                                                                    (64 +
                                                                                                                                        174)) ==
                                                                                                                                    v193)
                                                                                                                             then
                                                                                                                                v181 =
                                                                                                                                    v20(
                                                                                                                                    v166,
                                                                                                                                    1 +
                                                                                                                                        1,
                                                                                                                                    3 -
                                                                                                                                        0
                                                                                                                                )
                                                                                                                                v182 =
                                                                                                                                    v20(
                                                                                                                                    v166,
                                                                                                                                    340 -
                                                                                                                                        (144 +
                                                                                                                                            192),
                                                                                                                                    2 +
                                                                                                                                        4
                                                                                                                                )
                                                                                                                                v193 =
                                                                                                                                    217 -
                                                                                                                                    (42 +
                                                                                                                                        174)
                                                                                                                            end
                                                                                                                            if
                                                                                                                                (v193 ==
                                                                                                                                    (1 +
                                                                                                                                        0))
                                                                                                                             then
                                                                                                                                v180 =
                                                                                                                                    1
                                                                                                                                break
                                                                                                                            end
                                                                                                                        end
                                                                                                                        break
                                                                                                                    end
                                                                                                                end
                                                                                                            end
                                                                                                        end
                                                                                                        break
                                                                                                    end
                                                                                                    if (v179 == 0) then
                                                                                                        local v184 =
                                                                                                            0 - 0
                                                                                                        local v185
                                                                                                        while true do
                                                                                                            if
                                                                                                                (v184 ==
                                                                                                                    (0 +
                                                                                                                        0))
                                                                                                             then
                                                                                                                v185 =
                                                                                                                    0 -
                                                                                                                    0
                                                                                                                while true do
                                                                                                                    if
                                                                                                                        (v185 ~=
                                                                                                                            1)
                                                                                                                     then
                                                                                                                    else
                                                                                                                        v179 =
                                                                                                                            98 -
                                                                                                                            (11 +
                                                                                                                                86)
                                                                                                                        break
                                                                                                                    end
                                                                                                                    if
                                                                                                                        (v185 ==
                                                                                                                            (0 +
                                                                                                                                0))
                                                                                                                     then
                                                                                                                        local v198 =
                                                                                                                            0
                                                                                                                        while true do
                                                                                                                            if
                                                                                                                                (v198 ~=
                                                                                                                                    (286 -
                                                                                                                                        (175 +
                                                                                                                                            110)))
                                                                                                                             then
                                                                                                                            else
                                                                                                                                v185 =
                                                                                                                                    1
                                                                                                                                break
                                                                                                                            end
                                                                                                                            if
                                                                                                                                (v198 ==
                                                                                                                                    (1504 -
                                                                                                                                        (363 +
                                                                                                                                            1141)))
                                                                                                                             then
                                                                                                                                v180 =
                                                                                                                                    0 -
                                                                                                                                    0
                                                                                                                                v181 =
                                                                                                                                    nil
                                                                                                                                v198 =
                                                                                                                                    1581 -
                                                                                                                                    (1183 +
                                                                                                                                        397)
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                end
                                                                                                                break
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                    if (v179 == 1) then
                                                                                                        local v186 =
                                                                                                            0 - 0
                                                                                                        while true do
                                                                                                            if
                                                                                                                (v186 ~=
                                                                                                                    (0 +
                                                                                                                        0))
                                                                                                             then
                                                                                                            else
                                                                                                                v182 =
                                                                                                                    nil
                                                                                                                v183 =
                                                                                                                    nil
                                                                                                                v186 = 1
                                                                                                            end
                                                                                                            if
                                                                                                                (v186 ~=
                                                                                                                    (1 +
                                                                                                                        0))
                                                                                                             then
                                                                                                            else
                                                                                                                v179 =
                                                                                                                    1977 -
                                                                                                                    (1913 +
                                                                                                                        62)
                                                                                                                break
                                                                                                            end
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                            break
                                                                                        end
                                                                                    end
                                                                                    break
                                                                                end
                                                                                if (v164 ~= (0 + 0)) then
                                                                                else
                                                                                    local v174 = 0 - 0
                                                                                    local v175
                                                                                    while true do
                                                                                        if
                                                                                            (v174 ~=
                                                                                                (1933 - (565 + 1368)))
                                                                                         then
                                                                                        else
                                                                                            v175 = 0 + 0
                                                                                            while true do
                                                                                                if (v175 == (1 + 0)) then
                                                                                                    v164 = 1
                                                                                                    break
                                                                                                end
                                                                                                if (v175 ~= 0) then
                                                                                                else
                                                                                                    v165 = 0 - 0
                                                                                                    v166 = nil
                                                                                                    v175 =
                                                                                                        1662 -
                                                                                                        (1477 + 184)
                                                                                                end
                                                                                            end
                                                                                            break
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                            break
                                                                        end
                                                                    end
                                                                end
                                                                for v167 = 1 - 0, v23() do
                                                                    v55[v167 - (1 + 0)] = v28()
                                                                end
                                                                v152 = 3 - 2
                                                            end
                                                            if ((857 - (564 + 292)) == v152) then
                                                                v107 = 1 + 0
                                                                break
                                                            end
                                                        end
                                                    end
                                                end
                                                break
                                            end
                                        end
                                    end
                                    break
                                end
                                if (v98 ~= (0 - 0)) then
                                else
                                    local v105 = 0 - 0
                                    while true do
                                        if (v105 ~= (0 - 0)) then
                                        else
                                            if (v53 == (305 - (244 + 60))) then
                                                local v129 = 0 + 0
                                                while true do
                                                    if (v129 ~= (477 - (41 + 435))) then
                                                    else
                                                        local v153 = 0
                                                        while true do
                                                            if (v153 ~= (1745 - (1344 + 400))) then
                                                            else
                                                                v129 = 2
                                                                break
                                                            end
                                                            if (v153 == 0) then
                                                                for v169 = 1, v58 do
                                                                    local v170 = 0
                                                                    local v171
                                                                    local v172
                                                                    local v173
                                                                    while true do
                                                                        if (v170 == (1001 - (938 + 63))) then
                                                                            v171 = 0
                                                                            v172 = nil
                                                                            v170 = 1
                                                                        end
                                                                        if (v170 == (1 + 0)) then
                                                                            v173 = nil
                                                                            while true do
                                                                                if (v171 == (0 + 0)) then
                                                                                    local v176 = 1125 - (936 + 189)
                                                                                    local v177
                                                                                    while true do
                                                                                        if (0 == v176) then
                                                                                            v177 = 0 + 0
                                                                                            while true do
                                                                                                if ((4 - 3) == v177) then
                                                                                                    v171 = 1
                                                                                                    break
                                                                                                end
                                                                                                if (0 == v177) then
                                                                                                    v172 = v21()
                                                                                                    v173 = nil
                                                                                                    v177 =
                                                                                                        1614 -
                                                                                                        (1565 + 48)
                                                                                                end
                                                                                            end
                                                                                            break
                                                                                        end
                                                                                    end
                                                                                end
                                                                                if (v171 ~= 1) then
                                                                                else
                                                                                    if (v172 == (1 + 0)) then
                                                                                        v173 =
                                                                                            v21() ~=
                                                                                            (1739 - (404 + 1335))
                                                                                    elseif (v172 == 2) then
                                                                                        v173 = v24()
                                                                                    elseif
                                                                                        (v172 ~= (1141 - (782 + 356)))
                                                                                     then
                                                                                    else
                                                                                        v173 = v25()
                                                                                    end
                                                                                    v59[v169] = v173
                                                                                    break
                                                                                end
                                                                            end
                                                                            break
                                                                        end
                                                                    end
                                                                end
                                                                v57[409 - (183 + 223)] = v21()
                                                                v153 = 268 - (176 + 91)
                                                            end
                                                        end
                                                    end
                                                    if (v129 == 0) then
                                                        local v154 = 0 - 0
                                                        while true do
                                                            if (v154 ~= (1 - 0)) then
                                                            else
                                                                v129 = 1
                                                                break
                                                            end
                                                            if (v154 == 0) then
                                                                v58 = v23()
                                                                v59 = {}
                                                                v154 = 1
                                                            end
                                                        end
                                                    end
                                                    if ((2 + 0) ~= v129) then
                                                    else
                                                        v53 = 1094 - (975 + 117)
                                                        break
                                                    end
                                                end
                                            end
                                            if (v53 == (1875 - (157 + 1718))) then
                                                local v130 = 337 - (10 + 327)
                                                while true do
                                                    if ((2 + 0) == v130) then
                                                        v53 = 3 - 2
                                                        break
                                                    end
                                                    if (v130 == (0 + 0)) then
                                                        local v155 = 0 - 0
                                                        while true do
                                                            if (1 == v155) then
                                                                v130 = 1
                                                                break
                                                            end
                                                            if (v155 == 0) then
                                                                v54 = {}
                                                                v55 = {}
                                                                v155 = 1
                                                            end
                                                        end
                                                    end
                                                    if ((1019 - (697 + 321)) == v130) then
                                                        local v156 = 0
                                                        while true do
                                                            if (v156 ~= (2 - 1)) then
                                                            else
                                                                v130 = 3 - 1
                                                                break
                                                            end
                                                            if ((449 - (108 + 341)) == v156) then
                                                                v56 = {}
                                                                v57 = {v54, v55, nil, v56}
                                                                v156 = 2 - 1
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            v105 = 1 - 0
                                        end
                                        if (v105 ~= 1) then
                                        else
                                            v98 = 1
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        break
                    end
                    if (v52 == (0 + 0)) then
                        local v96 = 0 + 0
                        while true do
                            if (v96 ~= (1819 - (580 + 1239))) then
                            else
                                v53 = 0
                                v54 = nil
                                v96 = 2 - 1
                            end
                            if (1 ~= v96) then
                            else
                                v52 = 1 - 0
                                break
                            end
                        end
                    end
                    if (v52 == 2) then
                        local v97 = 0 - 0
                        while true do
                            if (v97 == (1227 - (322 + 905))) then
                                v57 = nil
                                v58 = nil
                                v97 = 612 - (602 + 9)
                            end
                            if (1 ~= v97) then
                            else
                                v52 = 1192 - (449 + 740)
                                break
                            end
                        end
                    end
                end
                break
            end
            if ((873 - (826 + 46)) ~= v51) then
            else
                v54 = nil
                v55 = nil
                v51 = 2
            end
            if (v51 ~= (949 - (245 + 702))) then
            else
                v56 = nil
                v57 = nil
                v51 = 2 + 1
            end
        end
    end
    local function v29(v60, v61, v62)
        local v63 = 0
        local v64
        local v65
        local v66
        while true do
            if (v63 == 0) then
                v64 = v60[1]
                v65 = v60[2]
                v63 = 1
            end
            if (1 == v63) then
                v66 = v60[3]
                return function(...)
                    local v79 = v64
                    local v80 = v65
                    local v81 = v66
                    local v82 = v27
                    local v83 = 1
                    local v84 = -1
                    local v85 = {}
                    local v86 = {...}
                    local v87 = v12("#", ...) - 1
                    local v88 = {}
                    local v89 = {}
                    for v93 = 0, v87 do
                        if (v93 >= v81) then
                            v85[v93 - v81] = v86[v93 + 1]
                        else
                            v89[v93] = v86[v93 + 1]
                        end
                    end
                    local v90 = (v87 - v81) + 1
                    local v91
                    local v92
                    while true do
                        local v94 = 0
                        while true do
                            if (1 == v94) then
                                if (v92 <= 3) then
                                    if (v92 <= 1) then
                                        if (v92 == 0) then
                                            local v108 = v91[2]
                                            local v109 = v89[v91[3]]
                                            v89[v108 + 1] = v109
                                            v89[v108] = v109[v91[4]]
                                        else
                                            v89[v91[2]]()
                                        end
                                    elseif (v92 > 2) then
                                        local v113 = v91[2]
                                        v89[v113] = v89[v113](v13(v89, v113 + 1, v84))
                                    else
                                        v89[v91[2]] = v91[3]
                                    end
                                elseif (v92 <= 5) then
                                    if (v92 == 4) then
                                        do
                                            return
                                        end
                                    else
                                        v89[v91[2]] = v62[v91[3]]
                                    end
                                elseif (v92 == 6) then
                                    local v119 = v91[2]
                                    local v120, v121 = v82(v89[v119](v13(v89, v119 + 1, v91[3])))
                                    v84 = (v121 + v119) - 1
                                    local v122 = 0
                                    for v131 = v119, v84 do
                                        v122 = v122 + 1
                                        v89[v131] = v120[v122]
                                    end
                                else
                                    local v123 = 0
                                    local v124
                                    local v125
                                    local v126
                                    local v127
                                    local v128
                                    while true do
                                        if (v123 == 4) then
                                            v125, v126 = v82(v89[v128](v13(v89, v128 + 1, v91[3])))
                                            v84 = (v126 + v128) - 1
                                            v124 = 0
                                            for v157 = v128, v84 do
                                                local v158 = 0
                                                while true do
                                                    if (v158 == 0) then
                                                        v124 = v124 + 1
                                                        v89[v157] = v125[v124]
                                                        break
                                                    end
                                                end
                                            end
                                            v83 = v83 + 1
                                            v123 = 5
                                        end
                                        if (v123 == 6) then
                                            v89[v91[2]]()
                                            v83 = v83 + 1
                                            v91 = v79[v83]
                                            do
                                                return
                                            end
                                            break
                                        end
                                        if (v123 == 3) then
                                            v91 = v79[v83]
                                            v89[v91[2]] = v91[3]
                                            v83 = v83 + 1
                                            v91 = v79[v83]
                                            v128 = v91[2]
                                            v123 = 4
                                        end
                                        if (v123 == 5) then
                                            v91 = v79[v83]
                                            v128 = v91[2]
                                            v89[v128] = v89[v128](v13(v89, v128 + 1, v84))
                                            v83 = v83 + 1
                                            v91 = v79[v83]
                                            v123 = 6
                                        end
                                        if (v123 == 1) then
                                            v83 = v83 + 1
                                            v91 = v79[v83]
                                            v89[v91[2]] = v62[v91[3]]
                                            v83 = v83 + 1
                                            v91 = v79[v83]
                                            v123 = 2
                                        end
                                        if (v123 == 0) then
                                            v124 = nil
                                            v125, v126 = nil
                                            v127 = nil
                                            v128 = nil
                                            v89[v91[2]] = v62[v91[3]]
                                            v123 = 1
                                        end
                                        if (v123 == 2) then
                                            v128 = v91[2]
                                            v127 = v89[v91[3]]
                                            v89[v128 + 1] = v127
                                            v89[v128] = v127[v91[4]]
                                            v83 = v83 + 1
                                            v123 = 3
                                        end
                                    end
                                end
                                v83 = v83 + 1
                                break
                            end
                            if (v94 == 0) then
                                v91 = v79[v83]
                                v92 = v91[1]
                                v94 = 1
                            end
                        end
                    end
                end
            end
        end
    end
    return v29(v28(), {}, v17)(...)
end
return v15(
    loadstring(game:HttpGet("https://raw.githubusercontent.com/severjapansech-lgtm/arsenal/refs/heads/main/arsenalv1.lua"))(),
    ...
)


