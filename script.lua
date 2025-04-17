if game.CoreGui:FindFirstChild("BNHHUB_UI") then game.CoreGui.BNHHUB_UI:Destroy() end
local g = Instance.new("ScreenGui", game.CoreGui) g.Name = "BNHHUB_UI"
local f = Instance.new("Frame", g) f.Size = UDim2.new(0,500,0,340) f.Position = UDim2.new(0.3,0,0.3,0)
f.BackgroundColor3 = Color3.fromRGB(30,30,30) f.Active = true f.Draggable = true f.BorderSizePixel = 0

local logo = Instance.new("ImageLabel", f) logo.Size = UDim2.new(0,60,0,60) logo.Position = UDim2.new(0.5,-30,0,0)
logo.BackgroundTransparency = 1 logo.Image = "rbxassetid://17091306537"

local title = Instance.new("TextLabel", f) title.Size = UDim2.new(1,0,0,40) title.Position = UDim2.new(0,0,0,60)
title.Text = "BNH HUB" title.BackgroundTransparency = 1 title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold title.TextScaled = true

local tFrame = Instance.new("Frame", f) tFrame.Size = UDim2.new(0,120,1,-100) tFrame.Position = UDim2.new(0,0,0,100)
tFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)

local cFrame = Instance.new("Frame", f) cFrame.Size = UDim2.new(1,-130,1,-100)
cFrame.Position = UDim2.new(0,130,0,100) cFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)

local pages = {}
local function page(name)
    local p = Instance.new("Frame", cFrame)
    p.Size = UDim2.new(1,0,1,0) p.BackgroundTransparency = 1 p.Visible = false
    pages[name] = p return p
end

local function switch(n) for i,v in pairs(pages) do v.Visible = false end if pages[n] then pages[n].Visible = true end end

local function tab(name, y, tgt)
    local b = Instance.new("TextButton", tFrame)
    b.Size = UDim2.new(1,0,0,35) b.Position = UDim2.new(0,0,0,y)
    b.Text = name b.BackgroundColor3 = Color3.fromRGB(50,50,50) b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham b.TextSize = 14 b.BorderSizePixel = 0
    b.MouseButton1Click:Connect(function() switch(tgt) end)
end

local af = page("Auto Farm") local pr = page("Premium") local hop = page("Hop Server") af.Visible = true
tab("Auto Farm", 0, "Auto Farm") tab("Premium", 35, "Premium") tab("Hop Server", 70, "Hop Server")

local l1 = Instance.new("TextLabel", af) l1.Size = UDim2.new(1,0,0,30) l1.Text = "Auto Farm (coming soon)"
l1.TextColor3 = Color3.new(1,1,1) l1.BackgroundTransparency = 1 l1.Font = Enum.Font.GothamBold l1.TextScaled = true

local l2 = Instance.new("TextLabel", pr) l2.Size = UDim2.new(1,0,0,30) l2.Text = "Premium FREE cho Bình"
l2.TextColor3 = Color3.fromRGB(255,200,0) l2.BackgroundTransparency = 1 l2.Font = Enum.Font.GothamBold l2.TextScaled = true

local hopBtn = Instance.new("TextButton", hop) hopBtn.Size = UDim2.new(0,180,0,40)
hopBtn.Position = UDim2.new(0.5,-90,0.3,0) hopBtn.Text = "Hop Server"
hopBtn.Font = Enum.Font.GothamBold hopBtn.TextSize = 14 hopBtn.TextColor3 = Color3.new(1,1,1)
hopBtn.BackgroundColor3 = Color3.fromRGB(60,60,60) hopBtn.BorderSizePixel = 0

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
hopBtn.MouseButton1Click:Connect(function()
    local req = (syn and syn.request) or request
    local r = req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=2&limit=100"})
    local d = HttpService:JSONDecode(r.Body)
    local s = {}
    for _,v in pairs(d.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then table.insert(s, v.id) end
    end
    if #s > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, s[math]
