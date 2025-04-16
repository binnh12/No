if game.CoreGui:FindFirstChild("BNHHUB_UI") then
    game.CoreGui:FindFirstChild("BNHHUB_UI"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BNHHUB_UI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local Logo = Instance.new("ImageLabel", MainFrame)
Logo.Size = UDim2.new(0, 60, 0, 60)
Logo.Position = UDim2.new(0.5, -30, 0, 10)
Logo.Image = "rbxassetid://17091306537"
Logo.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 70)
Title.Text = "Chuyển Hướng"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true

local TabHolder = Instance.new("Frame", MainFrame)
TabHolder.Size = UDim2.new(0, 130, 1, -110)
TabHolder.Position = UDim2.new(0, 0, 0, 110)
TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -140, 1, -110)
ContentFrame.Position = UDim2.new(0, 140, 0, 110)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentFrame.Name = "ContentFrame"

local function createPage()
    local page = Instance.new("Frame", ContentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    return page
end

local AutoFarmPage = createPage()
local PremiumPage = createPage()
local HopServerPage = createPage()

local function createTab(name, onClick)
    local btn = Instance.new("TextButton", TabHolder)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(onClick)
    return btn
end

createTab("Auto Farm", function()
    AutoFarmPage.Visible = true
    PremiumPage.Visible = false
    HopServerPage.Visible = false
end)

createTab("Premium", function()
    AutoFarmPage.Visible = false
    PremiumPage.Visible = true
    HopServerPage.Visible = false
end)

createTab("Hop Server", function()
    AutoFarmPage.Visible = false
    PremiumPage.Visible = false
    HopServerPage.Visible = true
end)

AutoFarmPage.Visible = true

local label1 = Instance.new("TextLabel", AutoFarmPage)
label1.Size = UDim2.new(1, 0, 0, 30)
label1.Position = UDim2.new(0, 0, 0, 0)
label1.Text = "Auto Farm (Đang phát triển)"
label1.TextColor3 = Color3.new(1, 1, 1)
label1.BackgroundTransparency = 1
label1.Font = Enum.Font.GothamBold
label1.TextScaled = true

local label2 = Instance.new("TextLabel", PremiumPage)
label2.Size = UDim2.new(1, 0, 0, 30)
label2.Position = UDim2.new(0, 0, 0, 0)
label2.Text = "🔥"
label2.TextColor3 = Color3.fromRGB(255, 200, 0)
label2.BackgroundTransparency = 1
label2.Font = Enum.Font.GothamBold
label2.TextScaled = true

local hopBtn = Instance.new("TextButton", HopServerPage)
hopBtn.Size = UDim2.new(0, 200, 0, 40)
hopBtn.Position = UDim2.new(0.5, -100, 0, 10)
hopBtn.Text = "Hop Server"
hopBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hopBtn.TextColor3 = Color3.new(1, 1, 1)
hopBtn.Font = Enum.Font.GothamBold
hopBtn.TextSize = 14
hopBtn.MouseButton1Click:Connect(function()
    local ts = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer
    local HttpService = game:GetService("HttpService")
    local servers = {}
    local req = syn and syn.request or http and http.request or http_request or request
    local body = req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=2&limit=100"}).Body
    for _, v in pairs(HttpService:JSONDecode(body).data) do
        if v.playing < v.maxPlayers then
            table.insert(servers, v.id)
        end
    end
    if #servers > 0 then
        ts:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player)
    end
end)
