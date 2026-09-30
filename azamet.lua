--========================================================
-- AZAMET HUB
--  Zeth 😎
-- Babapıro script
--========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

--========================================================
-- CONFIG
--========================================================

local KEY = "raiderzethvoid"
local MAX_VALUE = 6000

local FlySpeed = 100
local SpinSpeed = 5
local ShakePower = 2
local FlingPower = 120

local Character
local Humanoid
local Root

local function RefreshCharacter()
	Character = Player.Character or Player.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
	Root = Character:WaitForChild("HumanoidRootPart")
end

RefreshCharacter()

Player.CharacterAdded:Connect(function()
	task.wait(.4)
	RefreshCharacter()
end)

--========================================================
-- STATE
--========================================================

local State = {
	Fly = false,
	Noclip = false,
	InfiniteJump = false,
	Spin = false,
	Platform = false,
	ESP = false,
	Invisible = false,
	Fullbright = false,
	CameraShake = false,
	Atmosphere = false,
	Coordinates = false,
	FPS = false,
	Ping = false,
	Crosshair = false,
	Compass = false,
	WalkFling = false,
	AntiAFK = false
}

local Destroyed = false

local OldGravity = workspace.Gravity
local OldFOV = Camera.FieldOfView

local OldLighting = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient
}

--========================================================
-- SOUND
--========================================================

local function PlaySound(Type)
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
	Sound.Volume = .25

	if Type == "Error" then
		Sound.PlaybackSpeed = .65
	elseif Type == "Success" then
		Sound.PlaybackSpeed = 1.25
	else
		Sound.PlaybackSpeed = 1
	end

	Sound.Parent = SoundService
	Sound:Play()

	task.delay(2,function()
		if Sound then
			Sound:Destroy()
		end
	end)
end

--========================================================
-- GUI
--========================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AZAMET_BY_ZETH"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.DisplayOrder = 100
Gui.Parent = PlayerGui

local Scale = Instance.new("UIScale")
Scale.Scale = UIS.TouchEnabled and .82 or .95
Scale.Parent = Gui

--========================================================
-- KEY PAGE
--========================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.fromOffset(370,275)
KeyFrame.Position = UDim2.fromScale(.5,.5)
KeyFrame.AnchorPoint = Vector2.new(.5,.5)
KeyFrame.BackgroundColor3 = Color3.fromRGB(8,8,9)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = Gui

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(5,5,5)),
	ColorSequenceKeypoint.new(.5,Color3.fromRGB(35,35,35)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(5,5,5))
})
KeyGradient.Rotation = 45
KeyGradient.Parent = KeyFrame

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0,18)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Thickness = 2
KeyStroke.Color = Color3.fromRGB(255,255,255)
KeyStroke.Transparency = .15
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1,0,0,48)
KeyTitle.Position = UDim2.fromOffset(0,15)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "AZAMET"
KeyTitle.Font = Enum.Font.GothamBlack
KeyTitle.TextSize = 31
KeyTitle.TextColor3 = Color3.fromRGB(255,255,255)
KeyTitle.Parent = KeyFrame

local KeyBy = Instance.new("TextLabel")
KeyBy.Size = UDim2.new(1,0,0,22)
KeyBy.Position = UDim2.fromOffset(0,57)
KeyBy.BackgroundTransparency = 1
KeyBy.Text = "BY ZETH"
KeyBy.Font = Enum.Font.GothamBold
KeyBy.TextSize = 11
KeyBy.TextColor3 = Color3.fromRGB(150,150,150)
KeyBy.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1,-44,0,43)
KeyBox.Position = UDim2.fromOffset(22,91)
KeyBox.BackgroundColor3 = Color3.fromRGB(15,15,16)
KeyBox.PlaceholderText = "KEY GİR..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(130,130,130)
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 13
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0,10)
KeyBoxCorner.Parent = KeyBox

local KeyBoxStroke = Instance.new("UIStroke")
KeyBoxStroke.Color = Color3.fromRGB(80,80,80)
KeyBoxStroke.Parent = KeyBox

local Login = Instance.new("TextButton")
Login.Size = UDim2.fromOffset(150,42)
Login.Position = UDim2.fromOffset(22,148)
Login.BackgroundColor3 = Color3.fromRGB(235,235,235)
Login.Text = "GİRİŞ"
Login.Font = Enum.Font.GothamBlack
Login.TextSize = 13
Login.TextColor3 = Color3.fromRGB(0,0,0)
Login.AutoButtonColor = false
Login.Parent = KeyFrame

local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0,10)
LoginCorner.Parent = Login

local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.fromOffset(150,42)
GetKey.Position = UDim2.fromOffset(198,148)
GetKey.BackgroundColor3 = Color3.fromRGB(24,24,25)
GetKey.Text = "KEY AL"
GetKey.Font = Enum.Font.GothamBlack
GetKey.TextSize = 13
GetKey.TextColor3 = Color3.fromRGB(255,255,255)
GetKey.AutoButtonColor = false
GetKey.Parent = KeyFrame

local GetCorner = Instance.new("UICorner")
GetCorner.CornerRadius = UDim.new(0,10)
GetCorner.Parent = GetKey

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,-30,0,45)
Status.Position = UDim2.fromOffset(15,210)
Status.BackgroundTransparency = 1
Status.Text = "Key gerekli • By Zeth"
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.TextColor3 = Color3.fromRGB(150,150,150)
Status.Parent = KeyFrame

GetKey.MouseButton1Click:Connect(function()
	PlaySound("Click")
	Status.Text = "discord.gg/FNrA9rfCZz"

	if typeof(setclipboard) == "function" then
		setclipboard("https://discord.gg/FNrA9rfCZz")
		Status.Text = "Discord daveti kopyalandı!"
	end

	Status.TextColor3 = Color3.fromRGB(255,255,255)
end)

--========================================================
-- MAIN
--========================================================

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(520,430)
Main.Position = UDim2.fromScale(.5,.5)
Main.AnchorPoint = Vector2.new(.5,.5)
Main.BackgroundColor3 = Color3.fromRGB(7,7,8)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,18)
MainCorner.Parent = Main

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(3,3,4)),
	ColorSequenceKeypoint.new(.45,Color3.fromRGB(32,32,33)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(4,4,5))
})
MainGradient.Rotation = 35
MainGradient.Parent = Main

--========================================================
-- ANIMATED BORDER
--========================================================

local BorderParts = {}

local function BorderPart(Size,Position)
	local F = Instance.new("Frame")
	F.Size = Size
	F.Position = Position
	F.BackgroundColor3 = Color3.fromRGB(255,255,255)
	F.BorderSizePixel = 0
	F.ZIndex = 20
	F.Parent = Main

	local G = Instance.new("UIGradient")
	G.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
		ColorSequenceKeypoint.new(.25,Color3.fromRGB(255,255,255)),
		ColorSequenceKeypoint.new(.5,Color3.fromRGB(60,60,60)),
		ColorSequenceKeypoint.new(.75,Color3.fromRGB(255,255,255)),
		ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))
	})
	G.Parent = F

	table.insert(BorderParts,G)

	return F
end

BorderPart(
	UDim2.new(1,0,0,2),
	UDim2.new(0,0,0,0)
)

BorderPart(
	UDim2.new(1,0,0,2),
	UDim2.new(0,0,1,-2)
)

BorderPart(
	UDim2.new(0,2,1,0),
	UDim2.new(0,0,0,0)
)

BorderPart(
	UDim2.new(0,2,1,0),
	UDim2.new(1,-2,0,0)
)

-- sürekli siyah/beyaz ışık hareketi
task.spawn(function()
	local Rotation = 0

	while Gui.Parent and not Destroyed do
		Rotation += 2

		for _,Gradient in ipairs(BorderParts) do
			Gradient.Rotation = Rotation
		end

		MainGradient.Rotation = Rotation * .25
		KeyGradient.Rotation = Rotation * .4

		task.wait(.025)
	end
end)

--========================================================
-- HEADER
--========================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,52)
Header.BackgroundColor3 = Color3.fromRGB(10,10,11)
Header.BorderSizePixel = 0
Header.ZIndex = 10
Header.Parent = Main

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(.5,Color3.fromRGB(38,38,38)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))
})
HeaderGradient.Rotation = 0
HeaderGradient.Parent = Header

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0,18)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-105,1,0)
Title.Position = UDim2.fromOffset(17,0)
Title.BackgroundTransparency = 1
Title.Text = "AZAMET  •  BY ZETH"
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.ZIndex = 12
Title.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(32,30)
Minimize.Position = UDim2.new(1,-72,0,11)
Minimize.BackgroundColor3 = Color3.fromRGB(35,35,36)
Minimize.Text = "—"
Minimize.Font = Enum.Font.GothamBlack
Minimize.TextSize = 18
Minimize.TextColor3 = Color3.fromRGB(255,255,255)
Minimize.AutoButtonColor = false
Minimize.ZIndex = 13
Minimize.Parent = Header

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0,8)
MiniCorner.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30,30)
Close.Position = UDim2.new(1,-36,0,11)
Close.BackgroundColor3 = Color3.fromRGB(35,35,36)
Close.Text = "×"
Close.Font = Enum.Font.GothamBlack
Close.TextSize = 20
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.AutoButtonColor = false
Close.ZIndex = 13
Close.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,8)
CloseCorner.Parent = Close

--========================================================
-- SCROLL
--========================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-18,1,-63)
Scroll.Position = UDim2.fromOffset(9,58)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(220,220,220)
Scroll.CanvasSize = UDim2.new()
Scroll.ZIndex = 5
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,6)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0,5)
Padding.PaddingBottom = UDim.new(0,15)
Padding.Parent = Scroll

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	Scroll.CanvasSize = UDim2.fromOffset(
		0,
		Layout.AbsoluteContentSize.Y + 25
	)
end)

--========================================================
-- UI HELPERS
--========================================================

local function Section(Text)
	local L = Instance.new("TextLabel")
	L.Size = UDim2.new(1,-8,0,25)
	L.BackgroundTransparency = 1
	L.Text = "  "..Text
	L.TextXAlignment = Enum.TextXAlignment.Left
	L.Font = Enum.Font.GothamBlack
	L.TextSize = 11
	L.TextColor3 = Color3.fromRGB(235,235,235)
	L.ZIndex = 6
	L.Parent = Scroll
	return L
end

local function Button(Text)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1,-8,0,37)
	B.BackgroundColor3 = Color3.fromRGB(17,17,18)
	B.Text = Text
	B.Font = Enum.Font.GothamBold
	B.TextSize = 12
	B.TextColor3 = Color3.fromRGB(235,235,235)
	B.AutoButtonColor = false
	B.ZIndex = 6
	B.Parent = Scroll

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,9)
	C.Parent = B

	local S = Instance.new("UIStroke")
	S.Color = Color3.fromRGB(55,55,56)
	S.Thickness = 1
	S.Parent = B

	B.MouseEnter:Connect(function()
		TweenService:Create(
			B,
			TweenInfo.new(.12),
			{BackgroundColor3 = Color3.fromRGB(38,38,39)}
		):Play()
	end)

	B.MouseLeave:Connect(function()
		TweenService:Create(
			B,
			TweenInfo.new(.12),
			{BackgroundColor3 = Color3.fromRGB(17,17,18)}
		):Play()
	end)

	return B
end

local function Input(Placeholder)
	local B = Instance.new("TextBox")
	B.Size = UDim2.new(1,-8,0,35)
	B.BackgroundColor3 = Color3.fromRGB(12,12,13)
	B.PlaceholderText = Placeholder
	B.PlaceholderColor3 = Color3.fromRGB(135,135,135)
	B.TextColor3 = Color3.fromRGB(255,255,255)
	B.Text = ""
	B.Font = Enum.Font.Gotham
	B.TextSize = 12
	B.ClearTextOnFocus = false
	B.ZIndex = 6
	B.Parent = Scroll

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0,9)
	C.Parent = B

	local S = Instance.new("UIStroke")
	S.Color = Color3.fromRGB(48,48,49)
	S.Parent = B

	return B
end

--========================================================
-- MOVEMENT
--========================================================

Section("MOVEMENT")

local FlyButton = Button("✈  FLY  [OFF]")
local FlyBox = Input("Fly Speed • 1 - 6000")
local FlyApply = Button("⚡  Fly Speed Uygula")

local WalkBox = Input("WalkSpeed • 1 - 6000")
local WalkApply = Button("🏃  WalkSpeed Uygula")

local JumpBox = Input("JumpPower • 1 - 6000")
local JumpApply = Button("🦘  JumpPower Uygula")

local NoclipButton = Button("🚫  Noclip  [OFF]")
local InfiniteButton = Button("🦘  Infinite Jump  [OFF]")
local SpinButton = Button("🌀  Spin  [OFF]")
local SpinBox = Input("Spin Speed • 1 - 6000")
local SpinApply = Button("🌀  Spin Speed Uygula")
local SitButton = Button("🪑  Sit / Stand")
local PlatformButton = Button("🟦  Character Platform  [OFF]")

--========================================================
-- FLY
--========================================================

local FlyVelocity
local FlyConnection
local UpHeld = false
local DownHeld = false

local FlyUp = Instance.new("TextButton")
FlyUp.Size = UDim2.fromOffset(52,52)
FlyUp.Position = UDim2.new(1,-70,1,-135)
FlyUp.BackgroundColor3 = Color3.fromRGB(15,15,16)
FlyUp.Text = "▲"
FlyUp.TextColor3 = Color3.fromRGB(255,255,255)
FlyUp.TextSize = 20
FlyUp.Font = Enum.Font.GothamBlack
FlyUp.Visible = false
FlyUp.ZIndex = 80
FlyUp.Parent = Gui

local FUC = Instance.new("UICorner")
FUC.CornerRadius = UDim.new(1,0)
FUC.Parent = FlyUp

local FlyDown = Instance.new("TextButton")
FlyDown.Size = UDim2.fromOffset(52,52)
FlyDown.Position = UDim2.new(1,-70,1,-72)
FlyDown.BackgroundColor3 = Color3.fromRGB(15,15,16)
FlyDown.Text = "▼"
FlyDown.TextColor3 = Color3.fromRGB(255,255,255)
FlyDown.TextSize = 20
FlyDown.Font = Enum.Font.GothamBlack
FlyDown.Visible = false
FlyDown.ZIndex = 80
FlyDown.Parent = Gui

local FDC = Instance.new("UICorner")
FDC.CornerRadius = UDim.new(1,0)
FDC.Parent = FlyDown

FlyUp.MouseButton1Down:Connect(function()
	UpHeld = true
end)

FlyUp.MouseButton1Up:Connect(function()
	UpHeld = false
end)

FlyDown.MouseButton1Down:Connect(function()
	DownHeld = true
end)

FlyDown.MouseButton1Up:Connect(function()
	DownHeld = false
end)

local function StopFly()
	State.Fly = false
	FlyUp.Visible = false
	FlyDown.Visible = false

	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end

	if FlyVelocity then
		FlyVelocity:Destroy()
		FlyVelocity = nil
	end

	if Humanoid then
		Humanoid.PlatformStand = false
	end

	FlyButton.Text = "✈  FLY  [OFF]"
end

local function StartFly()

	RefreshCharacter()

	State.Fly = true

	FlyButton.Text = "✈  FLY  [ON]"
	FlyButton.TextColor3 = Color3.fromRGB(255,255,255)

	FlyUp.Visible = true
	FlyDown.Visible = true

	FlyVelocity = Instance.new("BodyVelocity")
	FlyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	FlyVelocity.P = 30000
	FlyVelocity.Velocity = Vector3.zero
	FlyVelocity.Parent = Root

	Humanoid.PlatformStand = true

	FlyConnection = RunService.RenderStepped:Connect(function()

		if not State.Fly or not Root or not Root.Parent then
			return
		end

		local Direction = Humanoid.MoveDirection
		local Velocity = Vector3.zero

		if Direction.Magnitude > 0 then
			Velocity += Direction.Unit * FlySpeed
		end

		if UIS:IsKeyDown(Enum.KeyCode.Space) or UpHeld then
			Velocity += Vector3.new(0,FlySpeed,0)
		end

		if UIS:IsKeyDown(Enum.KeyCode.LeftControl)
			or UIS:IsKeyDown(Enum.KeyCode.LeftShift)
			or DownHeld then

			Velocity -= Vector3.new(0,FlySpeed,0)
		end

		FlyVelocity.Velocity = Velocity
	end)
end

FlyButton.MouseButton1Click:Connect(function()
	PlaySound("Click")

	if State.Fly then
		StopFly()
	else
		StartFly()
	end
end)

FlyApply.MouseButton1Click:Connect(function()
	local N = tonumber(FlyBox.Text)

	if N then
		FlySpeed = math.clamp(N,1,MAX_VALUE)
		FlyBox.Text = ""
		PlaySound("Success")
	end
end)

--========================================================
-- WALK SPEED / JUMP
--========================================================

WalkApply.MouseButton1Click:Connect(function()
	local N = tonumber(WalkBox.Text)

	if N and Humanoid then
		Humanoid.WalkSpeed = math.clamp(N,1,MAX_VALUE)
		WalkBox.Text = ""
		PlaySound("Success")
	end
end)

JumpApply.MouseButton1Click:Connect(function()
	local N = tonumber(JumpBox.Text)

	if N and Humanoid then
		Humanoid.UseJumpPower = true
		Humanoid.JumpPower = math.clamp(N,1,MAX_VALUE)
		JumpBox.Text = ""
		PlaySound("Success")
	end
end)

NoclipButton.MouseButton1Click:Connect(function()
	State.Noclip = not State.Noclip

	NoclipButton.Text =
		"🚫  Noclip  ["..(State.Noclip and "ON" or "OFF").."]"
end)

InfiniteButton.MouseButton1Click:Connect(function()
	State.InfiniteJump = not State.InfiniteJump

	InfiniteButton.Text =
		"🦘  Infinite Jump  ["..
		(State.InfiniteJump and "ON" or "OFF").."]"
end)

UIS.JumpRequest:Connect(function()
	if State.InfiniteJump and Humanoid then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

SpinButton.MouseButton1Click:Connect(function()
	State.Spin = not State.Spin

	SpinButton.Text =
		"🌀  Spin  ["..(State.Spin and "ON" or "OFF").."]"
end)

SpinApply.MouseButton1Click:Connect(function()
	local N = tonumber(SpinBox.Text)

	if N then
		SpinSpeed = math.clamp(N,1,MAX_VALUE)
		SpinBox.Text = ""
		PlaySound("Success")
	end
end)

SitButton.MouseButton1Click:Connect(function()
	if Humanoid then
		Humanoid.Sit = not Humanoid.Sit
	end
end)

--========================================================
-- PLATFORM
--========================================================

local Platform

PlatformButton.MouseButton1Click:Connect(function()

	State.Platform = not State.Platform

	if State.Platform then

		Platform = Instance.new("Part")
		Platform.Name = "AZAMET_PLATFORM"
		Platform.Size = Vector3.new(7,.4,7)
		Platform.Anchored = true
		Platform.CanCollide = true
		Platform.Material = Enum.Material.SmoothPlastic
		Platform.Color = Color3.fromRGB(255,255,255)
		Platform.Transparency = .15
		Platform.Parent = workspace

	else

		if Platform then
			Platform:Destroy()
			Platform = nil
		end
	end

	PlatformButton.Text =
		"🟦  Character Platform  ["..
		(State.Platform and "ON" or "OFF").."]"
end)

--========================================================
-- VISUAL
--========================================================

Section("VISUAL")

local ESPButton = Button("👁  ESP  [OFF]")
local InvisibleButton = Button("👻  Invisible  [OFF]")
local FullbrightButton = Button("💡  Fullbright  [OFF]")

local FOVBox = Input("Camera FOV • 40 - 120")
local FOVApply = Button("🎥  Camera FOV Uygula")

local ZoomBox = Input("Camera Zoom Max • 5 - 6000")
local ZoomApply = Button("🔭  Camera Zoom Uygula")

local ShakeButton = Button("🎬  Camera Shake  [OFF]")
local ShakeBox = Input("Shake Power • 1 - 6000")
local ShakeApply = Button("🎬  Shake Power Uygula")

local ESPObjects = {}

local function ClearESP()
	for _,Object in ipairs(ESPObjects) do
		if Object then
			Object:Destroy()
		end
	end

	table.clear(ESPObjects)
end

local function ApplyESP()

	ClearESP()

	if not State.ESP then
		return
	end

	for _,Target in ipairs(Players:GetPlayers()) do

		if Target ~= Player and Target.Character then

			local H = Instance.new("Highlight")
			H.FillTransparency = .7
			H.FillColor = Color3.fromRGB(255,255,255)
			H.OutlineColor = Color3.fromRGB(0,0,0)
			H.Adornee = Target.Character
			H.Parent = Target.Character

			table.insert(ESPObjects,H)
		end
	end
end

ESPButton.MouseButton1Click:Connect(function()
	State.ESP = not State.ESP

	ESPButton.Text =
		"👁  ESP  ["..(State.ESP and "ON" or "OFF").."]"

	ApplyESP()
end)

InvisibleButton.MouseButton1Click:Connect(function()

	State.Invisible = not State.Invisible

	if Character then

		for _,Object in ipairs(Character:GetDescendants()) do

			if Object:IsA("BasePart") then
				Object.LocalTransparencyModifier =
					State.Invisible and 1 or 0
			end
		end
	end

	InvisibleButton.Text =
		"👻  Invisible  ["..
		(State.Invisible and "ON" or "OFF").."]"
end)

FullbrightButton.MouseButton1Click:Connect(function()

	State.Fullbright = not State.Fullbright

	if State.Fullbright then

		Lighting.Brightness = 3
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.Ambient = Color3.new(1,1,1)
		Lighting.OutdoorAmbient = Color3.new(1,1,1)

	else

		Lighting.Brightness = OldLighting.Brightness
		Lighting.ClockTime = OldLighting.ClockTime
		Lighting.FogEnd = OldLighting.FogEnd
		Lighting.Ambient = OldLighting.Ambient
		Lighting.OutdoorAmbient = OldLighting.OutdoorAmbient
	end

	FullbrightButton.Text =
		"💡  Fullbright  ["..
		(State.Fullbright and "ON" or "OFF").."]"
end)

FOVApply.MouseButton1Click:Connect(function()

	local N = tonumber(FOVBox.Text)

	if N then
		Camera.FieldOfView = math.clamp(N,40,120)
		FOVBox.Text = ""
		PlaySound("Success")
	end
end)

ZoomApply.MouseButton1Click:Connect(function()

	local N = tonumber(ZoomBox.Text)

	if N then
		Player.CameraMaxZoomDistance =
			math.clamp(N,5,MAX_VALUE)

		ZoomBox.Text = ""
		PlaySound("Success")
	end
end)

ShakeButton.MouseButton1Click:Connect(function()

	State.CameraShake = not State.CameraShake

	ShakeButton.Text =
		"🎬  Camera Shake  ["..
		(State.CameraShake and "ON" or "OFF").."]"
end)

ShakeApply.MouseButton1Click:Connect(function()

	local N = tonumber(ShakeBox.Text)

	if N then
		ShakePower = math.clamp(N,1,MAX_VALUE)
		ShakeBox.Text = ""
		PlaySound("Success")
	end
end)

--========================================================
-- WORLD
--========================================================

Section("WORLD")

local GravityBox = Input("Gravity • 0 - 6000")
local GravityApply = Button("🪐  Gravity Uygula")

local TimeBox = Input("ClockTime • 0 - 24")
local TimeApply = Button("🌅  Time Changer")

local AtmosButton = Button("🌫  Atmosphere  [OFF]")

GravityApply.MouseButton1Click:Connect(function()

	local N = tonumber(GravityBox.Text)

	if N then
		workspace.Gravity = math.clamp(N,0,MAX_VALUE)
		GravityBox.Text = ""
		PlaySound("Success")
	end
end)

TimeApply.MouseButton1Click:Connect(function()

	local N = tonumber(TimeBox.Text)

	if N then
		Lighting.ClockTime = math.clamp(N,0,24)
		TimeBox.Text = ""
		PlaySound("Success")
	end
end)

AtmosButton.MouseButton1Click:Connect(function()

	State.Atmosphere = not State.Atmosphere

	local Atmos = Lighting:FindFirstChild("AZAMET_Atmosphere")

	if State.Atmosphere then

		if not Atmos then
			Atmos = Instance.new("Atmosphere")
			Atmos.Name = "AZAMET_Atmosphere"
			Atmos.Parent = Lighting
		end

		Atmos.Density = .35
		Atmos.Haze = 1

	else

		if Atmos then
			Atmos:Destroy()
		end
	end

	AtmosButton.Text =
		"🌫  Atmosphere  ["..
		(State.Atmosphere and "ON" or "OFF").."]"
end)

--========================================================
-- MONITOR
--========================================================

Section("MONITOR")

local CoordLabel = Instance.new("TextLabel")
CoordLabel.Size = UDim2.fromOffset(210,58)
CoordLabel.Position = UDim2.fromOffset(10,70)
CoordLabel.BackgroundColor3 = Color3.fromRGB(8,8,9)
CoordLabel.BackgroundTransparency = .1
CoordLabel.TextColor3 = Color3.fromRGB(255,255,255)
CoordLabel.Font = Enum.Font.Code
CoordLabel.TextSize = 11
CoordLabel.TextXAlignment = Enum.TextXAlignment.Left
CoordLabel.Visible = false
CoordLabel.ZIndex = 70
CoordLabel.Parent = Gui

local CoordCorner = Instance.new("UICorner")
CoordCorner.CornerRadius = UDim.new(0,9)
CoordCorner.Parent = CoordLabel

local CoordButton = Button("📍  Coordinates HUD  [OFF]")

CoordButton.MouseButton1Click:Connect(function()

	State.Coordinates = not State.Coordinates
	CoordLabel.Visible = State.Coordinates

	CoordButton.Text =
		"📍  Coordinates HUD  ["..
		(State.Coordinates and "ON" or "OFF").."]"
end)

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.fromOffset(115,28)
FPSLabel.Position = UDim2.new(1,-125,0,10)
FPSLabel.BackgroundColor3 = Color3.fromRGB(8,8,9)
FPSLabel.TextColor3 = Color3.fromRGB(255,255,255)
FPSLabel.Font = Enum.Font.Code
FPSLabel.TextSize = 11
FPSLabel.Visible = false
FPSLabel.ZIndex = 70
FPSLabel.Parent = Gui

local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0,8)
FPSCorner.Parent = FPSLabel

local FPSButton = Button("📊  FPS Counter  [OFF]")

FPSButton.MouseButton1Click:Connect(function()

	State.FPS = not State.FPS
	FPSLabel.Visible = State.FPS

	FPSButton.Text =
		"📊  FPS Counter  ["..
		(State.FPS and "ON" or "OFF").."]"
end)

local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.fromOffset(115,28)
PingLabel.Position = UDim2.new(1,-125,0,42)
PingLabel.BackgroundColor3 = Color3.fromRGB(8,8,9)
PingLabel.TextColor3 = Color3.fromRGB(255,255,255)
PingLabel.Font = Enum.Font.Code
PingLabel.TextSize = 11
PingLabel.Visible = false
PingLabel.ZIndex = 70
PingLabel.Parent = Gui

local PingCorner = Instance.new("UICorner")
PingCorner.CornerRadius = UDim.new(0,8)
PingCorner.Parent = PingLabel

local PingButton = Button("📡  Ping Counter  [OFF]")

PingButton.MouseButton1Click:Connect(function()

	State.Ping = not State.Ping
	PingLabel.Visible = State.Ping

	PingButton.Text =
		"📡  Ping Counter  ["..
		(State.Ping and "ON" or "OFF").."]"
end)

--========================================================
-- CROSSHAIR
--========================================================

local CrossButton = Button("🎯  Crosshair  [OFF]")
local Crosshair

CrossButton.MouseButton1Click:Connect(function()

	State.Crosshair = not State.Crosshair

	if State.Crosshair then

		Crosshair = Instance.new("TextLabel")
		Crosshair.Size = UDim2.fromOffset(30,30)
		Crosshair.Position = UDim2.fromScale(.5,.5)
		Crosshair.AnchorPoint = Vector2.new(.5,.5)
		Crosshair.BackgroundTransparency = 1
		Crosshair.Text = "+"
		Crosshair.Font = Enum.Font.GothamBlack
		Crosshair.TextSize = 24
		Crosshair.TextColor3 = Color3.fromRGB(255,255,255)
		Crosshair.ZIndex = 90
		Crosshair.Parent = Gui

	else

		if Crosshair then
			Crosshair:Destroy()
			Crosshair = nil
		end
	end

	CrossButton.Text =
		"🎯  Crosshair  ["..
		(State.Crosshair and "ON" or "OFF").."]"
end)

--========================================================
-- COMPASS
--========================================================

local CompassButton = Button("🧭  Compass  [OFF]")
local Compass

CompassButton.MouseButton1Click:Connect(function()

	State.Compass = not State.Compass

	if State.Compass then

		Compass = Instance.new("TextLabel")
		Compass.Size = UDim2.fromOffset(170,30)
		Compass.Position = UDim2.fromScale(.5,0)
		Compass.AnchorPoint = Vector2.new(.5,0)
		Compass.BackgroundColor3 = Color3.fromRGB(8,8,9)
		Compass.Text = "N     E     S     W"
		Compass.Font = Enum.Font.GothamBold
		Compass.TextSize = 11
		Compass.TextColor3 = Color3.fromRGB(255,255,255)
		Compass.ZIndex = 90
		Compass.Parent = Gui

		local C = Instance.new("UICorner")
		C.CornerRadius = UDim.new(0,8)
		C.Parent = Compass

	else

		if Compass then
			Compass:Destroy()
			Compass = nil
		end
	end

	CompassButton.Text =
		"🧭  Compass  ["..
		(State.Compass and "ON" or "OFF").."]"
end)

--========================================================
-- ADMIN / WALK FLING
--========================================================

Section("ADMIN")

local FlingButton = Button("💥  Walk Fling  [OFF]")
local FlingPowerBox = Input("Fling Power • 1 - 6000")
local FlingPowerApply = Button("💥  Fling Power Uygula")

--========================================================
-- SERVERLESS WALK FLING
--========================================================

local function TryFlingTarget(TargetCharacter)

	if not Root or not Root.Parent then
		return
	end

	local TargetRoot =
		TargetCharacter:FindFirstChild("HumanoidRootPart")

	local TargetHumanoid =
		TargetCharacter:FindFirstChildOfClass("Humanoid")

	if not TargetRoot or not TargetHumanoid then
		return
	end

	if TargetHumanoid.Health <= 0 then
		return
	end

	local Distance =
		(TargetRoot.Position - Root.Position).Magnitude

	if Distance > 7 then
		return
	end

	local Direction =
		(TargetRoot.Position - Root.Position)

	if Direction.Magnitude < .1 then
		Direction = Root.CFrame.LookVector
	else
		Direction = Direction.Unit
	end

	local Velocity =
		Direction * FlingPower
		+ Vector3.new(
			0,
			FlingPower * .55,
			0
		)

	-- Önce hedefin network ownership'i client'a
	-- bırakılmışsa doğrudan fiziksel hız uygulamayı deniyoruz.
	pcall(function()
		TargetRoot.AssemblyLinearVelocity = Velocity
		TargetRoot.AssemblyAngularVelocity =
			Vector3.new(
				FlingPower,
				FlingPower,
				FlingPower
			)
	end)

	-- Kendi karakterimiz üzerinden de itme denemesi
	pcall(function()
		Root.AssemblyLinearVelocity =
			- Direction * math.min(FlingPower*.35,200)
	end)
end

FlingButton.MouseButton1Click:Connect(function()

	State.WalkFling = not State.WalkFling

	FlingButton.Text =
		"💥  Walk Fling  ["..
		(State.WalkFling and "ON" or "OFF").."]"

	FlingButton.TextColor3 =
		State.WalkFling
		and Color3.fromRGB(255,255,255)
		or Color3.fromRGB(235,235,235)

	PlaySound(State.WalkFling and "Success" or "Click")
end)

FlingPowerApply.MouseButton1Click:Connect(function()

	local N = tonumber(FlingPowerBox.Text)

	if N then
		FlingPower =
			math.clamp(N,1,MAX_VALUE)

		FlingPowerBox.Text = ""
		PlaySound("Success")
	end
end)

--========================================================
-- ANTI AFK
--========================================================

local AntiAFKButton = Button("⏱  Anti-AFK  [OFF]")

AntiAFKButton.MouseButton1Click:Connect(function()

	State.AntiAFK = not State.AntiAFK

	AntiAFKButton.Text =
		"⏱  Anti-AFK  ["..
		(State.AntiAFK and "ON" or "OFF").."]"
end)

Player.Idled:Connect(function()

	if State.AntiAFK then

		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

--========================================================
-- RESET
--========================================================

local ResetButton = Button("🔄  Reset Character")

ResetButton.MouseButton1Click:Connect(function()

	if Humanoid then
		Humanoid.Health = 0
	end
end)

--========================================================
-- RENDER
--========================================================

local LastFPS = os.clock()
local Frames = 0
local FPS = 0
local ShakeTime = 0
local FlingTimer = 0

RunService.RenderStepped:Connect(function(dt)

	if Destroyed then
		return
	end

	Frames += 1

	if os.clock() - LastFPS >= 1 then
		FPS = Frames
		Frames = 0
		LastFPS = os.clock()
	end

	--====================================================
	-- NOCLIP
	--====================================================

	if State.Noclip and Character then

		for _,Object in ipairs(Character:GetDescendants()) do

			if Object:IsA("BasePart") then
				Object.CanCollide = false
			end
		end
	end

	--====================================================
	-- PLATFORM
	--====================================================

	if State.Platform and Platform and Root then

		Platform.CFrame =
			CFrame.new(
				Root.Position.X,
				Root.Position.Y - 3.2,
				Root.Position.Z
			)
	end

	--====================================================
	-- SPIN
	--====================================================

	if State.Spin and Root then

		Root.CFrame =
			Root.CFrame *
			CFrame.Angles(
				0,
				math.rad(SpinSpeed),
				0
			)
	end

	--====================================================
	-- WALK FLING
	--====================================================

	if State.WalkFling and Root then

		FlingTimer += dt

		if FlingTimer >= .08 then

			FlingTimer = 0

			for _,Target in ipairs(Players:GetPlayers()) do

				if Target ~= Player
					and Target.Character then

					TryFlingTarget(Target.Character)
				end
			end
		end
	end

	--====================================================
	-- COORDINATES
	--====================================================

	if State.Coordinates and Root then

		local P = Root.Position

		CoordLabel.Text =
			string.format(
				"  X %.1f\n  Y %.1f\n  Z %.1f",
				P.X,
				P.Y,
				P.Z
			)
	end

	--====================================================
	-- FPS
	--====================================================

	if State.FPS then
		FPSLabel.Text = "FPS: "..FPS
	end

	--====================================================
	-- PING
	--====================================================

	if State.Ping then

		local Ping = math.floor(
			Player:GetNetworkPing() * 1000
		)

		PingLabel.Text =
			"Ping: "..Ping.." ms"
	end

	--====================================================
	-- CAMERA SHAKE
	--====================================================

	if State.CameraShake then

		ShakeTime += dt * 12

		local X =
			math.sin(ShakeTime)
			* ShakePower / 100

		local Y =
			math.cos(ShakeTime * 1.3)
			* ShakePower / 100

		Camera.CFrame =
			Camera.CFrame *
			CFrame.Angles(X,Y,0)
	end
end)

--========================================================
-- DRAG
--========================================================

local Dragging = false
local DragStart
local StartPos

Header.InputBegan:Connect(function(Input)

	if Input.UserInputType ==
		Enum.UserInputType.MouseButton1
		or Input.UserInputType ==
		Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPos = Main.Position

		Input.Changed:Connect(function()

			if Input.UserInputState ==
				Enum.UserInputState.End then

				Dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(Input)

	if not Dragging then
		return
	end

	if Input.UserInputType ==
		Enum.UserInputType.MouseMovement
		or Input.UserInputType ==
		Enum.UserInputType.Touch then

		local Delta =
			Input.Position - DragStart

		Main.Position =
			UDim2.new(
				StartPos.X.Scale,
				StartPos.X.Offset + Delta.X,
				StartPos.Y.Scale,
				StartPos.Y.Offset + Delta.Y
			)
	end
end)

--========================================================
-- MINIMIZE
--========================================================

local Mini = Instance.new("TextButton")
Mini.Size = UDim2.fromOffset(185,35)
Mini.Position = UDim2.fromOffset(10,10)
Mini.BackgroundColor3 = Color3.fromRGB(8,8,9)
Mini.Text = "──── AZAMET • BY ZETH ────"
Mini.Font = Enum.Font.GothamBold
Mini.TextSize = 10
Mini.TextColor3 = Color3.fromRGB(255,255,255)
Mini.AutoButtonColor = false
Mini.Visible = false
Mini.ZIndex = 95
Mini.Parent = Gui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0,9)
MiniCorner.Parent = Mini

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Color3.fromRGB(255,255,255)
MiniStroke.Thickness = 1
MiniStroke.Parent = Mini

Minimize.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Main.Visible = false
	Mini.Visible = true
end)

Mini.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Mini.Visible = false
	Main.Visible = true
end)

--========================================================
-- CLOSE MODAL
--========================================================

local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.fromScale(1,1)
Overlay.BackgroundColor3 = Color3.new(0,0,0)
Overlay.BackgroundTransparency = .35
Overlay.Visible = false
Overlay.ZIndex = 100
Overlay.Parent = Gui

local Confirm = Instance.new("Frame")
Confirm.Size = UDim2.fromOffset(315,175)
Confirm.Position = UDim2.fromScale(.5,.5)
Confirm.AnchorPoint = Vector2.new(.5,.5)
Confirm.BackgroundColor3 = Color3.fromRGB(10,10,11)
Confirm.Visible = false
Confirm.ZIndex = 101
Confirm.Parent = Gui

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0,15)
ConfirmCorner.Parent = Confirm

local ConfirmStroke = Instance.new("UIStroke")
ConfirmStroke.Color = Color3.fromRGB(255,255,255)
ConfirmStroke.Thickness = 1.5
ConfirmStroke.Parent = Confirm

local ConfirmTitle = Instance.new("TextLabel")
ConfirmTitle.Size = UDim2.new(1,0,0,40)
ConfirmTitle.BackgroundTransparency = 1
ConfirmTitle.Text = "UI'Yİ KAPAT?"
ConfirmTitle.Font = Enum.Font.GothamBlack
ConfirmTitle.TextSize = 18
ConfirmTitle.TextColor3 = Color3.fromRGB(255,255,255)
ConfirmTitle.ZIndex = 102
ConfirmTitle.Parent = Confirm

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Size = UDim2.new(1,-20,0,50)
ConfirmText.Position = UDim2.fromOffset(10,42)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Text = "Emin misin?\nAktif özellikler kapatılacak."
ConfirmText.Font = Enum.Font.Gotham
ConfirmText.TextSize = 12
ConfirmText.TextColor3 = Color3.fromRGB(170,170,170)
ConfirmText.ZIndex = 102
ConfirmText.Parent = Confirm

local No = Instance.new("TextButton")
No.Size = UDim2.fromOffset(125,38)
No.Position = UDim2.fromOffset(20,120)
No.BackgroundColor3 = Color3.fromRGB(35,35,36)
No.Text = "HAYIR"
No.Font = Enum.Font.GothamBold
No.TextSize = 12
No.TextColor3 = Color3.fromRGB(255,255,255)
No.ZIndex = 102
No.Parent = Confirm

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0,9)
NoCorner.Parent = No

local Yes = Instance.new("TextButton")
Yes.Size = UDim2.fromOffset(125,38)
Yes.Position = UDim2.fromOffset(170,120)
Yes.BackgroundColor3 = Color3.fromRGB(210,210,210)
Yes.Text = "EVET"
Yes.Font = Enum.Font.GothamBlack
Yes.TextSize = 12
Yes.TextColor3 = Color3.fromRGB(0,0,0)
Yes.ZIndex = 102
Yes.Parent = Confirm

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0,9)
YesCorner.Parent = Yes

Close.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Overlay.Visible = true
	Confirm.Visible = true
end)

No.MouseButton1Click:Connect(function()

	Confirm.Visible = false
	Overlay.Visible = false
end)

Yes.MouseButton1Click:Connect(function()

	Destroyed = true

	StopFly()

	if Platform then
		Platform:Destroy()
	end

	ClearESP()

	workspace.Gravity = OldGravity
	Camera.FieldOfView = OldFOV

	Lighting.Brightness = OldLighting.Brightness
	Lighting.ClockTime = OldLighting.ClockTime
	Lighting.FogEnd = OldLighting.FogEnd
	Lighting.Ambient = OldLighting.Ambient
	Lighting.OutdoorAmbient = OldLighting.OutdoorAmbient

	if Crosshair then
		Crosshair:Destroy()
	end

	if Compass then
		Compass:Destroy()
	end

	Gui:Destroy()
end)

--========================================================
-- LOGIN
--========================================================

Login.MouseButton1Click:Connect(function()

	if KeyBox.Text == KEY then

		PlaySound("Success")

		Status.Text = "KEY DOĞRU • BY ZETH"
		Status.TextColor3 = Color3.fromRGB(255,255,255)

		task.wait(.2)

		KeyFrame.Visible = false
		Main.Visible = true

	else

		PlaySound("Error")

		Status.Text = "HATALI KEY!"
		Status.TextColor3 = Color3.fromRGB(255,100,100)

		local Original =
			KeyFrame.Position

		for _ = 1,4 do

			KeyFrame.Position =
				Original + UDim2.fromOffset(7,0)

			task.wait(.035)

			KeyFrame.Position =
				Original - UDim2.fromOffset(7,0)

			task.wait(.035)
		end

		KeyFrame.Position = Original
	end
end)

print("================================")
print("AZAMET HUB • ZETH")
print("Void AŞKIM")
print("Raider BEBEĞİM")
print("================================")
