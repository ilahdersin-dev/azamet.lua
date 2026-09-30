--// =========================================================
--// AZAMET HUB
--// By Zeth
--// İyi Kullanımlar
--// =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

local Camera = workspace.CurrentCamera

--==================================================
-- KEY
--==================================================

local KEY = "raiderzethvoid"

--==================================================
-- STATE
--==================================================

local State = {
	Fly = false,
	ESP = false,
	Invisible = false,
	Noclip = false,
	Fullbright = false,
	InfiniteJump = false,
	Platform = false,
	Coordinates = false,
	FPS = false,
	Ping = false,
	Crosshair = false,
	Compass = false,
	CameraShake = false,
	WalkFling = false,
	AntiAFK = false,
	Atmosphere = false,
	Spin = false,
}

--==================================================
-- SETTINGS
--==================================================

local FlySpeed = 60
local SpinSpeed = 5
local CameraShakePower = 2

local OldGravity = workspace.Gravity
local OldFOV = Camera.FieldOfView

local OriginalLighting = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient
}

local Destroyed = false

--==================================================
-- CHARACTER REFRESH
--==================================================

local function RefreshCharacter()
	Character = Player.Character or Player.CharacterAdded:Wait()

	Humanoid = Character:WaitForChild("Humanoid")
	Root = Character:WaitForChild("HumanoidRootPart")
end

Player.CharacterAdded:Connect(function()
	task.wait(0.7)

	if not Destroyed then
		RefreshCharacter()
	end
end)

--==================================================
-- SOUND SYSTEM
--==================================================

local function PlaySound(soundType)
	local Sound = Instance.new("Sound")

	Sound.SoundId = "rbxasset://sounds/electronicpingshort.wav"
	Sound.Volume = 0.35
	Sound.Parent = SoundService

	if soundType == "Error" then
		Sound.PlaybackSpeed = 0.65

	elseif soundType == "Success" then
		Sound.PlaybackSpeed = 1.35

	else
		Sound.PlaybackSpeed = 1
	end

	Sound:Play()

	task.delay(2, function()
		if Sound then
			Sound:Destroy()
		end
	end)
end

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "AZAMET_BY_ZETH"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Scale = Instance.new("UIScale")
Scale.Scale = UIS.TouchEnabled and 0.88 or 1
Scale.Parent = Gui

--==================================================
-- KEY FRAME
--==================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.fromOffset(330,245)
KeyFrame.Position = UDim2.fromScale(0.5,0.5)
KeyFrame.AnchorPoint = Vector2.new(0.5,0.5)
KeyFrame.BackgroundColor3 = Color3.fromRGB(7,10,15)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = Gui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0,14)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(0,255,210)
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,48)
Title.BackgroundTransparency = 1
Title.Text = "AZAMET"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 27
Title.TextColor3 = Color3.fromRGB(0,255,210)
Title.Parent = KeyFrame

local By = Instance.new("TextLabel")
By.Size = UDim2.new(1,0,0,22)
By.Position = UDim2.fromOffset(0,42)
By.BackgroundTransparency = 1
By.Text = "By Zeth"
By.Font = Enum.Font.GothamBold
By.TextSize = 13
By.TextColor3 = Color3.fromRGB(145,155,170)
By.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1,-40,0,42)
KeyBox.Position = UDim2.fromOffset(20,78)
KeyBox.BackgroundColor3 = Color3.fromRGB(15,20,28)
KeyBox.PlaceholderText = "KEY GİR..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.PlaceholderColor3 = Color3.fromRGB(100,110,120)
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = KeyFrame

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0,8)
KeyBoxCorner.Parent = KeyBox

local Login = Instance.new("TextButton")
Login.Size = UDim2.fromOffset(135,40)
Login.Position = UDim2.fromOffset(20,132)
Login.BackgroundColor3 = Color3.fromRGB(0,190,160)
Login.Text = "GİRİŞ"
Login.Font = Enum.Font.GothamBold
Login.TextSize = 14
Login.TextColor3 = Color3.fromRGB(0,0,0)
Login.AutoButtonColor = false
Login.Parent = KeyFrame

local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0,8)
LoginCorner.Parent = Login

local GetKey = Instance.new("TextButton")
GetKey.Size = UDim2.fromOffset(135,40)
GetKey.Position = UDim2.fromOffset(175,132)
GetKey.BackgroundColor3 = Color3.fromRGB(25,32,42)
GetKey.Text = "🔑 KEY AL"
GetKey.Font = Enum.Font.GothamBold
GetKey.TextSize = 13
GetKey.TextColor3 = Color3.fromRGB(0,255,210)
GetKey.AutoButtonColor = false
GetKey.Parent = KeyFrame

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0,8)
GetKeyCorner.Parent = GetKey

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1,-30,0,45)
KeyStatus.Position = UDim2.fromOffset(15,185)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = "Key gerekli • By Zeth"
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextSize = 12
KeyStatus.TextColor3 = Color3.fromRGB(130,140,150)
KeyStatus.Parent = KeyFrame

--==================================================
-- KEY AL
--==================================================

local DiscordInvite = "https://discord.gg/FNrA9rfCZz"

GetKey.MouseButton1Click:Connect(function()
	PlaySound("Click")

	-- Roblox Studio dışında clipboard desteği varsa
	if setclipboard then
		setclipboard(DiscordInvite)

		KeyStatus.Text = "Discord linki kopyalandı!"
		KeyStatus.TextColor3 = Color3.fromRGB(0,255,210)
	else
		KeyStatus.Text = "discord.gg/FNrA9rfCZz"
		KeyStatus.TextColor3 = Color3.fromRGB(0,255,210)
	end
end)

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(520,360)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Color3.fromRGB(6,9,14)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,13)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0,220,185)
MainStroke.Thickness = 1.2
MainStroke.Parent = Main

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,48)
Header.BackgroundColor3 = Color3.fromRGB(10,15,22)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0,13)
HeaderCorner.Parent = Header

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1,-100,1,0)
HeaderTitle.Position = UDim2.fromOffset(15,0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "AZAMET  •  By Zeth"
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextSize = 17
HeaderTitle.TextColor3 = Color3.fromRGB(0,255,210)
HeaderTitle.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(38,32)
Minimize.Position = UDim2.new(1,-78,0,8)
Minimize.BackgroundColor3 = Color3.fromRGB(25,32,42)
Minimize.Text = "—"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.AutoButtonColor = false
Minimize.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0,7)
MinCorner.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(32,32)
Close.Position = UDim2.new(1,-38,0,8)
Close.BackgroundColor3 = Color3.fromRGB(120,35,45)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 20
Close.TextColor3 = Color3.new(1,1,1)
Close.AutoButtonColor = false
Close.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,7)
CloseCorner.Parent = Close

--==================================================
-- SCROLL
--==================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-20,1,-62)
Scroll.Position = UDim2.fromOffset(10,55)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(0,220,185)
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,7)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0,3)
Padding.PaddingBottom = UDim.new(0,12)
Padding.Parent = Scroll

local function UpdateCanvas()
	Scroll.CanvasSize = UDim2.fromOffset(
		0,
		Layout.AbsoluteContentSize.Y + 20
	)
end

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)

--==================================================
-- UI HELPERS
--==================================================

local function Button(Text)
	local B = Instance.new("TextButton")

	B.Size = UDim2.new(1,-5,0,38)
	B.BackgroundColor3 = Color3.fromRGB(15,21,29)

	B.Text = Text
	B.Font = Enum.Font.GothamBold
	B.TextSize = 14
	B.TextColor3 = Color3.fromRGB(235,240,245)

	B.AutoButtonColor = false
	B.Parent = Scroll

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,8)
	Corner.Parent = B

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(30,42,52)
	Stroke.Thickness = 1
	Stroke.Parent = B

	B.MouseEnter:Connect(function()
		TweenService:Create(
			B,
			TweenInfo.new(.15),
			{
				BackgroundColor3 = Color3.fromRGB(20,32,40)
			}
		):Play()
	end)

	B.MouseLeave:Connect(function()
		TweenService:Create(
			B,
			TweenInfo.new(.15),
			{
				BackgroundColor3 = Color3.fromRGB(15,21,29)
			}
		):Play()
	end)

	B.MouseButton1Click:Connect(function()
		PlaySound("Click")
	end)

	return B
end

local function Section(Text)
	local L = Instance.new("TextLabel")

	L.Size = UDim2.new(1,-5,0,25)
	L.BackgroundTransparency = 1

	L.Text = "  "..Text
	L.TextXAlignment = Enum.TextXAlignment.Left

	L.Font = Enum.Font.GothamBlack
	L.TextSize = 12
	L.TextColor3 = Color3.fromRGB(0,255,210)

	L.Parent = Scroll

	return L
end

local function InputRow(Placeholder)
	local Box = Instance.new("TextBox")

	Box.Size = UDim2.new(1,-5,0,38)
	Box.BackgroundColor3 = Color3.fromRGB(15,21,29)

	Box.PlaceholderText = Placeholder
	Box.Text = ""

	Box.TextColor3 = Color3.new(1,1,1)
	Box.PlaceholderColor3 = Color3.fromRGB(120,130,140)

	Box.Font = Enum.Font.Gotham
	Box.TextSize = 13

	Box.ClearTextOnFocus = false

	Box.Parent = Scroll

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,8)
	Corner.Parent = Box

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(30,42,52)
	Stroke.Thickness = 1
	Stroke.Parent = Box

	return Box
end

--==================================================
-- MOVEMENT
--==================================================

Section("MOVEMENT")

--==================================================
-- FLY
--==================================================

local FlyButton
local FlyVelocity
local FlyConnection

local function StopFly()
	State.Fly = false

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

	if FlyButton then
		FlyButton.Text = "✈ Fly  [OFF]"
		FlyButton.TextColor3 = Color3.fromRGB(235,240,245)
	end
end

local function SetFly(Value)
	if Value then

		RefreshCharacter()

		State.Fly = true

		FlyButton.Text = "✈ Fly  [ON]"
		FlyButton.TextColor3 = Color3.fromRGB(0,255,210)

		if FlyVelocity then
			FlyVelocity:Destroy()
		end

		FlyVelocity = Instance.new("BodyVelocity")
		FlyVelocity.Name = "AZAMET_FlyVelocity"

		FlyVelocity.MaxForce = Vector3.new(
			math.huge,
			math.huge,
			math.huge
		)

		FlyVelocity.P = 25000
		FlyVelocity.Velocity = Vector3.zero
		FlyVelocity.Parent = Root

		Humanoid.PlatformStand = true

		FlyConnection = RunService.RenderStepped:Connect(function()

			if not State.Fly then
				return
			end

			if not Character
				or not Character.Parent
				or not Humanoid
				or not Root
				or not Root.Parent then

				RefreshCharacter()

				if FlyVelocity then
					FlyVelocity:Destroy()
				end

				FlyVelocity = Instance.new("BodyVelocity")
				FlyVelocity.Name = "AZAMET_FlyVelocity"

				FlyVelocity.MaxForce = Vector3.new(
					math.huge,
					math.huge,
					math.huge
				)

				FlyVelocity.P = 25000
				FlyVelocity.Parent = Root

				Humanoid.PlatformStand = true
			end

			-- Mobil joystick ve PC hareketi
			local MoveDirection = Humanoid.MoveDirection

			if MoveDirection.Magnitude > 0 then
				FlyVelocity.Velocity =
					MoveDirection.Unit * FlySpeed
			else
				FlyVelocity.Velocity = Vector3.zero
			end

			-- PC yukarı
			if UIS:IsKeyDown(Enum.KeyCode.Space) then
				FlyVelocity.Velocity +=
					Vector3.new(0,FlySpeed,0)
			end

			-- PC aşağı
			if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
				FlyVelocity.Velocity -=
					Vector3.new(0,FlySpeed,0)
			end
		end)

	else
		StopFly()
	end
end

FlyButton = Button("✈ Fly  [OFF]")

FlyButton.MouseButton1Click:Connect(function()
	SetFly(not State.Fly)
end)

local SpeedBox = InputRow("Fly Speed")

local SpeedApply = Button("⚡ Fly Speed Uygula")

SpeedApply.MouseButton1Click:Connect(function()

	local Number = tonumber(SpeedBox.Text)

	if Number then
		FlySpeed = math.clamp(Number,1,500)

		SpeedBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- WALKSPEED
--==================================================

local WalkBox = InputRow("WalkSpeed")

local WalkApply = Button("🏃 WalkSpeed Uygula")

WalkApply.MouseButton1Click:Connect(function()

	local Number = tonumber(WalkBox.Text)

	if Number and Humanoid then
		Humanoid.WalkSpeed =
			math.clamp(Number,0,500)

		WalkBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- JUMP POWER
--==================================================

local JumpBox = InputRow("JumpPower")

local JumpApply = Button("🦘 JumpPower Uygula")

JumpApply.MouseButton1Click:Connect(function()

	local Number = tonumber(JumpBox.Text)

	if Number and Humanoid then

		Humanoid.UseJumpPower = true

		Humanoid.JumpPower =
			math.clamp(Number,0,300)

		JumpBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- NOCLIP
--==================================================

local NoclipButton = Button("🚫 Noclip  [OFF]")

NoclipButton.MouseButton1Click:Connect(function()

	State.Noclip = not State.Noclip

	NoclipButton.Text =
		"🚫 Noclip  [" ..
		(State.Noclip and "ON" or "OFF") ..
		"]"

	NoclipButton.TextColor3 =
		State.Noclip
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

--==================================================
-- INFINITE JUMP
--==================================================

local InfiniteButton = Button("🦘 Infinite Jump  [OFF]")

InfiniteButton.MouseButton1Click:Connect(function()

	State.InfiniteJump =
		not State.InfiniteJump

	InfiniteButton.Text =
		"🦘 Infinite Jump  [" ..
		(State.InfiniteJump and "ON" or "OFF") ..
		"]"

	InfiniteButton.TextColor3 =
		State.InfiniteJump
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

--==================================================
-- SPIN
--==================================================

local SpinButton = Button("🌀 Spin  [OFF]")

SpinButton.MouseButton1Click:Connect(function()

	State.Spin = not State.Spin

	SpinButton.Text =
		"🌀 Spin  [" ..
		(State.Spin and "ON" or "OFF") ..
		"]"

	SpinButton.TextColor3 =
		State.Spin
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

local SpinSpeedBox = InputRow("Spin Speed")

local SpinApply = Button("🌀 Spin Speed Uygula")

SpinApply.MouseButton1Click:Connect(function()

	local Number = tonumber(SpinSpeedBox.Text)

	if Number then

		SpinSpeed =
			math.clamp(Number,1,100)

		SpinSpeedBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- SIT
--==================================================

local SitButton = Button("🪑 Sit / Stand")

SitButton.MouseButton1Click:Connect(function()

	if Humanoid then
		Humanoid.Sit = not Humanoid.Sit
	end
end)

--==================================================
-- PLATFORM
--==================================================

local Platform
local PlatformButton = Button("🟦 Character Platform  [OFF]")

PlatformButton.MouseButton1Click:Connect(function()

	State.Platform = not State.Platform

	if State.Platform then

		Platform = Instance.new("Part")

		Platform.Name = "AZAMET_Platform"
		Platform.Size = Vector3.new(7,0.5,7)

		Platform.Anchored = true
		Platform.CanCollide = true

		Platform.Transparency = 0.2
		Platform.Material = Enum.Material.Neon

		Platform.Parent = workspace

	else

		if Platform then
			Platform:Destroy()
			Platform = nil
		end
	end

	PlatformButton.Text =
		"🟦 Character Platform  [" ..
		(State.Platform and "ON" or "OFF") ..
		"]"
end)

--==================================================
-- VISUAL
--==================================================

Section("PLAYER / VISUAL")

--==================================================
-- ESP
--==================================================

local ESPButton = Button("👁 ESP  [OFF]")
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

		if Target ~= Player
			and Target.Character then

			local Highlight =
				Instance.new("Highlight")

			Highlight.FillTransparency = 0.65
			Highlight.OutlineColor =
				Color3.fromRGB(0,255,210)

			Highlight.FillColor =
				Color3.fromRGB(0,180,150)

			Highlight.Adornee =
				Target.Character

			Highlight.Parent =
				Target.Character

			table.insert(
				ESPObjects,
				Highlight
			)
		end
	end
end

ESPButton.MouseButton1Click:Connect(function()

	State.ESP = not State.ESP

	ESPButton.Text =
		"👁 ESP  [" ..
		(State.ESP and "ON" or "OFF") ..
		"]"

	ESPButton.TextColor3 =
		State.ESP
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)

	ApplyESP()
end)

Players.PlayerAdded:Connect(function()
	task.wait(1)

	if State.ESP then
		ApplyESP()
	end
end)

--==================================================
-- INVISIBLE
--==================================================

local InvisibleButton = Button("👻 Invisible  [OFF]")

InvisibleButton.MouseButton1Click:Connect(function()

	State.Invisible =
		not State.Invisible

	for _,Object in ipairs(Character:GetDescendants()) do

		if Object:IsA("BasePart") then
			Object.LocalTransparencyModifier =
				State.Invisible and 1 or 0
		end
	end

	InvisibleButton.Text =
		"👻 Invisible  [" ..
		(State.Invisible and "ON" or "OFF") ..
		"]"

	InvisibleButton.TextColor3 =
		State.Invisible
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

--==================================================
-- FULLBRIGHT
--==================================================

local FullbrightButton =
	Button("💡 Fullbright  [OFF]")

FullbrightButton.MouseButton1Click:Connect(function()

	State.Fullbright =
		not State.Fullbright

	if State.Fullbright then

		Lighting.Brightness = 3
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000

		Lighting.Ambient =
			Color3.new(1,1,1)

		Lighting.OutdoorAmbient =
			Color3.new(1,1,1)

	else

		Lighting.Brightness =
			OriginalLighting.Brightness

		Lighting.ClockTime =
			OriginalLighting.ClockTime

		Lighting.FogEnd =
			OriginalLighting.FogEnd

		Lighting.Ambient =
			OriginalLighting.Ambient

		Lighting.OutdoorAmbient =
			OriginalLighting.OutdoorAmbient
	end

	FullbrightButton.Text =
		"💡 Fullbright  [" ..
		(State.Fullbright and "ON" or "OFF") ..
		"]"

	FullbrightButton.TextColor3 =
		State.Fullbright
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

--==================================================
-- FOV
--==================================================

local FOVBox = InputRow("Camera FOV")

local FOVApply = Button("🎥 Camera FOV Uygula")

FOVApply.MouseButton1Click:Connect(function()

	local Number = tonumber(FOVBox.Text)

	if Number then

		Camera.FieldOfView =
			math.clamp(Number,40,120)

		FOVBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- CAMERA ZOOM
--==================================================

local ZoomBox = InputRow("Camera Zoom Max")

local ZoomApply =
	Button("🔭 Camera Zoom Uygula")

ZoomApply.MouseButton1Click:Connect(function()

	local Number = tonumber(ZoomBox.Text)

	if Number then

		Player.CameraMaxZoomDistance =
			math.clamp(Number,5,500)

		ZoomBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- WORLD
--==================================================

Section("WORLD / EFFECTS")

--==================================================
-- GRAVITY
--==================================================

local GravityBox = InputRow("Gravity")

local GravityApply =
	Button("🪐 Gravity Uygula")

GravityApply.MouseButton1Click:Connect(function()

	local Number = tonumber(GravityBox.Text)

	if Number then

		workspace.Gravity =
			math.clamp(Number,0,500)

		GravityBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- CLOCK TIME
--==================================================

local TimeBox =
	InputRow("ClockTime 0-24")

local TimeApply =
	Button("🌅 Time Changer")

TimeApply.MouseButton1Click:Connect(function()

	local Number = tonumber(TimeBox.Text)

	if Number then

		Lighting.ClockTime =
			math.clamp(Number,0,24)

		TimeBox.Text = ""

		PlaySound("Success")
	end
end)

--==================================================
-- ATMOSPHERE
--==================================================

local AtmosButton =
	Button("🌫 Atmosphere  [OFF]")

AtmosButton.MouseButton1Click:Connect(function()

	State.Atmosphere =
		not State.Atmosphere

	local Atmosphere =
		Lighting:FindFirstChildOfClass("Atmosphere")

	if State.Atmosphere then

		if not Atmosphere then

			Atmosphere =
				Instance.new("Atmosphere")

			Atmosphere.Parent =
				Lighting
		end

		Atmosphere.Density = 0.35
		Atmosphere.Haze = 1

	else

		if Atmosphere then
			Atmosphere.Density = 0
		end
	end

	AtmosButton.Text =
		"🌫 Atmosphere  [" ..
		(State.Atmosphere and "ON" or "OFF") ..
		"]"

	AtmosButton.TextColor3 =
		State.Atmosphere
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

--==================================================
-- CAMERA SHAKE
--==================================================

local ShakeButton =
	Button("🎬 Camera Shake  [OFF]")

local ShakeTime = 0

ShakeButton.MouseButton1Click:Connect(function()

	State.CameraShake =
		not State.CameraShake

	ShakeButton.Text =
		"🎬 Camera Shake  [" ..
		(State.CameraShake and "ON" or "OFF") ..
		"]"

	ShakeButton.TextColor3 =
		State.CameraShake
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

--==================================================
-- CROSSHAIR
--==================================================

local CrossButton =
	Button("🎯 Crosshair  [OFF]")

local Crosshair

CrossButton.MouseButton1Click:Connect(function()

	State.Crosshair =
		not State.Crosshair

	if State.Crosshair then

		Crosshair =
			Instance.new("TextLabel")

		Crosshair.Size =
			UDim2.fromOffset(30,30)

		Crosshair.Position =
			UDim2.fromScale(0.5,0.5)

		Crosshair.AnchorPoint =
			Vector2.new(0.5,0.5)

		Crosshair.BackgroundTransparency = 1

		Crosshair.Text = "+"
		Crosshair.Font = Enum.Font.GothamBold
		Crosshair.TextSize = 25

		Crosshair.TextColor3 =
			Color3.fromRGB(0,255,210)

		Crosshair.ZIndex = 50
		Crosshair.Parent = Gui

	else

		if Crosshair then
			Crosshair:Destroy()
			Crosshair = nil
		end
	end

	CrossButton.Text =
		"🎯 Crosshair  [" ..
		(State.Crosshair and "ON" or "OFF") ..
		"]"
end)

--==================================================
-- COMPASS
--==================================================

local CompassButton =
	Button("🧭 Compass  [OFF]")

local Compass

CompassButton.MouseButton1Click:Connect(function()

	State.Compass =
		not State.Compass

	if State.Compass then

		Compass =
			Instance.new("TextLabel")

		Compass.Size =
			UDim2.fromOffset(160,30)

		Compass.Position =
			UDim2.fromScale(0.5,0)

		Compass.AnchorPoint =
			Vector2.new(0.5,0)

		Compass.BackgroundColor3 =
			Color3.fromRGB(5,10,15)

		Compass.BackgroundTransparency = 0.2

		Compass.Text =
			"N     E     S     W"

		Compass.Font =
			Enum.Font.GothamBold

		Compass.TextSize = 13

		Compass.TextColor3 =
			Color3.fromRGB(0,255,210)

		Compass.ZIndex = 50
		Compass.Parent = Gui

		local C =
			Instance.new("UICorner")

		C.CornerRadius =
			UDim.new(0,8)

		C.Parent = Compass

	else

		if Compass then
			Compass:Destroy()
			Compass = nil
		end
	end

	CompassButton.Text =
		"🧭 Compass  [" ..
		(State.Compass and "ON" or "OFF") ..
		"]"
end)

--==================================================
-- MONITOR
--==================================================

Section("MONITOR")

--==================================================
-- COORDINATES
--==================================================

local CoordLabel =
	Instance.new("TextLabel")

CoordLabel.Size =
	UDim2.fromOffset(240,55)

CoordLabel.Position =
	UDim2.fromOffset(12,70)

CoordLabel.BackgroundColor3 =
	Color3.fromRGB(5,10,15)

CoordLabel.BackgroundTransparency = 0.2

CoordLabel.Text = ""

CoordLabel.TextColor3 =
	Color3.fromRGB(0,255,210)

CoordLabel.Font =
	Enum.Font.Code

CoordLabel.TextSize = 12

CoordLabel.TextXAlignment =
	Enum.TextXAlignment.Left

CoordLabel.Visible = false
CoordLabel.ZIndex = 40
CoordLabel.Parent = Gui

local CoordCorner =
	Instance.new("UICorner")

CoordCorner.CornerRadius =
	UDim.new(0,8)

CoordCorner.Parent =
	CoordLabel

local CoordButton =
	Button("📍 Coordinates HUD  [OFF]")

CoordButton.MouseButton1Click:Connect(function()

	State.Coordinates =
		not State.Coordinates

	CoordLabel.Visible =
		State.Coordinates

	CoordButton.Text =
		"📍 Coordinates HUD  [" ..
		(State.Coordinates and "ON" or "OFF") ..
		"]"
end)

--==================================================
-- FPS
--==================================================

local FPSLabel =
	Instance.new("TextLabel")

FPSLabel.Size =
	UDim2.fromOffset(130,30)

FPSLabel.Position =
	UDim2.new(1,-140,0,70)

FPSLabel.BackgroundTransparency = 0.2

FPSLabel.BackgroundColor3 =
	Color3.fromRGB(5,10,15)

FPSLabel.TextColor3 =
	Color3.fromRGB(0,255,210)

FPSLabel.Font =
	Enum.Font.Code

FPSLabel.TextSize = 12

FPSLabel.Visible = false
FPSLabel.ZIndex = 40
FPSLabel.Parent = Gui

local FPSCorner =
	Instance.new("UICorner")

FPSCorner.CornerRadius =
	UDim.new(0,8)

FPSCorner.Parent =
	FPSLabel

local FPSButton =
	Button("📊 FPS Counter  [OFF]")

FPSButton.MouseButton1Click:Connect(function()

	State.FPS =
		not State.FPS

	FPSLabel.Visible =
		State.FPS

	FPSButton.Text =
		"📊 FPS Counter  [" ..
		(State.FPS and "ON" or "OFF") ..
		"]"
end)

--==================================================
-- PING
--==================================================

local PingLabel =
	Instance.new("TextLabel")

PingLabel.Size =
	UDim2.fromOffset(130,30)

PingLabel.Position =
	UDim2.new(1,-140,0,105)

PingLabel.BackgroundColor3 =
	Color3.fromRGB(5,10,15)

PingLabel.BackgroundTransparency = 0.2

PingLabel.TextColor3 =
	Color3.fromRGB(0,255,210)

PingLabel.Font =
	Enum.Font.Code

PingLabel.TextSize = 12

PingLabel.Visible = false
PingLabel.ZIndex = 40
PingLabel.Parent = Gui

local PingCorner =
	Instance.new("UICorner")

PingCorner.CornerRadius =
	UDim.new(0,8)

PingCorner.Parent =
	PingLabel

local PingButton =
	Button("📡 Ping Counter  [OFF]")

PingButton.MouseButton1Click:Connect(function()

	State.Ping =
		not State.Ping

	PingLabel.Visible =
		State.Ping

	PingButton.Text =
		"📡 Ping Counter  [" ..
		(State.Ping and "ON" or "OFF") ..
		"]"
end)

--==================================================
-- ADMIN
--==================================================

Section("ADMIN")

--==================================================
-- WALK FLING
--==================================================

local WalkFlingButton =
	Button("💥 Walk Fling  [OFF]")

WalkFlingButton.MouseButton1Click:Connect(function()

	State.WalkFling =
		not State.WalkFling

	WalkFlingButton.Text =
		"💥 Walk Fling  [" ..
		(State.WalkFling and "ON" or "OFF") ..
		"]"

	WalkFlingButton.TextColor3 =
		State.WalkFling
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)

	local Remote =
		ReplicatedStorage:FindFirstChild(
			"AZAMET_WalkFling"
		)

	if Remote then
		Remote:FireServer(
			State.WalkFling
		)
	end
end)

--==================================================
-- ANTI AFK
--==================================================

local AntiAFKButton =
	Button("⏱ Anti-AFK  [OFF]")

AntiAFKButton.MouseButton1Click:Connect(function()

	State.AntiAFK =
		not State.AntiAFK

	AntiAFKButton.Text =
		"⏱ Anti-AFK  [" ..
		(State.AntiAFK and "ON" or "OFF") ..
		"]"

	AntiAFKButton.TextColor3 =
		State.AntiAFK
		and Color3.fromRGB(0,255,210)
		or Color3.fromRGB(235,240,245)
end)

Player.Idled:Connect(function()

	if State.AntiAFK then

		VirtualUser:CaptureController()

		VirtualUser:ClickButton2(
			Vector2.new()
		)
	end
end)

--==================================================
-- RESET
--==================================================

local ResetButton =
	Button("🔄 Reset Character")

ResetButton.MouseButton1Click:Connect(function()

	if Humanoid then
		Humanoid.Health = 0
	end
end)

--==================================================
-- RENDER LOOP
--==================================================

local LastTime = tick()
local Frames = 0
local FPS = 0

RunService.RenderStepped:Connect(function(DeltaTime)

	if Destroyed then
		return
	end

	Frames += 1

	if tick() - LastTime >= 1 then

		FPS = Frames
		Frames = 0
		LastTime = tick()
	end

	-- Noclip
	if State.Noclip and Character then

		for _,Object in ipairs(
			Character:GetDescendants()
		) do

			if Object:IsA("BasePart") then
				Object.CanCollide = false
			end
		end
	end

	-- Platform
	if State.Platform
		and Platform
		and Root then

		Platform.CFrame =
			CFrame.new(
				Root.Position.X,
				Root.Position.Y - 3.2,
				Root.Position.Z
			)
	end

	-- SPIN
	if State.Spin and Root then

		Root.CFrame =
			Root.CFrame *
			CFrame.Angles(
				0,
				math.rad(SpinSpeed),
				0
			)
	end

	-- Coordinates
	if State.Coordinates and Root then

		local Position =
			Root.Position

		CoordLabel.Text =
			string.format(
				"  X: %.1f\n  Y: %.1f\n  Z: %.1f",
				Position.X,
				Position.Y,
				Position.Z
			)
	end

	-- FPS
	if State.FPS then
		FPSLabel.Text =
			"FPS: "..FPS
	end

	-- Ping
	if State.Ping then

		local Ping =
			math.floor(
				Player:GetNetworkPing() * 1000
			)

		PingLabel.Text =
			"Ping: "..Ping.." ms"
	end

	-- Camera Shake
	if State.CameraShake then

		ShakeTime +=
			DeltaTime * 12

		local X =
			math.sin(ShakeTime)
			* CameraShakePower
			/ 100

		local Y =
			math.cos(ShakeTime * 1.3)
			* CameraShakePower
			/ 100

		Camera.CFrame =
			Camera.CFrame *
			CFrame.Angles(X,Y,0)
	end
end)

--==================================================
-- INFINITE JUMP
--==================================================

UIS.JumpRequest:Connect(function()

	if State.InfiniteJump
		and Humanoid then

		Humanoid:ChangeState(
			Enum.HumanoidStateType.Jumping
		)
	end
end)

--==================================================
-- DRAG
--==================================================

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

--==================================================
-- MINIMIZE
--==================================================

local Mini =
	Instance.new("TextButton")

Mini.Size =
	UDim2.fromOffset(175,34)

Mini.Position =
	UDim2.fromOffset(12,12)

Mini.BackgroundColor3 =
	Color3.fromRGB(7,12,18)

Mini.Text =
	"──── AZAMET • By Zeth ────"

Mini.Font =
	Enum.Font.GothamBold

Mini.TextSize = 11

Mini.TextColor3 =
	Color3.fromRGB(0,255,210)

Mini.Visible = false
Mini.AutoButtonColor = false
Mini.ZIndex = 60
Mini.Parent = Gui

local MiniCorner =
	Instance.new("UICorner")

MiniCorner.CornerRadius =
	UDim.new(0,8)

MiniCorner.Parent = Mini

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

--==================================================
-- CLOSE MODAL
--==================================================

local Overlay =
	Instance.new("Frame")

Overlay.Size =
	UDim2.fromScale(1,1)

Overlay.BackgroundColor3 =
	Color3.new(0,0,0)

Overlay.BackgroundTransparency = 0.4
Overlay.Visible = false
Overlay.ZIndex = 100
Overlay.Parent = Gui

local Confirm =
	Instance.new("Frame")

Confirm.Size =
	UDim2.fromOffset(310,165)

Confirm.Position =
	UDim2.fromScale(0.5,0.5)

Confirm.AnchorPoint =
	Vector2.new(0.5,0.5)

Confirm.BackgroundColor3 =
	Color3.fromRGB(8,12,18)

Confirm.ZIndex = 101
Confirm.Parent = Gui

local ConfirmCorner =
	Instance.new("UICorner")

ConfirmCorner.CornerRadius =
	UDim.new(0,12)

ConfirmCorner.Parent =
	Confirm

local ConfirmStroke =
	Instance.new("UIStroke")

ConfirmStroke.Color =
	Color3.fromRGB(0,255,210)

ConfirmStroke.Thickness = 1.3
ConfirmStroke.Parent = Confirm

local ConfirmTitle =
	Instance.new("TextLabel")

ConfirmTitle.Size =
	UDim2.new(1,0,0,40)

ConfirmTitle.BackgroundTransparency = 1

ConfirmTitle.Text =
	"UI'Yİ KAPAT?"

ConfirmTitle.Font =
	Enum.Font.GothamBlack

ConfirmTitle.TextSize = 19

ConfirmTitle.TextColor3 =
	Color3.fromRGB(0,255,210)

ConfirmTitle.ZIndex = 102
ConfirmTitle.Parent = Confirm

local ConfirmText =
	Instance.new("TextLabel")

ConfirmText.Size =
	UDim2.new(1,-20,0,45)

ConfirmText.Position =
	UDim2.fromOffset(10,40)

ConfirmText.BackgroundTransparency = 1

ConfirmText.Text =
	"Emin misin?\nAktif özellikler kapatılacak."

ConfirmText.Font =
	Enum.Font.Gotham

ConfirmText.TextSize = 12

ConfirmText.TextColor3 =
	Color3.fromRGB(180,190,200)

ConfirmText.ZIndex = 102
ConfirmText.Parent = Confirm

local No =
	Instance.new("TextButton")

No.Size =
	UDim2.fromOffset(125,38)

No.Position =
	UDim2.fromOffset(20,110)

No.BackgroundColor3 =
	Color3.fromRGB(30,38,48)

No.Text =
	"HAYIR"

No.Font =
	Enum.Font.GothamBold

No.TextSize = 13

No.TextColor3 =
	Color3.new(1,1,1)

No.ZIndex = 102
No.AutoButtonColor = false
No.Parent = Confirm

local NoCorner =
	Instance.new("UICorner")

NoCorner.CornerRadius =
	UDim.new(0,8)

NoCorner.Parent = No

local Yes =
	Instance.new("TextButton")

Yes.Size =
	UDim2.fromOffset(125,38)

Yes.Position =
	UDim2.fromOffset(165,110)

Yes.BackgroundColor3 =
	Color3.fromRGB(125,35,45)

Yes.Text =
	"EVET"

Yes.Font =
	Enum.Font.GothamBold

Yes.TextSize = 13

Yes.TextColor3 =
	Color3.new(1,1,1)

Yes.ZIndex = 102
Yes.AutoButtonColor = false
Yes.Parent = Confirm

local YesCorner =
	Instance.new("UICorner")

YesCorner.CornerRadius =
	UDim.new(0,8)

YesCorner.Parent = Yes

Confirm.Visible = false

Close.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Overlay.Visible = true
	Confirm.Visible = true
end)

No.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Confirm.Visible = false
	Overlay.Visible = false
end)

--==================================================
-- CLOSE EVERYTHING
--==================================================

Yes.MouseButton1Click:Connect(function()

	PlaySound("Click")

	Destroyed = true

	-- Fly
	StopFly()

	-- Walk Fling
	local Remote =
		ReplicatedStorage:FindFirstChild(
			"AZAMET_WalkFling"
		)

	if Remote then
		Remote:FireServer(false)
	end

	-- Platform
	if Platform then
		Platform:Destroy()
		Platform = nil
	end

	-- ESP
	ClearESP()

	-- Lighting
	Lighting.Brightness =
		OriginalLighting.Brightness

	Lighting.ClockTime =
		OriginalLighting.ClockTime

	Lighting.FogEnd =
		OriginalLighting.FogEnd

	Lighting.Ambient =
		OriginalLighting.Ambient

	Lighting.OutdoorAmbient =
		OriginalLighting.OutdoorAmbient

	-- Gravity
	workspace.Gravity =
		OldGravity

	-- FOV
	Camera.FieldOfView =
		OldFOV

	-- Crosshair
	if Crosshair then
		Crosshair:Destroy()
	end

	-- Compass
	if Compass then
		Compass:Destroy()
	end

	Overlay:Destroy()
	Confirm:Destroy()
	Gui:Destroy()
end)

--==================================================
-- LOGIN
--==================================================

Login.MouseButton1Click:Connect(function()

	if KeyBox.Text == KEY then

		PlaySound("Success")

		KeyStatus.Text =
			"KEY DOĞRU • By Zeth"

		KeyStatus.TextColor3 =
			Color3.fromRGB(0,255,210)

		task.wait(0.3)

		KeyFrame.Visible = false
		Main.Visible = true

		Main.Size =
			UDim2.fromOffset(480,330)

		TweenService:Create(
			Main,
			TweenInfo.new(
				0.45,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out
			),
			{
				Size =
					UDim2.fromOffset(520,360)
			}
		):Play()

	else

		PlaySound("Error")

		KeyStatus.Text =
			"Hatalı key!"

		KeyStatus.TextColor3 =
			Color3.fromRGB(255,70,80)

		local OriginalPosition =
			KeyFrame.Position

		for i = 1,4 do

			KeyFrame.Position =
				OriginalPosition +
				UDim2.fromOffset(8,0)

			task.wait(0.04)

			KeyFrame.Position =
				OriginalPosition -
				UDim2.fromOffset(8,0)

			task.wait(0.04)
		end

		KeyFrame.Position =
			OriginalPosition
	end
end)

--==================================================
-- START
--==================================================

KeyFrame.Visible = true
Main.Visible = false

print("AZAMET HUB • ZETHBABAPIRO")
