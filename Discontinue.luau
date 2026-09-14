-- Script Kick Form Game
-- Tempatkan di StarterPlayerScripts atau StarterGui sebagai LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Membuat ScreenGui Utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FakeDisconnectGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true -- Agar menutupi seluruh layar termasuk topbar
screenGui.DisplayOrder = 9999999 -- Agar berada di atas semua UI lain
screenGui.Parent = playerGui

-- 2. Membuat Background Overlay Gelap (LEBIH GELAP)
local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0 -- Lebih gelap (0.65 dari 0.4)
background.BorderSizePixel = 0
background.Parent = screenGui

-- 3. Membuat Kartu Pesan Utama (MainFrame) - WARNA ABU GELAP
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 450, 0, 320)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -160) -- Posisi di tengah layar
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Abu-abu gelap seperti gambar
mainFrame.BorderSizePixel = 0
mainFrame.Parent = background

-- Memberikan sudut melengkung (UICorner) pada MainFrame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

-- Garis pemisah di bawah judul
local separator = Instance.new("Frame")
separator.Name = "Separator"
separator.Size = UDim2.new(0.9, 0, 0, 1)
separator.Position = UDim2.new(0.05, 0, 0, 75)
separator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
separator.Parent = mainFrame

-- 4. Membuat Teks Judul Besar ("Disconnected") - TEXT PUTIH
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 20)
title.BackgroundTransparency = 1
title.Text = "Disconnected"
title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Putih
title.TextSize = 32
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- 5. Membuat Teks Pesan & Error Code - TEXT PUTIH/ABU TERANG
local message = Instance.new("TextLabel")
message.Name = "Message"
message.Size = UDim2.new(0.9, 0, 0, 120)
message.Position = UDim2.new(0.05, 0, 0, 95)
message.BackgroundTransparency = 1
message.Text = "The script is currently down because some bugs, please wait for an update or contact externimate0 for fixed the issue\n\nDown Time: 24 Hour\n(Error Code: 269)"
message.TextColor3 = Color3.fromRGB(180, 180, 180) -- Abu-abu terang
message.TextSize = 18
message.Font = Enum.Font.Gotham
message.TextWrapped = true
message.TextYAlignment = Enum.TextYAlignment.Top
message.Parent = mainFrame

-- 6. Membuat Tombol "Leave" - PUTIH DENGAN TEXT HITAM
local leaveButton = Instance.new("TextButton")
leaveButton.Name = "LeaveButton"
leaveButton.Size = UDim2.new(0.9, 0, 0, 45)
leaveButton.Position = UDim2.new(0.05, 0, 1, -65)
leaveButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Putih seperti gambar
leaveButton.TextColor3 = Color3.fromRGB(0, 0, 0) -- Hitam
leaveButton.Text = "Leave"
leaveButton.TextSize = 20
leaveButton.Font = Enum.Font.GothamSemibold
leaveButton.BorderSizePixel = 0
leaveButton.Parent = mainFrame

-- Memberikan sudut melengkung pada Tombol
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = leaveButton

leaveButton.MouseLeave:Connect(function()
	leaveButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
end)

-- 7. Fungsi saat Tombol "Leave" Ditekan
leaveButton.MouseButton1Click:Connect(function()
	-- game:Shutdown() akan menutup aplikasi Roblox secara paksa dari sisi client
	game:Shutdown()
end)


-- 7. BLOKIR semua input keyboard & mouse kecuali tombol Leave
-- Mematikan CoreGui menu (ESC)
local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- Mencegah player bergerak / berinteraksi
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
humanoid.WalkSpeed = 0
humanoid.JumpPower = 0

-- Mencegah klik kanan / menu lain
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	-- Blokir semua input kecuali klik pada tombol Leave
	if input.UserInputType == Enum.UserInputType.MouseButton1 or
	   input.UserInputType == Enum.UserInputType.MouseButton2 or
	   input.UserInputType == Enum.UserInputType.Touch then
		-- Cek apakah klik mengenai tombol Leave
		local mouse = player:GetMouse()
		if mouse.Target and mouse.Target:IsDescendantOf(leaveButton) then
			return -- Izinkan klik ke tombol Leave
		end
		-- Blokir input lain
		input = nil
	end
end)

-- 8. Fungsi saat Tombol "Leave" Ditekan
leaveButton.MouseButton1Click:Connect(function()
	game:Shutdown()
end)

-- Cegah player respawn / keluar dari UI
player.CharacterAdded:Connect(function(char)
	local hum = char:WaitForChild("Humanoid")
	hum.WalkSpeed = 0
	hum.JumpPower = 0
end)
