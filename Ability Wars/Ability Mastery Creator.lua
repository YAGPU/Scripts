local module = {}

function module:SetupMastery(abilities)
    local UIS = game:GetService("UserInputService")

    local function isInLobby()
        return game.Players.LocalPlayer.Character.Humanoid.WalkSpeed == 40
    end

    local function doesEquip(ability)
        return game.Players.LocalPlayer.leaderstats.Ability.Value == ability
    end

    local function activateAbility(abilityFunction)
        if abilityFunction then
            abilityFunction()
        end
    end

    coroutine.resume(coroutine.create(function()
        while wait() do
            if not isInLobby() and doesEquip(abilities.Base) then
                if abilities.Q == true then game:GetService("Players").LocalPlayer.PlayerGui["Ability Buttons"].Q.Visible = true end
                if abilities.R == true then game:GetService("Players").LocalPlayer.PlayerGui["Ability Buttons"].R.Visible = true end
                if abilities.E == true then game:GetService("Players").LocalPlayer.PlayerGui["Ability Buttons"].E.Visible = true end
            elseif isInLobby() then
                game:GetService("Players").LocalPlayer.PlayerGui["Ability Buttons"].Q.Visible = false
                game:GetService("Players").LocalPlayer.PlayerGui["Ability Buttons"].R.Visible = false
                game:GetService("Players").LocalPlayer.PlayerGui["Ability Buttons"].E.Visible = false
            end
        end
    end))

    UIS.InputBegan:Connect(function(input)
        if UIS:GetFocusedTextBox() then return end
        if input.KeyCode == Enum.KeyCode.Q and not isInLobby() and doesEquip(abilities.Base) and abilities.Q then
            activateAbility(abilities.QF)
        end
        if input.KeyCode == Enum.KeyCode.R and not isInLobby() and doesEquip(abilities.Base) and abilities.R then
            activateAbility(abilities.RF)
        end
        if input.KeyCode == Enum.KeyCode.E and not isInLobby() and doesEquip(abilities.Base) and abilities.E then
            activateAbility(abilities.EF)
        end
    end)

    game.Players.LocalPlayer.CharacterAdded:Connect(function(chr)
        chr:WaitForChild("Humanoid", 5):GetPropertyChangedSignal("Health"):Connect(function()
            local newval = chr:WaitForChild("Humanoid", 5).Health
            if newval =< 0 then
                activateAbility(abilities.onReset)
            end
        end)
    end)
end

return module
