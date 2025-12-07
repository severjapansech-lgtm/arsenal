local KEY_DUNG = "280711"

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DigitalSafeAutoClose"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Nền mờ
local background = Instance.new("Frame", gui)
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.4
background.ZIndex = 0

-- Container chính
local container = Instance.new("Frame", gui)
container.Size = UDim2.new(0, 500, 0, 600)
container.Position = UDim2.new(0.5, -250, 0.5, -300)
container.BackgroundTransparency = 1
container.ZIndex = 1

-- Két sắt chính
local safeFrame = Instance.new("Frame", container)
safeFrame.Size = UDim2.new(1, 0, 1, 0)
safeFrame.BackgroundColor3 = Color3.fromRGB(60, 40, 20)
safeFrame.ZIndex = 2

local safeCorner = Instance.new("UICorner", safeFrame)
safeCorner.CornerRadius = UDim.new(0, 20)

-- Texture kim loại
local metalTexture = Instance.new("UIGradient", safeFrame)
metalTexture.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 70, 40)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 40, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 70, 40))
})
metalTexture.Rotation = 90

-- Viền kim loại
local metalBorder = Instance.new("Frame", safeFrame)
metalBorder.Size = UDim2.new(1, 0, 1, 0)
metalBorder.BackgroundTransparency = 1
metalBorder.ZIndex = 3

local borderStroke = Instance.new("UIStroke", metalBorder)
borderStroke.Thickness = 5
borderStroke.Color = Color3.fromRGB(180, 150, 100)
borderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Màn hình hiển thị
local screenContainer = Instance.new("Frame", safeFrame)
screenContainer.Size = UDim2.new(0.8, 0, 0.15, 0)
screenContainer.Position = UDim2.new(0.1, 0, 0.1, 0)
screenContainer.BackgroundColor3 = Color3.fromRGB(20, 40, 10)
screenContainer.ZIndex = 4

local screenCorner = Instance.new("UICorner", screenContainer)
screenCorner.CornerRadius = UDim.new(0, 10)

-- Hiệu ứng màn hình LED
local ledEffect = Instance.new("Frame", screenContainer)
ledEffect.Size = UDim2.new(1, 0, 1, 0)
ledEffect.BackgroundTransparency = 1
ledEffect.ZIndex = 5

local ledGradient = Instance.new("UIGradient", ledEffect)
ledGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
})
ledGradient.Transparency = NumberSequence.new(0.7)

-- Hiển thị số đã nhập
local displayText = Instance.new("TextLabel", screenContainer)
displayText.Size = UDim2.new(1, -20, 1, -20)
displayText.Position = UDim2.new(0, 10, 0, 10)
displayText.Text = "------"
displayText.TextColor3 = Color3.fromRGB(0, 255, 0)
displayText.BackgroundTransparency = 1
displayText.Font = Enum.Font.GothamBlack
displayText.TextSize = 36
displayText.TextStrokeTransparency = 0.8
displayText.TextStrokeColor3 = Color3.fromRGB(0, 100, 0)
displayText.ZIndex = 6

-- Status text
local statusText = Instance.new("TextLabel", safeFrame)
statusText.Size = UDim2.new(0.8, 0, 0.07, 0)
statusText.Position = UDim2.new(0.1, 0, 0.27, 0)
statusText.Text = "NHẬP 6 CHỮ SỐ"
statusText.TextColor3 = Color3.fromRGB(200, 200, 100)
statusText.BackgroundTransparency = 1
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 18
statusText.ZIndex = 4

-- Bàn phím số
local keypadContainer = Instance.new("Frame", safeFrame)
keypadContainer.Size = UDim2.new(0.8, 0, 0.5, 0)
keypadContainer.Position = UDim2.new(0.1, 0, 0.35, 0)
keypadContainer.BackgroundTransparency = 1
keypadContainer.ZIndex = 4

-- Tạo các nút số
local buttons = {}
local buttonLayout = {
    {"1", "2", "3"},
    {"4", "5", "6"},
    {"7", "8", "9"},
    {"C", "0", "E"}
}

local buttonSize = UDim2.new(0.3, 0, 0.2, 0)
local buttonSpacing = 0.05

for row = 1, 4 do
    for col = 1, 3 do
        local buttonValue = buttonLayout[row][col]
        
        local buttonFrame = Instance.new("Frame", keypadContainer)
        buttonFrame.Size = buttonSize
        buttonFrame.Position = UDim2.new((col-1) * (buttonSize.X.Scale + buttonSpacing), 0, 
                                        (row-1) * (buttonSize.Y.Scale + buttonSpacing), 0)
        buttonFrame.BackgroundColor3 = Color3.fromRGB(80, 60, 40)
        buttonFrame.ZIndex = 5
        
        local buttonCorner = Instance.new("UICorner", buttonFrame)
        buttonCorner.CornerRadius = UDim.new(0, 10)
        
        -- Hiệu ứng kim loại nút
        local buttonMetal = Instance.new("UIGradient", buttonFrame)
        buttonMetal.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 100, 70)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 60, 40))
        })
        buttonMetal.Rotation = 90
        
        local button = Instance.new("TextButton", buttonFrame)
        button.Size = UDim2.new(1, -4, 1, -4)
        button.Position = UDim2.new(0, 2, 0, 2)
        button.Text = buttonValue
        button.BackgroundColor3 = Color3.fromRGB(60, 40, 20)
        button.TextColor3 = Color3.fromRGB(255, 255, 200)
        button.Font = Enum.Font.GothamBlack
        button.TextSize = 24
        button.ZIndex = 6
        
        local buttonInnerCorner = Instance.new("UICorner", button)
        buttonInnerCorner.CornerRadius = UDim.new(0, 8)
        
        -- Viền nút
        local buttonStroke = Instance.new("UIStroke", button)
        buttonStroke.Thickness = 2
        buttonStroke.Color = Color3.fromRGB(180, 150, 100)
        
        -- Hiệu ứng hover
        button.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(80, 60, 40)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
                BackgroundColor3 = Color3.fromRGB(60, 40, 20)
            }):Play()
        end)
        
        -- Xử lý click
        button.MouseButton1Click:Connect(function()
            -- Hiệu ứng nhấn nút
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.05), {
                Size = UDim2.new(1, -8, 1, -8),
                Position = UDim2.new(0, 4, 0, 4)
            }):Play()
            
            wait(0.05)
            
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.05), {
                Size = UDim2.new(1, -4, 1, -4),
                Position = UDim2.new(0, 2, 0, 2)
            }):Play()
            
            if buttonValue == "C" then
                -- Clear
                currentInput = ""
                updateDisplay()
                statusText.Text = "ĐÃ XÓA"
                statusText.TextColor3 = Color3.fromRGB(255, 200, 100)
            elseif buttonValue == "E" then
                -- Enter/Submit
                checkKey()
            elseif #currentInput < 6 then
                -- Thêm số
                currentInput = currentInput .. buttonValue
                updateDisplay()
            end
        end)
        
        buttons[buttonValue] = button
    end
end

-- Nhãn nút
local clearLabel = Instance.new("TextLabel", buttons["C"].Parent)
clearLabel.Size = UDim2.new(1, 0, 0, 15)
clearLabel.Position = UDim2.new(0, 0, 1, 5)
clearLabel.Text = "XÓA"
clearLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
clearLabel.BackgroundTransparency = 1
clearLabel.Font = Enum.Font.GothamBold
clearLabel.TextSize = 12
clearLabel.ZIndex = 6

local enterLabel = Instance.new("TextLabel", buttons["E"].Parent)
enterLabel.Size = UDim2.new(1, 0, 0, 15)
enterLabel.Position = UDim2.new(0, 0, 1, 5)
enterLabel.Text = "MỞ"
enterLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
enterLabel.BackgroundTransparency = 1
enterLabel.Font = Enum.Font.GothamBold
enterLabel.TextSize = 12
enterLabel.ZIndex = 6

-- Tay cầm két sắt
local handleContainer = Instance.new("Frame", safeFrame)
handleContainer.Size = UDim2.new(0.15, 0, 0.2, 0)
handleContainer.Position = UDim2.new(0.8, 0, 0.4, 0)
handleContainer.BackgroundTransparency = 1
handleContainer.ZIndex = 4

-- Tay cầm
local handle = Instance.new("Frame", handleContainer)
handle.Size = UDim2.new(1, 0, 0.4, 0)
handle.Position = UDim2.new(0, 0, 0.3, 0)
handle.BackgroundColor3 = Color3.fromRGB(40, 30, 15)
handle.ZIndex = 5

local handleCorner = Instance.new("UICorner", handle)
handleCorner.CornerRadius = UDim.new(0, 10)

-- Hiệu ứng kim loại tay cầm
local handleMetal = Instance.new("UIGradient", handle)
handleMetal.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 80, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 150, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 80, 50))
})
handleMetal.Rotation = 90

-- Nút tay cầm
local handleKnob = Instance.new("Frame", handle)
handleKnob.Size = UDim2.new(0.6, 0, 0.6, 0)
handleKnob.Position = UDim2.new(0.2, 0, 0.2, 0)
handleKnob.BackgroundColor3 = Color3.fromRGB(60, 50, 30)
handleKnob.ZIndex = 6

local knobCorner = Instance.new("UICorner", handleKnob)
knobCorner.CornerRadius = UDim.new(1, 0)

-- Biến theo dõi
local currentInput = ""
local attempts = 0
local MAX_ATTEMPTS = 3
local isUnlocked = false
local isAnimating = false

-- Cập nhật hiển thị
local function updateDisplay()
    local displayStr = currentInput
    for i = #currentInput + 1, 6 do
        displayStr = displayStr .. "-"
    end
    
    -- Thêm khoảng cách giữa các số
    if #currentInput > 0 then
        local formatted = ""
        for i = 1, #displayStr do
            formatted = formatted .. displayStr:sub(i, i) .. " "
        end
        displayText.Text = formatted
    else
        displayText.Text = "- - - - - -"
    end
    
    -- Hiệu ứng nhấp nháy cho số mới nhập
    if #currentInput > 0 then
        displayText.TextColor3 = Color3.fromRGB(0, 255, 0)
        statusText.Text = string.format("ĐÃ NHẬP: %d/6", #currentInput)
        statusText.TextColor3 = Color3.fromRGB(200, 200, 100)
    else
        displayText.TextColor3 = Color3.fromRGB(100, 255, 100)
        statusText.Text = "NHẬP 6 CHỮ SỐ"
        statusText.TextColor3 = Color3.fromRGB(200, 200, 100)
    end
end

-- ================== HÀM TỰ ĐỘNG ĐÓNG KÉT ==================
local function autoCloseSafe()
    if isAnimating then return end
    isAnimating = true
    isUnlocked = true
    
    statusText.Text = "✓ MỞ KÉT THÀNH CÔNG!"
    statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
    
    -- Hiệu ứng màn hình thành công
    for i = 1, 3 do
        displayText.TextColor3 = Color3.fromRGB(0, 255, 0)
        wait(0.1)
        displayText.TextColor3 = Color3.fromRGB(100, 255, 100)
        wait(0.1)
    end
    
    -- Hiệu ứng tay cầm xoay
    local ts = game:GetService("TweenService")
    ts:Create(handle, TweenInfo.new(0.5), {
        Rotation = 90
    }):Play()
    
    -- Hiệu ứng mở cửa két
    local door = Instance.new("Frame", safeFrame)
    door.Size = UDim2.new(0.3, 0, 0.8, 0)
    door.Position = UDim2.new(0.7, 0, 0.1, 0)
    door.BackgroundColor3 = Color3.fromRGB(40, 30, 20)
    door.BackgroundTransparency = 0.5
    door.ZIndex = 7
    
    local doorGradient = Instance.new("UIGradient", door)
    doorGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 80, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 40, 20))
    })
    
    -- Hiệu ứng ánh sáng vàng từ trong két
    local safeLight = Instance.new("Frame", safeFrame)
    safeLight.Size = UDim2.new(0.25, 0, 0.7, 0)
    safeLight.Position = UDim2.new(0.71, 0, 0.15, 0)
    safeLight.BackgroundColor3 = Color3.fromRGB(255, 255, 150)
    safeLight.BackgroundTransparency = 0.7
    safeLight.ZIndex = 6
    
    local lightGradient = Instance.new("UIGradient", safeLight)
    lightGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 100))
    })
    lightGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.5),
        NumberSequenceKeypoint.new(1, 0.9)
    })
    
    -- Hiệu ứng ánh sáng tỏa ra
    for i = 1, 10 do
        local ray = Instance.new("Frame", safeFrame)
        ray.Size = UDim2.new(0, math.random(5, 15), 0, 2)
        ray.Position = UDim2.new(0.71 + math.random() * 0.25, 0, 0.15 + math.random() * 0.7, 0)
        ray.BackgroundColor3 = Color3.fromRGB(255, 255, 150)
        ray.BackgroundTransparency = 0.5
        ray.Rotation = math.random(-45, 45)
        ray.ZIndex = 5
        
        ts:Create(ray, TweenInfo.new(0.5), {
            Size = UDim2.new(0, ray.Size.X.Offset * 3, 0, ray.Size.Y.Offset),
            BackgroundTransparency = 1
        }):Play()
        
        game.Debris:AddItem(ray, 0.5)
        wait(0.1)
    end
    
    -- Vô hiệu hóa bàn phím
    for _, btn in pairs(buttons) do
        btn.Active = false
        btn.TextColor3 = Color3.fromRGB(100, 100, 100)
    end
    
    -- Hiển thị thông báo đếm ngược tự đóng
    wait(1)
    statusText.Text = "✓ TỰ ĐỘNG ĐÓNG TRONG 3..."
    wait(1)
    statusText.Text = "✓ TỰ ĐỘNG ĐÓNG TRONG 2..."
    wait(1)
    statusText.Text = "✓ TỰ ĐỘNG ĐÓNG TRONG 1..."
    wait(1)
    
    -- ========== HIỆU ỨNG ĐÓNG KÉT TỰ ĐỘNG ==========
    
    -- 1. Đóng cửa két
    statusText.Text = "ĐANG ĐÓNG KÉT..."
    statusText.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    ts:Create(door, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    
    ts:Create(safeLight, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play()
    
    ts:Create(handle, TweenInfo.new(0.5), {
        Rotation = 0
    }):Play()
    
    wait(0.5)
    
    -- 2. Hiệu ứng khóa lại
    statusText.Text = "ĐANG KHÓA KÉT..."
    
    -- Hiệu ứng khóa
    for i = 1, 3 do
        displayText.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(0.1)
        displayText.TextColor3 = Color3.fromRGB(100, 255, 100)
        wait(0.1)
    end
    
    displayText.Text = "LOCKED"
    displayText.TextColor3 = Color3.fromRGB(255, 50, 50)
    
    wait(0.5)
    
    -- 3. Hiệu ứng mờ dần
    statusText.Text = "✓ HOÀN TẤT!"
    
    local fadeTime = 1
    
    -- Mờ dần tất cả các phần tử
    ts:Create(gui, TweenInfo.new(fadeTime), {
        BackgroundTransparency = 1
    }):Play()
    
    ts:Create(safeFrame, TweenInfo.new(fadeTime), {
        BackgroundTransparency = 1
    }):Play()
    
    ts:Create(metalBorder, TweenInfo.new(fadeTime), {
        Transparency = 1
    }):Play()
    
    ts:Create(screenContainer, TweenInfo.new(fadeTime), {
        BackgroundTransparency = 1
    }):Play()
    
    ts:Create(displayText, TweenInfo.new(fadeTime), {
        TextTransparency = 1
    }):Play()
    
    ts:Create(statusText, TweenInfo.new(fadeTime), {
        TextTransparency = 1
    }):Play()
    
    -- Mờ dần các nút
    for _, btn in pairs(buttons) do
        ts:Create(btn, TweenInfo.new(fadeTime), {
            BackgroundTransparency = 1,
            TextTransparency = 1
        }):Play()
    end
    
    -- Mờ dần tay cầm
    ts:Create(handle, TweenInfo.new(fadeTime), {
        BackgroundTransparency = 1
    }):Play()
    
    ts:Create(handleKnob, TweenInfo.new(fadeTime), {
        BackgroundTransparency = 1
    }):Play()
    
    -- Đợi hiệu ứng hoàn tất
    wait(fadeTime + 0.5)
    
    -- Xóa GUI
    gui:Destroy()
    
    print("Két sắt đã được mở và tự động đóng!")
end

-- Hiệu ứng sai mật mã
local function wrongCodeEffect()
    if isAnimating then return end
    isAnimating = true
    
    attempts = attempts + 1
    local remaining = MAX_ATTEMPTS - attempts
    
    -- Hiệu ứng màn hình đỏ
    for i = 1, 3 do
        displayText.TextColor3 = Color3.fromRGB(255, 50, 50)
        screenContainer.BackgroundColor3 = Color3.fromRGB(60, 20, 10)
        wait(0.1)
        displayText.TextColor3 = Color3.fromRGB(255, 100, 100)
        screenContainer.BackgroundColor3 = Color3.fromRGB(40, 10, 5)
        wait(0.1)
    end
    
    -- Hiệu ứng rung két
    local originalPos = container.Position
    for i = 1, 5 do
        local offset = math.random(-5, 5)
        container.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset + offset, 
                                      originalPos.Y.Scale, originalPos.Y.Offset)
        wait(0.05)
    end
    container.Position = originalPos
    
    if remaining > 0 then
        statusText.Text = string.format("SAI MÃ SỐ! Còn %d lần thử", remaining)
        statusText.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        -- Tự động xóa sau 2 giây
        currentInput = ""
        updateDisplay()
        
        delay(2, function()
            if not isUnlocked then
                statusText.Text = "NHẬP 6 CHỮ SỐ"
                statusText.TextColor3 = Color3.fromRGB(200, 200, 100)
            end
        end)
    else
        -- Khóa két và tự động đóng
        statusText.Text = "⛔ KÉT ĐÃ BỊ KHÓA!"
        statusText.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        -- Vô hiệu hóa tất cả nút
        for _, btn in pairs(buttons) do
            btn.Active = false
            btn.TextColor3 = Color3.fromRGB(100, 100, 100)
        end
        
        -- Hiệu ứng khóa
        displayText.Text = "LOCKED"
        displayText.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        -- Tự động đóng sau 3 giây
        wait(3)
        autoCloseSafe()
    end
    
    isAnimating = false
end

-- Kiểm tra key (TỰ ĐỘNG KHI NHẬP ĐỦ 6 SỐ)
local function checkKey()
    if #currentInput ~= 6 then
        statusText.Text = "VUI LÒNG NHẬP ĐỦ 6 SỐ!"
        statusText.TextColor3 = Color3.fromRGB(255, 200, 100)
        return
    end
    
    if currentInput == KEY_DUNG then
        -- TỰ ĐỘNG GỌI HÀM ĐÓNG KÉT
        autoCloseSafe()
    else
        wrongCodeEffect()
    end
end

-- ========== TỰ ĐỘNG KIỂM TRA KHI NHẬP ĐỦ 6 SỐ ==========
local function autoCheckOnFullInput()
    if #currentInput == 6 then
        -- Đợi 0.5 giây cho người dùng xem lại
        wait(0.5)
        
        if not isAnimating and not isUnlocked then
            -- Tự động kiểm tra
            if currentInput == KEY_DUNG then
                statusText.Text = "✓ ĐANG KIỂM TRA..."
                statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
                wait(0.5)
                autoCloseSafe()
            else
                wrongCodeEffect()
            end
        end
    end
end

-- Kết nối tự động kiểm tra
box:GetPropertyChangedSignal("Text"):Connect(function()
    if #currentInput == 6 then
        spawn(autoCheckOnFullInput)
    end
end)

-- Cũng kiểm tra khi text thay đổi (nếu có textbox ẩn)
local hiddenInput = Instance.new("TextBox", gui)
hiddenInput.Visible = false
hiddenInput:GetPropertyChangedSignal("Text"):Connect(function()
    if #hiddenInput.Text == 6 then
        spawn(autoCheckOnFullInput)
    end
end)

-- Cập nhật hidden input khi currentInput thay đổi
local function updateHiddenInput()
    hiddenInput.Text = currentInput
end

-- Kết nối các nút với hidden input
for value, button in pairs(buttons) do
    if value ~= "C" and value ~= "E" then
        button.MouseButton1Click:Connect(function()
            updateHiddenInput()
        end)
    elseif value == "C" then
        button.MouseButton1Click:Connect(function()
            updateHiddenInput()
        end)
    end
end

-- Xử lý nhập từ bàn phím
local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local key = input.KeyCode.Name
        
        if tonumber(key:sub(-1)) then
            -- Nhấn số 0-9
            local num = key:sub(-1)
            if #currentInput < 6 then
                currentInput = currentInput .. num
                updateDisplay()
                updateHiddenInput()
            end
        elseif key == "Return" or key == "Enter" then
            -- Nhấn Enter
            checkKey()
        elseif key == "Backspace" then
            -- Nhấn Backspace
            if #currentInput > 0 then
                currentInput = currentInput:sub(1, -2)
                updateDisplay()
                updateHiddenInput()
            end
        end
    end
end)

-- Khởi tạo
updateDisplay()
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





