local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Icy's Hood Script",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Icy's Interface Suite",
   LoadingSubtitle = "by Icy",
   Theme = "Ocean", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Icy's Hood | Key",
      Subtitle = "In Video Discription",
      Note = "Join Discord For More", -- Use this to tell the user how to get a key
      FileName = "IcysHoodKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/raw/s1hjMkBe"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = Window:CreateTab("🏠 Home", nil) -- Title, Image
local MainSection = MainTab:CreateSection("Combat")

Rayfield:Notify({
   Title = "You successfully excuted the Script!",
   Content = "Hood Gui",
   Duration = 4.5,
   Image = nil,
})

local Button = MainTab:CreateButton({
   Name = "Aim Lock",
   Callback = function()
-- Aim Assist Script for Roblox (Da Hood-like game)
-- This script provides smooth camera control and helps aim at nearby players.
-- Aim assist can be toggled using the Q key, and it stays locked onto the first player it targets.
-- No target switching will occur.

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local userInputService = game:GetService("UserInputService")
local mouse = player:GetMouse()

-- Settings for Aim Assist
local aimAssistRange = 50  -- Range in studs to detect enemies
local aimSpeed = 0.2  -- Speed of smoothing the aim towards the target
local lockedTarget = nil  -- Locked target for aim assist

-- Variable to track if Aim Assist is enabled
local isAimAssistEnabled = false

-- Visual Feedback: Show a red circle around the locked target (for demonstration purposes)
local function createTargetIndicator(target)
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = target.Character.HumanoidRootPart
    billboard.Size = UDim2.new(0, 10, 0, 10)
    billboard.StudsOffset = Vector3.new(0, 2, 0)  -- Position the indicator slightly above the target
    billboard.Parent = target.Character

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red circle
    frame.BackgroundTransparency = 0.5  -- Semi-transparent
    frame.Parent = billboard

    return billboard
end

-- Remove the target indicator when no longer needed
local function removeTargetIndicator(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local billboard = target.Character:FindFirstChildOfClass("BillboardGui")
        if billboard then
            billboard:Destroy()
        end
    end
end

-- Function to find the closest enemy within range
local function getClosestEnemy()
    local closestEnemy = nil
    local shortestDistance = aimAssistRange  -- Start with a maximum distance

    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                closestEnemy = otherPlayer
                shortestDistance = distance
            end
        end
    end

    return closestEnemy
end

-- Function to smoothly adjust the camera aim towards the target
local function smoothCameraAim(target)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local targetPos = target.Character.HumanoidRootPart.Position
    local targetDirection = (targetPos - camera.CFrame.Position).unit  -- Direction to the target
    
    -- Smoothly rotate the camera towards the target direction
    local newCFrame = camera.CFrame:lerp(CFrame.lookAt(camera.CFrame.Position, targetPos), aimSpeed)
    camera.CFrame = newCFrame
end

-- Detect when the Q key is pressed to toggle Aim Assist
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- When the Q key is pressed, toggle the Aim Assist
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Q then
        isAimAssistEnabled = not isAimAssistEnabled  -- Toggle Aim Assist state
        
        if isAimAssistEnabled then
            -- If Aim Assist is enabled, lock onto the closest enemy
            lockedTarget = getClosestEnemy()
            if lockedTarget then
                print("Aim Assist Enabled - Locked onto " .. lockedTarget.Name)
                -- Create the target indicator
                createTargetIndicator(lockedTarget)
            else
                print("Aim Assist Enabled - No target in range")
            end
        else
            -- If Aim Assist is disabled, unlock the target
            print("Aim Assist Disabled")
            -- Remove the target indicator
            if lockedTarget then
                removeTargetIndicator(lockedTarget)
            end
            lockedTarget = nil
        end
    end
end)

-- Main loop to check for enemies and adjust camera when aiming
game:GetService("RunService").Heartbeat:Connect(function()
    if isAimAssistEnabled and lockedTarget then
        -- If Aim Assist is enabled and there's a locked target, apply aim assist
        smoothCameraAim(lockedTarget)
    end
end)

   end,
})

local Button = MainTab:CreateButton({
   Name = "Esp",
   Callback = function()
 -- Roblox script to highlight torsos with selection boxes and add nametags above heads
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Settings for the Selection Box
local selectionBoxSize = Vector3.new(2, 3, 2)  -- Size of the selection box (Adjust as needed)
local boxColor = Color3.fromRGB(255, 0, 0)  -- Red color for the selection box

-- Function to create the Selection Box on the character torso
local function createSelectionBox(character)
    -- Check if the character has a HumanoidRootPart
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        -- Create the selection box
        local selectionBox = Instance.new("SelectionBox")
        selectionBox.Adornee = humanoidRootPart
        selectionBox.Parent = character
        selectionBox.Color3 = boxColor  -- Set the box color
        selectionBox.Size = selectionBoxSize  -- Set the box size
        selectionBox.LineThickness = 0.05  -- Thickness of the selection box lines
        selectionBox.OcclusionMode = Enum.OcclusionMode.None  -- Disable occlusion (make it visible through walls)
    end
end

-- Function to create the Nametag above the player's head
local function createNametag(character, playerName)
    -- Check if the character has a Head part
    local head = character:FindFirstChild("Head")
    if head then
        -- Create a BillboardGui to display the name
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Parent = head
        billboardGui.Adornee = head
        billboardGui.Size = UDim2.new(0, 100, 0, 50)  -- Set the size of the nametag
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)  -- Position the nametag above the head
        billboardGui.AlwaysOnTop = true  -- Keep the nametag above everything else

        -- Create the TextLabel to display the name
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Parent = billboardGui
        nameLabel.Text = playerName
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text color
        nameLabel.TextStrokeTransparency = 0.8  -- Add outline to the text
        nameLabel.TextSize = 14  -- Set the text size
        nameLabel.BackgroundTransparency = 1  -- Remove the background
        nameLabel.Size = UDim2.new(1, 0, 1, 0)  -- Make the label fill the whole BillboardGui
    end
end

-- Function to remove Selection Boxes and Nametags when a character is removed
local function removeSelectionBoxAndNametag(character)
    -- Remove any existing selection boxes
    local existingSelectionBox = character:FindFirstChildOfClass("SelectionBox")
    if existingSelectionBox then
        existingSelectionBox:Destroy()
    end

    -- Remove any existing nametags
    local existingBillboardGui = character:FindFirstChild("Head") and character.Head:FindFirstChildOfClass("BillboardGui")
    if existingBillboardGui then
        existingBillboardGui:Destroy()
    end
end

-- Create Selection Boxes and Nametags for players already in the game
for _, player in ipairs(Players:GetPlayers()) do
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        createSelectionBox(player.Character)
        createNametag(player.Character, player.Name)
    end
end

-- Set up event listeners to handle new players joining and leaving
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Wait until the character's humanoid root part is available
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        if humanoidRootPart then
            createSelectionBox(character)
            createNametag(character, player.Name)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        removeSelectionBoxAndNametag(player.Character)
    end
end)

-- Continuously update for any changes (e.g., in case a player's character is reset)
game:GetService("RunService").Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Ensure the selection box and nametag are updated or recreated if needed
            if not player.Character:FindFirstChildOfClass("SelectionBox") then
                createSelectionBox(player.Character)
            end
            if not player.Character.Head:FindFirstChildOfClass("BillboardGui") then
                createNametag(player.Character, player.Name)
            end
        end
    end
end)

   end,
})
