local Players = game:GetService("Players")

local canDoFakeKick = true

Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg == "/e stopthefake" then
        canDoFakeKick = false
    end
end)

Players.PlayerRemoving:Connect(function(player)
    function chatMessage(msg)
        if canDoFakeKick then
            if game.TextChatService.ChatVersion ~= Enum.ChatVersion.LegacyChatService then
                game.TextChatService.TextChannels.RBXGeneral:SendAsync(tostring(msg))
            else
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(msg), "All")
            end
        end
    end
    chatMessage(getgenv().fakeKick_prefix .. "kick " .. (getgenv().fakeKick_useDisplay and player.DisplayName or player.Name))
end)
