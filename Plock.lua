local v1 = {}
local vu2 = game:GetService('Players').LocalPlayer
local v3 = game:GetService('UserInputService')
local vu4 = nil
local vu5 = nil
local vu6 = false
local vu7 = false
local vu8 = false
local vu9 = nil
local vu10 = {}
local vu11 = false
local vu12 = nil

local function vu17()
    local v13, v14, v15 = ipairs(vu10)

    while true do
        local vu16

        v15, vu16 = v13(v14, v15)

        if v15 == nil then
            break
        end

        pcall(function()
            vu16:Disconnect()
        end)
    end

    vu10 = {}
end
local function vu18()
    if vu12 then
        vu12:Pause()
    end
end
local function vu19()
    if vu12 then
        vu12:Restore()
    end
end
local function vu22(p20)
    vu4 = p20
    vu5 = p20.Name

    table.insert(vu10, p20.AncestryChanged:Connect(function(_, p21)
        if not p21 then
            vu4 = nil
            vu5 = nil
            vu8 = false
            vu7 = false
            vu6 = false
            vu11 = false

            vu19()
        end
    end))
end
local function vu24()
    local v23 = ((not vu4 or (vu4.Name ~= 'Shark Anchor' or not vu6)) and true or false) and (((vu5 ~= 'Dough-Dough' or not vu7) and true or false) and vu4)

    if v23 then
        if vu4.Name ~= 'Cursed Dual Katana' then
            v23 = false
        else
            v23 = vu8
        end
    end

    return v23
end

v3.TouchStarted:Connect(function(p25)
    local v26 = workspace.CurrentCamera

    if v26 then
        if p25.Position.X > v26.ViewportSize.X / 2 then
            vu11 = true

            if vu24() then
                vu18()
            end
        end
    end
end)
v3.TouchEnded:Connect(function(p27)
    local v28 = workspace.CurrentCamera

    if v28 then
        if p27.Position.X > v28.ViewportSize.X / 2 then
            vu11 = false

            vu19()

            vu8 = false
            vu7 = false
            vu6 = false
        end
    end
end)

local function vu31()
    if vu9 then
        pcall(function()
            vu9:Disconnect()
        end)

        vu9 = nil
    end

    task.spawn(function()
        while true do
            local vu29 = false

            local function v30()
                vu29 = true
            end

            gui = vu2:FindFirstChild('PlayerGui'):FindFirstChild('Main')

            if gui then
                dmgCounter = gui:FindFirstChild('DmgCounter')

                if dmgCounter then
                    dmgTextLabel = dmgCounter:FindFirstChild('Text')

                    if dmgTextLabel then
                        vu9 = dmgTextLabel:GetPropertyChangedSignal('Text'):Connect(function()
                            if 0 < (tonumber(dmgTextLabel.Text) or 0) and (vu24() and vu11) then
                                vu18()
                            elseif not vu11 then
                                vu19()
                            end
                        end)

                        table.insert(vu10, vu9)
                        v30()
                    else
                        warn('[DamageLog] TextLabel inside DmgCounter not found, retrying...')
                        task.wait(1)
                    end
                else
                    warn('[DamageLog] DmgCounter not found, retrying...')
                    task.wait(1)
                end
            else
                warn('[DamageLog] Main GUI not found, retrying...')
                task.wait(1)
            end
            if vu29 then
                return
            end
        end
    end)
end

if not getgenv().VSkillHooked then
    getgenv().VSkillHooked = true

    local vu32 = nil

    vu32 = hookmetamethod(game, '__namecall', function(p33, ...)
        local v34 = getnamecallmethod()
        local v35 = {...}

        if v34 == 'InvokeServer' or v34 == 'FireServer' then
            local v36 = v35[1]

            if typeof(v36) == 'string' and (v36:upper() == 'Z' and (vu4 and vu4.Name == 'Shark Anchor')) then
                vu6 = true
            end
            if typeof(v36) == 'string' and (v36:upper() == 'V' and vu5 == 'Dough-Dough') then
                vu7 = true
            end
            if typeof(v36) == 'string' and (v36:upper() == 'Z' and (vu4 and vu4.Name == 'Cursed Dual Katana')) then
                vu8 = true
            end
        end

        return vu32(p33, ...)
    end)
end

local function v40(p37)
    vu17()

    vu8 = false
    vu7 = false
    vu6 = false
    vu11 = false

    vu19()
    table.insert(vu10, p37.ChildAdded:Connect(function(p38)
        if p38:IsA('Tool') then
            vu22(p38)
        end
    end))
    table.insert(vu10, p37.ChildRemoved:Connect(function(p39)
        if p39 == vu4 and vu5 then
            vu4 = nil
            vu5 = nil
            vu8 = false
            vu7 = false
            vu6 = false
            vu11 = false

            vu19()
        end
    end))
    vu31()
end

vu2.CharacterAdded:Connect(v40)

if vu2.Character then
    v40(vu2.Character)
end

function v1.CheckVSkillUsage(_, p41)
    vu12 = p41

    vu31()
end

return v1
