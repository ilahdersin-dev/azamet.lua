--========================================================
--                    AZAMET HUB
--              By Zeth😮‍💨
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local KEY = "raiderzethvoid"

local Character
local Humanoid
local Root

local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    Root = Character:WaitForChild("HumanoidRootPart")
end

UpdateCharacter()

Player.CharacterAdded:Connect(function()
    task.wait(.4)
    UpdateCharacter()
end)

--========================================================
-- STATE
--========================================================

local State = {
    Fly = false,
    Freeze = false,
    ESP = false,
    Invisible = false,
    Noclip = false,
    Fullbright = false,
    InfiniteJump = false,
    Teleport = false
}

local FlySpeed = 60
local OldGravity = workspace.Gravity
local OldWalkSpeed = 16
local OldJumpPower = 50

local FlyConnection
local NoclipConnection
local InfiniteJumpConnection

local ESPObjects = {}

local UIClosed = false
local Destroyed = false

--========================================================
-- GUI
--========================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AZAMET_HUB"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999
Gui.Parent = PlayerGui

--========================================================
-- LOADING SCREEN
--========================================================

local Loading = Instance.new("Frame")
Loading.Size = UDim2.fromScale(1,1)
Loading.BackgroundColor3 = Color3.fromRGB(3,5,9)
Loading.BorderSizePixel = 0
Loading.Parent = Gui

local LoadTitle = Instance.new("TextLabel")
LoadTitle.AnchorPoint = Vector2.new(.5,.5)
LoadTitle.Position = UDim2.fromScale(.5,.42)
LoadTitle.Size = UDim2.fromOffset(600,80)
LoadTitle.BackgroundTransparency = 1
LoadTitle.Text = "AZAMET"
LoadTitle.TextColor3 = Color3.fromRGB(0,255,200)
LoadTitle.TextSize = 58
LoadTitle.Font = Enum.Font.GothamBlack
LoadTitle.Parent = Loading

local LoadSub = Instance.new("TextLabel")
LoadSub.AnchorPoint = Vector2.new(.5,.5)
LoadSub.Position = UDim2.fromScale(.5,.51)
LoadSub.Size = UDim2.fromOffset(500,30)
LoadSub.BackgroundTransparency = 1
LoadSub.Text = "STUDIO CONTROL SYSTEM"
LoadSub.TextColor3 = Color3.fromRGB(130,145,155)
LoadSub.TextSize = 14
LoadSub.Font = Enum.Font.GothamBold
LoadSub.Parent = Loading

local LoadBack = Instance.new("Frame")
LoadBack.AnchorPoint = Vector2.new(.5,.5)
LoadBack.Position = UDim2.fromScale(.5,.63)
LoadBack.Size = UDim2.fromOffset(320,5)
LoadBack.BackgroundColor3 = Color3.fromRGB(25,30,35)
LoadBack.BorderSizePixel = 0
LoadBack.Parent = Loading

Instance.new("UICorner",LoadBack).CornerRadius = UDim.new(1,0)

local LoadBar = Instance.new("Frame")
LoadBar.Size = UDim2.new(0,0,1,0)
LoadBar.BackgroundColor3 = Color3.fromRGB(0,255,200)
LoadBar.BorderSizePixel = 0
LoadBar.Parent = LoadBack

Instance.new("UICorner",LoadBar).CornerRadius = UDim.new(1,0)

local LoadText = Instance.new("TextLabel")
LoadText.AnchorPoint = Vector2.new(.5,.5)
LoadText.Position = UDim2.fromScale(.5,.69)
LoadText.Size = UDim2.fromOffset(400,25)
LoadText.BackgroundTransparency = 1
LoadText.Text = "Başlatılıyor..."
LoadText.TextColor3 = Color3.fromRGB(120,130,140)
LoadText.TextSize = 12
LoadText.Font = Enum.Font.Gotham
LoadText.Parent = Loading

TweenService:Create(
    LoadBar,
    TweenInfo.new(2,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),
    {Size = UDim2.fromScale(1,1)}
):Play()

task.wait(.7)
LoadText.Text = "Modüller hazırlanıyor..."
task.wait(.65)
LoadText.Text = "AZAMET yükleniyor..."
task.wait(.65)

TweenService:Create(
    Loading,
    TweenInfo.new(.5),
    {BackgroundTransparency = 1}
):Play()

task.wait(.55)
Loading:Destroy()

--========================================================
-- KEY SCREEN
--========================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.AnchorPoint = Vector2.new(.5,.5)
KeyFrame.Position = UDim2.fromScale(.5,.5)
KeyFrame.Size = UDim2.fromOffset(370,245)
KeyFrame.BackgroundColor3 = Color3.fromRGB(7,10,15)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = Gui

Instance.new("UICorner",KeyFrame).CornerRadius = UDim.new(0,18)

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(0,255,200)
KeyStroke.Transparency = .3
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Position = UDim2.fromOffset(22,18)
KeyTitle.Size = UDim2.new(1,-44,0,35)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "AZAMET"
KeyTitle.TextColor3 = Color3.fromRGB(0,255,200)
KeyTitle.TextSize = 28
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyFrame

local KeySub = Instance.new("TextLabel")
KeySub.Position = UDim2.fromOffset(22,52)
KeySub.Size = UDim2.new(1,-44,0,25)
KeySub.BackgroundTransparency = 1
KeySub.Text = "Güvenli erişim anahtarını gir"
KeySub.TextColor3 = Color3.fromRGB(130,140,150)
KeySub.TextSize = 13
KeySub.Font = Enum.Font.Gotham
KeySub.TextXAlignment = Enum.TextXAlignment.Left
KeySub.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Position = UDim2.fromOffset(22,92)
KeyBox.Size = UDim2.new(1,-44,0,44)
KeyBox.BackgroundColor3 = Color3.fromRGB(17,21,28)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "KEY"
KeyBox.PlaceholderColor3 = Color3.fromRGB(85,95,105)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(240,245,250)
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

Instance.new("UICorner",KeyBox).CornerRadius = UDim.new(0,9)

local Enter = Instance.new("TextButton")
Enter.Position = UDim2.fromOffset(22,148)
Enter.Size = UDim2.new(1,-44,0,42)
Enter.BackgroundColor3 = Color3.fromRGB(0,170,135)
Enter.BorderSizePixel = 0
Enter.Text = "GİRİŞ YAP"
Enter.TextColor3 = Color3.new(1,1,1)
Enter.TextSize = 14
Enter.Font = Enum.Font.GothamBold
Enter.Parent = KeyFrame

Instance.new("UICorner",Enter).CornerRadius = UDim.new(0,9)

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Position = UDim2.fromOffset(22,198)
KeyStatus.Size = UDim2.new(1,-44,0,25)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = ""
KeyStatus.TextSize = 12
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.Parent = KeyFrame

--========================================================
-- MAIN PANEL
--========================================================

local Main = Instance.new("Frame")
Main.AnchorPoint = Vector2.new(.5,.5)
Main.Position = UDim2.fromScale(.5,.5)
Main.Size = UDim2.fromOffset(610,430)
Main.BackgroundColor3 = Color3.fromRGB(6,9,14)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,18)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0,255,200)
MainStroke.Transparency = .45
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

--========================================================
-- DRAGGING
--========================================================

local Dragging = false
local DragStart
local StartPosition

Main.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end

        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if Dragging and
        (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then

        local Delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end

end)

--========================================================
-- HEADER
--========================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,68)
Header.BackgroundTransparency = 1
Header.Parent = Main

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Position = UDim2.fromOffset(22,12)
HeaderTitle.Size = UDim2.fromOffset(300,32)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "AZAMET"
HeaderTitle.TextColor3 = Color3.fromRGB(0,255,200)
HeaderTitle.TextSize = 25
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local HeaderSub = Instance.new("TextLabel")
HeaderSub.Position = UDim2.fromOffset(23,40)
HeaderSub.Size = UDim2.fromOffset(300,18)
HeaderSub.BackgroundTransparency = 1
HeaderSub.Text = "STUDIO CONTROL PANEL"
HeaderSub.TextColor3 = Color3.fromRGB(90,105,115)
HeaderSub.TextSize = 10
HeaderSub.Font = Enum.Font.GothamBold
HeaderSub.TextXAlignment = Enum.TextXAlignment.Left
HeaderSub.Parent = Header

-- MINIMIZE

local MinButton = Instance.new("TextButton")
MinButton.Position = UDim2.new(1,-78,0,16)
MinButton.Size = UDim2.fromOffset(28,28)
MinButton.BackgroundColor3 = Color3.fromRGB(20,25,32)
MinButton.BorderSizePixel = 0
MinButton.Text = "−"
MinButton.TextColor3 = Color3.fromRGB(220,225,230)
MinButton.TextSize = 20
MinButton.Font = Enum.Font.GothamBold
MinButton.Parent = Header

Instance.new("UICorner",MinButton).CornerRadius = UDim.new(0,8)

-- CLOSE

local CloseButton = Instance.new("TextButton")
CloseButton.Position = UDim2.new(1,-42,0,16)
CloseButton.Size = UDim2.fromOffset(28,28)
CloseButton.BackgroundColor3 = Color3.fromRGB(35,20,24)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255,100,110)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

Instance.new("UICorner",CloseButton).CornerRadius = UDim.new(0,8)

--========================================================
-- MINI BAR
--========================================================

local Mini = Instance.new("TextButton")
Mini.AnchorPoint = Vector2.new(.5,0)
Mini.Position = UDim2.fromScale(.5,0)
Mini.Size = UDim2.fromOffset(220,34)
Mini.BackgroundColor3 = Color3.fromRGB(7,10,15)
Mini.BorderSizePixel = 0
Mini.Text = "────  AZAMET  ────"
Mini.TextColor3 = Color3.fromRGB(0,255,200)
Mini.TextSize = 13
Mini.Font = Enum.Font.GothamBlack
Mini.Visible = false
Mini.Parent = Gui

Instance.new("UICorner",Mini).CornerRadius = UDim.new(0,10)

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Color3.fromRGB(0,255,200)
MiniStroke.Transparency = .35
MiniStroke.Parent = Mini

--========================================================
-- BUTTON
--========================================================

local function Button(text,x,y,w,h)

    local B = Instance.new("TextButton")

    B.Position = UDim2.fromOffset(x,y)
    B.Size = UDim2.fromOffset(w,h)
    B.BackgroundColor3 = Color3.fromRGB(15,20,27)
    B.BorderSizePixel = 0
    B.Text = text
    B.TextColor3 = Color3.fromRGB(225,230,235)
    B.TextSize = 12
    B.Font = Enum.Font.GothamBold
    B.AutoButtonColor = false
    B.Parent = Main

    Instance.new("UICorner",B).CornerRadius = UDim.new(0,10)

    local S = Instance.new("UIStroke")
    S.Color = Color3.fromRGB(30,38,48)
    S.Parent = B

    B.MouseEnter:Connect(function()

        TweenService:Create(
            B,
            TweenInfo.new(.12),
            {BackgroundColor3 = Color3.fromRGB(25,33,42)}
        ):Play()

    end)

    B.MouseLeave:Connect(function()

        TweenService:Create(
            B,
            TweenInfo.new(.12),
            {BackgroundColor3 = Color3.fromRGB(15,20,27)}
        ):Play()

    end)

    return B
end

--========================================================
-- FLY
--========================================================

local FlyButton = Button("✈  FLY   OFF",22,83,245,42)

local FlySpeedBox = Instance.new("TextBox")
FlySpeedBox.Position = UDim2.fromOffset(280,83)
FlySpeedBox.Size = UDim2.fromOffset(95,42)
FlySpeedBox.BackgroundColor3 = Color3.fromRGB(15,20,27)
FlySpeedBox.BorderSizePixel = 0
FlySpeedBox.PlaceholderText = "Fly Speed"
FlySpeedBox.PlaceholderColor3 = Color3.fromRGB(90,100,110)
FlySpeedBox.TextColor3 = Color3.new(1,1,1)
FlySpeedBox.TextSize = 12
FlySpeedBox.Font = Enum.Font.Gotham
FlySpeedBox.Parent = Main

Instance.new("UICorner",FlySpeedBox).CornerRadius = UDim.new(0,10)

FlyButton.MouseButton1Click:Connect(function()

    UpdateCharacter()

    State.Fly = not State.Fly

    if State.Fly then

        FlyButton.Text = "✈  FLY   ON"
        FlyButton.TextColor3 = Color3.fromRGB(0,255,200)

        FlySpeed = tonumber(FlySpeedBox.Text) or 60

        Humanoid.PlatformStand = true

        FlyConnection = RunService.RenderStepped:Connect(function()

            if State.Fly and Root then

                Root.AssemblyLinearVelocity =
                    Camera.CFrame.LookVector * FlySpeed

                Root.AssemblyAngularVelocity = Vector3.zero

            end

        end)

    else

        FlyButton.Text = "✈  FLY   OFF"
        FlyButton.TextColor3 = Color3.fromRGB(225,230,235)

        if FlyConnection then
            FlyConnection:Disconnect()
            FlyConnection = nil
        end

        if Humanoid then
            Humanoid.PlatformStand = false
        end

        if Root then
            Root.AssemblyLinearVelocity = Vector3.zero
        end

    end

end)

--========================================================
-- FREEZE
--========================================================

local FreezeButton = Button("❄  FREEZE   OFF",22,135,245,42)

FreezeButton.MouseButton1Click:Connect(function()

    UpdateCharacter()

    State.Freeze = not State.Freeze
    Root.Anchored = State.Freeze

    if State.Freeze then
        FreezeButton.Text = "❄  FREEZE   ON"
        FreezeButton.TextColor3 = Color3.fromRGB(0,255,200)
    else
        FreezeButton.Text = "❄  FREEZE   OFF"
        FreezeButton.TextColor3 = Color3.fromRGB(225,230,235)
    end

end)

--========================================================
-- WALKSPEED
--========================================================

local SpeedBox = Instance.new("TextBox")
SpeedBox.Position = UDim2.fromOffset(22,187)
SpeedBox.Size = UDim2.fromOffset(155,42)
SpeedBox.BackgroundColor3 = Color3.fromRGB(15,20,27)
SpeedBox.BorderSizePixel = 0
SpeedBox.PlaceholderText = "Walk Speed"
SpeedBox.PlaceholderColor3 = Color3.fromRGB(90,100,110)
SpeedBox.TextColor3 = Color3.new(1,1,1)
SpeedBox.TextSize = 12
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.Parent = Main

Instance.new("UICorner",SpeedBox).CornerRadius = UDim.new(0,10)

local SpeedApply = Button("UYGULA",185,187,82,42)

SpeedApply.MouseButton1Click:Connect(function()

    local Value = tonumber(SpeedBox.Text)

    if Value then
        UpdateCharacter()
        Humanoid.WalkSpeed = Value
    end

end)

--========================================================
-- JUMP POWER
--========================================================

local JumpBox = Instance.new("TextBox")
JumpBox.Position = UDim2.fromOffset(280,135)
JumpBox.Size = UDim2.fromOffset(95,42)
JumpBox.BackgroundColor3 = Color3.fromRGB(15,20,27)
JumpBox.BorderSizePixel = 0
JumpBox.PlaceholderText = "Jump Power"
JumpBox.PlaceholderColor3 = Color3.fromRGB(90,100,110)
JumpBox.TextColor3 = Color3.new(1,1,1)
JumpBox.TextSize = 12
JumpBox.Font = Enum.Font.Gotham
JumpBox.Parent = Main

Instance.new("UICorner",JumpBox).CornerRadius = UDim.new(0,10)

local JumpApply = Button("UYGULA",280,187,95,42)

JumpApply.MouseButton1Click:Connect(function()

    local Value = tonumber(JumpBox.Text)

    if Value then

        UpdateCharacter()

        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = Value

    end

end)

--========================================================
-- ESP
--========================================================

local ESPButton = Button("👁  ESP   OFF",22,240,245,42)

local function RemoveESP(PlayerObject)

    if ESPObjects[PlayerObject] then
        ESPObjects[PlayerObject]:Destroy()
        ESPObjects[PlayerObject] = nil
    end

end

local function AddESP(PlayerObject)

    if PlayerObject == Player then return end
    if not State.ESP then return end

    local Char = PlayerObject.Character

    if not Char then return end

    RemoveESP(PlayerObject)

    local Highlight = Instance.new("Highlight")

    Highlight.Name = "AZAMET_ESP"
    Highlight.Adornee = Char
    Highlight.FillColor = Color3.fromRGB(0,255,200)
    Highlight.OutlineColor = Color3.fromRGB(255,255,255)
    Highlight.FillTransparency = .65
    Highlight.OutlineTransparency = .05
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    Highlight.Parent = Char

    ESPObjects[PlayerObject] = Highlight

end

local function RefreshESP()

    for _,P in ipairs(Players:GetPlayers()) do

        if P ~= Player then

            if State.ESP then
                AddESP(P)
            else
                RemoveESP(P)
            end

        end

    end

end

ESPButton.MouseButton1Click:Connect(function()

    State.ESP = not State.ESP

    if State.ESP then
        ESPButton.Text = "👁  ESP   ON"
        ESPButton.TextColor3 = Color3.fromRGB(0,255,200)
    else
        ESPButton.Text = "👁  ESP   OFF"
        ESPButton.TextColor3 = Color3.fromRGB(225,230,235)
    end

    RefreshESP()

end)

Players.PlayerAdded:Connect(function(P)

    P.CharacterAdded:Connect(function()

        task.wait(.4)

        if State.ESP then
            AddESP(P)
        end

    end)

end)

Players.PlayerRemoving:Connect(RemoveESP)

--========================================================
-- INVISIBLE
--========================================================

local InvisibleButton = Button("👻  INVISIBLE   OFF",390,83,195,42)

local function SetInvisible(Value)

    if not Character then return end

    for _,Obj in ipairs(Character:GetDescendants()) do

        if Obj:IsA("BasePart") then
            Obj.LocalTransparencyModifier = Value and 1 or 0
        elseif Obj:IsA("Decal") then
            Obj.Transparency = Value and 1 or 0
        end

    end

end

InvisibleButton.MouseButton1Click:Connect(function()

    State.Invisible = not State.Invisible

    SetInvisible(State.Invisible)

    if State.Invisible then
        InvisibleButton.Text = "👻  INVISIBLE   ON"
        InvisibleButton.TextColor3 = Color3.fromRGB(0,255,200)
    else
        InvisibleButton.Text = "👻  INVISIBLE   OFF"
        InvisibleButton.TextColor3 = Color3.fromRGB(225,230,235)
    end

end)

--========================================================
-- NOCLIP
--========================================================

local NoclipButton = Button("🚫  NOCLIP   OFF",390,135,195,42)

NoclipButton.MouseButton1Click:Connect(function()

    State.Noclip = not State.Noclip

    if State.Noclip then

        NoclipButton.Text = "🚫  NOCLIP   ON"
        NoclipButton.TextColor3 = Color3.fromRGB(0,255,200)

        NoclipConnection = RunService.Stepped:Connect(function()

            if Character then

                for _,Part in ipairs(Character:GetDescendants()) do

                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                    end

                end

            end

        end)

    else

        NoclipButton.Text = "🚫  NOCLIP   OFF"
        NoclipButton.TextColor3 = Color3.fromRGB(225,230,235)

        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end

        if Character then

            for _,Part in ipairs(Character:GetDescendants()) do

                if Part:IsA("BasePart") and Part.Name ~= "HumanoidRootPart" then
                    Part.CanCollide = true
                end

            end

        end

    end

end)

--========================================================
-- FULLBRIGHT
--========================================================

local FullbrightButton = Button("☀  FULLBRIGHT   OFF",390,187,195,42)

FullbrightButton.MouseButton1Click:Connect(function()

    State.Fullbright = not State.Fullbright

    if State.Fullbright then

        FullbrightButton.Text = "☀  FULLBRIGHT   ON"
        FullbrightButton.TextColor3 = Color3.fromRGB(0,255,200)

        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false

    else

        FullbrightButton.Text = "☀  FULLBRIGHT   OFF"
        FullbrightButton.TextColor3 = Color3.fromRGB(225,230,235)

        Lighting.Brightness = 2
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = true

    end

end)

--========================================================
-- INFINITE JUMP
--========================================================

local InfiniteButton = Button("♾  INFINITE JUMP   OFF",390,239,195,42)

InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()

    if State.InfiniteJump then

        UpdateCharacter()

        if Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end

    end

end)

InfiniteButton.MouseButton1Click:Connect(function()

    State.InfiniteJump = not State.InfiniteJump

    if State.InfiniteJump then
        InfiniteButton.Text = "♾  INFINITE JUMP   ON"
        InfiniteButton.TextColor3 = Color3.fromRGB(0,255,200)
    else
        InfiniteButton.Text = "♾  INFINITE JUMP   OFF"
        InfiniteButton.TextColor3 = Color3.fromRGB(225,230,235)
    end

end)

--========================================================
-- TELEPORT TOOL
--========================================================

local TeleportButton = Button("📍  TELEPORT TOOL",390,291,195,42)

local function GiveTeleportTool()

    if Player.Backpack:FindFirstChild("AZAMET") then
        return
    end

    if Character and Character:FindFirstChild("AZAMET") then
        return
    end

    local Tool = Instance.new("Tool")

    Tool.Name = "AZAMET"
    Tool.ToolTip = "Tıkla → teleport"
    Tool.RequiresHandle = false
    Tool.CanBeDropped = false

    Tool.Activated:Connect(function()

        local Mouse = Player:GetMouse()

        if Mouse and Mouse.Hit and Root then

            Root.CFrame =
                CFrame.new(Mouse.Hit.Position + Vector3.new(0,3,0))

        end

    end)

    Tool.Parent = Player.Backpack

end

TeleportButton.MouseButton1Click:Connect(function()

    State.Teleport = not State.Teleport

    if State.Teleport then

        TeleportButton.Text = "📍  TOOL ACTIVE"
        TeleportButton.TextColor3 = Color3.fromRGB(0,255,200)

        GiveTeleportTool()

    else

        TeleportButton.Text = "📍  TELEPORT TOOL"
        TeleportButton.TextColor3 = Color3.fromRGB(225,230,235)

        local BackpackTool = Player.Backpack:FindFirstChild("AZAMET")

        if BackpackTool then
            BackpackTool:Destroy()
        end

        if Character then

            local EquippedTool = Character:FindFirstChild("AZAMET")

            if EquippedTool then
                EquippedTool:Destroy()
            end

        end

    end

end)

--========================================================
-- GRAVITY
--========================================================

local GravityBox = Instance.new("TextBox")
GravityBox.Position = UDim2.fromOffset(390,344)
GravityBox.Size = UDim2.fromOffset(100,38)
GravityBox.BackgroundColor3 = Color3.fromRGB(15,20,27)
GravityBox.BorderSizePixel = 0
GravityBox.PlaceholderText = "Gravity"
GravityBox.PlaceholderColor3 = Color3.fromRGB(90,100,110)
GravityBox.TextColor3 = Color3.new(1,1,1)
GravityBox.TextSize = 12
GravityBox.Font = Enum.Font.Gotham
GravityBox.Parent = Main

Instance.new("UICorner",GravityBox).CornerRadius = UDim.new(0,9)

local GravityButton = Button("UYGULA",500,344,85,38)

GravityButton.MouseButton1Click:Connect(function()

    local Value = tonumber(GravityBox.Text)

    if Value then
        workspace.Gravity = Value
    end

end)

--========================================================
-- RESET
--========================================================

local ResetButton = Button("↻  RESET CHARACTER",22,293,245,42)

ResetButton.MouseButton1Click:Connect(function()

    if Humanoid then
        Humanoid.Health = 0
    end

end)

--========================================================
-- CLOSE CONFIRMATION
--========================================================

local Confirm = Instance.new("Frame")
Confirm.AnchorPoint = Vector2.new(.5,.5)
Confirm.Position = UDim2.fromScale(.5,.5)
Confirm.Size = UDim2.fromOffset(350,190)
Confirm.BackgroundColor3 = Color3.fromRGB(8,11,16)
Confirm.BorderSizePixel = 0
Confirm.Visible = false
Confirm.ZIndex = 20
Confirm.Parent = Gui

Instance.new("UICorner",Confirm).CornerRadius = UDim.new(0,16)

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Color = Color3.fromRGB(255,80,90)
ConfirmStroke.Transparency = .35
ConfirmStroke.Parent = Confirm

local ConfirmTitle = Instance.new("TextLabel")
ConfirmTitle.Position = UDim2.fromOffset(20,18)
ConfirmTitle.Size = UDim2.new(1,-40,0,30)
ConfirmTitle.BackgroundTransparency = 1
ConfirmTitle.Text = "UI'Yİ KAPAT?"
ConfirmTitle.TextColor3 = Color3.fromRGB(255,100,110)
ConfirmTitle.TextSize = 20
ConfirmTitle.Font = Enum.Font.GothamBold
ConfirmTitle.Parent = Confirm

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Position = UDim2.fromOffset(20,52)
ConfirmText.Size = UDim2.new(1,-40,0,45)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Emin misin?\nAktif özellikler kapatılacak."
ConfirmText.TextColor3 = Color3.fromRGB(170,180,190)
ConfirmText.TextSize = 13
ConfirmText.Font = Enum.Font.Gotham
ConfirmText.Parent = Confirm

local NoButton = Instance.new("TextButton")
NoButton.Position = UDim2.fromOffset(20,120)
NoButton.Size = UDim2.fromOffset(145,42)
NoButton.BackgroundColor3 = Color3.fromRGB(25,30,38)
NoButton.BorderSizePixel = 0
NoButton.Text = "HAYIR"
NoButton.TextColor3 = Color3.new(1,1,1)
NoButton.TextSize = 13
NoButton.Font = Enum.Font.GothamBold
NoButton.Parent = Confirm

Instance.new("UICorner",NoButton).CornerRadius = UDim.new(0,9)

local YesButton = Instance.new("TextButton")
YesButton.Position = UDim2.fromOffset(185,120)
YesButton.Size = UDim2.fromOffset(145,42)
YesButton.BackgroundColor3 = Color3.fromRGB(170,45,55)
YesButton.BorderSizePixel = 0
YesButton.Text = "EVET"
YesButton.TextColor3 = Color3.new(1,1,1)
YesButton.TextSize = 13
YesButton.Font = Enum.Font.GothamBold
YesButton.Parent = Confirm

Instance.new("UICorner",YesButton).CornerRadius = UDim.new(0,9)

NoButton.MouseButton1Click:Connect(function()
    Confirm.Visible = false
end)

--========================================================
-- DISABLE EVERYTHING
--========================================================

local function DisableEverything()

    State.Fly = false
    State.Freeze = false
    State.ESP = false
    State.Invisible = false
    State.Noclip = false
    State.Fullbright = false
    State.InfiniteJump = false
    State.Teleport = false

    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end

    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end

    if InfiniteJumpConnection then
        InfiniteJumpConnection:Disconnect()
        InfiniteJumpConnection = nil
    end

    UpdateCharacter()

    if Humanoid then
        Humanoid.PlatformStand = false
        Humanoid.WalkSpeed = 16
        Humanoid.UseJumpPower = true
        Humanoid.JumpPower = 50
    end

    if Root then
        Root.Anchored = false
        Root.AssemblyLinearVelocity = Vector3.zero
        Root.AssemblyAngularVelocity = Vector3.zero
    end

    workspace.Gravity = OldGravity

    -- Görünürlük
    if Character then
        for _,Obj in ipairs(Character:GetDescendants()) do

            if Obj:IsA("BasePart") then
                Obj.LocalTransparencyModifier = 0
            elseif Obj:IsA("Decal") then
                Obj.Transparency = 0
            end

        end
    end

    -- ESP temizle
    for P,Object in pairs(ESPObjects) do

        if Object then
            Object:Destroy()
        end

        ESPObjects[P] = nil

    end

    -- Teleport tool temizle
    local BackpackTool = Player.Backpack:FindFirstChild("AZAMET")

    if BackpackTool then
        BackpackTool:Destroy()
    end

    if Character then

        local EquippedTool = Character:FindFirstChild("AZAMET")

        if EquippedTool then
            EquippedTool:Destroy()
        end

    end

    -- UI
    Destroyed = true

    Gui:Destroy()

end

YesButton.MouseButton1Click:Connect(DisableEverything)

CloseButton.MouseButton1Click:Connect(function()
    Confirm.Visible = true
end)

--========================================================
-- MINIMIZE
--========================================================

MinButton.MouseButton1Click:Connect(function()

    UIClosed = true

    TweenService:Create(
        Main,
        TweenInfo.new(.3,Enum.EasingStyle.Quart,Enum.EasingDirection.In),
        {
            Size = UDim2.fromOffset(610,0)
        }
    ):Play()

    task.wait(.3)

    Main.Visible = false
    Mini.Visible = true

    Mini.Size = UDim2.fromOffset(0,34)

    TweenService:Create(
        Mini,
        TweenInfo.new(.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
        {
            Size = UDim2.fromOffset(220,34)
        }
    ):Play()

end)

Mini.MouseButton1Click:Connect(function()

    UIClosed = false

    Mini.Visible = false
    Main.Visible = true

    Main.Size = UDim2.fromOffset(610,0)

    TweenService:Create(
        Main,
        TweenInfo.new(.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
        {
            Size = UDim2.fromOffset(610,430)
        }
    ):Play()

end)

--========================================================
-- LOGIN
--========================================================

Enter.MouseButton1Click:Connect(function()

    if KeyBox.Text == KEY then

        KeyStatus.Text = "✓ Erişim onaylandı"
        KeyStatus.TextColor3 = Color3.fromRGB(0,255,150)

        task.wait(.35)

        KeyFrame.Visible = false
        Main.Visible = true

        Main.Size = UDim2.fromOffset(0,0)

        TweenService:Create(
            Main,
            TweenInfo.new(.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
            {
                Size = UDim2.fromOffset(610,430)
            }
        ):Play()

    else

        KeyStatus.Text = "✕ Hatalı key"
        KeyStatus.TextColor3 = Color3.fromRGB(255,80,90)

        KeyBox.Text = ""

        local Original = KeyFrame.Position

        TweenService:Create(
            KeyFrame,
            TweenInfo.new(.06,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,3,true),
            {
                Position = Original + UDim2.fromOffset(8,0)
            }
        ):Play()

    end

end)

--========================================================
-- CHARACTER UPDATE
--========================================================

Player.CharacterAdded:Connect(function()

    task.wait(.5)

    if Destroyed then
        return
    end

    UpdateCharacter()

    if State.Invisible then
        SetInvisible(true)
    end

    if State.ESP then
        RefreshESP()
    end

end)
