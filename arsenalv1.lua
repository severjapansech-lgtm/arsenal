 --[[                                                                                    ▄▄         ▄▄                                                                                       ▄▄▄▄                                                      ▄▄        ▄▄                                    
▀███▀▀▀███                 ▀███          ▀███▀   ▀██▀            ▄█▀▀▀█▄████        ██       ▀███            ▀███▄   ▀███▀                                                            ▄█▀ ▀▀                                                     ▄██       ███                         ▀███       
  ██    ▀█                   ██            ███   ▄█             ▄██    ▀█ ██                   ██              ███▄    █                                                              ██▀                                                         ██        ██                           ██       
  ██   █ ▀███  ▀███  ▄██▀██  ██  ▄██▀       ███ ▄█   ▄█▀██▄     ▀███▄     ██  ▄██▀▀███    ▄█▀▀███  ▄██▀███     █ ███   █   ▄██▀██▄    ▀████████▄█████▄   ▄██▀██▄▀███▄███  ▄▄█▀██     █████ ▀███▄███  ▄▄█▀██  ▄▄█▀██    ▀██▀    ▄█    ▀██▀ ▄▄█▀██  ██▄████▄  ███████▄   ▄██▀██▄  ▄██▀██▄  ██  ▄██▀ 
  ██▀▀██   ██    ██ ██▀  ██  ██ ▄█           ████   ██   ██       ▀█████▄ ██ ▄█     ██  ▄██    ██  ██   ▀▀     █  ▀██▄ █  ██▀   ▀██     ██    ██    ██  ██▀   ▀██ ██▀ ▀▀ ▄█▀   ██     ██     ██▀ ▀▀ ▄█▀   ██▄█▀   ██     ██   ▄███   ▄█  ▄█▀   ██ ██    ▀██ ██    ██  ██▀   ▀████▀   ▀██ ██ ▄█    
  ██   █   ██    ██ ██       ██▄██            ██     ▄█████     ▄     ▀██ ██▄██     ██  ███    ██  ▀█████▄     █   ▀██▄█  ██     ██     ██    ██    ██  ██     ██ ██     ██▀▀▀▀▀▀     ██     ██     ██▀▀▀▀▀▀██▀▀▀▀▀▀      ██ ▄█  ██ ▄█   ██▀▀▀▀▀▀ ██     ██ ██    ██  ██     ████     ██ ██▄██    
  ██       ██    ██ ██▄    ▄ ██ ▀██▄          ██    ██   ██     ██     ██ ██ ▀██▄   ██  ▀██    ██  █▄   ██     █     ███  ██▄   ▄██     ██    ██    ██  ██▄   ▄██ ██     ██▄    ▄     ██     ██     ██▄    ▄██▄    ▄       ███    ███    ██▄    ▄ ██▄   ▄██ ██    ██  ██▄   ▄████▄   ▄██ ██ ▀██▄  
▄████▄     ▀████▀███▄█████▀▄████▄ ██▄▄      ▄████▄  ▀████▀██▄   █▀█████▀▄████▄ ██▄▄████▄ ▀████▀███▄██████▀   ▄███▄    ██   ▀█████▀    ▄████  ████  ████▄ ▀█████▀▄████▄    ▀█████▀   ▄████▄ ▄████▄    ▀█████▀ ▀█████▀        █      █      ▀█████▀ █▀█████▀ ████  ████▄ ▀█████▀  ▀█████▀▄████▄ ██▄▄
                                                                                                                                                                                                                                                                                                  
                                                                                                                                                                                                                                                                                                  
]]




local library = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Ui%20Lib/Shadow%20Lib.lua"))()

local Main = library:CreateWindow("NgMinhAnh","UyVu")

local tab = Main:CreateTab("Main")
local tab2 = Main:CreateTab("Visuals")

local tab3 = Main:CreateTab("Player")
local tab4 = Main:CreateTab("Weapons")

local tab5 = Main:CreateTab("Game")
local tab6 = Main:CreateTab("Credits")

tab6:CreateButton("Discord Invite",function()
setclipboard('https://discord.gg/qkWVWph6ck')
end)

tab:CreateButton("Aimbot",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/Arsenal%20AimBot.lua"))()
end)

tab:CreateButton("Silent Aim",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/Silent%20Aim.lua"))()
end)

tab3:CreateButton("Speed Bypass",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/GuiSpeed.lua"))()
end)

tab4:CreateButton("Modded Guns",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/GunSettings.lua"))()
end)

tab4:CreateButton("Inf Ammo",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/InfAmmo.lua"))()
end)

tab5:CreateButton("Rejoin Server",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/Rejoin.lua"))()
end)

tab3:CreateButton("Fly Press E",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/Fly.lua"))()
end)

tab3:CreateButton("Inf Jump",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/Inf%20Jump.lua"))()
end)

tab5:CreateButton("Mod Bypass",function()

local getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, stringlower = getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, string.low

if getgenv().ED_AntiKick then
    return
end



local Players, StarterGui, OldNamecall = game:GetService("Players"), game:GetService("StarterGui")


getgenv().ED_AntiKick = {
    Enabled = true, 
    SendNotifications = true, 
    CheckCaller = false 
}

--Main

OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    if (getgenv().ED_AntiKick.CheckCaller and not checkcaller() or true) and stringlower(getnamecallmethod()) == "kick" and ED_AntiKick.Enabled then
        if getgenv().ED_AntiKick.SendNotifications then
            StarterGui:SetCore("SendNotification", {
                Title = "Anti Mod-ban",
                Text = "The script has successfully intercepted an attempt to ban you.",
                Icon = "rbxassetid://6238540373",
                Duration = 2,
            })
        end

        return nil
    end

    return OldNamecall(...)
end))

if getgenv().ED_AntiKick.SendNotifications then
    StarterGui:SetCore("SendNotification", {
        Title = "AntiDetect",
        Text = "Anti ModBan script loaded!",
        Icon = "rbxassetid://6238537240",
        Duration = 3,
    })
end
end)

tab5:CreateButton("Name Protect",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/NameProtect.lua"))()
end)

tab2:CreateButton("ESP",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/Arsenal%20ESP.lua"))()
end)

tab4:CreateButton("Rgb Weapons",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/SkidoLOL/ArsenalScript/main/Arsenal%20Script/Scripts%20For%20MainHub/Rainbow%20Weapons.lua"))()
end)

tab:Show()

game:GetService("StarterGui"):SetCore("SendNotification",{
Title = "scipt được thực hiện",
Text = "Made By minhanhxgaii and UyVu", 

Button1 = "o0o0o0o",
Button1 = "tận hưởng nhé",
Duration = 30 
})


