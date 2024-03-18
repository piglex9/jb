--https://github.com/piglex9/icetray4
--[[

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2023 Alexandru Armando Davisca Petrescu
    -Vienna, Austria
 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.

--]]

--[[
    fixes for ro-exec/krampus:
        - fixed disable turrets for cargoship
        - fixed isInMuseum function
        - fixed roll features
        - fixed hack's circle updater
        - fixed kick when using jumppower
        - fixed anti break vehicle
        ~ destruct all destructibles needs fix, krampus needs a fix for firetouchinterest on meshparts 
]]

if global then
    print("ice tray is already running")
    while true do
        task.wait()
    end
end

local execution_time = tick()

while true do
    if game:IsLoaded() then
        if game.PlaceId == 606849621 or game.PlaceId == 6898041828 then -- @ jb stable primul id si al doilea este public testing-ul
            break
        end
    end
    task.wait()
end

local IS_NOT_OBFUSCATED = false
if not LPH_OBFUSCATED then
    IS_NOT_OBFUSCATED = true
    function LPH_NO_VIRTUALIZE(...)
        task.spawn(...)
    end
end

local player = game:GetService("Players").LocalPlayer
local runservice = game:GetService("RunService")
local repl = game:GetService("ReplicatedStorage")
local textService = game:GetService("TextChatService")

local function http_request(url)
    local request = request or syn and syn.request
    return request({
        Url = url;
        Method = "GET";
    })
end
local function ON_LOADUP()
    local function ON_VERSION_REQUEST()
        getrenv()._version = "4.0.9"
        getrenv().discord_id = LRM_LinkedDiscordID or 0
    end
    ON_VERSION_REQUEST()
    local function ON_SERVER_CONNECT()
        if global or key or IS_WORKING == true or CONNECTIONS and CONNECTIONS > 1 then
            return player:Kick("ice tray cannot run multiple times. restart game!")
        end
        loadstring(game:HttpGet("https://raw.githubusercontent.com/piglex9/icetray4/main/src/ui.lua"))()
    end
    ON_SERVER_CONNECT()
    local function executionIdentifier()
        local executor = identifyexecutor()
        global.getExecutor = executor
        global.exploit = Electron and "electron" or global.getExecutor == "Krampus" and "krampus/ro-exec" or "???"
        global.version = _version
    end
    executionIdentifier()
    global.config = {}
    global.ui_status = {}
    global.ui.statusRobberies = {}
    global.ui.colorForcing = {}
    local function ui()
        local function ui()
            local window = global.ui.window.tab
            local plr = global.ui.player.tab
            local vehicle = global.ui.vehicle.tab
            local misc = global.ui.misc.tab
            local combat = global.ui.combat.tab
            local markers = global.ui.markers.tab
            local robbery = global.ui.robbery.tab
            local info = global.ui.info.tab
            local uiMarker = markers:Section("Marker")
            local uiTeams, teamsSection = markers:Section("Teams")
            local uiObj, objSection = markers:Section("Objects")
            local uiSettings, settingsSection = markers:Section("Settings")
            local sections = {
                WalkSpeed = plr:Section("Walk Speed");
                JumpPower = plr:Section("Jump Power");
                PlayerUtils = plr:Section("Utils");
                PlayerMisc = plr:Section("Misc");
                Marker = uiMarker;
                Teams = uiTeams;
                Objects = uiObj;
                Settings = uiSettings;
                Gunmods = combat:Section("Gun Mods");
                GunmodsMisc = combat:Section("Misc");
                Gunstore = combat:Section("Gun Store");
                BreakExperience = combat:Section("Break Experience");
                Killaura = combat:Section("Kill Aura");
                Silentaim = combat:Section("Silent Aim");
                Arrestaura = combat:Section("Arrest Aura");
                Waypoints = misc:Section("Waypoints");
                Misc = misc:Section("Misc");
                Prison = misc:Section("Prison");
                BreakVehicles = misc:Section("Break Nearby Vehicles");
                Auras = misc:Section("Auras");
                PlaySounds = misc:Section("Play Sounds");
                RocketFun = misc:Section("Rocket Fun");
                C4Fun = misc:Section("C4 Fun");
                Disablers = misc:Section("Disablers");
                CarModify = vehicle:Section("Car Modifications");
                HeliModify = vehicle:Section("Heli Modifications");
                PlaneModify = vehicle:Section("Plane Modifications");
                BikeModify = vehicle:Section("Bike Modifications");
                BoatModify = vehicle:Section("Boat Modifications");
                VehicleMisc = vehicle:Section("Misc");
                Bank = robbery:Section("Bank");
                BankTruck = robbery:Section("Money Truck");
                Jewelry = robbery:Section("Jewelry");
                Museum = robbery:Section("Museum");
                Casino = robbery:Section("Casino");
                Airdrop = robbery:Section("Airdrop");
                Cargoplane = robbery:Section("Cargo Plane");
                Mansion = robbery:Section("Mansion");
                Trains = robbery:Section("Trains");
                Powerplant = robbery:Section("Powerplant");
                Tomb = robbery:Section("Tomb");
                Cargoship = robbery:Section("Cargoship");
                SmallStores = robbery:Section("Small Stores");
                Info = info:Section("Info");
                LightingTechnology = info:Section("Lighting Technology");
                Config = info:Section("Config");
            }
            global.ui.sections = sections
            local function slider(section, name, min, max, callback)
                local section = sections[section]
                return section:Slider(name, min, max, callback)
            end
            local function toggle(section, name, callback, isMasterSwitch)
                if not isMasterSwitch then
                    isMasterSwitch = false
                end
                local section = sections[section]
                return section:Toggle(name, callback, isMasterSwitch)
            end
            local function label(section, text, forceColor, forceLeft)
                local section = sections[section]
                global.ui.statusRobberies[text] = text
                global.ui.colorForcing[text] = forceColor
                return section:Label(text, forceColor, forceLeft)
            end
            local function button(section, name, callback)
                local section = sections[section]
                return section:Button(name, callback)
            end
            local function textbox(section, name, nametext, callback)
                local section = sections[section]
                return section:TextBox(name, nametext, callback)
            end
            local function selector(section, name, list, callback)
                local section = sections[section]
                return section:Selector(name, list, callback)
            end
            local function dropdown(section, name, list, callback)
                local section = sections[section]
                return section:DropDown(name, list, callback)
            end
            local function keybind(section, name, default_key, callback)
                local section = sections[section]
                return section:KeyBind(name, default_key, callback)
            end
            local function credit(section, name)
                local section = sections[section]
                return section:Credit(name)
            end
            local callback = {}
            local function sections()
                local config = global.config
                local function player()
                    function callback.master_switch_walkspeed(bool)
                        global.ui_status.master_switch_walkspeed = bool
                    end
                    function callback.master_switch_jumppower(bool)
                        global.ui_status.master_switch_jumppower = bool
                    end
                    function callback.walkspeed(num)
                        global.ui_status.walkspeed = num
                    end
                    function callback.ws_disable_if_handcuffed(bool)
                        global.ui_status.ws_disable_if_handcuffed = bool
                    end
                    function callback.jp_disable_if_handcuffed(bool)
                        global.ui_status.jp_disable_if_handcuffed = bool
                    end
                    function callback.jumppower(num)
                        global.ui_status.jumppower = num
                    end
                    function callback.antiragdoll(bool)
                        global.ui_status.antiragdoll = bool
                    end
                    function callback.antifalldamage(bool)
                        global.ui_status.antifalldamage = bool
                    end
                    function callback.antiskydive(bool)
                        global.ui_status.antiskydive = bool
                    end
                    function callback.antitaze(bool)
                        global.ui_status.antitaze = bool
                    end
                    function callback.allow_equip_on_duck(bool)
                        global.ui_status.allow_equip_on_duck = bool
                    end
                    function callback.infduck(bool)
                        global.ui_status.infduck = bool
                    end
                    function callback.infpunch(bool)
                        global.ui_status.infpunch = bool
                    end
                    function callback.alwaysjump(bool)
                        global.ui_status.alwaysjump = bool
                    end
                    function callback.allow_equip_with_items(bool)
                        global.ui_status.allow_equip_with_items = bool
                    end
                    function callback.allow_equip_while_flying(bool)
                        global.ui_status.allow_equip_while_flying = bool
                    end
                    function callback.automatic_respawn_on_taze(bool)
                        global.ui_status.automatic_respawn_on_taze = bool
                    end
                    function callback.alwayssprint(bool)
                        global.ui_status.alwayssprint = bool
                    end
                    function callback.jesus(bool)
                        global.ui_status.jesus = bool
                    end
                    function callback.automatic_punch(bool)
                        global.ui_status.automatic_punch = bool
                    end
                    function callback.always_duck(bool)
                        global.ui_status.always_duck = bool
                    end
                    function callback.respawn()
                        local dieOfFalldamage = global.registry.dieOfFalldamage
                        if dieOfFalldamage then
                            dieOfFalldamage()
                        end
                    end
                    function callback.antiparachute(bool)
                        global.ui_status.antiparachute = bool
                    end
                    function callback.fov(num)
                        global.ui_status.fov = num or 70
                    end
                    function callback.parachute_key(key)
                        global.ui_status.parachute_key = key.Name
                    end
                    function callback.parachute_on_key(bool)
                        global.ui_status.parachute_on_key = bool
                    end
                    function callback.glider_key(key)
                        global.ui_status.glider_key = key.Name
                    end
                    function callback.glider_on_key(bool)
                        global.ui_status.glider_on_key = bool
                    end
                    function callback.one_way_noclip(bool)
                        global.ui_status.one_way_noclip = bool
                    end
                    function callback.noclip_attempt_key(key)
                        global.ui_status.noclip_attempt_key = key.Name
                    end
                    function callback.infinite_roll(bool)
                        global.ui_status.infinite_roll = bool
                    end
                    function callback.roll_duration(num)
                        global.ui_status.roll_duration = num
                    end
                    function callback.always_roll(bool)
                        global.ui_status.always_roll = bool
                    end
                    function callback.break_physics(bool)
                        global.ui_status.break_physics = bool
                    end
                    function callback.frozen_roll(bool)
                        global.ui_status.frozen_roll = bool
                    end
                    function callback.always_juiced(bool)
                        global.ui_status.always_juiced = bool
                    end
                    function callback.fortnite_mode(bool)
                        global.ui_status.fortnite_mode = bool
                    end
                    function callback.fortnite_mode_speed(num)
                        global.ui_status.fortnite_mode_speed = num
                    end
                    function callback.automatic_equip_after_death(bool)
                        global.ui_status.automatic_equip_after_death = bool
                    end
                    local master_switch_walkspeed = toggle("WalkSpeed", "Master Switch", callback.master_switch_walkspeed, true)
                    local ws = slider("WalkSpeed", "Value", 16, 100, callback.walkspeed)
                    master_switch_walkspeed.setChild(ws)
                    local ws_disable_if_handcuffed = toggle("WalkSpeed", "Disable If Handcuffed", callback.ws_disable_if_handcuffed)
                    master_switch_walkspeed.setChild(ws_disable_if_handcuffed)
                    local master_switch_jumppower = toggle("JumpPower", "Master Switch", callback.master_switch_jumppower, true)
                    local jp = slider("JumpPower", "Value", 50, 300, callback.jumppower)
                    master_switch_jumppower.setChild(jp)
                    local jp_disable_if_handcuffed = toggle("JumpPower", "Disable If Handcuffed", callback.jp_disable_if_handcuffed)
                    master_switch_jumppower.setChild(jp_disable_if_handcuffed)
                    local respawn = button("PlayerUtils", "Choose Respawn", callback.respawn)
                    local antiragdoll = toggle("PlayerUtils", "Anti Ragdoll", callback.antiragdoll)
                    local antiskydive = toggle("PlayerUtils", "Anti Skydive", callback.antiskydive)
                    local antiparachute = toggle("PlayerUtils", "Anti Parachute", callback.antiparachute)
                    local antifalldamage = toggle("PlayerUtils", "Anti Falldamage", callback.antifalldamage)
                    local antitaze = toggle("PlayerUtils", "Anti Taze", callback.antitaze)
                    local jesus = toggle("PlayerUtils", "Jesus", callback.jesus)
                    function callback.flight()
                        global.notify("Feature not implemented", 5)
                    end
                    --local flight = toggle("PlayerUtils", "Flight", callback.flight)
                    --config.flight = flight
                    local automatic_equip_after_death = toggle("PlayerUtils", "Automatic Equip After Death", callback.automatic_equip_after_death)
                    config.automatic_equip_after_death = automatic_equip_after_death
                    local allow_equip_on_duck = toggle("PlayerUtils", "Allow Equip On Duck", callback.allow_equip_on_duck)
                    local allow_equip_while_flying = toggle("PlayerUtils", "Allow Equip While Flying", callback.allow_equip_while_flying)
                    local allow_equip_with_items = toggle("PlayerUtils", "Allow Equip With Items", callback.allow_equip_with_items)
                    local fov = slider("PlayerMisc", "FOV", 70, 150, callback.fov)
                    local glider_on_key = toggle("PlayerMisc", "Glider On Key", callback.glider_on_key, true)
                    local glider_key = keybind("PlayerMisc", "Glider Key", Enum.KeyCode.J, callback.glider_key)
                    glider_on_key.setChild(glider_key)
                    local parachute_on_key = toggle("PlayerMisc", "Parachute On Key", callback.parachute_on_key, true)
                    local parachute_key = keybind("PlayerMisc", "Parachute Key", Enum.KeyCode.Z, callback.parachute_key)
                    parachute_on_key.setChild(parachute_key)
                    local one_way_noclip = toggle("PlayerMisc", "1 Way Noclip", callback.one_way_noclip, true)
                    local noclip_attempt_key = keybind("PlayerMisc", "Noclip Attempt Key", Enum.KeyCode.H, callback.noclip_attempt_key)
                    one_way_noclip.setChild(noclip_attempt_key)
                    local infduck = toggle("PlayerMisc", "Infinite Duck", callback.infduck)
                    local infpunch = toggle("PlayerMisc", "Infinite Punch", callback.infpunch)
                    local alwaysjump = toggle("PlayerMisc", "Infinite Jump", callback.alwaysjump)
                    local infinite_roll = toggle("PlayerMisc", "Infinite Roll", callback.infinite_roll)
                    local break_physics = toggle("PlayerMisc", "Break Roll Physics", callback.break_physics)
                    local frozen_roll = toggle("PlayerMisc", "Frozen Roll", callback.frozen_roll)
                    local roll_duration = slider("PlayerMisc", "Roll Duration", 3, 50, callback.roll_duration)
                    local always_roll = toggle("PlayerMisc", "Always Roll", callback.always_roll)
                    local alwayssprint = toggle("PlayerMisc", "Always Sprint", callback.alwayssprint)
                    local automatic_punch = toggle("PlayerMisc", "Always Punch", callback.automatic_punch)
                    local always_duck = toggle("PlayerMisc", "Always Duck", callback.always_duck)
                    local always_juiced = toggle("PlayerMisc", "Always Juiced", callback.always_juiced)
                    local fortnite_mode = toggle("PlayerMisc", "Fortnite Mode", callback.fortnite_mode, true)
                    local fortnite_mode_speed = slider("PlayerMisc", "Animation Speed", 1, 10, callback.fortnite_mode_speed)
                    fortnite_mode.setChild(fortnite_mode_speed)
                    function callback.spinbot(bool)
                        global.ui_status.spinbot = bool
                    end
                    function callback.spinbot_speed(num)
                        global.ui_status.spinbot_speed = num
                    end
                    local spinbot = toggle("PlayerMisc", "Spinbot", callback.spinbot, true)
                    local spinbot_speed = slider("PlayerMisc", "Spin Speed", 1, 15, callback.spinbot_speed)
                    spinbot.setChild(spinbot_speed)
                    config.spinbot = spinbot
                    config.spinbot_speed = spinbot_speed
                    function callback.hide_character()
                        global.registry.hide_character_function()
                    end
                    local hide_character = button("PlayerMisc", "Hide Character", callback.hide_character)
                    local automatic_respawn_on_taze = toggle("PlayerMisc", "Automatic Respawn On Stunned", callback.automatic_respawn_on_taze)
                    config.master_switch_walkspeed = master_switch_walkspeed
                    config.walkspeed = ws
                    config.always_juiced = always_juiced
                    config.infinite_roll = infinite_roll
                    config.fortnite_mode = fortnite_mode
                    config.fortnite_mode_speed = fortnite_mode_speed
                    config.always_roll = always_roll
                    config.frozen_roll = frozen_roll
                    config.break_physics = break_physics
                    config.roll_duration = roll_duration
                    config.ws_disable_if_handcuffed = ws_disable_if_handcuffed
                    config.master_switch_jumppower = master_switch_jumppower
                    config.jumppower = jp
                    config.jp_disable_if_handcuffed = jp_disable_if_handcuffed
                    config.antiragdoll = antiragdoll
                    config.one_way_noclip = one_way_noclip
                    config.noclip_attempt_key = noclip_attempt_key
                    config.antiskydive = antiskydive
                    config.antiparachute = antiparachute
                    config.antifalldamage = antifalldamage
                    config.parachute_on_key = parachute_on_key
                    config.parachute_key = parachute_key
                    config.glider_on_key = glider_on_key
                    config.glider_key = glider_key
                    config.fov = fov
                    config.antitaze = antitaze
                    config.jesus = jesus
                    config.automatic_punch = automatic_punch
                    config.automatic_respawn_on_taze = automatic_respawn_on_taze
                    config.infduck = infduck
                    config.infpunch = infpunch
                    config.alwaysjump = alwaysjump
                    config.always_duck = always_duck
                    config.alwayssprint = alwayssprint
                    config.allow_equip_on_duck = allow_equip_on_duck
                    config.allow_equip_while_flying = allow_equip_while_flying
                    config.allow_equip_with_items = allow_equip_with_items
                end
                local function vehicle()
                    function callback.master_switch_carmodify(bool)
                        global.ui_status.master_switch_carmodify = bool
                    end
                    function callback.car_speed(num)
                        global.ui_status.car_speed = num
                    end
                    function callback.car_brakes(num)
                        global.ui_status.car_brakes = num
                    end
                    function callback.car_turnspeed(num)
                        global.ui_status.car_turnspeed = num
                    end
                    function callback.car_height(num)
                        global.ui_status.car_height = num
                    end
                    function callback.master_switch_heli_speed(bool)
                        global.ui_status.master_switch_heli_speed = bool
                    end
                    function callback.heli_speed(num)
                        global.ui_status.heli_speed = num
                    end
                    function callback.infinite_heli_height(bool)
                        global.ui_status.infinite_heli_height = bool
                    end
                    function callback.infinite_drone_height(bool)
                        global.ui_status.infinite_drone_height = bool
                    end
                    function callback.infinite_nitro(bool)
                        global.ui_status.infinite_nitro = bool
                    end
                    function callback.antitirepop(bool)
                        global.ui_status.antitirepop = bool
                    end
                    function callback.allow_equip_in_vehicle(bool)
                        global.ui_status.allow_equip_in_vehicle = bool
                    end
                    function callback.show_hotbar_in_vehicle(bool)
                        global.ui_status.show_hotbar_in_vehicle = bool
                    end
                    function callback.destroy_all_destructibles(bool)
                        global.ui_status.destroy_all_destructibles = bool
                    end
                    function callback.automatic_flip_vehicle(bool)
                        global.ui_status.automatic_flip_vehicle = bool
                    end
                    function callback.spam_headlights(bool)
                        global.ui_status.spam_headlights = bool
                    end
                    function callback.spam_jeep_roof(bool)
                        global.ui_status.spam_jeep_roof = bool
                    end
                    function callback.always_drift(bool)
                        global.ui_status.always_drift = bool
                    end
                    function callback.automatic_hijack_vehicles(bool)
                        global.ui_status.automatic_hijack_vehicles = bool
                    end
                    function callback.instant_rope(bool)
                        global.ui_status.instant_rope = bool
                    end
                    function callback.rope_aura(bool)
                        global.ui_status.rope_aura = bool
                    end
                    function callback.automatic_eject_vehicle_player(bool)
                        global.ui_status.automatic_eject_vehicle_player = bool
                    end
                    function callback.automatic_lock_vehicle(bool)
                        global.ui_status.automatic_lock_vehicle = bool
                    end
                    function callback.master_switch_carmodify(bool)
                        global.ui_status.master_switch_carmodify = bool
                    end
                    function callback.destruct_delay(num)
                        global.ui_status.destruct_delay = num
                    end
                    function callback.no_trailer(bool)
                        global.ui_status.no_trailer = bool
                    end
                    function callback.vehicle_jump(bool)
                        global.ui_status.vehicle_jump = bool
                    end
                    function callback.vehicle_jump_key(key)
                        global.ui_status.vehicle_jump_key = key.Name 
                    end
                    function callback.master_switch_plane(bool)
                        global.ui_status.master_switch_plane = bool
                    end
                    function callback.anti_max_height(bool)
                        global.ui_status.anti_max_height = bool
                    end
                    function callback.plane_speed(num)
                        global.ui_status.plane_speed = num
                    end
                    function callback.automatic_jet_heat_seek(bool)
                        global.ui_status.automatic_jet_heat_seek = bool
                    end
                    function callback.master_switch_boat(bool)
                        global.ui_status.master_switch_boat = bool
                    end
                    function callback.boat_speed(num)
                        global.ui_status.boat_speed = num
                    end
                    function callback.boat_on_land(bool)
                        global.ui_status.boat_on_land = bool
                    end
                    function callback.master_switch_bike(bool)
                        global.ui_status.master_switch_bike = bool
                    end
                    function callback.bike_speed(num)
                        global.ui_status.bike_speed = num
                    end
                    function callback.dirt_bike_height(bool)
                        global.ui_status.dirt_bike_height = bool
                    end
                    function callback.bike_height_value(num)
                        global.ui_status.bike_height_value = num
                    end
                    function callback.rope_length(num)
                        global.ui_status.rope_length = num
                    end
                    local master_switch_carmodify = toggle("CarModify", "Master Switch", callback.master_switch_carmodify, true)
                    local car_speed = slider("CarModify", "Speed", 1, 50, callback.car_speed)
                    local car_brakes = slider("CarModify", "Brakes", 1, 50, callback.car_brakes)
                    local car_turnspeed = slider("CarModify", "Turn Speed", 1, 5, callback.car_turnspeed)
                    local car_height = slider("CarModify", "Height", 3, 125, callback.car_height)
                    master_switch_carmodify.setChild(car_speed)
                    master_switch_carmodify.setChild(car_brakes)
                    master_switch_carmodify.setChild(car_turnspeed)
                    master_switch_carmodify.setChild(car_height)
                    local infinite_nitro = toggle("CarModify", "Infinite Nitro", callback.infinite_nitro)
                    local automatic_flip_vehicle = toggle("CarModify", "Automatic Flip Vehicle", callback.automatic_flip_vehicle)
                    local spam_headlights = toggle("CarModify", "Spam Headlights", callback.spam_headlights)
                    local spam_jeep_roof = toggle("CarModify", "Spam Jeep Roof", callback.spam_jeep_roof)
                    local always_drift = toggle("CarModify", "Always Drift", callback.always_drift)
                    master_switch_carmodify.setChild(infinite_nitro)
                    master_switch_carmodify.setChild(automatic_flip_vehicle)
                    master_switch_carmodify.setChild(spam_headlights)
                    master_switch_carmodify.setChild(spam_jeep_roof)
                    master_switch_carmodify.setChild(always_drift)
                    local master_switch_heli_speed = toggle("HeliModify", "Master Switch", callback.master_switch_heli_speed, true)
                    local heli_speed = slider("HeliModify", "Speed", 1, 5, callback.heli_speed)
                    local rope_length = slider("HeliModify", "Rope Length", 50, 200, callback.rope_length)
                    local infinite_heli_height = toggle("HeliModify", "Infinite Heli Height", callback.infinite_heli_height)
                    local infinite_drone_height = toggle("HeliModify", "Infinite Drone Height", callback.infinite_drone_height)
                    local instant_rope = toggle("HeliModify", "Instant Rope", callback.instant_rope, true)
                    local rope_aura = toggle("HeliModify", "Extended Rope", callback.rope_aura)
                    master_switch_heli_speed.setChild(heli_speed)
                    master_switch_heli_speed.setChild(rope_length)
                    master_switch_heli_speed.setChild(infinite_heli_height)
                    master_switch_heli_speed.setChild(infinite_drone_height)
                    master_switch_heli_speed.setChild(instant_rope)
                    master_switch_heli_speed.setChild(rope_aura)
                    instant_rope.setChild(rope_aura)
                    local master_switch_plane = toggle("PlaneModify", "Master Switch", callback.master_switch_plane, true)
                    local plane_speed = slider("PlaneModify", "Speed", 1, 5, callback.plane_speed)
                    local anti_max_height = toggle("PlaneModify", "Anti Max Height", callback.anti_max_height)
                    local automatic_jet_heat_seek = toggle("PlaneModify", "Automatic Jet Heat Seek", callback.automatic_jet_heat_seek)
                    master_switch_plane.setChild(plane_speed)
                    master_switch_plane.setChild(anti_max_height)
                    master_switch_plane.setChild(automatic_jet_heat_seek)
                    local master_switch_bike = toggle("BikeModify", "Master Switch", callback.master_switch_bike, true)
                    local bike_speed = slider("BikeModify", "Speed", 1, 5, callback.bike_speed)
                    local dirt_bike_height = toggle("BikeModify", "Dirt Bike Height", callback.dirt_bike_height, true)
                    local bike_height_value = slider("BikeModify", "Value", 1, 15, callback.bike_height_value)
                    dirt_bike_height.setChild(bike_height_value)
                    master_switch_bike.setChild(bike_speed)
                    master_switch_bike.setChild(dirt_bike_height)
                    local master_switch_boat = toggle("BoatModify", "Master Switch", callback.master_switch_boat, true)
                    local boat_speed = slider("BoatModify", "Speed", 1, 5, callback.boat_speed)
                    local boat_on_land = toggle("BoatModify", "Boat On Land", callback.boat_on_land)
                    master_switch_boat.setChild(boat_speed)
                    master_switch_boat.setChild(boat_on_land)
                    local force_set_bodycolor = textbox("VehicleMisc", "Force Bodycolor", "Color Name", callback.force_set_bodycolor)
                    local antitirepop = toggle("VehicleMisc", "Anti Break Vehicle", callback.antitirepop)
                    local no_trailer = toggle("VehicleMisc", "No Semitruck Trailer", callback.no_trailer)
                    local vehicle_jump = toggle("VehicleMisc", "Vehicle Jump", callback.vehicle_jump, true)
                    local vehicle_jump_key = keybind("VehicleMisc", "Vehicle Jump Key", Enum.KeyCode.X, callback.vehicle_jump_key)
                    vehicle_jump.setChild(vehicle_jump_key)
                    local automatic_hijack_vehicles = toggle("VehicleMisc", "Automatic Hijack Vehicles", callback.automatic_hijack_vehicles)
                    local automatic_lock_vehicle = toggle("VehicleMisc", "Automatic Lock Vehicle", callback.automatic_lock_vehicle)
                    local automatic_eject_vehicle_player = toggle("VehicleMisc", "Automatic Eject Passengers", callback.automatic_eject_vehicle_player)
                    local destroy_all_destructibles = toggle("VehicleMisc", "Destroy All Destructibles", callback.destroy_all_destructibles, true)
                    local destruct_delay = slider("VehicleMisc", "Destruct Delay", 0, 10, callback.destruct_delay)
                    destroy_all_destructibles.setChild(destruct_delay)
                    local show_hotbar_in_vehicle = toggle("VehicleMisc", "Show Hotbar In Vehicle", callback.show_hotbar_in_vehicle)
                    config.master_switch_boat = master_switch_boat
                    config.boat_speed = boat_speed
                    config.boat_on_land = boat_on_land
                    config.master_switch_plane = master_switch_plane
                    config.plane_speed = plane_speed
                    config.anti_max_height = anti_max_height
                    config.automatic_jet_heat_seek = automatic_jet_heat_seek
                    config.master_switch_bike = master_switch_bike
                    config.bike_speed = bike_speed
                    config.dirt_bike_height = dirt_bike_height
                    config.bike_height_value = bike_height_value
                    config.master_switch_carmodify = master_switch_carmodify
                    config.car_speed = car_speed
                    config.vehicle_jump = vehicle_jump
                    config.car_brakes = car_brakes
                    config.no_trailer = no_trailer
                    config.car_turnspeed = car_turnspeed
                    config.rope_length = rope_length
                    config.car_height = car_height
                    config.master_switch_heli_speed = master_switch_heli_speed
                    config.destruct_delay = destruct_delay
                    config.heli_speed = heli_speed
                    config.automatic_flip_vehicle = automatic_flip_vehicle
                    config.spam_headlights = spam_headlights
                    config.spam_jeep_roof = spam_jeep_roof
                    config.always_drift = always_drift
                    config.automatic_lock_vehicle = automatic_lock_vehicle
                    config.vehicle_jump_key = vehicle_jump_key
                    config.automatic_eject_vehicle_player = automatic_eject_vehicle_player
                    config.infinite_heli_height = infinite_heli_height
                    config.instant_rope = instant_rope
                    config.rope_aura = rope_aura
                    config.infinite_drone_height = infinite_drone_height
                    config.infinite_nitro = infinite_nitro
                    config.destroy_all_destructibles = destroy_all_destructibles
                    config.automatic_hijack_vehicles = automatic_hijack_vehicles
                    config.antitirepop = antitirepop
                    config.allow_equip_in_vehicle = allow_equip_in_vehicle
                    config.show_hotbar_in_vehicle = show_hotbar_in_vehicle
                end
                local function misc()
                    function callback.always_keycard(bool)
                        global.ui_status.always_keycard = bool
                    end
                    function callback.no_equip_conditions(bool)
                        global.ui_status.no_equip_conditions = bool
                    end
                    function callback.never_unload_world(bool)
                        global.ui_status.never_unload_world = bool
                    end
                    function callback.remove_clothing()
                        if global._loaded then
                            local hitbox = workspace.ClothingRacks.ClothingRack.Hitbox
                            fireclickdetector(hitbox.ClickDetector)
                        end
                    end
                    function callback.give_police_clothing()
                        if global._loaded then
                            local client = global.registry.client
                            for i,v in next, client.descendants.givers do
                                if v.Name == "Station" then
                                    if v.Item.Value == "ShirtPolice" then
                                        fireclickdetector(v.ClickDetector)
                                    end
                                    if v.Item.Value == "PantsPolice" then
                                        fireclickdetector(v.ClickDetector)
                                    end
                                end
                                task.wait()
                            end
                        end
                    end
                    function callback.give_police_hat()
                        if global._loaded then
                            local client = global.registry.client
                            for i,v in next, client.descendants.givers do
                                if v.Name == "Station" then
                                    if v.Item.Value == "HatPolice" then
                                        fireclickdetector(v.ClickDetector)
                                    end
                                end
                            end
                        end
                    end
                    function callback.pickpocketaura(bool)
                        global.ui_status.pickpocketaura = bool
                    end
                    function callback.range_pickpocketaura(num)
                        global.ui_status.range_pickpocketaura = num
                    end
                    function callback.droppedcashaura(bool)
                        global.ui_status.droppedcashaura = bool
                    end
                    function callback.droppedcashrange(num)
                        global.ui_status.droppedcashrange = num
                    end
                    function callback.range_pickpocketaura(num)
                        global.ui_status.range_pickpocketaura = num
                    end
                    function callback.disable_lasers(bool)
                        global.ui_status.disable_lasers = bool
                    end
                    function callback.disable_cameras(bool)
                        global.ui_status.disable_cameras = bool
                    end
                    function callback.master_switch_no_circle_delay(bool)
                        global.ui_status.master_switch_no_circle_delay = bool
                    end
                    function callback.master_switch_open_doors(bool)
                        global.ui_status.master_switch_open_doors = bool
                    end
                    function callback.disable_military_turrets(bool)
                        global.ui_status.disable_military_turrets = bool
                    end
                    function callback.disable_smoke_grenade_effect(bool)
                        global.ui_status.disable_smoke_grenade_effect = bool
                    end
                    function callback.open_security_cameras()
                        if global._loaded then        
                            local client = global.registry.client
                            for i,v in next, client.modules.ui.CircleAction.Specs do
                                if v.Name == "Open Security Cameras" then
                                    v:Callback(true)
                                    break
                                end
                            end 
                        end
                    end
                    function callback.rainbowbullets(bool)
                        global.ui_status.rainbowbullets = bool
                    end
                    function callback.disable_anti_flight_zones(bool)
                        global.ui_status.disable_anti_flight_zones = bool
                    end
                    function callback.infinite_jetpack_fuel(bool)
                        global.ui_status.infinite_jetpack_fuel = bool
                    end
                    function callback.break_vehicles(bool)
                        global.ui_status.break_vehicles = bool
                    end
                    function callback.master_switch_eject_aura(bool)
                        global.ui_status.master_switch_eject_aura = bool
                    end
                    function callback.range_ejectaura(num)
                        global.ui_status.range_ejectaura = num
                    end
                    function callback.master_switch_tase_aura(bool)
                        global.ui_status.master_switch_tase_aura = bool
                    end
                    function callback.automatic_open_front_gates(bool)
                        global.ui_status.automatic_open_front_gates = bool
                    end
                    function callback.automatic_open_side_gate(bool)
                        global.ui_status.automatic_open_side_gate = bool
                    end
                    function callback.automatic_open_main_gate(bool)
                        global.ui_status.automatic_open_main_gate = bool
                    end
                    function callback.automatic_punch_electric_gate(bool)
                        global.ui_status.automatic_punch_electric_gate = bool
                    end
                    function callback.automatic_open_cells(bool)
                        global.ui_status.automatic_open_cells = bool
                    end
                    function callback.master_switch_breakout_aura(bool)
                        global.ui_status.master_switch_breakout_aura = bool
                    end
                    function callback.range_breakoutaura(num)
                        global.ui_status.range_breakoutaura = num
                    end
                    function callback.disable_home_turrets(bool)
                        global.ui_status.disable_home_turrets = bool
                    end
                    function callback.open_secretbases(bool)
                        global.ui_status.open_secretbases = bool
                    end
                    function callback.playsounds(tip)
                        local client = global.registry.client
                        local playsounds = global.registry.playSounds
                        playsounds(tip, {
                            Source = client.playerCharacter;
                            MaxTime = 7;
                            Volume = math.huge;
                        })
                    end
                    function callback.annoyserver(bool)
                        global.ui_status.annoyserver = bool
                    end
                    function callback.clicklightning(bool)
                        global.ui_status.clicklightning = bool
                    end
                    function callback.only_on_weapon_equipped(bool)
                        global.ui_status.only_on_weapon_equipped = bool
                    end
                    function callback.instant_break(bool)
                        global.ui_status.instant_break = bool
                    end
                    function callback.target_enemy_team_only(bool)
                        global.ui_status.target_enemy_team_only = bool
                    end
                    function callback.disable_automatic_unparachute(bool)
                        global.ui_status.disable_automatic_unparachute = bool
                    end
                    function callback.clicknuke(bool)
                        global.ui_status.clicknuke = bool
                    end
                    function callback.disable_minimap_flash(bool)
                        global.ui_status.disable_minimap_flash = bool
                    end
                    function callback.pit_aura(bool)
                        global.ui_status.pit_aura = bool
                    end
                    function callback.pit_aura_range(num)
                        global.ui_status.pit_aura_range = num
                    end
                    function callback.auto_accept_battle(bool)
                        global.ui_status.auto_accept_battle = bool
                    end
                    function callback.auto_start_matchmaking(bool)
                        global.ui_status.auto_start_matchmaking = bool
                    end
                    function callback.place_waypoint(key)
                        if global._loaded then
                            local setWaypoint = global.registry.setWaypoint
                            if setWaypoint then
                                setWaypoint(key)
                            end
                        end
                    end
                    function callback.open_all_safes(bool)
                        global.ui_status.open_all_safes = bool
                    end
                    function callback.c4dick_masterswitch(bool)
                        global.ui_status.c4dick_masterswitch = bool
                    end
                    function callback.dick_player(key)
                        if global._loaded then
                            local dick_player = global.registry.dick_player
                            if dick_player then
                                dick_player(key)
                            end
                        end
                    end
                    function callback.spawn_dick()
                        if global._loaded then
                            local dick_player = global.registry.dick_player
                            if dick_player then
                                dick_player(players.LocalPlayer.Name)
                            end
                        end
                    end
                    function callback.disable_fireworks(bool)
                        global.ui_status.disable_fireworks = bool
                    end
                    function callback.always_reequip_c4(bool)
                        global.ui_status.always_reequip_c4 = bool
                    end
                    function callback.disable_spotlight_tracking(bool)
                        global.ui_status.disable_spotlight_tracking = bool
                    end
                    function callback.automatic_open_yard_gates(bool)
                        global.ui_status.automatic_open_yard_gates = bool
                    end
                    function callback.override_length(bool)
                        global.ui_status.override_length = bool
                    end
                    function callback.dick_length(num)
                        global.ui_status.dick_length = num
                    end
                    function callback.chatspy(bool)
                        global.ui_status.chatspy = bool
                    end
                    function callback.break_maximum_security_elevator(bool)
                        global.ui_status.break_maximum_security_elevator = bool
                    end
                    local place_waypoint = dropdown("Waypoints", "Place Waypoint", {}, callback.place_waypoint)
                    local always_keycard = toggle("Misc", "Always Keycard", callback.always_keycard)
                    local master_switch_open_doors = toggle("Misc", "Open Nearby Doors", callback.master_switch_open_doors)
                    local master_switch_no_circle_delay = toggle("Misc", "No Circle Delay", callback.master_switch_no_circle_delay)
                    local rainbowbullets = toggle("Misc", "Colorful Bullets", callback.rainbowbullets)
                    local infinite_jetpack_fuel = toggle("Misc", "Infinite Jetpack Fuel", callback.infinite_jetpack_fuel)
                    local never_unload_world = toggle("Misc", "Never Unload World", callback.never_unload_world)
                    local open_secretbases = toggle("Misc", "Open Secretbases", callback.open_secretbases)
                    local auto_accept_battle = toggle("Misc", "Automatic Accept Battle", callback.auto_accept_battle)
                    local auto_start_matchmaking = toggle("Misc", "Automatic Start Matchmaking", callback.auto_start_matchmaking)
                    local clicklightning = toggle("Misc", "Click Lightning", callback.clicklightning)
                    local clicknuke = toggle("Misc", "Click Nuke", callback.clicknuke)
                    local chatspy = toggle("Misc", "Chat Spy", callback.chatspy)
                    local open_security_cameras = button("Misc", "Open Security Cameras", callback.open_security_cameras)
                    local remove_clothing = button("Misc", "Remove Clothing", callback.remove_clothing)
                    local give_police_clothing = button("Misc", "Give Police Clothing", callback.give_police_clothing)
                    local give_police_hat = button("Misc", "Give Police Hat", callback.give_police_hat)
                    local automatic_punch_electric_gate = toggle("Prison", "Automatic Punch Electric Gate", callback.automatic_punch_electric_gate)
                    local automatic_open_front_gates = toggle("Prison", "Automatic Open Front Gates", callback.automatic_open_front_gates)
                    local automatic_open_yard_gates = toggle("Prison", "Automatic Open Yard Gates", callback.automatic_open_yard_gates)
                    local automatic_open_side_gate = toggle("Prison", "Automatic Open Side Gate", callback.automatic_open_side_gate)
                    local automatic_open_main_gate = toggle("Prison", "Automatic Open Main Gate", callback.automatic_open_main_gate)
                    local automatic_open_cells = toggle("Prison", "Automatic Open Cells", callback.automatic_open_cells)
                    local break_maximum_security_elevator = toggle("Prison", "Break Max Security Elevator", callback.break_maximum_security_elevator)
                    local break_vehicles = toggle("BreakVehicles", "Master Switch", callback.break_vehicles, true)
                    local only_on_weapon_equipped = toggle("BreakVehicles", "Only On Weapon Equipped", callback.only_on_weapon_equipped)
                    local instant_break = toggle("BreakVehicles", "Instant Break", callback.instant_break)
                    local target_enemy_team_only = toggle("BreakVehicles", "Ignore Teammates", callback.target_enemy_team_only)
                    break_vehicles.setChild(only_on_weapon_equipped)
                    break_vehicles.setChild(instant_break)
                    break_vehicles.setChild(target_enemy_team_only)
                    local pickpocketaura = toggle("Auras", "Pickpocket Aura", callback.pickpocketaura, true)
                    local range_pickpocketaura = slider("Auras", "Range", 1, 50, callback.range_pickpocketaura)
                    pickpocketaura.setChild(range_pickpocketaura)
                    local master_switch_eject_aura = toggle("Auras", "Eject Aura", callback.master_switch_eject_aura, true)
                    local range_ejectaura = slider("Auras", "Range", 1, 80, callback.range_ejectaura)
                    master_switch_eject_aura.setChild(range_ejectaura)
                    local master_switch_breakout_aura = toggle("Auras", "Breakout Aura", callback.master_switch_breakout_aura, true)
                    local range_breakoutaura = slider("Auras", "Range", 1, 20, callback.range_breakoutaura)
                    master_switch_breakout_aura.setChild(range_breakoutaura)
                    local pit_aura = toggle("Auras", "Pit Aura", callback.pit_aura, true)
                    local pit_aura_range = slider("Auras", "Range", 10, 100, callback.pit_aura_range)
                    pit_aura.setChild(pit_aura_range)
                    local droppedcashaura = toggle("Auras", "Dropped Cash Aura", callback.droppedcashaura, true)
                    local droppedcashrange = slider("Auras", "Range", 1, 25, callback.droppedcashrange)
                    droppedcashaura.setChild(droppedcashrange)
                    local playsounds = dropdown("PlaySounds", "Sounds", {}, callback.playsounds)
                    local annoyserver = toggle("PlaySounds", "Annoy Server", callback.annoyserver)
                    function callback.rocket_trail(bool)
                        global.ui_status.rocket_trail = bool
                    end
                    function callback.spawn_rocket()
                        if global._loaded then
                            global.registry.spawn_rocket(players.LocalPlayer.Name)
                        end
                    end
                    function callback.spawn_rocket_on(name)
                        if global._loaded then
                            global.registry.spawn_rocket(name)
                        end
                    end
                    function callback.rocket_explosion(bool)
                        global.ui_status.rocket_explosion = bool
                    end
                    function callback.spawn_explosion()
                        if global._loaded then
                            global.registry.spawn_rocket(players.LocalPlayer.Name, true)
                        end
                    end
                    function callback.spawn_explosion_on(name)
                        if global._loaded then
                            global.registry.spawn_rocket(name, true)
                        end
                    end
                    function callback.explosion_size(num)
                        global.ui_status.explosion_size = num
                    end
                    local rocket_trail = toggle("RocketFun", "Rocket Trail", callback.rocket_trail, true)
                    local spawn_rocket = button("RocketFun", "Spawn Rocket", callback.spawn_rocket)
                    local spawn_rocket_on = textbox("RocketFun", "Spawn Rocket On", "Player Name", callback.spawn_rocket_on)
                    rocket_trail.setChild(spawn_rocket)
                    rocket_trail.setChild(spawn_rocket_on)
                    local rocket_explosion = toggle("RocketFun", "Rocket Explosion", callback.rocket_explosion, true)
                    local spawn_explosion = button("RocketFun", "Spawn Explosion", callback.spawn_explosion)
                    local spawn_explosion_on = textbox("RocketFun", "Spawn Explosion On", "Player Name", callback.spawn_explosion_on)
                    local explosion_size = slider("RocketFun", "Explosion Size", 1, 100, callback.explosion_size)
                    rocket_explosion.setChild(spawn_explosion)
                    rocket_explosion.setChild(spawn_explosion_on)
                    rocket_explosion.setChild(explosion_size)
                    config.rocket_explosion = rocket_explosion
                    config.rocket_trail = rocket_trail
                    config.spawn_rocket = spawn_rocket
                    config.extend_duration = extend_duration
                    config.explosion_size = explosion_size
                    function callback.bomb_vest(bool)
                        global.ui_status.bomb_vest = bool
                    end
                    function callback.spawn_vest()
                    
                    end
                    function callback.spawn_vest_player()
                    end
                    function callback.ammo_purchase_limit(num)
                        global.ui_status.ammo_purchase_limit = num
                    end
                    local c4dick_masterswitch = toggle("C4Fun", "C4 Dick", callback.c4dick_masterswitch, true)
                    local spawn_dick = button("C4Fun", "Spawn Dick", callback.spawn_dick)
                    local override_length = toggle("C4Fun", "Override Length", callback.override_length, true)
                    local dick_length = slider("C4Fun", "Dick Length", 1, 6, callback.dick_length)
                    local dick_player = textbox("C4Fun", "Spawn Dick On", "Player Name", callback.dick_player)
                    --local bomb_vest = toggle("C4Fun", "Bomb Vest", callback.bomb_vest, true)
                    local spawn_vest = button("C4Fun", "Spawn Vest", callback.spawn_vest)
                    local spawn_vest_player = textbox("C4Fun", "Spawn Vest On", "Player Name", callback.spawn_vest_player)
                    local ammo_purchase_limit = slider("C4Fun", "Ammo Purchase Limit", 1, 10, callback.ammo_purchase_limit)
                    --bomb_vest.setChild(spawn_vest)
                   -- bomb_vest.setChild(spawn_vest_player)
                    --bomb_vest.setChild(ammo_purchase_limit)
                    c4dick_masterswitch.setChild(spawn_dick)
                    c4dick_masterswitch.setChild(dick_player)
                    c4dick_masterswitch.setChild(override_length)
                    override_length.setChild(dick_length)
                    config.override_length = override_length
                    config.break_maximum_security_elevator = break_maximum_security_elevator
                    config.dick_length = dick_length
                    config.dick_player = dick_player
                    function callback.disable_radio_keybind(bool)
                        global.ui_status.disable_radio_keybind = bool
                    end
                    local disable_lasers = toggle("Disablers", "Disable Lasers", callback.disable_lasers)
                    local disable_cameras = toggle("Disablers", "Disable Cameras", callback.disable_cameras)
                    local disable_radio_keybind = toggle("Disablers", "Disable Radio Keybind", callback.disable_radio_keybind)
                    local disable_spotlight_tracking = toggle("Disablers", "Disable Spotlight Tracking", callback.disable_spotlight_tracking)
                    local disable_minimap_flash = toggle("Disablers", "Disable Minimap Flash", callback.disable_minimap_flash)
                    local disable_automatic_unparachute = toggle("Disablers", "Disable Automatic Unparachute", callback.disable_automatic_unparachute)
                    local disable_military_turrets = toggle("Disablers", "Disable Military Turrets", callback.disable_military_turrets)
                    local disable_home_turrets = toggle("Disablers", "Disable Home Turrets", callback.disable_home_turrets)
                    local disable_smoke_grenade_effect = toggle("Disablers", "Disable Smoke Grenade Effect", callback.disable_smoke_grenade_effect)
                    config.disable_radio_keybind = disable_radio_keybind
                    config.c4dick_masterswitch = c4dick_masterswitch
                    config.disable_spotlight_tracking = disable_spotlight_tracking
                    config.always_reequip_c4 = always_reequip_c4
                    config.place_waypoint = place_waypoint
                    config.clicklightning = clicklightning
                    config.pit_aura = pit_aura
                    config.pit_aura_range = pit_aura_range
                    config.disable_minimap_flash = disable_minimap_flash
                    config.clicknuke = clicknuke
                    config.auto_accept_battle = auto_accept_battle
                    config.auto_start_matchmaking = auto_start_matchmaking
                    config.only_on_weapon_equipped = only_on_weapon_equipped
                    config.instant_break = instant_break
                    config.target_enemy_team_only = target_enemy_team_only
                    config.chatspy = chatspy
                    config.playsounds = playsounds
                    config.always_keycard = always_keycard
                    config.annoyserver = annoyserver
                    config.master_switch_open_doors = master_switch_open_doors
                    config.disable_automatic_unparachute = disable_automatic_unparachute
                    config.break_vehicles = break_vehicles
                    config.no_equip_conditions = no_equip_conditions
                    config.master_switch_no_circle_delay = master_switch_no_circle_delay
                    config.never_unload_world = never_unload_world
                    config.rainbowbullets = rainbowbullets
                    config.infinite_jetpack_fuel = infinite_jetpack_fuel
                    config.pickpocketaura = pickpocketaura
                    config.master_switch_breakout_aura = master_switch_breakout_aura
                    config.range_breakoutaura = range_breakoutaura
                    config.automatic_open_front_gates = automatic_open_front_gates
                    config.automatic_open_side_gate = automatic_open_side_gate
                    config.automatic_open_main_gate = automatic_open_main_gate
                    config.automatic_open_yard_gates = automatic_open_yard_gates
                    config.open_secretbases = open_secretbases
                    config.automatic_open_cells = automatic_open_cells
                    config.range_pickpocketaura = range_pickpocketaura
                    config.automatic_punch_electric_gate = automatic_punch_electric_gate
                    config.master_switch_eject_aura = master_switch_eject_aura
                    config.range_ejectaura = range_ejectaura
                    config.droppedcashaura = droppedcashaura
                    config.droppedcashrange = droppedcashrange
                    config.disable_lasers = disable_lasers
                    config.disable_cameras = disable_cameras
                    config.disable_home_turrets = disable_home_turrets
                    config.disable_military_turrets = disable_military_turrets
                    config.disable_smoke_grenade_effect = disable_smoke_grenade_effect
                end
                local function combat()
                    function callback.open_gunstore_ui(bool)
                        global.ui_status.open_gunstore_ui = bool
                    end
                    function callback.equip_owned_guns()
                        local isProjectile = global.registry.isProjectile
                        if global._loaded then
                            local client = global.registry.client
                            local equipOwnedItem = global.registry.equipOwnedItem
                            if equipOwnedItem then
                                for i,v in next, client.reg.resolveOwnedItems do
                                    if not isProjectile(v) then
                                        equipOwnedItem(v)
                                    end
                                end
                            end
                        end
                    end
                    function callback.always_equip_owned_guns(bool)
                        global.ui_status.always_equip_owned_guns = bool
                    end
                    function callback.spam_drop_guns(bool)
                        global.ui_status.spam_drop_guns = bool
                    end
                    function callback.automatic_fire(bool)
                        global.ui_status.automatic_fire = bool
                    end
                    function callback.no_recoil(bool)
                        global.ui_status.no_recoil = bool
                    end
                    function callback.master_switch_silentaim(bool)
                        global.ui_status.master_switch_silentaim = bool
                    end
                    function callback.target_closest_crosshair(bool)
                        global.ui_status.target_closest_crosshair = bool
                    end
                    function callback.always_predict(bool)
                        global.ui_status.always_predict = bool
                    end
                    function callback.master_switch_arrestaura(bool)
                        global.ui_status.master_switch_arrestaura = bool
                    end
                    function callback.range_arrestaura(num)
                        global.ui_status.range_arrestaura = num
                    end
                    function callback.allow_target_prisoner(bool)
                        global.ui_status.allow_target_prisoner = bool
                    end
                    function callback.fov_silentaim(num)
                        global.ui_status.fov_silentaim = num
                    end
                    function callback.fov_circle(bool)
                        global.ui_status.fov_circle = bool
                    end
                    function callback.automatic_equip_handcuffs(bool)
                        global.ui_status.automatic_equip_handcuffs = bool
                    end
                    function callback.automatic_eject_player(bool)
                        global.ui_status.automatic_eject_player = bool
                    end
                    function callback.talk_on_arrest(bool)
                        global.ui_status.talk_on_arrest = bool
                    end
                    function callback.no_wall_penetration(bool)
                        global.ui_status.no_wall_penetration = bool
                    end
                    function callback.allow_target_npcs(bool)
                        global.ui_status.allow_target_npcs = bool
                    end
                    function callback.allow_tase_target(bool)
                        global.ui_status.allow_tase_target = bool
                    end
                    function callback.through_walls(bool)
                        global.ui_status.through_walls = bool
                    end
                    function callback.anti_flintlock_knockback(bool)
                        global.ui_status.anti_flintlock_knockback = bool
                    end
                    function callback.allow_target_boss(bool)
                        global.ui_status.allow_target_boss = bool
                    end
                    function callback.always_target_boss_head(bool)
                        global.ui_status.always_target_boss_head = bool
                    end
                    function callback.instant_reload(bool)
                        global.ui_status.instant_reload = bool
                    end
                    function callback.anti_scope_ui(bool)
                        global.ui_status.anti_scope_ui = bool
                    end
                    function callback.allow_taser_aimbot(bool)
                        global.ui_status.allow_taser_aimbot = bool
                    end
                    function callback.ignore_while_driving(bool)
                        global.ui_status.ignore_while_driving = bool
                    end
                    function callback.automatic_fix_robbery_bag(bool)
                        global.ui_status.automatic_fix_robbery_bag = bool
                    end
                    function callback.instant_seek(bool)
                        global.ui_status.instant_seek = bool
                    end
                    function callback.equip_guns(value)
                        if global._loaded then
                            local client = global.registry.client
                            local equipOwnedItem = global.registry.equipOwnedItem
                            if equipOwnedItem then
                                if not table.find(client.reg.resolveEquippedItems, value) then
                                    equipOwnedItem(value)
                                end
                            end
                        end
                    end
                    function callback.extended_aimbot_range(bool)
                        global.ui_status.extended_aimbot_range = bool
                    end
                    function callback.range_taseaura(num)
                        global.ui_status.range_taseaura = num
                    end
                    function callback.wallbang(bool)
                        global.ui_status.wallbang = bool
                    end
                    function callback.move_camera_killall(bool)
                        global.ui_status.move_camera_killall = bool
                    end
                    function callback.ignoreteam_killall(bool)
                        global.ui_status.ignoreteam_killall = bool
                    end
                    function callback.max_distance(num)
                        global.ui_status.max_distance = num
                    end
                    function callback.automatic_shoot(bool)
                        global.ui_status.automatic_shoot = bool
                    end
                    function callback.no_spread(bool)
                        global.ui_status.no_spread = bool
                    end
                    function callback.kill_player(name)
                        if global._loaded then
                            global.registry.kill_player(name)
                        end
                    end
                    function callback.anti_smoke_throw_limit(bool)
                        global.ui_status.anti_smoke_throw_limit = bool
                    end
                    function callback.quickfire(bool)
                        global.ui_status.quickfire = bool
                    end
                    function callback.kill_all_in_vehicle(bool)
                        global.ui_status.kill_all_in_vehicle = bool
                    end
                    function callback.teleport_locations(key)
                        if global._loaded then
                            global.teleports.setLocation(key)
                        end
                    end
                    local automatic_fire = toggle("Gunmods", "Automatic Fire", callback.automatic_fire)
                    local no_recoil = toggle("Gunmods", "No Recoil", callback.no_recoil)
                    local no_spread = toggle("Gunmods", "No Spread", callback.no_spread)
                    local wallbang = toggle("Gunmods", "Wallbang", callback.wallbang)
                    local instant_reload = toggle("Gunmods", "Instant Reload", callback.instant_reload)
                    local instant_seek = toggle("Gunmods", "Instant Seek", callback.instant_seek)
                    local quickfire = toggle("GunmodsMisc", "Quick Fire", callback.quickfire)
                    local anti_flintlock_knockback = toggle("GunmodsMisc", "Anti Knockback", callback.anti_flintlock_knockback)
                    local anti_smoke_throw_limit = toggle("GunmodsMisc", "Anti Smoke Throw Limit", callback.anti_smoke_throw_limit)
                    local anti_scope_ui = toggle("GunmodsMisc", "Anti Scope UI", callback.anti_scope_ui)
                    config.quickfire = quickfire
                    local open_gunstore_ui = toggle("Gunstore", "Open Gunstore UI", callback.open_gunstore_ui)
                    local equip_owned_guns = button("Gunstore", "Equip Owned Guns", callback.equip_owned_guns)
                    local equip_guns = dropdown("Gunstore", "Equip Guns", {}, callback.equip_guns)
                    local always_equip_owned_guns = toggle("Gunstore", "Always Equip Owned Guns", callback.always_equip_owned_guns)
                    local spam_drop_guns = toggle("Gunstore", "Spam Drop Items", callback.spam_drop_guns, true)
                    function callback.kill_all_in_vehicle(bool)
                        global.ui_status.kill_all_in_vehicle = bool
                    end
                    function callback.kill_all_vehicle_ignore_teammates(bool)
                        global.ui_status.kill_all_vehicle_ignore_teammates = bool
                    end
                    local kill_player = textbox("BreakExperience", "Attempt Kill Player", "Player Name", callback.kill_player)
                    function callback.teleport_player(name)
                        if global._loaded then
                            global.teleports.teleport_player(name)
                        end
                    end
                    function callback.force_target(name)
                        if global._loaded then
                            if global.aimbot then
                                global.aimbot.setTarget(name)
                            end
                        end
                    end
                    function callback.killaura_masterswitch(bool)
                        global.ui_status.killaura_masterswitch = bool
                    end
                    function callback.killaura_range(num)
                        global.ui_status.killaura_range = num
                    end
                    local teleport_locations = dropdown("BreakExperience", "Teleport Locations", {"Casino", "Diamonds", "Lava", "Bossroom", "Powerplant", "Bank", "Computer", "Museum", "Jewelry"}, callback.teleport_locations)
                    local teleport_current_location = label("BreakExperience", "SELECTED_LOCATION", Color3.fromRGB(200, 200, 200))
                    local teleport_player = textbox("BreakExperience", "Teleport Player", "Player Name", callback.teleport_player)
                    local kill_all_in_vehicle = toggle("BreakExperience", "Kill All In Vehicle", callback.kill_all_in_vehicle, true)
                    local kill_all_vehicle_ignore_teammates = toggle("BreakExperience", "Ignore Teammates", callback.kill_all_vehicle_ignore_teammates)
                    config.kill_all_vehicle_ignore_teammates = kill_all_vehicle_ignore_teammates
                    kill_all_in_vehicle.setChild(kill_all_vehicle_ignore_teammates)
                    local killaura_masterswitch = toggle("Killaura", "Master Switch", callback.killaura_masterswitch, true)
                    local killaura_range = slider("Killaura", "Range", 50, 100, callback.killaura_range)
                    killaura_masterswitch.setChild(killaura_range)
                    config.killaura_masterswitch = killaura_masterswitch
                    config.killaura_range = killaura_range
                    local master_switch_silentaim = toggle("Silentaim", "Master Switch", callback.master_switch_silentaim, true)
                    local fov_silentaim = slider("Silentaim", "FOV", 1, 600, callback.fov_silentaim)
                    local max_distance = slider("Silentaim", "Max Distance", 500, 5000, callback.max_distance)
                    local force_target = textbox("Silentaim", "Force Target", "Player Name", callback.force_target)
                    local selected_target = label("Silentaim", "FORCED_TARGET_NAME", Color3.fromRGB(200, 200, 200))
                    master_switch_silentaim.setChild(force_target)
                    master_switch_silentaim.setChild(selected_target)
                    local automatic_shoot = toggle("Silentaim", "Automatic Shoot", callback.automatic_shoot)
                    local fov_circle = toggle("Silentaim", "FOV Circle", callback.fov_circle)
                    local always_predict = toggle("Silentaim", "Movement Prediction", callback.always_predict, true)
                    local extended_aimbot_range = toggle("Silentaim", "Extended Aimbot Range", callback.extended_aimbot_range)
                    local allow_taser_aimbot = toggle("Silentaim", "Allow Taser Aimbot", callback.allow_taser_aimbot)
                    local allow_target_prisoner = toggle("Silentaim", "Allow Target Prisoner", callback.allow_target_prisoner)
                    local allow_target_npcs = toggle("Silentaim", "Allow Target NPCs", callback.allow_target_npcs)
                    local allow_target_boss = toggle("Silentaim", "Allow Target Boss", callback.allow_target_boss, true)
                    local always_target_boss_head = toggle("Silentaim", "Head Only", callback.always_target_boss_head)
                    local no_wall_penetration = toggle("Silentaim", "No Wall Penetration", callback.no_wall_penetration)
                    master_switch_silentaim.setChild(fov_silentaim)
                    master_switch_silentaim.setChild(fov_circle)
                    master_switch_silentaim.setChild(always_predict)
                    master_switch_silentaim.setChild(automatic_shoot)
                    config.automatic_shoot = automatic_shoot
                    config.instant_seek = instant_seek
                    config.kill_all_in_vehicle = kill_all_in_vehicle
                    config.kill_all_vehicle_ignore_teammates = kill_all_vehicle_ignore_teammates
                    master_switch_silentaim.setChild(extended_aimbot_range)
                    master_switch_silentaim.setChild(max_distance)
                    master_switch_silentaim.setChild(allow_taser_aimbot)
                    master_switch_silentaim.setChild(allow_target_prisoner)
                    master_switch_silentaim.setChild(allow_target_npcs)
                    master_switch_silentaim.setChild(allow_target_boss)
                    allow_target_boss.setChild(always_target_boss_head)
                    master_switch_silentaim.setChild(no_wall_penetration)
                    local master_switch_arrestaura = toggle("Arrestaura", "Master Switch", callback.master_switch_arrestaura, true)
                    local range_arrestaura = slider("Arrestaura", "Range", 1, 20, callback.range_arrestaura)
                    local ignore_while_driving = toggle("Arrestaura", "Ignore while driving", callback.ignore_while_driving)
                    local automatic_equip_handcuffs = toggle("Arrestaura", "Automatic Equip Handcuffs", callback.automatic_equip_handcuffs)
                    local automatic_eject_player = toggle("Arrestaura", "Automatic Eject Player", callback.automatic_eject_player)
                    local allow_tase_target = toggle("Arrestaura", "Allow Tase Target", callback.allow_tase_target, true)
                    local through_walls = toggle("Arrestaura", "Allow Through Walls", callback.through_walls)
                    local talk_on_arrest = toggle("Arrestaura", "Talk on Arrest", callback.talk_on_arrest)
                    master_switch_arrestaura.setChild(range_arrestaura)
                    master_switch_arrestaura.setChild(automatic_equip_handcuffs)
                    master_switch_arrestaura.setChild(automatic_eject_player)
                    master_switch_arrestaura.setChild(allow_tase_target)
                    master_switch_arrestaura.setChild(ignore_while_driving)
                    master_switch_arrestaura.setChild(through_walls)
                    master_switch_arrestaura.setChild(talk_on_arrest)
                    config.anti_scope_ui = anti_scope_ui
                    config.allow_target_boss = allow_target_boss
                    config.wallbang = wallbang
                    config.instant_reload = instant_reload
                    config.always_target_boss_head = always_target_boss_head
                    config.automatic_fire = automatic_fire
                    config.no_recoil = no_recoil
                    config.no_spread = no_spread
                    config.equip_guns = equip_guns
                    config.ignoreteam_killall = ignoreteam_killall
                    config.ignorevehicles_killall = ignorevehicles_killall
                    config.max_distance = max_distance
                    config.master_switch_silentaim = master_switch_silentaim
                    config.fov_silentaim = fov_silentaim
                    config.fov_circle = fov_circle
                    config.move_camera_killall = move_camera_killall
                    config.always_predict = always_predict
                    config.extended_aimbot_range = extended_aimbot_range
                    config.always_equip_owned_guns = always_equip_owned_guns
                    config.spam_drop_guns = spam_drop_guns
                    config.anti_smoke_throw_limit = anti_smoke_throw_limit
                    config.allow_target_npcs = allow_target_npcs
                    config.no_wall_penetration = no_wall_penetration
                    config.allow_target_prisoner = allow_target_prisoner
                    config.anti_flintlock_knockback = anti_flintlock_knockback
                    config.master_switch_arrestaura = master_switch_arrestaura
                    config.allow_taser_aimbot = allow_taser_aimbot
                    config.range_arrestaura = range_arrestaura
                    config.automatic_equip_handcuffs = automatic_equip_handcuffs
                    config.allow_tase_target = allow_tase_target
                    config.attempt_fling = attempt_fling
                    config.through_walls = through_walls
                    config.automatic_eject_player = automatic_eject_player
                    config.talk_on_arrest = talk_on_arrest
                    config.ignore_while_driving = ignore_while_driving
                end
                local function markers()
                    function callback.master_switch_marker(bool)
                        global.ui_status.master_switch_marker = bool
                    end
                    function callback.police_marker(bool)
                        global.ui_status.allow_police_marker = bool
                    end
                    function callback.criminal_marker(bool)
                        global.ui_status.allow_criminal_marker = bool
                    end
                    function callback.prisoner_marker(bool)
                        global.ui_status.allow_prisoner_marker = bool
                    end
                    function callback.airdrop_marker(bool)
                        global.ui_status.allow_airdrop_marker = bool
                    end
                    function callback.allow_football_marker(bool)
                        global.ui_status.allow_football_marker = bool
                    end
                    function callback.allow_hackable_computer_marker(bool)
                        global.ui_status.allow_hackable_computer_marker = bool
                    end
                    function callback.no_robberymarker_delay(bool)
                        global.ui_status.no_robberymarker_delay = bool
                    end
                    function callback.allow_npcs_marker(bool)
                        global.ui_status.allow_npcs_marker = bool
                    end
                    function callback.mark_bounty_criminals(bool)
                        global.ui_status.mark_bounty_criminals = bool
                    end
                    function callback.mark_forced_target(bool)
                        global.ui_status.mark_forced_target = bool
                    end
                    local master_switch_marker = toggle("Marker", "Master Switch", callback.master_switch_marker)
                    local allow_criminal_marker = toggle("Teams", "Allow Criminal Marker", callback.criminal_marker)
                    local allow_prisoner_marker = toggle("Teams", "Allow Prisoner Marker", callback.prisoner_marker)
                    local allow_police_marker = toggle("Teams", "Allow Police Marker", callback.police_marker)
                    local allow_airdrop_marker = toggle("Objects", "Allow Airdrop Marker", callback.airdrop_marker)
                    local allow_football_marker = toggle("Objects", "Allow Football Marker", callback.allow_football_marker)
                    local allow_npcs_marker = toggle("Objects", "Allow NPCs Marker", callback.allow_npcs_marker)
                    local no_robberymarker_delay = toggle("Settings", "No Robbery Marker Delay", callback.no_robberymarker_delay)
                    local mark_bounty_criminals = toggle("Settings", "Mark Bounty Criminals", callback.mark_bounty_criminals)
                    local mark_forced_target = toggle("Settings", "Mark Forced Target", callback.mark_forced_target)
                    config.mark_forced_target = mark_forced_target
                    config.master_switch_marker = master_switch_marker
                    config.allow_criminal_marker = allow_criminal_marker
                    config.allow_prisoner_marker = allow_prisoner_marker
                    config.allow_police_marker = allow_police_marker
                    config.allow_airdrop_marker = allow_airdrop_marker
                    config.allow_football_marker = allow_football_marker
                    config.allow_npcs_marker = allow_npcs_marker
                    config.no_robberymarker_delay = no_robberymarker_delay
                    config.mark_bounty_criminals = mark_bounty_criminals
                end
                local function robbery()
                    local function bank()
                        function callback.auto_touch_vault(bool)
                            global.ui_status.auto_touch_vault = bool
                        end
                        function callback.auto_place_dynamite(bool)
                            global.ui_status.auto_place_dynamite = bool
                        end
                        function callback.open_entrance_doors(bool)
                            if global._loaded then
                                local openBankEntrances = global.registry.openBankEntrances
                                if openBankEntrances then
                                    openBankEntrances()
                                else
                                    global.notify("Feature not implemented.", 5)
                                end
                            end
                        end
                        local status = label("Bank", "Bank Status", Color3.fromRGB(0, 0, 0))
                        local status2 = label("Bank", "BANK2_ROBBERY_STATUS", Color3.fromRGB(0,0,0))
                        local auto_touch_vault = toggle("Bank", "Automatic Touch Vault", callback.auto_touch_vault)
                        local auto_place_dynamite = toggle("Bank", "Automatic Place Dynamite", callback.auto_place_dynamite)
                        local open_entrance_doors = button("Bank", "Open Entrance Doors", callback.open_entrance_doors)
                        config.auto_touch_vault = auto_touch_vault
                        config.auto_place_dynamite = auto_place_dynamite
                        config.open_entrance_doors = open_entrance_doors
                    end
                    bank()
                    local function banktruck()
                        function callback.automatic_explode_truck(bool)
                            global.ui_status.automatic_explode_truck = bool
                        end
                        local status = label("BankTruck", "Banktruck Status", Color3.fromRGB(0, 0, 0))
                        local automatic_explode_truck = toggle("BankTruck", "Automatic Explode Truck", callback.automatic_explode_truck)
                        config.automatic_explode_truck = automatic_explode_truck
                    end
                    banktruck()
                    local function smallstores()
                        local donut = label("SmallStores", "Donut Shop", Color3.fromRGB(0, 0, 0))
                        local gas = label("SmallStores", "Gas Station", Color3.fromRGB(0, 0, 0))
                    end
                    smallstores()
                    local function jewelry()
                        function callback.automatic_grab_nearby_jewels(bool)
                            global.ui_status.automatic_grab_nearby_jewels = bool
                        end
                        function callback.automatic_punch_jewelry_boxes(bool)
                            global.ui_status.automatic_punch_jewelry_boxes = bool
                        end
                        local status = label("Jewelry", "Jewelry Status", Color3.fromRGB(0, 0, 0))
                        local automatic_punch_jewelry_boxes = toggle("Jewelry", "Automatic Punch Boxes", callback.automatic_punch_jewelry_boxes)
                        local automatic_grab_nearby_jewels = toggle("Jewelry", "Automatic Grab Nearby Jewels", callback.automatic_grab_nearby_jewels)
                        config.automatic_grab_nearby_jewels = automatic_grab_nearby_jewels
                        config.automatic_punch_jewelry_boxes = automatic_punch_jewelry_boxes
                    end
                    jewelry()
                    local function museum()
                        function callback.automatic_place_dynamite(bool)
                            global.ui_status.automatic_place_dynamite = bool
                        end
                        function callback.auto_fill_bag(bool)
                            global.ui_status.auto_fill_bag = bool
                        end
                        function callback.break_museum_puzzle(bool)
                            global.ui_status.break_museum_puzzle = bool
                        end
                        function callback.automatic_resolve_museum_puzzle(bool)
                            global.ui_status.automatic_resolve_museum_puzzle = bool
                        end
                        local status = label("Museum", "Museum Status", Color3.fromRGB(0, 0, 0))
                        local automatic_resolve_museum_puzzle = toggle("Museum", "Automatic Resolve Puzzle", callback.automatic_resolve_museum_puzzle)
                        local automatic_place_dynamite = toggle("Museum", "Automatic Place Dynamite", callback.automatic_place_dynamite)
                        local auto_fill_bag = toggle("Museum", "Automatic Fill Bag", callback.auto_fill_bag)
                        local break_museum_puzzle = toggle("Museum", "Break Museum Puzzle", callback.break_museum_puzzle)
                        config.auto_fill_bag = auto_fill_bag
                        config.automatic_resolve_museum_puzzle = automatic_resolve_museum_puzzle
                        config.break_museum_puzzle = break_museum_puzzle
                        config.automatic_place_dynamite = automatic_place_dynamite
                    end
                    museum()
                    local function casino()
                        function callback.auto_crack_vault(bool)
                            global.ui_status.auto_crack_vault = bool
                        end
                        function callback.auto_collect_cash(bool)
                            global.ui_status.auto_collect_cash = bool
                        end
                        function callback.auto_open_door(bool)
                            global.ui_status.auto_open_door = bool
                        end
                        function callback.auto_open_keycode_door(bool)
                            global.ui_status.auto_open_keycode_door = bool
                        end
                        function callback.break_elevator(bool)
                            global.ui_status.break_elevator = bool
                        end
                        function callback.hack_nearby_computers(bool)
                            global.ui_status.hack_nearby_computers = bool
                        end
                        function callback.reveal_casino_keycode()
                            local getKeycode = global.registry.getKeycode
                            if getKeycode then
                                local keycode = getKeycode()
                                if keycode ~= "" then
                                    global.notify(keycode, 10)
                                end
                            end
                        end
                        function callback.call_elevator_to_floor(cb)
                            local call_elevator_to_floor = global.registry.call_elevator_to_floor
                            if call_elevator_to_floor then
                                call_elevator_to_floor(cb)
                            end
                        end
                        local status = label("Casino", "Casino Status", Color3.fromRGB(0, 0, 0))
                        local auto_crack_vault = toggle("Casino", "Automatic Crack Vault", callback.auto_crack_vault)
                        local auto_collect_cash = toggle("Casino", "Automatic Collect Loot", callback.auto_collect_cash)
                        local auto_open_door = toggle("Casino", "Automatic Open Door", callback.auto_open_door)
                        local break_elevator = toggle("Casino", "Break Elevator", callback.break_elevator)
                        local hack_nearby_computers = toggle("Casino", "Hack Nearby Computers", callback.hack_nearby_computers)
                        local reveal_casino_keycode = button("Casino", "Reveal Keycode", callback.reveal_casino_keycode)
                        local call_elevator_to_floor = dropdown("Casino", "Call Elevator To Floor", {"The Roof", "Security", "Ground", "Vaults"}, callback.call_elevator_to_floor)
                        config.auto_crack_vault = auto_crack_vault
                        config.auto_collect_cash = auto_collect_cash
                        config.auto_open_door = auto_open_door
                        config.break_elevator = break_elevator
                        config.hack_nearby_computers = hack_nearby_computers
                        config.reveal_casino_keycode = reveal_casino_keycode
                    end
                    casino()
                    local function mansion()
                        function callback.disable_traps(bool)
                            global.ui_status.disable_traps = bool
                        end
                        function callback.anti_boss_attack(bool)
                            global.ui_status.anti_boss_attack = bool
                        end
                        function callback.anti_boss_ragdoll(bool)
                            global.ui_status.anti_boss_ragdoll = bool
                        end
                        function callback.break_mansion_npcs(bool)
                            global.ui_status.break_mansion_npcs = bool
                        end
                        function callback.automatic_elevator_entry(bool)
                            global.ui_status.automatic_elevator_entry = bool
                        end
                        function callback.allow_on_police_team(bool)
                            global.ui_status.allow_on_police_team = bool
                        end
                        function callback.entry_only_near_elevator(bool)
                            global.ui_status.entry_only_near_elevator = bool
                        end
                        local status = label("Mansion", "Mansion Status", Color3.fromRGB(0, 0, 0))
                        local automatic_elevator_entry = toggle("Mansion", "Automatic Elevator Entry", callback.automatic_elevator_entry, true)
                        local allow_on_police_team = toggle("Mansion", "Allow On Police Team", callback.allow_on_police_team)
                        automatic_elevator_entry.setChild(allow_on_police_team)
                        local anti_boss_attack = toggle("Mansion", "Anti Boss Attack", callback.anti_boss_attack)
                        local anti_boss_ragdoll = toggle("Mansion", "Anti Boss Ragdoll", callback.anti_boss_ragdoll)
                        local break_mansion_npcs = toggle("Mansion", "Break NPCs", callback.break_mansion_npcs)
                        local disable_traps = toggle("Mansion", "Disable Traps", callback.disable_traps)
                        config.break_mansion_npcs = break_mansion_npcs
                        config.disable_traps = disable_traps
                        config.anti_boss_attack = anti_boss_attack
                        config.allow_on_police_team = allow_on_police_team
                        config.anti_boss_ragdoll = anti_boss_ragdoll
                        config.automatic_elevator_entry = automatic_elevator_entry
                    end
                    mansion()
                    local function powerplant()
                        function callback.puzzle_resolver(bool)
                            global.ui_status.puzzle_resolver = bool
                        end
                        function callback.disable_piston_damage(bool)
                            global.ui_status.disable_piston_damage = bool
                        end
                        function callback.disable_powerwire_damage(bool)
                            global.ui_status.disable_powerwire_damage = bool
                        end
                        local status = label("Powerplant", "Powerplant Status", Color3.fromRGB(0, 0, 0))
                        --local puzzle_resolver = toggle("Powerplant", "Automatic Resolve Puzzle", callback.puzzle_resolver)
                        local disable_piston_damage = toggle("Powerplant", "Disable Piston Damage", callback.disable_piston_damage)
                        local disable_powerwire_damage = toggle("Powerplant", "Disable Powerwire Damage", callback.disable_powerwire_damage)
                        --config.puzzle_resolver = puzzle_resolver
                        config.disable_piston_damage = disable_piston_damage
                        config.disable_powerwire_damage = disable_powerwire_damage
                    end
                    powerplant()
                    local function airdrop()
                        function callback.break_npcs(bool)
                            global.ui_status.break_npcs = bool
                        end
                        function callback.automatic_hold(bool)
                            global.ui_status.automatic_hold = bool
                        end
                        local status = label("Airdrop", "Airdrop Status", Color3.fromRGB(0, 0, 0))
                        local automatic_hold = toggle("Airdrop", "Automatic Hold E", callback.automatic_hold)
                        local break_npcs = toggle("Airdrop", "Break NPCs", callback.break_npcs)
                        config.automatic_hold = automatic_hold
                        config.break_npcs = break_npcs
                    end
                    airdrop()
                    local function cargoplane()
                        function callback.automatic_inspect_crate(bool)
                            global.ui_status.automatic_inspect_crate = bool
                        end
                        function callback.automatic_open_cargoplane_door(bool)
                            global.ui_status.automatic_open_cargoplane_door = bool
                        end
                        function callback.call_cargoplane()
                            local callplane = global.registry.callplane
                            if callplane then
                                callplane()
                            end
                        end
                        local status = label("Cargoplane", "Cargoplane Status", Color3.fromRGB(0, 0, 0))
                        local automatic_inspect_crate = toggle("Cargoplane", "Automatic Inspect Crate", callback.automatic_inspect_crate)
                        local automatic_open_cargoplane_door = toggle("Cargoplane", "Automatic Open Door", callback.automatic_open_cargoplane_door)
                        local call_cargoplane = button("Cargoplane", "Call Cargoplane", callback.call_cargoplane)
                        config.automatic_inspect_crate = automatic_inspect_crate
                        config.automatic_open_cargoplane_door = automatic_open_cargoplane_door
                    end
                    cargoplane()
                    local function trains()
                        function callback.automatic_train_fillbag(bool)
                            global.ui_status.automatic_train_fillbag = bool
                        end
                        function callback.automatic_breach_vault(bool)
                            global.ui_status.automatic_breach_vault = bool
                        end
                        function callback.automatic_delivery(bool)
                            global.ui_status.automatic_delivery = bool
                        end
                        function callback.anti_station_stop(bool)
                            global.ui_status.anti_station_stop = bool
                        end
                        local status = label("Trains", "Trains Status", Color3.fromRGB(0, 0, 0))
                        local automatic_train_fillbag = toggle("Trains", "Automatic Fill Bag", callback.automatic_train_fillbag)
                        local automatic_delivery = toggle("Trains", "Automatic Delivery", callback.automatic_delivery)
                        local automatic_breach_vault = toggle("Trains", "Automatic Breach Vault", callback.automatic_breach_vault)
                        local anti_station_stop = toggle("Trains", "Anti Station Stop", callback.anti_station_stop)
                        config.automatic_train_fillbag = automatic_train_fillbag
                        config.automatic_delivery = automatic_delivery
                        config.automatic_breach_vault = automatic_breach_vault
                        config.anti_station_stop = anti_station_stop
                    end
                    trains()
                    local function tomb()
                        function callback.disable_darts(bool)
                            global.ui_status.disable_darts = bool
                        end
                        function callback.disable_spikes(bool)
                            global.ui_status.disable_spikes = bool
                        end
                        function callback.disable_lava(bool)
                            global.ui_status.disable_lava = bool
                        end
                        function callback.disable_wood(bool)
                            global.ui_status.disable_wood = bool
                        end
                        function callback.automatic_resolve_dart_room(bool)
                            global.ui_status.automatic_resolve_dart_room = bool
                        end
                        local status = label("Tomb", "Tomb Status", Color3.fromRGB(0, 0, 0))
                        local automatic_resolve_dart_room = toggle("Tomb", "Automatic Resolve Dart Room", callback.automatic_resolve_dart_room)
                        local disable_darts = toggle("Tomb", "Disable Darts", callback.disable_darts)
                        local disable_wood = toggle("Tomb", "Disable Wood Damage", callback.disable_wood)
                        local disable_spikes = toggle("Tomb", "Disable Spike Damage", callback.disable_spikes)
                        local disable_lava = toggle("Tomb", "Disable Lava Damage", callback.disable_lava)
                        config.automatic_resolve_dart_room = automatic_resolve_dart_room
                        config.disable_darts = disable_darts
                        config.disable_wood = disable_wood
                        config.disable_spikes = disable_spikes
                        config.disable_lava = disable_lava
                    end
                    tomb()
                    local function cargoship()
                        function callback.disable_cargoship_turrets(bool)
                            global.ui_status.disable_cargoship_turrets = bool
                        end
                        function callback.destroy_all_crates(bool)
                            global.ui_status.destroy_all_crates = bool
                        end
                        local status = label("Cargoship", "Cargoship Status", Color3.fromRGB(0, 0, 0))
                        --local destroy_all_crates = toggle("Cargoship", "Destroy All Crates", callback.destroy_all_crates)
                        local disable_cargoship_turrets = toggle("Cargoship", "Disable Turrets", callback.disable_cargoship_turrets)
                        config.disable_cargoship_turrets = disable_cargoship_turrets
                    end
                    cargoship()
                end
                local function info()
                    function callback.hideusername(bool)
                        global.ui_status.hideusername = bool
                    end
                    function callback.keybindUI(key)
                        global.ui_status.keybindUI = key.Name
                    end
                    function callback.goto_trade_world()
                        local generateJobId = global.registry.generateJobId
                        local jobId = generateJobId(true)
                        if jobId then
                            teleportservice:TeleportToPlaceInstance("9780994092", jobId, players.LocalPlayer)
                        end
                    end
                    function callback.join_random_server()
                        local generateJobId = global.registry.generateJobId
                        local jobId = generateJobId()
                        if jobId then
                            teleportservice:TeleportToPlaceInstance("606849621", jobId, players.LocalPlayer)
                        end
                    end
                    function callback.rejoin()
                        local jobId = game.JobId
                        if jobId then
                            teleportservice:TeleportToPlaceInstance("606849621", jobId, players.LocalPlayer)
                        end
                    end
                    function callback.saveuistatus(bool)
                        global.ui_status.saveuistatus = bool
                    end
                    function callback.lighting_technology(val)
                        local lighting_technology = global.registry.lighting_technology
                        if lighting_technology then
                            lighting_technology(val)
                        end
                    end
                    function callback.refresh_config()
                        if global._loaded then
                            global.refresh_config()
                        end
                    end
                    function callback.config_name(name)
                        if global._loaded then
                            global.ui_status.config_name = name
                        end
                    end
                    function callback.save_config()
                        if global._loaded then
                            global.save_config()
                        end
                    end
                    function callback.load_config(name)
                        if global._loaded then
                            global.load_config(name)
                        end
                    end
                    local infolabel = credit("Info", "Credits: alex9#0001 (870050524857258055)")
                    local infoversion = label("Info", ("Version: v%s-%s"):format(global.version, global.exploit))
                    local goto_trade_world = button("Info", "Teleport To Trade World", callback.goto_trade_world)
                    local join_random_server = button("Info", "Join Random Server", callback.join_random_server)
                    local rejoin = button("Info", "Rejoin", callback.rejoin)
                    local hideusername = toggle("Info", "Hide UI Username", callback.hideusername)
                    local saveuistatus = toggle("Info", "Save UI Status", callback.saveuistatus)
                    local keybindUI = keybind("Info", "UI Toggle Keybind", Enum.KeyCode.X, callback.keybindUI)
                    local lighting_technology = dropdown("LightingTechnology", "Technology", {"Compatibility", "Future", "ShadowMap", "Voxel"}, callback.lighting_technology)
                    local load_config = dropdown("Config", "Load Config", {}, callback.load_config)
                    local current_load = label("Config", "LOADED_CONFIG", Color3.fromRGB(200, 200, 200))
                    local refresh_config = button("Config", "Refresh", callback.refresh_config)
                    local config_name = textbox("Config", "Config Name", "name", callback.config_name)
                    local save_config = button("Config", "Save Config", callback.save_config)
                    config.hideusername = hideusername
                    config.saveuistatus = saveuistatus
                    config.keybindUI = keybindUI
                    config.load_config = load_config
                end
                player()
                vehicle()
                misc()
                combat()
                markers()
                robbery()
                info()
                global.ui_callbacks = callback
            end
            sections()
            global.ui.markerSection = {
                teamsSection = teamsSection;
                objSection = objSection;
                settingsSection = settingsSection;
            }
        end
        ui()
        global.features_loaded = true
    end
    ui()
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end
ON_LOADUP()

getrenv().env = getrenv()
env.icetray = global
env.IS_WORKING = true
env.CONNECTIONS = 1
env.request = request or syn and syn.request
env.discord_code = "5Eqt6QBfYY"
env.coregui = game:GetService("CoreGui")

while true do
    if coregui:FindFirstChild("ice tray v4") then
        getrenv().uistatus = false
        break
    end
    getrenv().uistatus = true
    task.wait()
end

global.USER_INPUT_TYPE_SWITCH = false
global.IS_IN_NOCLIP = false
local client = {}
local meta = {
    __index = function(t, k)
        warn(("Could not find key `%s`"):format(k))
    end;
}
setmetatable(client, meta)

local function icetrayload()
    local function createRegistry()
        client.modules = {
            math = require(repl.Module.Math);
            roact = require(repl.Roact);
            rayCast = require(repl.Module.RayCast);
            bulletEmitter = require(repl.Game.ItemSystem.BulletEmitter);
            notify = require(repl.Game.Notification).new;
            contextMsg = require(repl.Game.ContextMessage.ContextMessageUI);
            worldMarker = require(repl.Game.WorldMarker.WorldMarker);
            system = require(repl.Game.WorldMarker.WorldMarkerSystem);
            group = require(repl.Game.WorldMarker.WorldMarkerGroup);
            cmdr = require(repl.CmdrClient);
            crawlButton = require(repl.Game.DefaultActions).crawlButton;
            fallingInit = require(repl.Game.Falling).Init;
            falling = require(repl.Game.Falling);
            playerMarkerSystem = require(repl.Game.PlayerMarkerSystem);
            vehicle = require(repl.Vehicle.VehicleUtils);
            settings = require(repl.Resource.Settings);
            itemSystem = require(repl.Game.ItemSystem.ItemSystem);
            inventoryItemSystem = require(repl.Inventory.InventoryItemSystem);
            gun = require(repl.Game.Item.Gun);
            taser = require(repl.Game.Item.Taser);
            robberyConsts = require(repl.Robbery.RobberyConsts);
            puzzleFlow = require(repl.Game.Robbery.PuzzleFlow);
            ui = require(repl.Module.UI);
            playerUtils = require(repl.Game.PlayerUtils);
            tagUtils = require(repl.Tag.TagUtils);
            smoke = require(repl.Game.SmokeGrenade.SmokeGrenade);
            localization = require(repl.Module.Localization);
            characterAnim = require(repl.Game.CharacterAnim);
            characterUtil = require(repl.Game.CharacterUtil);
            paraglide = require(repl.Game.Paraglide);
            region = require(repl.Std.Region);
            defaultActions = require(repl.Game.DefaultActions);
            actionButtonService = require(repl.ActionButton.ActionButtonService);
            inventoryItemUtils = require(repl.Inventory.InventoryItemUtils);
            jetpack = require(repl.Game.JetPack.JetPack);
            guardNPCshared = require(repl.GuardNPC.GuardNPCShared);
            worldUnloadConsts = require(repl.WorldUnload.WorldUnloadConsts);
            humanoidUnloadConsts = require(repl.HumanoidUnload.HumanoidUnloadConsts);
            gamepassSystem = require(repl.Game.Gamepass.GamepassSystem);
            piston = require(repl.Game.Robbery.PowerPlant.Piston);
            dartDispenser = require(repl.Game.DartDispenser.DartDispenser);
            itemCamera = require(repl.Game.ItemSystem.ItemCamera);
            sniper = require(repl.Game.Item.Sniper);
            militaryTurret = require(repl.Game.MilitaryTurret.MilitaryTurret);
            bossNpcBinder = require(repl.MansionRobbery.BossNPCBinder);
            --cargoShipTurret = require(repl.Game.Robbery.CargoShip.Turret); -- Ö
            lightningSystem = require(repl.Game.LightningSystem);
            confirmation = require(repl.Module.Confirmation);
            hotbarItemSystem = require(repl.Hotbar.HotbarItemSystem);
            hotbarItemUtils = require(repl.Hotbar.HotbarItemUtils);
            party = require(repl.Game.Party);
            geomUtils = require(repl.Std.GeomUtils);
            vehicleLinkUtils = require(repl.VehicleLink.VehicleLinkUtils);
            loadingBar = require(repl.Game.LoadingBar);
            mansionRobberyUtils = require(repl.MansionRobbery.MansionRobberyUtils);
            regionUtils = require(repl.Std.Region.RegionUtils);
            displayDamage = require(repl.Game.DisplayDamage);
            minimapService = require(repl.App.MinimapService);
            jet = require(repl.Game.Plane.Jet);
            stunt = require(repl.Game.Plane.Stunt);
            boat = require(repl.Game.Boat.Boat);
            seekingMissileUtils = require(repl.SeekingMissile.SeekingMissileUtils);
            volt = require(repl.Game.Vehicle.Volt);
            alexChassis2 = require(repl.Module.AlexChassis2);
            charBinder = require(repl.App.CharacterBinder);
            trainSystem = require(repl.Game.TrainSystem);
            tableUtils = require(repl.Std.TableUtils);
            levenshtein = require(repl.Module.Levenshtein);
            c4 = require(repl.Game.Item.C4);
            simulatedPhysicsProjectile = require(repl.Module.SimulatedPhysicsProjectile);
            roll = require(repl.MovementRoll.MovementRollService);
            gameUtil = require(repl.Game.GameUtil);
            trackingSpotlight = require(repl.TrackingSpotlight.TrackingSpotlightBinder);
            rocketLauncherConsts = require(repl.RocketLauncher.RocketLauncherConsts);
            seekingMissileShared = require(repl.SeekingMissile.SeekingMissileShared);
            netObjPool = require(repl.NetObjPool.NetObjPoolBinder);
            smokeGrenade = require(repl.Game.Item.SmokeGrenade);
            turret = require(repl.Turret2.Turret);
        }
        client.confirmation = {
            confirmed = {};
        }
        client.players = {}
        client.descendants = {
            givers = workspace.Givers:GetChildren();
            vehicles = workspace.Vehicles;
        }
        client.onWorkspaceSpawnRun = {}
        client.onWorkspaceRemovedRun = {}
        client.reg = {}
        client.state = {}
        client.waypoints = {
            bank = "Rising City Bank";
            crater_city_bank = "Crater City Bank";
            jewelry = "Jewelry";
            museum = "Museum";
            tomb = "Tomb";
            casino = "Casino";
            powerplant = "Powerplant";
            mansion = "Mansion";
            bounty_bay_airport = "Bounty Bay Airport (Cargoplane)";
            donut_store = "Donut Store";
            gas_station = "Gas Station";
            criminal_base_city = "City Criminal Base";
            criminal_base_volcano = "Volcano Criminal Base";
            crater_city_airport = "Crater City Airport";
            cargo_port = "Cargoport";
            prison = "Prison";
            military_base = "Military Base";
            fire_station = "Fire Station";
            gun_store_city = "City Gun Store";
            gun_store_mountainside = "Mountainside Gun Store";
            gun_store_cratercity = "Crater City Gun Store";
            oil_rig = "Oil Rig";
        }
        client.rayHooks = {}
        client.onGetEq = {}
        client.gamelocations = {
            criminal_base_city = Vector3.new(-241.04759216308594, 18.26566505432129, 1603.2467041015625);
            cargo_port = Vector3.new(-346.10906982421875, 21.265666961669922, 2051.884521484375);
            powerplant = Vector3.new(73.05872344970703, 21.26565933227539, 2330.603271484375);
            bounty_bay_airport = Vector3.new(-1280.7972412109375, 41.57174301147461, 2862.231689453125);
            museum = Vector3.new(1039.164306640625, 101.80693054199219, 1220.47412109375);
            gun_store_city = Vector3.new(387.13153076171875, 18.565671920776367, 519.4755859375);
            bank = Vector3.new(-11.083830833435059, 18.56781768798828, 785.1068115234375);
            jewelry = Vector3.new(90.18016815185547, 18.265535354614258, 1360.61181640625);
            gas_station = Vector3.new(-1563.6400146484375, 18.398113250732422, 709.526123046875);
            prison = Vector3.new(-1178.06005859375, 18.359729766845703, -1408.713134765625);
            donut_store = Vector3.new(93.99942016601562, 19.21782684326172, -1520.624755859375);
            dog_store = Vector3.new(254.4175567626953, 19.61784553527832, -1625.93212890625);
            gun_store_mountainside = Vector3.new(-9.677970886230469, 19.21782684326172, -1771.1429443359375);
            tomb = Vector3.new(557.5381469726562, 25.799976348876953, -490.9645080566406);
            military_base = Vector3.new(673.5711669921875, 19.318540573120117, -3615.018310546875);
            casino = Vector3.new(-301.520751953125, 19.817184448242188, -4661.919921875);
            crater_city_airport = Vector3.new(-854.0402221679688, 19.67174530029297, -4898.408203125);
            gun_store_cratercity = Vector3.new(-482.135986328125, 19.853652954101562, -5663.77197265625);
            fire_station = Vector3.new(-317.110107421875, 19.904991149902344, -5394.2763671875);
            mansion = Vector3.new(3087.748779296875, 62.8889274597168, -4604.91748046875);
            criminal_base_volcano = Vector3.new(2204.335205078125, 19.55750274658203, -2654.022216796875);
            rail_track1 = Vector3.new(512, 18, 1789);
            rail_track2 = Vector3.new(1517, 18, -176);
            crater_city_bank = Vector3.new(-668, 19, -6087);
            oil_rig = Vector3.new(-2374, 108, -4042);
        }
        local function loadRobberies()
            local robberies = {
                "bank";
                "museum";
                "jewelry";
                "mansion";
                "casino";
                "tomb";
                "powerplant";
                "crater_city_bank";
                "oil_rig";
            }
            for i,v in next, robberies do
                local location = client.gamelocations[v]
                player:RequestStreamAroundAsync(location)
            end
        end
        loadRobberies()
        client.run_on_player_connect = {}
        client.run_on_player_disconnect = {}
        local function addPlayersToTable()
            for i,v in next, players:GetPlayers() do
                if v ~= player then
                    table.insert(client.players, v)
                end
            end
        end
        addPlayersToTable()
        local function onPlayerAdded(player)
            for i,v in next, client.run_on_player_connect do
                v._fn(player)
            end
            table.insert(client.players, player)
        end
        players.PlayerAdded:connect(onPlayerAdded)
        local function onPlayerRemoving(player)
            for i,v in next, client.run_on_player_disconnect do
                v._fn(player)
            end
            for i=1, #client.players do
                local v = client.players[i]
                if v == player then
                    table.remove(client.players, i)
                    break
                end
            end
        end
        players.PlayerRemoving:connect(onPlayerRemoving)
        function client.confirmation.new(text)
            local confirmation = client.modules.confirmation.new(text)
            return confirmation
        end
        function client.confirmation.onYes(confirmation, onYes)
            confirmation.OnYes:Connect(onYes)
        end
        function client.confirmation.onNo(confirmation, onNo)
            confirmation.OnNo:Connect(onNo)
        end
        global.registry = {
            client = client;
            doors = {};
            sounds = {}; 
        }
        global.LocalMouse = player:GetMouse()
        global.ignorelist = {}
        local function notify(text, duration)
            return client.modules.notify({
                Text = tostring(text);
                Duration = tonumber(duration) or 0;
            })
        end
        global.notify = notify
        local contextMessageModule = client.modules.contextMsg
        client.contextModule = {
            open = contextMessageModule.open;
            close = contextMessageModule.close;
            setmsg = contextMessageModule.setMessage;
            status = contextMessageModule.isOpen;
        }
    end
    createRegistry()
    local function send_console_developer(text)
        local Cmdr = client.modules.cmdr
        if not Cmdr then
            force_destroy_coregui(true)
            return false
        end
        return Cmdr.Events.AddLine(("ICETRAY : %s"):format(tostring(text)))
    end
    send_console_developer("beginning icetrayload")
    local function keepRobberiesLoaded() 
        local locations = client.gamelocations
        while true do
            for i,v in next, locations do
                player:RequestStreamAroundAsync(v)
            end
            task.wait(5)
        end
    end
    task.spawn(keepRobberiesLoaded)--?
    local function synfunction()
        local function unsupported(func, isDebugLibrary)
            local msg = ("Tried to run %s but this function is not supported by your exploit")
            if func == "Drawing" then
                warn(msg:format("Drawing"))
                return {
                    new = function(...)
                    end;
                }
            end
            if isDebugLibrary then
                warn(msg:format("debug."..tostring(func)))
                return function() end
            end
            warn(msg:format(tostring(func)))
            return function() end
        end
        global.functions = {
            getreg = debug.getregistry or getreg or unsupported("getregistry", true);
            getupvalues = debug.getupvalues or unsupported("getupvalues", true);
            getconstants = debug.getconstants or unsupported("getconstants", true);
            setconstant = debug.setconstant or unsupported("setconstant", true);
            getupvalue = debug.getupvalue or unsupported("getupvalue", true);
            setupvalue = debug.setupvalue or unsupported("setupvalue", true);
            getgc = getgc or unsupported("getgc");
            getrawmetatable = getrawmetatable or unsupported("getrawmetatable");
            setreadonly = setreadonly or make_writeable or unsupported("make_writeable");
            newcclosure = newcclosure or unsupported("newcclosure");
            setclipboard = setclipboard or unsupported("setclipboard");
            islclosure = islclosure or unsupported("islclosure");
            setscriptable = setscriptable or unsupported("setscriptable");
            is_synapse_function = is_synapse_function or is_oxygen_function or iskrnlclosure or isexecutorclosure or checkclosure or unsupported("is_synapse_function");
            firetouchinterest = firetouchinterest or unsupported("firetouchinterest");
            fireclickdetector = fireclickdetector or unsupported("fireclickdetector");
            getconnections = getconnections or unsupported("getconnections");
            sethiddenproperty = sethiddenproperty or unsupported("sethiddenproperty");
            getsynasset = getsynasset or getcustomasset or unsupported("getsynasset");
            writefile = writefile or unsupported("writefile");
            readfile = readfile or unsupported("readfile");
            appendfile = appendfile or unsupported("appendfile");
            makefolder = makefolder or unsupported("makefolder");
            isfile = isfile or unsupported("isfile");
            isfolder = isfolder or unsupported("isfolder");
            decompile = decompile or function() return "nu exista decompiler pe acest executor" end;
            listfiles = listfiles or unsupported("listfiles");
            set_thread_identity = syn and syn.set_thread_identity or set_thread_identity or setthreadidentity or unsupported("set_thread_identity");
            drawing = Drawing or unsupported("Drawing");
        }
    end
    local function tagService()
        local function tagStorage()
            local inst = Instance.new("Folder")
            inst.Name = "tagService"
            if IS_NOT_OBFUSCATED then
                inst.Parent = repl
                warn("tagService folder is in ReplicatedStorage")
            end
            return inst
        end
        local tags = {}
        tags.storage = tagStorage()
        tags.tags = {
            BoolValue = 0;
            NumberValue = 1;
            StringValue = 2;
            BrickColorValue = 3;
            CFrameValue = 4;
            Color3Value = 5;
            IntValue = 6;
            ObjectValue = 7;
            RayValue = 8;
            Vector3Value = 9;
        }
        local tags_module = {}
        function tags_module.getTag(num)
            num = tonumber(num)
            for i,v in next, client.tags.tags do
                if v == num then
                    return i
                end
            end
            return false
        end
        tags.module = tags_module
        tags.cache = {}
        function tags.new(name, tip, defaultValue, callback)
            name = tostring(name)
            local getTag = client.tags.module.getTag(tip)
            if not getTag then
                error(("cannot make tag `%s`"):format(name))
            end
            local cache = {}
            local inst = Instance.new(getTag)
            inst.Name = name
            inst.Parent = client.tags.storage
            inst.Value = defaultValue
            inst.Changed:connect(function()
                cache.obj = inst
                cache.value = inst.Value
                return callback(inst.Value)
            end)
            cache.name = name
            cache.obj = inst
            cache.value = inst.Value
            table.insert(tags.cache, cache)
            return cache
        end
        function tags.getTagByName(self, name)
            local cache = self.cache
            for i,v in next, cache do
                if v and v.name == name then
                    return v
                end
            end
            return false
        end
        client.tags = tags
    end
    local function warningBar()
        local warning = {}
        local gui = {}
        function warning.new(typ, props)
            local inst = Instance.new(typ)
            for i,v in next, props do
                if i ~= "Parent" then
                    if typeof(v) == "Instance" then
                        v.Parent = inst
                    else
                        inst[i] = v
                    end
                end
            end
            inst.Parent = props.Parent
            return inst
        end
        function warning.start(self)
            local ui = self.new("ScreenGui", {
                Name = "warnings";
                Parent = player.PlayerGui;
                Enabled = false;
                self.new("Frame", {
                    Active = true;
                    Draggable = true;
                    AnchorPoint = Vector2.new(0.5, 1);
                    BackgroundTransparency = 1;
                    Position = UDim2.new(0.49, 0, 0.35, 0);
                    Size = UDim2.new(0, 377, 0, 208);
                    ZIndex = 3;
                    self.new("TextLabel", {
                        BackgroundTransparency = 1;
                        Position = UDim2.new(0.104065098, 0, 0.247999325, 0);
                        Size = UDim2.new(0, 94, 0, 102);
                        Text = "⚠️";
                        TextSize = 75.000;
                        BorderSizePixel = 2;
                        TextWrapped = true;
                        Font = Enum.Font.SourceSans;
                    });
                    self.new("TextLabel", {
                        Name = "State";
                        BackgroundTransparency = 1;
                        Position = UDim2.new(0.33129105, 0, 0.377007276, 0);
                        Size = UDim2.new(0, 212, 0, 26);
                        TextColor3 = Color3.fromRGB(255, 255, 255);
                        Font = Enum.Font.Ubuntu;
                        Text = "State";
                        TextSize = 15;
                        TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
                        TextStrokeTransparency = 0.5;
                    });
                    self.new("Frame", {
                        Name = "Uncolored";
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                        BackgroundTransparency = 0.6;
                        BorderSizePixel = 0;
                        Position = UDim2.new(0.330542207, 0, 0.502994716, 0);
                        Size = UDim2.new(0, 213, 0, 7);
                        self.new("Frame", {
                            Name = "Colored";
                            BorderSizePixel = 0;
                            Size = UDim2.new(0, 1, 0, 7);
                            self.new("UIGradient", {
                                Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 200, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))};
                            });
                        });
                    });
                });
            });
            local new = {}
            new.ui = ui
            new.percentage = 0
            function new.getEnabled(self)
                return self.ui.Enabled
            end
            function new.setEnabled(self, value)
                self.ui.Enabled = value
            end
            function new.setText(self, text)
                text = tostring(text)
                self.ui.Frame.State.Text = text
            end
            function new.cleanup(self)
                self.ui.Enabled = false
                self.ui.Frame.Uncolored.Colored.Size = UDim2.new(0, 1, 0, 7)
                self.percentage = 0
                self.time = nil
            end
            function new.tween(self)
                local tween = tweenservice:Create(self.ui.Frame.Uncolored.Colored, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2.new(self.percentage/100, 1, 0, 7)})
                tween:Play()
            end
            function new.play(self)
                assert(not self.hb, "hb already in process...")
                self.time = tick()
                self.hb = runservice.Heartbeat:connect(function()
                    if self.percentage >= 101 then
                        self.hb:disconnect()
                        self.hb = nil
                        task.delay(0.1, function()
                            self:cleanup()
                        end)
                        return false
                    end
                    if tick() - self.time > 0.02 then
                        self.percentage += 1 
                        self:tween()
                        self.time = tick()
                    end
                end)
            end
            return new
        end
        client.warningBar = warning:start()
    end
    warningBar()
    function global.createloop(seconds, callback)
        return interval.every(tonumber(seconds)):connect(callback)
    end
    local function createfiles()
        local writefile = global.functions.writefile
        local appendfile = global.functions.appendfile
        local makefolder = global.functions.makefolder
        local isfile = global.functions.isfile
        local isfolder = global.functions.isfolder
        local isIcetrayFolder = isfolder("icetray")
        if not isIcetrayFolder then
            makefolder("icetray")
        end
        local isResourceFolder = isfolder("icetray/resource")
        if not isResourceFolder then
            makefolder("icetray/resource")
        end
        local isConfigurationFolder = isfolder("icetray/config")    
        if not isConfigurationFolder then
            makefolder("icetray/config")
        end
        local function files()
            send_console_developer("loading resource")
            local isfile = global.functions.isfile
            local function makeResources()
                local function httpGet(url)
                    return game:HttpGet(url)
                end
                if not isfile("icetray/resource/airdrop.png") then
                    writefile("icetray/resource/airdrop.png", httpGet("https://img001.prntscr.com/file/img001/CxPl0JU6SyyrHhMyL5NEhw.png"))
                end
                if not isfile("icetray/resource/football.png") then
                    writefile("icetray/resource/football.png", httpGet("https://img001.prntscr.com/file/img001/RAhMFSwkRyCglvAtWrJbVQ.png"))
                end
                if not isfile("icetray/resource/robot.png") then
                    writefile("icetray/resource/robot.png", httpGet("https://img001.prntscr.com/file/img001/HDrYpapySqKS52X3BIMdHA.png"))
                end
            end
            makeResources()
        end
        files()
    end
    function Find(tbl, options)
        assert(#options~=0)
        local c = 1
        local f = {}
        for i, v in next, tbl do
            local str = options[c]
            if str and v == str then
                c += 1 
                table.insert(f, i)
            end
        end
        return f
    end
    synfunction()
    createfiles()
    tagService()
    send_console_developer("ended icetrayload")
    global.Find = Find
    global.registry.log = send_console_developer
end
icetrayload()

local createloop = global.createloop
local getreg = global.functions.getreg
local getupvalues = global.functions.getupvalues
local getconstants = global.functions.getconstants
local setconstant = global.functions.setconstant
local getupvalue = global.functions.getupvalue
local setupvalue = global.functions.setupvalue
local setreadonly = global.functions.setreadonly
local newcclosure = global.functions.newcclosure
local setclipboard = global.functions.setclipboard
local islclosure = global.functions.islclosure
local setscriptable = global.functions.setscriptable
local is_synapse_function = global.functions.is_synapse_function
local firetouchinterest = global.functions.firetouchinterest
local fireclickdetector = global.functions.fireclickdetector
local getconnections = global.functions.getconnections
local set_thread_identity = global.functions.set_thread_identity
local sethiddenproperty = global.functions.sethiddenproperty
local getgc = global.functions.getgc
local getsynasset = global.functions.getsynasset

local function loadup()
    local log = global.registry.log
    if not log then
        error("Configuration failure")
    end
    log("starting loadup")
    local function playerCharacter()
        local function onCharacterAdded(char)
            client.playerCharacter = player.Character
        end
        player.CharacterAdded:connect(onCharacterAdded)
        if player.Character then
            client.playerCharacter = player.Character
        else
            client.playerCharacter = player:WaitForChild("Character")
        end
    end
    playerCharacter()
    local function registry()
        local function funcs()
            local _equipConditions = client.modules.inventoryItemSystem._equipConditions
            local _unequipConditions = client.modules.inventoryItemSystem._unequipConditions
            for i,v in next, _equipConditions do
                local upvs, con = getupvalues(v), getconstants(v)
                if #upvs == 2 then
                    global.registry.antiEquip = upvs
                end
                if table.find(con, "IsCrawling") then
                    global.registry.iscrawling = v
                end
            end
            table.insert(_equipConditions, function()
                if global.is_instant_reloading then
                    return false
                end
                return true
            end)
            table.insert(_unequipConditions, function()
                if global.is_instant_reloading then
                    return false
                end
                return true
            end)
            local onPressed = getupvalue(client.modules.crawlButton.onPressed, 3)
            if onPressed then
                global.registry.buttons = onPressed
                local lastDuckTick = getupvalue(onPressed.attemptToggleCrawling, 9)
                if lastDuckTick then
                    global.registry.lastDuckTick = lastDuckTick
                else
                    log("Wrong upvalue for lastDuckTick")
                end
            else
                log("Wrong upvalue for onPressed")
            end
            local falling = getupvalue(client.modules.falling.Init, 15)
            if falling then
                global.registry.falling = falling
            else
                log("Wrong upvalue for falling")
            end
            local trainSystem = client.modules.trainSystem
            local em = getupvalue(trainSystem.Init, 2)
            if em and type(em) == "table" then
                for i,v in next, em do
                    if type(v) == "function" then
                        if islclosure(v) then
                            local con = getconstants(v)
                            if table.find(con, "Stunned") then
                                global.registry.stunnedFunc = v
                            end
                            if table.find(con, "assert", 1) and table.find(con, "Nuke", 3) and table.find(con, "Shockwave", 3) then
                                global.registry.nukecontrol = v
                            end
                        end
                        for i2,v2 in next, getupvalues(v) do
                            if type(v2) == "function" and islclosure(v2) then
                                local con = getconstants(v2)
                                if table.find(con, "error") == 1 then
                                    global.registry.isInMuseumRobbery = v2
                                end
                            end
                        end
                    end
                end
            else
                log("Wrong upvalue for em")
            end
            local gates = {}
            for i,v in next, collectionservice:GetTagged("Door") do
                for i2,v2 in next, v:GetChildren() do
                    if v2:IsA("ObjectValue") and v2.Name == "Button" then
                        local val = v2.Value
                        if val then
                            if val:IsA("Part") then
                                val = val.Parent
                            end
                            if val:IsA("Model") then
                                val = val:FindFirstChild("ClickDetector", true)
                            end
                            table.insert(gates, val.MouseClick)
                        end
                    end
                end
            end
            global.registry.prisonGate = gates
            local function hasKey()
                local inventoryItemSystem = client.modules.inventoryItemSystem
                local gameUtil = client.modules.gameUtil
                local settings = client.modules.settings
                if gameUtil.Team == settings.EnumTeam.Police then
                    return true
                end
                return inventoryItemSystem.playerHasItem(player, "Key")
            end
            global.registry.hasKey = hasKey
            local getreg = getreg()
            for i,v in next, getreg do
                if type(v) == "function" then
                    for i2,v2 in next, getupvalues(v) do
                        if type(v2) == "table" then
                            if rawget(v2, "Nitro") and rawget(v2, "NitroLastMax") then
                                global.registry.nitro = v2
                            end
                            for i3,v3 in next, v2 do
                                if type(v3) == "table" and rawget(v3, "Tag") and rawget(v3, "Part") and type(rawget(v3, "Fun")) == "function" then
                                    table.insert(global.registry.doors, v3.Fun)
                                end
                            end
                        end
                        if type(v2) == "function" then
                            if islclosure(v2) then
                                local con = getconstants(v2)
                                if table.find(con, "ShouldEject") then
                                    global.registry.shouldEject = v2
                                end
                            end
                            for i3,v3 in next, getupvalues(v2) do
                                if type(v3) == "function" and islclosure(v3) then
                                    local con = getconstants(v3)
                                    if table.find(con, "Source") and table.find(con, "Play") then
                                        global.registry.playSounds = v3
                                    end
                                end
                            end
                        end
                    end
                    if islclosure(v) then
                        if not is_synapse_function(v) then
                            for i2,v2 in next, getupvalues(v) do
                                if type(v2) == "table" and type(rawget(v2, "Fireworks")) == "function" then
                                    global.registry.fireworks = v2
                                end
                            end
                        end
                    end
                end
            end
            for i,v in next, global.registry.doors do
                if type(v) == "function" and #getupvalues(v) >= 4 then
                    local o = getupvalue(v, 4)
                    setupvalue(v, 4, function(...)
                        if global.ui_status.master_switch_open_doors then
                            return true
                        end
                        return o(...)
                    end)
                end
            end
            return true
        end
        local funcs = funcs()
        while true do
            if funcs then
                break
            end
            task.wait()
        end
        local function shouldFuncs()
            local charBinder = client.modules.charBinder
            local _fn = getupvalue(getupvalue(charBinder:GetClassAddedSignal()._handlerListHead._fn,1),2)
            global.registry.shouldArrest = getupvalue(_fn, 1)
            global.registry.shouldPickpocket = _fn
            global.registry.shouldBreakout = _fn
        end
        shouldFuncs()
        local function generateJobId(isTradeWorld) -- @dont remember who created this function, but thanks :D
            local placeId
            if isTradeWorld then
                placeId = "9780994092"
            else
                placeId = "606849621"
            end
            local jobids = {}
            local api = httpservice:JSONDecode(game:HttpGetAsync(("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100"):format(placeId)))
            for i,v in next, api.data do
                if v.playing ~= nil then
                    if v.playing < 29 then
                        table.insert(jobids, v.id)
                    end
                end
            end
            if #jobids < 1 then
                log("No JobId could be found. Try generating again! Generator issue from whoever created this function or roblox(?)")
                return ""
            end
            return jobids[math.random(1, #jobids)]
        end
        local markerColors = {
            Prisoner = Color3.fromRGB(253, 148, 81);
            Police = Color3.fromRGB(84, 215, 253);
            Criminal = Color3.fromRGB(253, 100, 30);
            Airdrop = Color3.fromRGB(148, 0, 211);
            Football = Color3.fromRGB(68, 186, 13);
            NPCs = Color3.fromRGB(140, 182, 210);
            Bounty = Color3.fromRGB(255, 255, 50);
            Target = Color3.fromRGB(179, 182, 255);
        }
        local markerSystem = client.modules.playerMarkerSystem
        local function constructMarker(player)
            return markerSystem._constructMarker(player)
        end
        local function setColor(player, color)
            return markerSystem._setColor(player, color)
        end
        local function destructMarker(player)
            return markerSystem._destructMarker(player)
        end
        local function doesMarkerExist(player)
            return markerSystem._doesMarkerExist(player)
        end
        local function getLocalVehicle()
            local module = client.modules.vehicle.GetLocalVehiclePacket()
            if module and module.IsPassenger then
                return false
            end
            return module
        end
        local function getHeliRope(getLocalVehicle)
            if getLocalVehicle then
                if getLocalVehicle.Model:FindFirstChild("Preset") and getLocalVehicle.Model.Preset:FindFirstChild("RopePull") then
                    return getLocalVehicle.Model.Preset.RopePull
                end
            end
            return false
        end
        local function canLockVehicle()
            return client.modules.vehicle.canLocalLock()
        end
        local function toggleLock()
            return client.modules.vehicle.toggleLocalLocked()
        end
        local function passengerKick(player)
            client.modules.vehicle.attemptPassengerEject(player)
        end
        local function getPlayerVehicle(player, isArresting)
            for i,v in next, client.descendants.vehicles:GetChildren() do
                local seat = v:FindFirstChild("Seat")
                local passenger = v:FindFirstChild("Passenger")
                local sname = seat and seat:FindFirstChild("PlayerName")
                if sname and sname.Value == player.Name then
                    if isArresting then
                        return v.Seat
                    end
                    return v
                end
                local pname = passenger and passenger:FindFirstChild("PlayerName")
                if pname and pname.Value == player.Name then
                    if isArresting then
                        return v.Passenger
                    end
                    return v
                end
            end
            return false
        end
        local function getPartsInRegion(posX, posY, posZ, minX, minY, minZ, maxX, maxY, maxZ)
            if posX < maxX and posX > minX then
                if posZ < maxZ and posZ > minZ then
                    if posY < maxY and posY > minY then
                        return true 
                    end
                end
            end
            return false
        end
        local function isVulnerable(p1, p2, settings)
            p1 = tostring(p1)
            p2 = tostring(p2)
            if p1 and p2 then
                if p1 == "Police" then
                    if p2 == "Criminal" then
                        return true
                    end
                    if p2 == "Prisoner" then
                        if settings and settings.prisonerTarget then
                            return global.ui_status.allow_target_prisoner
                        end
                        return false
                    end
                end
                if p1 == "Prisoner" then
                    if p2 == "Criminal" then
                        return false
                    end
                    if p2 == "Police" then
                        return true
                    end
                end
                if p1 == "Criminal" then
                    if p2 == "Prisoner" then
                        return false
                    end
                    if p2 == "Police" then
                        return true
                    end
                end
            end
        end
        local function sounds()
            for i,v in next, client.modules.settings.Sounds do
                table.insert(global.registry.sounds, i)
            end
        end
        task.spawn(sounds)
        --sounds()
        local function hasItemEquipped(item)
            local isItemEquipped = client.modules.itemSystem.GetLocalEquipped()
            return isItemEquipped and isItemEquipped.inventoryItemValue.name == item
        end
        local function addWaypoint(tbl)
            local minimapService = client.modules.minimapService
            return minimapService.addWaypoint({
                name = "USER";
                position = tbl.position;
                priority = tbl.priority or 100;
            })
        end
        local function setWaypoint(key)
            local addWaypoint = global.registry.addWaypoint
            if addWaypoint then
                local waypoints = client.waypoints
                local gamelocations = client.gamelocations
                for keyName, label in next, waypoints do
                    if label == key then
                        addWaypoint({
                            position = gamelocations[keyName];
                            priority = 100;
                        })
                        break
                    end
                end
            end
        end
        local function getEquippedItem()
            return client.modules.itemSystem.GetLocalEquipped()
        end
        local function unequipAll()
            return client.modules.inventoryItemSystem.unequipAll()
        end
        local function getInventoryItemsFor(player)
            if not player then
                return false
            end
            local inventoryItemSystem = client.modules.inventoryItemSystem
            return inventoryItemSystem.getInventoryItemsFor(player)
        end
        local function equip(item)
            if not client.playerCharacter then
                return false
            end
            local success, err = pcall(function()
                local hasItemEquipped = global.registry.hasItemEquipped
                for i,v in next, client.reg.getInventoryItemsFor do
                    if v.obj.name == item and not hasItemEquipped(item) and v.AttemptSetEquipped then
                        v:AttemptSetEquipped(true)
                    end 
                end
            end)
            if not success then
                warn(("Something errored when trying to equip item `%s`"):format(item))
                log(("Something errored when trying to equip item `%s`"):format(item))
            end
        end
        local function neverDropItems()
            return {"Taser", "Handcuffs", "RoadSpike", "Bag", "Crate", "Gem", "MansionInvite"}
        end
        local function dropGun()
            local hasItemEquipped = global.registry.hasItemEquipped
            local neverDropItems = global.registry.neverDropItems()
            for i,v in next, client.reg.getInventoryItemsFor do
                if hasItemEquipped(v.obj.name) then
                    if not table.find(neverDropItems, v.obj.name) then
                        v:AttemptDrop()
                    end
                end
            end
        end
        local function call_elevator_to_floor(floor)
            local casino = workspace:FindFirstChild("Casino")
            if not casino then
                return false
            end
            local elevatorCar = casino.Elevator.Car:GetDescendants()
            if not elevatorCar then
                return false
            end
            local elevatorFloors = casino.Elevator.Floors:GetDescendants()
            if not elevatorFloors then
                return false
            end
            floor = tostring(floor)
            local function clickDetector(floor)
                if floor == 4 then
                    for i,v in next, elevatorCar do
                        if v.Name == "4" and v:FindFirstChild("ClickDetector") then
                            fireclickdetector(v.ClickDetector)
                        end
                    end
                    return true
                end
                for i,v in next, elevatorFloors do
                    if v.Name == "Call" and v.Parent.Name == tostring(floor) then
                        fireclickdetector(v.ClickDetector)
                    end
                end
            end
            if floor == "The Roof" then
                clickDetector(4)
            end
            if floor == "Security" then
                clickDetector(3)
            end
            if floor == "Ground" then
                clickDetector(2)
            end
            
            if floor == "Vaults" then
                clickDetector(1)
            end
        end
        local function checkWallBeforePenetration(target)
            if not target then
                return false
            end
            if workspace:FindFirstChild("Drop") then
                if target:IsDescendantOf(workspace.Drop) then
                    return true
                end
            end
            if workspace:FindFirstChild("MansionRobbery") then
                if target:IsDescendantOf(workspace.MansionRobbery) then
                    return true
                end
            end
            local localChar = client.playerCharacter
            local ignorelist = global.ignorelist
            local camera = workspace.CurrentCamera
            local char = target.Character
            if not char or not localChar then
                return false
            end
            local function rayCheck(target)
                local result = true
                local dist = (camera.CFrame.Position - target.Head.Position).magnitude
                local unit = (target.Head.Position - camera.CFrame.Position).unit
                local list = {camera, client.playerCharacter, global.LocalMouse.TargetFilter}
                for i,v in next, ignorelist do
                    table.insert(list, v)
                end
                local ray = Ray.new(camera.CFrame.Position, unit * dist)
                local hit = workspace:FindPartOnRayWithIgnoreList(ray, list) -- @ asta am furat o de undeva dar nu mai tin minte de unde
                if hit and not hit:IsDescendantOf(target) then
                    result = false
                    if not hit.CanCollide and hit.ClassName ~= Terrain or hit:IsDescendantOf(client.descendants.vehicles) then
                        ignorelist[#ignorelist + 1] = hit
                    end
                end
                return result
            end
            return rayCheck(char)
        end
        local isAnchored = false
        local last_used_shoot = tick()
        local function shootGun()
            if global.ui_status.spam_drop_guns then
                return false
            end
            if global.is_instant_reloading then
                return false
            end
            if global.is_registering_item then
                return false
            end
            local function attemptShoot(gun)
                if not gun.ShootCheckConditions then
                    return function() end
                end
                pcall(function()
                    client.modules.gun._attemptShoot(gun)
                end)
            end
            local getEquippedItem = client.reg.getEquippedItem
            if not getEquippedItem then
                return false
            end
            if not getEquippedItem.BulletEmitter then
                return false
            end
            if tick() - last_used_shoot < 0.2 and getEquippedItem.__ClassName == "Sniper" then
                return false
            end
            last_used_shoot = tick()
            attemptShoot(getEquippedItem)
        end
        local function canUseTaser(taser)
            local utils = client.modules.inventoryItemUtils
            return utils.getAttr(taser.inventoryItemValue, "NextUse") > 0
        end
        local function useTaser()
            local function tase(taser)
                global.AI_TASER_USE = true
                task.delay(0.5, function()
                    global.AI_TASER_USE = false
                end)
                return client.modules.taser.Tase(taser, taser) --@nu inteleg de ce trebuie `taser` pus de 2 ori. 
            end
            local getEquippedItem = client.reg.getEquippedItem
            if not getEquippedItem then
                return false
            end
            tase(getEquippedItem)
        end
        local function getRobberyStatus(robbery)
            local enums = {
                "OPENED";
                "STARTED";
                "CLOSED";
            }
            
            local consts = client.modules.robberyConsts
            local robberystate = repl:FindFirstChild("RobberyState")
            for i,v in next, consts.LIST_ROBBERY do
                local enum = consts.ENUM_ROBBERY[v]
                local state = robberystate:FindFirstChild(enum)
                if state then
                    local data = consts.DATA_ROBBERY[enum]
                    if tostring(data.key) == tostring(robbery) then
                        return enums[state.Value]
                    end
                end
            end
            return "?"
        end
        local function getClosestCrate()
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                return false
            end
            local plane = workspace:FindFirstChild("Plane")
            if not plane then
                return false
            end
            local crates = plane:FindFirstChild("Crates")
            if not crates then
                return false
            end
            local target, dist = nil, math.huge
            for i,v in next, crates:GetDescendants() do
                if v:IsA("BasePart") then
                    local magnitude = (root.Position - v.Position).magnitude
                    if magnitude < dist then
                        dist = magnitude
                        target = v
                    end
                end
            end
            return target
        end
        local function hasMansioninvite()
            return table.find(client.reg.resolveEquippedItems, "MansionInvite")
        end
        local function getKeycode()
            local casino = workspace:FindFirstChild("Casino")
            if not casino then
                return ""
            end
            local parts = {}
            local codes = casino.RobberyDoor.Codes
            local code = ""
            for i,v in next, codes:GetDescendants() do
                if v:IsA("TextLabel") and #v.Text ~= 0 then
                    table.insert(parts, {
                        textLabel = v;
                        part = v.Parent.Parent;
                    })
                end
            end
            table.sort(parts, function(x, y)
                return x.part.Position.z > y.part.Position.z
            end)
            for i,v in next, parts do
                code = code .. v.textLabel.Text
            end
            return code or ""
        end
        local function getCasinoDoor()
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                return false
            end
            local casino = workspace:FindFirstChild("Casino")
            if not casino then
                return false
            end
            local robberyDoor = casino.RobberyDoor:GetDescendants()
            for i,v in next, robberyDoor do
                if v.Name == "Region" then
                    if (v.Position - root.Position).magnitude < 15 then
                        return true
                    end
                end
            end
            return false
        end
        local mostWanted = workspace.MostWanted
        local function getPlayersWithBounty()
            local plrs = {}
            for i,v in next, mostWanted:FindFirstChild("MostWanted"):GetDescendants() do
                if v:IsA("TextLabel") and v.Name == "PlayerName" and v.Name ~= "badcc" then
                    for i2,v2 in next, client.players do
                        if v.Text == v2.DisplayName and not table.find(plrs, v2) then
                            table.insert(plrs, v2)
                        end
                    end
                end
            end
            return plrs
        end
        local function hasInVehicleTag(char)
            if char and char:FindFirstChild("InVehicle") then
                return true
            end
            return false
        end
        local function getSeats()
            local vehicle = client.modules.vehicle
            local plrs = {}
            local getVehicle = client.reg.getLocalVehicle
            if getVehicle then
                local getSeats = vehicle.getSeats(getVehicle.Model)
                for i,v in next, getSeats do
                    if v.Player ~= player then
                        table.insert(plrs, v)
                    end
                end
            else
                return nil
            end
            return plrs
        end
        local function getClosestPlayer(range, settings)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local rootplr = char.PrimaryPart
            if not rootplr then
                return false
            end 
            local isVulnerable = global.registry.isVulnerable
            local target, dist = nil, range
            for i,v in next, client.players do
                local char = v.Character
                if char and isVulnerable(player.Team, v.Team, {
                    prisonerTarget = global.ui_status.allow_target_prisoner
                }) then
                    local hum = char:FindFirstChild("Humanoid")
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root and hum and hum.Health > 0 then
                        local magnitude = (root.Position - rootplr.Position).magnitude
                        if magnitude < dist then
                            target = v
                            dist = magnitude
                        end
                    end
                end
            end
            return target
        end
        local function getAllClosePlayers(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local rootplr = char.PrimaryPart
            if not rootplr then
                return false
            end 
            local isVulnerable = global.registry.isVulnerable
            local targets = {}
            for i,v in next, client.players do
                local char = v.Character
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if hum and root and hum.Health > 0 then
                        local distance = (root.Position - rootplr.Position).magnitude
                        if distance < range then
                            table.insert(targets, v)
                        end
                    end
                end
            end
            return targets
        end
        local function getClosestPlayerWithVehicleTag(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local rootplr = char:FindFirstChild("HumanoidRootPart")
            if not rootplr then
                return false
            end
            local target = {}
            for i,v in next, client.players do
                if v ~= player then
                    local char = v.Character
                    if char and hasInVehicleTag(char) then
                        local hum = char:FindFirstChild("Humanoid")
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if hum and root and hum.Health > 0 then
                            local distance = player:DistanceFromCharacter(root.Position) -- (root.Position - rootplr.Position).magnitude
                            if distance < range then
                                table.insert(target, v)
                            end
                        end
                    end
                end
            end
            return target
        end
        local function getClosestPlayerForBreakouts(range)
            if tostring(player.Team) == "Police" then
                return false
            end
            local char = client.playerCharacter
            if not char then
                return false
            end
            local rootplr = char:FindFirstChild("HumanoidRootPart")
            if not rootplr then
                return false
            end
            local target, dist = nil, 0
            for i,v in next, client.players do
                if v ~= player then
                    if tostring(v.Team) ~= "Police" then
                        local char = v.Character
                        if char and v.Folder:FindFirstChild("Cuffed") then
                            local hum = char:FindFirstChild("Humanoid")
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if hum and root and hum.Health > 0 then
                                local distance = player:DistanceFromCharacter(root.Position) -- (root.Position - rootplr.Position).magnitude
                                if distance < range then
                                    target = v
                                end
                            end
                        end
                    end 
                end
            end
            return target
        end
        local function getClosestVulnerablePlayer(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char.PrimaryPart
            if not root then
                return false
            end
            local isVulnerable = global.registry.isVulnerable
            local target, dist = nil, range
            for i,v in next, client.players do
                if v ~= player then
                    local char = v.Character
                    if char and not v.Folder:FindFirstChild("Cuffed") then
                        local hum = char:FindFirstChild("Humanoid")
                        local primaryPart = char.PrimaryPart
                        if hum and hum.Health > 0 and primaryPart then
                            if isVulnerable(player.Team, v.Team) then
                                local distance = (root.Position - primaryPart.Position).magnitude
                                if distance < dist then
                                    dist = distance
                                    target = v
                                end
                            end
                        end
                    end
                end
            end
            return target
        end
        local function getClosestPlayerByFov(range, isJetSearch)
            local char = client.playerCharacter
            if char then
                local rootplr = char:FindFirstChild("HumanoidRootPart")
                if rootplr then
                    local camera = workspace.CurrentCamera
                    local mouse = global.LocalMouse
                    local mousepos = Vector2.new(mouse.X, mouse.Y)
                    local gml = uis:GetMouseLocation()
                    local target, dist = nil, math.huge
                    local allow_target_boss = global.ui_status.allow_target_boss
                    local allow_target_npcs = global.ui_status.allow_target_npcs
                    local allow_target_prisoner = global.ui_status.allow_target_prisoner
                    local force_target = global.aimbot.force_target
                    if force_target then
                        local max_dist = global.ui_status.max_distance or 500
                        local char = force_target.Character
                        if char then
                            if char:IsDescendantOf(workspace) then
                                local hum = char:FindFirstChild("Humanoid")
                                local root = char.PrimaryPart
                                if hum and root and hum.Health > 0 then
                                    if (root.Position - rootplr.Position).magnitude < 3500 then
                                        return force_target
                                    end
                                end
                            end
                        end
                    end 
                    local mansionRobbery = workspace:FindFirstChild("MansionRobbery")
                    if allow_target_boss then
                        if mansionRobbery then
                            local boss = mansionRobbery:FindFirstChild("ActiveBoss")
                            if boss then
                                local hum = boss:FindFirstChild("Humanoid")
                                local root = boss:FindFirstChild("HumanoidRootPart")
                                if hum and root and hum.Health > 0 then
                                    if (root.Position - rootplr.Position).magnitude < 300 then
                                        return boss
                                    end
                                end
                            end
                        end
                    end
                    if allow_target_npcs then
                        local drop = workspace:FindFirstChild("Drop")
                        if drop then
                            if #workspace.GuardNPCPlayers:GetChildren() > 0 then
                                for i,v in next, workspace.GuardNPCPlayers:GetChildren() do
                                    if v and v.Value then
                                        local hum = v.Value:FindFirstChild("Humanoid")
                                        local root = v.Value:FindFirstChild("HumanoidRootPart")
                                        if hum and root and hum.Health > 0 then
                                            local _, onscreen = camera:WorldToScreenPoint(root.Position)
                                            if onscreen then
                                                local dis = (Vector2.new(gml.X, gml.Y) - Vector2.new(_.X, _.Y)).magnitude
                                                if dis < dist and dis < range*1.5 and (root.Position - rootplr.Position).magnitude < 300 then
                                                    dist = dis
                                                    target = v.Value
                                                end
                                            end
                                        end
                                    end
                                end
                                if target then
                                    return target
                                end
                            end
                        end
                        if mansionRobbery then
                            local guardsFolder = mansionRobbery.GuardsFolder
                            if #guardsFolder:GetChildren() > 0 then
                                for i,v in next, guardsFolder:GetChildren() do
                                    local hum = v:FindFirstChild("Humanoid")
                                    local root = v:FindFirstChild("HumanoidRootPart")
                                    if hum and root and hum.Health > 0 then
                                        local _, onscreen = camera:WorldToScreenPoint(root.Position)
                                        if onscreen then
                                            local dis = (Vector2.new(gml.X, gml.Y) - Vector2.new(_.X, _.Y)).magnitude
                                            if dis < dist and dis < range*1.5 and (root.Position - rootplr.Position).magnitude < 300 then
                                                dist = dis
                                                target = v
                                            end
                                        end
                                    end
                                end
                                if target then
                                    return target
                                end
                            end
                        end
                    end
                    local max_dist = global.ui_status.max_distance or 500
                    for i,v in next, client.players do
                        if v ~= player then
                            if not isJetSearch and isVulnerable(player.Team, v.Team, {
                                prisonerTarget = global.ui_status.allow_target_prisoner
                            }) or isJetSearch and true then
                                local char = v.Character
                                if char and char:IsDescendantOf(workspace) then
                                    local hum = char:FindFirstChild("Humanoid")
                                    local root = char:FindFirstChild("HumanoidRootPart")
                                    if hum and root and hum.Health > 0 then
                                        local _, onscreen = camera:WorldToScreenPoint(root.Position)
                                        if onscreen then
                                            local dis = (Vector2.new(gml.X, gml.Y) - Vector2.new(_.X, _.Y)).magnitude
                                            local dis_ = (root.Position - rootplr.Position).magnitude
                                            if dis < dist and dis_ < max_dist then 
                                                dist = dis
                                                target = v
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    return target
                end
            end
        end
        local function getClosestHeliPickup(part, range)
            local char = client.playerCharacter
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local getLocalVehicle = client.reg.getLocalVehicle
                    if getLocalVehicle then
                        local getHeliRope = global.registry.getHeliRope(getLocalVehicle)
                        if getHeliRope then
                            local target
                            local vehicleLinkUtils = client.modules.vehicleLinkUtils
                            local geomUtils = client.modules.geomUtils
                            for i,v in next, collectionservice:GetTagged("HeliPickup") do
                                if v ~= getLocalVehicle.Model then
                                    local getPrimaryPart = vehicleLinkUtils.getPrimaryPart(v)
                                    if getPrimaryPart then
                                        local mag = (part.Position - geomUtils.closestPointInPart(getPrimaryPart, part.Position)).magnitude
                                        if mag < range then
                                            range = mag
                                            target = v
                                        end
                                    end
                                end
                            end
                            return target
                        end 
                    end
                end
            end
            return false
        end
        local function getClosestPlayerWithNoHandcuffs(range, bool)
            local char = client.playerCharacter
            if char then
                local rootplr = char:FindFirstChild("HumanoidRootPart")
                if rootplr then
                    local target
                    for i,v in next, client.players do
                        if v ~= player then
                            if tostring(v.Team) ~= tostring(player.Team) and tostring(v.Team) ~= "Prisoner" then
                                local char = v.Character
                                if char then
                                    local hum = char:FindFirstChild("Humanoid")
                                    local root = char:FindFirstChild("HumanoidRootPart")
                                    if hum and root and hum.Health > 0 then
                                        if (root.Position - rootplr.Position).magnitude < range then
                                            if bool and v.Folder:FindFirstChild("Cuffed") then
                                                return v
                                            end
                                            if not v.Folder:FindFirstChild("Cuffed") then
                                                target = v
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    return target
                end
            end
        end
        local function getClosestPlayerWithTagPolice(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local rootplr = char:FindFirstChild("HumanoidRootPart")
            if not rootplr then
                return false
            end
            local closest, dist = nil, range
            for i,v in next, client.players do
                if v ~= player then
                    if tostring(v.Team) == "Police" and tostring(player.Team) ~= tostring(v.Team) then
                        local char = v.Character
                        if char then
                            local hum = char:FindFirstChild("Humanoid")
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if hum and root and hum.Health > 0 then
                                local magnitude = (root.Position - rootplr.Position).magnitude
                                if magnitude < range then
                                    closest = v
                                    dist = magnitude
                                end
                            end
                        end
                    end
                end
            end
            return closest
        end
        local function getClosestDroppedCash(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char.PrimaryPart
            if not root then
                return false
            end
            local cash = collectionservice:GetTagged("CashDrop")
            local closest, dist = nil, range
            for i,v in next, cash do
                if v and v.PrimaryPart then
                    local magnitude = (root.Position - v.PrimaryPart.Position).magnitude
                    if magnitude < range then
                        closest = v.PrimaryPart
                        dist = magnitude
                    end
                end
            end
            return closest
        end
        local function getBattleInvites()
            local invites = {}
            for i,v in next, player.CrewBattleInvitesFolder:GetChildren() do
                table.insert(invites, v.Name)
            end
            return invites
        end
        local function getBattleResponseRemote()
            return repl.BattleResponseRemote
        end
        local function getBattleReadyUpRemote()
            return repl.ReadyUpRemote
        end
        local function getClanId(self)
            return player:GetAttribute("CurrentClanId")
        end
        local function isClanAdmin()
            return player:GetAttribute("IsPlayerClanAdminCached")
        end
        local function getClanPlayersOnlineId(self)
            local getClanId = self:getClanId()
            if getClanId then
                local numClanPlayersOnline = repl:FindFirstChild("ClanPlayersOnline")
                if numClanPlayersOnline then
                    local key = numClanPlayersOnline:FindFirstChild(getClanId)
                    if key then
                        return key
                    end
                end
            end
        end
        local function isProjectile(item, settings)
            local settings = settings or {}
            local includeAdditionals = settings.includeAdditionals
            local projectiles = {"C4", "RocketLauncher", "SmokeGrenade", "Grenade", "C4Ammo", "RocketAmmo", includeAdditionals and "Flashlight" or nil, includeAdditionals and "Binoculars" or nil}
            if table.find(projectiles, item) then
                return true
            end
            return false
        end
        local function equipOwnedItem(item, unequip)
            global.hideshopui = true
            global.open_shop = true
            local shouldUnequip = unequip or false
            local gunshopgui = player.PlayerGui.GunShopGui
            local container = gunshopgui.Container.Container
            local mainContainer = container.Main.Container
            while true do
                if mainContainer:FindFirstChild("Slider") then
                    break
                end
                task.wait()
            end
            local resolveOwnedItems = client.reg.resolveOwnedItems
            if isProjectile(item) then
                local sidebar = container.Sidebar
                local projectile = sidebar:FindFirstChild("Projectile")
                if projectile then
                    if table.find(resolveOwnedItems, item) or item == "RocketAmmo" or item == "C4Ammo" then
                        set_thread_identity(2)
                        for _, connection in next, getconnections(projectile.MouseButton1Down) do
                            connection.Function()
                        end
                        set_thread_identity(7)
                        while true do
                            if mainContainer.Slider:FindFirstChild("C4") then
                                break
                            end
                            task.wait()
                        end
                        local slider = mainContainer:FindFirstChild("Slider")
                        if slider then
                            local item = slider:FindFirstChild(item)
                            if item then
                                local action = item.Bottom.Action
                                if action and (shouldUnequip and action.Text == "UNEQUIP") or not shouldUnequip and action and action.Text ~= "UNEQUIP" or item == "RocketAmmo" and action.Text == "$1,000" then
                                    for _, connection in next, getconnections(action.MouseButton1Down) do
                                        connection.Function()
                                    end
                                end
                            end
                        end
                    end
                end
                global.hideshopui = false
                global.open_shop = false
            else
                local slider = mainContainer:FindFirstChild("Slider")
                if slider then
                    if not table.find(resolveOwnedItems, "Pistol") then
                        local pistol = slider:FindFirstChild("Pistol")
                        if pistol then
                            local action = pistol.Bottom.Action
                            if action and action.Text == "FREE" then
                                for _, connection in next, getconnections(action.MouseButton1Down) do
                                    connection.Function()
                                end
                            end
                        end
                    end
                    if table.find(resolveOwnedItems, item) then
                        local weapon = slider:FindFirstChild(item)
                        if weapon then
                            local action = weapon.Bottom.Action
                            if action and (shouldUnequip and action.Text == "UNEQUIP") or not shouldUnequip and action and action.Text ~= "UNEQUIP" then
                                for _, connection in next, getconnections(action.MouseButton1Down) do
                                    connection.Function()
                                end
                            end
                        end
                    end
                end
                global.hideshopui = false
                global.open_shop = false
            end
        end
        local function getClanPlayersOnline(self)
            local getClanPlayersOnlineId = self:getClanPlayersOnlineId()
            if getClanPlayersOnlineId then
                return #getClanPlayersOnlineId:GetChildren()
            end
            return false
        end
        local function getNextShotPossible()
            return player:GetAttribute("NextShotPossibleTime") or os.time()
        end
        local function getClosestCasinoLoot(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                return false
            end
            local casino = workspace:FindFirstChild("Casino")
            if not casino then
                return false
            end
            for i,v in next, casino.Loots:GetChildren() do
                if (v.Position - root.Position).magnitude < range then
                    return v
                end
            end
            return false
        end
        local function getClosestComputer(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                return false
            end
            local casino = workspace:FindFirstChild("Casino")
            if not casino then
                return false
            end
            local closest, dist = nil, range
            for i,v in next, casino.Computers:GetDescendants() do
                if v.Name == "Computer" then
                    local display = v:FindFirstChild("Display")
                    if tostring(display.BrickColor) == "Really black" or tostring(display.BrickColor) == "Really red" then
                        local magnitude = (root.Position - display.Position).magnitude
                        if magnitude < range then
                            closest = v
                            dist = magnitude
                        end
                    end
                end
            end
            return closest
        end
        local function getClosestBankDoor(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                return false
            end
            local banks = workspace:FindFirstChild("Banks")
            if not banks then
                return false
            end
            for i,v in next, banks:GetDescendants() do
                if v:IsA("Part") and v.Name == "BankDoor" then
                    if (v.Position - root.Position).magnitude < range then
                        return v
                    end
                end
            end
        end
        local function getClosestTriggerDoor(range)
            local char = client.playerCharacter
            if not char then
                return false
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then
                return false
            end
            local banks = workspace:FindFirstChild("Banks")
            if not banks then
                return false
            end
            for i,v in next, banks:GetDescendants() do
                if v.Name == "TriggerDoor" then
                    if (v.Position - root.Position).magnitude < range then
                        return v
                    end
                end
            end
            return false
        end
        local function resolvePowerplant(flow)
            local function add1()
                for _=1, #flow.Grid do
                    local grid = flow.Grid[_]
                    for n=1, #grid do
                        local num = grid[n]
                        num += 1
                        grid[n] = num
                    end
                end
            end
            local function remove1()
                for _=1, #flow.Grid do
                    local grid = flow.Grid[_]
                    for n=1, #grid do
                        local num = grid[n]
                        num -= 1
                        grid[n] = num
                    end
                end
            end
            local function resolveRequest()
                return "-s-1-->>.s-xa4";
            end
            local function resolver()
                add1()
                local resolveRequest = resolveRequest()
                if not resolveRequest then
                    remove1()
                    return false
                end
                if not resolveRequest.Body then
                    remove1()
                    return false
                end
                pcall(function()
                    local body = httpservice:JSONDecode(resolveRequest.Body)
                    if body.status then
                        flow.Grid = body.resolved
                    end
                end)
                remove1()
                flow.OnConnection()
            end
            resolver()
            return true
        end
        local function resolveOwnedItems()
            local tbl = {}
            for i,v in next, player.Items:GetChildren() do
                table.insert(tbl, v.Name)
            end
            return tbl
        end
        local function resolveEquippedItems()
            local tbl = {}
            for i,v in next, player.Folder:GetChildren() do
                if v.Name ~= "SmokeGrenade" then
                    table.insert(tbl, v.Name)
                end
            end
            return tbl
        end
        local function isInMuseum()
            return getupvalue(global.registry.isInMuseumRobbery, 1)
        end
        local function callplane()
            for i,v in next, client.modules.ui.CircleAction.Specs do
                if v.Name == "Call Cargo Plane" then
                    v:Callback(true)
                end
            end
        end
        local function dieOfFalldamage()
            local char = player.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum then
                    hum.Health = 0
                end
            end
        end
        local function lighting_technology(val)
            pcall(function()
                val = tostring(val)
                global.ui_status.technology = val
                sethiddenproperty(lighting, "Technology", global.ui_status.technology)
            end)
        end
        local function getSpeedometer()
            return player.PlayerGui.AppUI:FindFirstChild("Speedometer") or nil
        end
        local function isUnderRoof(root)
            local ign
            if workspace:FindFirstChild("Rain") then
                ign = {root.Parent, client.descendants.vehicles, workspace.Rain}
            else
                ign = {root.Parent, client.descendants.vehicles}
            end
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Blacklist
            params.FilterDescendantsInstances = ign
            local ray = workspace:Raycast(root.Position, Vector3.new(0, 1, 0) * 100, params)
            if ray then
                return true
            end
            return false
        end
        local function findTarget(name)
            name = tostring(name)
            name = name:lower()
            for i,v in next, client.players do
                local displayName = v.DisplayName:lower()
                local _name = v.Name:lower()
                if displayName == name or _name == name or (_name):find(name) or (displayName):find(name) then
                    return v
                end
            end
            return false
        end
        global.registry.isUnderRoof = isUnderRoof
        global.registry.resolveKeycode = resolveKeycode
        global.registry.isProjectile = isProjectile
        global.registry.addWaypoint = addWaypoint
        global.registry.setWaypoint = setWaypoint
        global.registry.equipOwnedItem = equipOwnedItem
        global.registry.hasInVehicleTag = hasInVehicleTag
        global.registry.getSpeedometer = getSpeedometer
        global.registry.getClanId = getClanId
        global.registry.isClanAdmin = isClanAdmin
        global.registry.getBattleReadyUpRemote = getBattleReadyUpRemote
        global.registry.getClanPlayersOnlineId = getClanPlayersOnlineId
        global.registry.getClanPlayersOnline = getClanPlayersOnline
        global.registry.getNextShotPossible = getNextShotPossible
        global.registry.getBattleResponseRemote = getBattleResponseRemote
        global.registry.getBattleInvites = getBattleInvites
        global.registry.hasMansioninvite = hasMansioninvite
        global.registry.lighting_technology = lighting_technology
        global.registry.generateJobId = generateJobId
        global.registry.getLocalVehicle = getLocalVehicle
        global.registry.getClosestHeliPickup = getClosestHeliPickup
        global.registry.getPlayerVehicle = getPlayerVehicle
        global.registry.getCasinoDoor = getCasinoDoor
        global.registry.getClosestPlayer = getClosestPlayer
        global.registry.getClosestPlayerByFov = getClosestPlayerByFov
        global.registry.getClosestPlayerWithNoHandcuffs = getClosestPlayerWithNoHandcuffs
        global.registry.getClosestPlayerWithTagPolice = getClosestPlayerWithTagPolice
        global.registry.getClosestDroppedCash = getClosestDroppedCash
        global.registry.isVulnerable = isVulnerable
        global.registry.getClosestBankDoor = getClosestBankDoor
        global.registry.getClosestCasinoLoot = getClosestCasinoLoot
        global.registry.getClosestPlayerForBreakouts = getClosestPlayerForBreakouts
        global.registry.getClosestComputer = getClosestComputer
        global.registry.getAllClosePlayers = getAllClosePlayers
        global.registry.getClosestTriggerDoor = getClosestTriggerDoor
        global.registry.constructMarker = constructMarker
        global.registry.getPartsInRegion = getPartsInRegion
        global.registry.setColor = setColor
        global.registry.getPlayersWithBounty = getPlayersWithBounty
        global.registry.getClosestPlayerWithVehicleTag = getClosestPlayerWithVehicleTag
        global.registry.getInventoryItemsFor = getInventoryItemsFor
        global.registry.dropGun = dropGun
        global.registry.canUseTaser = canUseTaser
        global.registry.getSeats = getSeats
        global.registry.getClosestCrate = getClosestCrate
        global.registry.destructMarker = destructMarker
        global.registry.doesMarkerExist = doesMarkerExist
        global.registry.neverDropItems = neverDropItems
        global.registry.checkWallBeforePenetration = checkWallBeforePenetration
        global.registry.hasItemEquipped = hasItemEquipped
        global.registry.unequipAll = unequipAll
        global.registry.markerColors = markerColors
        global.registry.call_elevator_to_floor = call_elevator_to_floor
        global.registry.getEquippedItem = getEquippedItem
        global.registry.getKeycode = getKeycode
        global.registry.shootGun = shootGun
        global.registry.useTaser = useTaser
        global.registry.equip = equip
        global.registry.getHeliRope = getHeliRope
        global.registry.getClosestVulnerablePlayer = getClosestVulnerablePlayer
        global.registry.isInMuseum = isInMuseum
        global.registry.resolveOwnedItems = resolveOwnedItems
        global.registry.resolveEquippedItems = resolveEquippedItems
        global.registry.resolvePowerplant = resolvePowerplant
        global.registry.callplane = callplane
        global.registry.getRobberyStatus = getRobberyStatus
        global.registry.dieOfFalldamage = dieOfFalldamage
        global.registry.findTarget = findTarget
    end
    registry()
    local function client_reg()
        local function loop()
            if global.registry.getEquippedItem then
                client.reg.getEquippedItem = global.registry.getEquippedItem()
            end
            if global.registry.getLocalVehicle then
                client.reg.getLocalVehicle = global.registry.getLocalVehicle()
                if client.reg.getLocalVehicle then
                    client.state.isLocalInVehicle = true
                else
                    client.state.isLocalInVehicle = false
                end
            end
            if global.registry.resolveOwnedItems then
                client.reg.resolveOwnedItems = global.registry.resolveOwnedItems()
            end
            if global.registry.resolveEquippedItems then
                client.reg.resolveEquippedItems = global.registry.resolveEquippedItems()
            end
            if global.registry.getInventoryItemsFor then
                client.reg.getInventoryItemsFor = global.registry.getInventoryItemsFor(player)
            end
            if global.registry.getClosestVulnerablePlayer then
                client.reg.getClosestVulnerablePlayer = global.registry.getClosestVulnerablePlayer(global.ui_status.killaura_range or 50)
            end
            if global.registry.getClosestPlayerByFov then
                local getClosestPlayerByFov = global.registry.getClosestPlayerByFov
                local getClosestPlayer = global.registry.getClosestPlayer
                local getEquippedItem = client.reg.getEquippedItem
                if getEquippedItem then
                    if getEquippedItem.__ClassName == "Taser" then
                        if global.ui_status.master_switch_silentaim or global.ui_status.allow_tase_target then
                            local fov = global.ui_status.fov_silentaim or 0
                            client.reg.getClosestPlayerByFov = getClosestPlayer(85)
                        end
                    else
                        if global.ui_status.master_switch_silentaim then
                            local fov = global.ui_status.fov_silentaim or 0
                            client.reg.getClosestPlayerByFov = getClosestPlayerByFov(fov)
                        end
                    end
                end
                local getLocalVehicle = client.reg.getLocalVehicle
                if getLocalVehicle then
                    if tostring(getLocalVehicle.Make) == "Jet" then
                        if global.ui_status.master_switch_plane then
                            if global.ui_status.automatic_jet_heat_seek then
                                if not getEquippedItem then
                                    client.reg.getClosestPlayerByFov = getClosestPlayerByFov(2000, true)
                                end
                            end
                        end
                    end
                end
            end
        end
        createloop(0, loop)
        local function tagServiceForVehicles()
            local cache
            cache = client.tags.new("isLocalInVehicle", 0, false, function(val)
                if global.ui_status.spinbot then
                    local char = client.playerCharacter
                    if char then
                        local root = char.PrimaryPart
                        if root then
                            if val then
                                if root:FindFirstChild("IsLocalSpinning") then
                                    root.IsLocalSpinning.MaxTorque = Vector3.new()
                                end
                            else
                                if root:FindFirstChild("IsLocalSpinning") then
                                    root.IsLocalSpinning.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                                end
                            end
                        end
                    end
                end
            end)
            local function loop()
                local bool = client.state.isLocalInVehicle
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        tagServiceForVehicles()
    end
    client_reg()
    while true do
        if client.reg.resolveOwnedItems then
            break
        end
        task.wait()
    end
    local function removeSettings()
        local settings = player.PlayerGui.AppUI.DevPanel.Container.SETTINGS.SETTINGS
        local playerMarkers = settings:FindFirstChild("playerMarkers")
        if playerMarkers then
            playerMarkers.Visible = false
        end
    end
    removeSettings()
    local workspaceChildren = {}
    local function workspaceChildAdded(obj)
        table.insert(workspaceChildren, obj)
    end
    for i,v in next, workspace:GetChildren() do
        table.insert(workspaceChildren, v)
    end
    table.insert(client.onWorkspaceSpawnRun, {
        _fn = workspaceChildAdded
    })
    local function findEmptyFolder() -- @ n are sens folderu asta
        for i,v in next, workspaceChildren do
            if v:IsA("Folder") and v.Name == "Folder" and #v:GetChildren() ~= 0 then
                client.NonEmptyFolder = v
            end
        end
    end
    findEmptyFolder()
    local function onewayNoclip()
        local isUnderRoof = global.registry.isUnderRoof
        local function onPressed()
            if global.IS_IN_NOCLIP then
                return false
            end
            local char = client.playerCharacter
            if char then
                local hasInVehicleTag = global.registry.hasInVehicleTag
                if not hasInVehicleTag(char) then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        if not isUnderRoof(root) then
                            global.IS_IN_NOCLIP = true -- @activeaza anti falldmg automat si pune walkspeedul la 0
                            local velocity = root.Velocity
                            local oldCframe = root.CFrame
                            local lookVector = root.CFrame.LookVector
                            local currentCamera = workspace.CurrentCamera
                            local cameraType = currentCamera.CameraType
                            currentCamera.CameraType = "Scriptable"
                            root.Velocity = Vector3.new(0, 100000, 0)
                            root.CFrame = oldCframe + Vector3.new(0, 1000000, 0)
                            task.wait(0.5)
                            root.CFrame = root.CFrame + root.CFrame.LookVector * 5
                            root.Velocity = velocity
                            root.CFrame = oldCframe + lookVector * 10
                            currentCamera.CameraType = cameraType
                            task.wait(0.5)
                            global.IS_IN_NOCLIP = false
                        else
                            global.notify("There is something above your head", 5)
                        end
                    end
                end
            end
        end
        local lastPressed = tick()
        local function onInputBegan(key)
            if global.ui_status.one_way_noclip then
                if key.KeyCode.Name == global.ui_status.noclip_attempt_key then
                    if client.confirmation.confirmed.one_way_noclip then
                        if tick() - lastPressed > 0.7 and not global.IS_IN_NOCLIP then
                            onPressed()
                            lastPressed = tick()
                        end
                    end
                end
            end
        end
        uis.InputBegan:connect(onInputBegan)
    end
    onewayNoclip()
    local function forceTarget()
        global.aimbot = {
            junk = {};
            connections = {};
        }
        local warningBar = client.warningBar
        local isVulnerable = global.registry.isVulnerable
        local doesMarkerExist = global.registry.doesMarkerExist
        local constructMarker = global.registry.constructMarker
        local destructMarker = global.registry.destructMarker
        local setColor = global.registry.setColor
        local markerColors = global.registry.markerColors
        local statusRobberies = global.ui.statusRobberies
        local findTarget = global.registry.findTarget
        statusRobberies["FORCED_TARGET_NAME"] = ("Forcing target selection on: None")
        local function onTargetRespawned(target)
            if not isVulnerable(player.Team, target.Team) then
                if doesMarkerExist(target) then
                    destructMarker(target)
                end
                global.notify("Target is no longer vulnerable", 5)
                global.aimbot.force_target = nil
                global.aimbot.connections[target.UserId]:disconnect()
                global.aimbot.connections[target.UserId] = nil
                statusRobberies["FORCED_TARGET_NAME"] = ("Forcing target selection on: None")
                return false
            end
            task.spawn(function()
                local char = target:WaitForChild("Character")
                if char then
                    local root = char:WaitForChild("HumanoidRootPart")
                    if root then
                        player:RequestStreamAroundAsync(root.Position)
                    end
                end
            end)
            if global.ui_status.mark_forced_target then
                if not doesMarkerExist(target) then
                    constructMarker(target)
                    setColor(target, markerColors.Target)
                end
            end
            warningBar:setEnabled(true)
            warningBar:setText("Target has respawned")
            pcall(function()
                warningBar:play()
            end)
        end
        global.aimbot.junk.onTargetRespawned = onTargetRespawned
        local old_target
        local function setTarget(name)
            local target = findTarget(name)
            if target then
                if isVulnerable(player.Team, target.Team, {prisonerTarget = true}) then
                    task.spawn(function() -- @ hack
                        for i,v in next, global.aimbot.connections do
                            v:disconnect()
                            v = nil
                        end
                        global.aimbot.connections[target.UserId] = target.CharacterAdded:connect(function()
                            onTargetRespawned(target)
                        end)
                    end)
                    if global.ui_status.mark_forced_target then
                        if not doesMarkerExist(target) then
                            constructMarker(target)
                            setColor(target, markerColors.Target)
                        else
                            destructMarker(target)
                        end
                        if old_target ~= nil and doesMarkerExist(old_target) then
                            destructMarker(old_target)
                        end
                    end
                    global.aimbot.force_target = target
                    old_target = target
                    statusRobberies["FORCED_TARGET_NAME"] = ("Forcing target selection on: %s"):format(target.DisplayName)
                    return global.notify(("Target selection will now prioritze player %s"):format(target.DisplayName), 5)
                else
                    return global.notify("Target has to be a enemy", 5)
                end
            else
                return global.notify(("Couldn't find target with name `%s`"):format(name), 5)
            end
        end
        global.aimbot.setTarget = setTarget
        local function onCharacterAdded()
            local target = global.aimbot.force_target
            if target then
                if not isVulnerable(player.Team, target.Team) then
                    if doesMarkerExist(target) then
                        destructMarker(target)
                    end
                    global.aimbot.force_target = nil
                    global.aimbot.connections[target.UserId]:disconnect()
                    global.aimbot.connections[target.UserId] = nil
                    statusRobberies["FORCED_TARGET_NAME"] = ("Forcing target selection on: None")
                    global.notify(("Target %s is no longer vulnerable"):format(target.DisplayName), 5)
                    warningBar:setEnabled(true)
                    warningBar:setText("Target is no longer vulnerable")
                    warningBar:play()
                end
            end
        end
        player.CharacterAdded:connect(onCharacterAdded)
        local function onPlayerRemoving(target)
            if global.aimbot.force_target == target then
                global.aimbot.force_target = nil
                global.aimbot.connections[target.UserId]:disconnect()
                global.aimbot.connections[target.UserId] = nil
                statusRobberies["FORCED_TARGET_NAME"] = ("Forcing target selection on: None")
                global.notify(("Target %s has left the game"):format(target.DisplayName), 5)
                warningBar:setEnabled(true)
                warningBar:setText("Target left the game")
                warningBar:play()
            end
        end
        table.insert(client.run_on_player_disconnect, {
            _fn = onPlayerRemoving;
        })
    end
    forceTarget()
    local function Corrections()
        local function battleInvitesAccept()
            local battleInvitesFolder = player:FindFirstChild("CrewBattleInvitesFolder")
            if not battleInvitesFolder then
                log("LocalPlayer is in battle.. Automatic Accept is not available.")
                return false
            end
            local battleInvites
            local function tagService()
                battleInvites = client.tags.new("battleInvites", 0, false, function(val)
                    if val then
                        local getBattleInvites = global.registry.getBattleInvites()
                        if getBattleInvites and #getBattleInvites ~= 0 then
                            for i,v in next, getBattleInvites do
                                local getBattleResponseRemote = global.registry.getBattleResponseRemote()
                                getBattleResponseRemote:FireServer(v, true)
                            end
                        end
                    end
                end)
            end
            tagService()
            local function onBattleInvitesFolderChildAdded(obj)
                local bool = global.ui_status.auto_accept_battle
                if bool then
                    local getBattleResponseRemote = global.registry.getBattleResponseRemote()
                    getBattleResponseRemote:FireServer(obj.Name, true)
                end
            end
            player.CrewBattleInvitesFolder.ChildAdded:connect(onBattleInvitesFolderChildAdded)
            local function loop()
                local bool = global.ui_status.auto_accept_battle
                if battleInvites then
                    battleInvites.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        battleInvitesAccept()
        local function battleStart()
            local battleInvitesFolder = player:FindFirstChild("CrewBattleInvitesFolder")
            if not battleInvitesFolder then
                log("LocalPlayer is in battle.. Automatic Battle Start is not available.")
                return false
            end
            local battleStartObj
            local function tagService()
                battleStartObj = client.tags.new("battleStart", 0, false, function(val)
                    if val then
                        local getClanPlayersOnline = global.registry:getClanPlayersOnline()
                        if getClanPlayersOnline and getClanPlayersOnline >= 3 then
                            local isClanAdmin = global.registry.isClanAdmin()
                            if isClanAdmin then
                                local getBattleReadyUpRemote = global.registry.getBattleReadyUpRemote()
                                if getBattleReadyUpRemote then
                                    getBattleReadyUpRemote:FireServer()
                                end
                            end
                        end
                    end
                end)
            end
            tagService()
            local function onOnlineValueChanged(num)
                local bool = global.ui_status.auto_start_matchmaking
                if bool then
                    local getClanPlayersOnline = global.registry:getClanPlayersOnline()
                    if getClanPlayersOnline and getClanPlayersOnline >= 3 then
                        local isClanAdmin = global.registry.isClanAdmin()
                        if isClanAdmin then
                            local getBattleReadyUpRemote = global.registry.getBattleReadyUpRemote()
                            if getBattleReadyUpRemote then
                                getBattleReadyUpRemote:FireServer()
                            end
                        end
                    end
                end
            end
            local getClanPlayersOnlineId = global.registry:getClanPlayersOnlineId()
            if getClanPlayersOnlineId then
                getClanPlayersOnlineId.Changed:connect(onOnlineValueChanged)
            else
                log("Not in clan")
                local cache
                cache = createloop(1, function()
                    local getClanPlayersOnlineId = global.registry:getClanPlayersOnlineId()
                    if getClanPlayersOnlineId then
                        getClanPlayersOnlineId.Changed:connect(onOnlineValueChanged)
                        cache:disconnect()
                        cache = nil
                    end
                end)
            end
            local function loop()
                local bool = global.ui_status.auto_start_matchmaking
                if battleStartObj then
                    battleStartObj.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        battleStart()
        local function waypoints()
            local waypointsTbl = client.waypoints
            local list = {}
            for keyName, label in next, waypointsTbl do
                table.insert(list, label)
            end
            local function assignLocations()
                local config = global.config
                local cfg = config.place_waypoint
                cfg.list = list
                task.delay(0.2, function()
                    cfg.reload(cfg.list)
                end)
            end
            assignLocations()
        end
        waypoints()
        local function onWorkspaceSpawnRun()
            local function onSpawnRun(obj)
                for i,v in next, client.onWorkspaceSpawnRun do
                    v._fn(obj)
                end
            end
            workspace.ChildAdded:connect(onSpawnRun)
        end
        onWorkspaceSpawnRun()
        local function onWorkspaceRemovedRun()
            local function onRemovedRun(obj)
                for i,v in next, client.onWorkspaceRemovedRun do
                    v._fn(obj)
                end
            end
            workspace.ChildRemoved:connect(onRemovedRun)
        end
        onWorkspaceRemovedRun()
        local function playerStateCorrection()
            local function requestJump()
                local hum = client.playerCharacter and client.playerCharacter:FindFirstChild("Humanoid")
                if global.ui_status and global.ui_status.alwaysjump and hum then
                    hum:ChangeState("Jumping")
                end
            end
            uis.JumpRequest:connect(requestJump)
        end
        playerStateCorrection()
        local function fortnitedance()
            local is_dancing = false
            local party = client.modules.party.Init
            local model
            local function discoModel()
                local m = Instance.new("Model")
                m.Name = "samibagpulanunguri"
                m.Parent = workspace
                model = m
            end
            discoModel()
            local cache_switch
            local cache_speed
            local stopDancing = getupvalue(party,6)
            local startDancing = getupvalue(party,5)
            local function onCharacterAdded()
                if not is_dancing and global.ui_status.fortnite_mode then
                    startDancing(model)
                else
                    is_dancing = false
                end
            end 
            local function onCharacterRemoving()
                if is_dancing then
                    stopDancing()
                    is_dancing = false
                end
            end
            player.CharacterAdded:connect(onCharacterAdded)
            player.CharacterRemoving:connect(onCharacterRemoving)
            local function tagService()
                cache_switch = client.tags.new("fortnite", 0, false, function(val)
                    if val then
                        is_dancing = true
                        startDancing(model)
                    else
                        is_dancing = false
                        stopDancing()
                    end
                    if is_dancing and cache_speed.obj.Value then
                        local danceAnim = getupvalue(getupvalue(party, 4), 8)
                        danceAnim:AdjustSpeed(tonumber(cache_speed.obj.Value))
                    end
                end)
                cache_speed = client.tags.new("fortniteSpeed", 1, 0, function(val)
                    if not is_dancing then
                        return false
                    end
                    local danceAnim = getupvalue(getupvalue(party, 4), 8)
                    danceAnim:AdjustSpeed(tonumber(val))
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.fortnite_mode
                local speed = global.ui_status.fortnite_mode_speed
                if cache_switch then
                    cache_switch.obj.Value = bool
                    if bool then
                        cache_speed.obj.Value = speed or 1
                    end
                end
            end
            createloop(0, loop)
        end
        fortnitedance()
        local function duckCorrection()
            local function automatic()
                local function loop()
                    local bool = global.ui_status.always_duck
                    local buttons = global.registry.buttons
                    if bool and buttons then
                        pcall(function()
                            buttons.attemptToggleCrawling()
                        end)
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("alwaysduck", 0, false, function(val)
                        if val then
                            loopf = createloop(0.3, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            else
                                warn("no loopf")
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.always_duck
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            automatic()
            local loopf
            local cache
            local function loop()
                local bool = global.ui_status.infduck
                if bool then
                    local lastDuckTick = global.registry.lastDuckTick
                    table.clear(lastDuckTick)
                    table.insert(lastDuckTick, 1, 0)
                end
            end
            local function tagService()
                cache = client.tags.new("infiniteduck", 0, false, function(val)
                    if val then
                        loopf = createloop(0, loop)
                    else
                        if loopf then
                            loopf:disconnect()
                            loopf = nil
                        end
                    end
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.infduck
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        duckCorrection()
        local function ispointintagCorrection()
            local module = client.modules.tagUtils.isPointInTag
            local function hook(pos, str, ...)
                if global.IS_IN_NOCLIP then
                    return true
                end
                if string.find(debug.traceback(), "Falling") then
                    if str == "NoFallDamage" then
                        if global.ui_status.antifalldamage then
                            return true
                        end
                    end
                    if str == "NoRagdoll" then
                        if global.ui_status.antiragdoll then
                            return true
                        end
                    end
                end
                return module(pos, str, ...)
            end
            client.modules.tagUtils.isPointInTag = hook
        end
        ispointintagCorrection()
        local function humanoidCorrection()
            local function hideCharacter()
                local fakeCharacter = Instance.new("Model")
                local fakeHumanoid = Instance.new("Humanoid")
                local boolVal = Instance.new("BoolValue")
                fakeCharacter.Parent = workspace
                fakeCharacter.Name = "FakeCharacter"
                fakeHumanoid.Parent = fakeCharacter
                boolVal.Name = "isLocalFakeCharacter"
                boolVal.Parent = fakeCharacter
                local animator
                local isInProcess = false
                local firstTime = true
                local buttons = global.registry.buttons
                local function hide_character_function()
                    if isInProcess then
                        return false
                    end
                    local char = client.playerCharacter
                    if not char then
                        return false
                    end
                    local hum = char:FindFirstChild("Humanoid")
                    if not hum then
                        return false
                    end
                    isInProcess = true
                    player.Character = fakeCharacter
                    task.wait()
                    animator = hum.Animator
                    animator.Parent = nil
                    hum:Destroy()
                    task.wait()
                    player.Character = char
                    local newFakeHumanoid = Instance.new("Humanoid")
                    newFakeHumanoid.Parent = char
                    hum = char:FindFirstChild("Humanoid")
                    if not hum then
                        return false
                    end
                    animator.Parent = hum
                    animator = nil
                    char.Animate.Disabled = true
                    task.wait()
                    char.Animate.Disabled = false
                    task.wait()
                    isInProcess = false
                    if not char:FindFirstChild("Ball") then
                        buttons.attemptToggleCrawling()
                    end
                    if firstTime then
                        global.notify('Stay in crouch and your character should be "hidden" for others. If you jump they may see you!', 8)
                        firstTime = false
                    end
                end
                global.registry.hide_character_function = hide_character_function
            end
            hideCharacter()
            local function spinbot()
                local function doSpin(speed)
                    local char = client.playerCharacter
                    if char then
                        local root = char.PrimaryPart
                        if root then
                            if root:FindFirstChild("IsLocalSpinning") then
                                root.IsLocalSpinning:Destroy()
                            end
                            local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
                            bodyAngularVelocity.Name = "IsLocalSpinning"
                            bodyAngularVelocity.Parent = root
                            bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                            bodyAngularVelocity.AngularVelocity = Vector3.new(0, speed or 1, 0)
                        end
                    end
                end
                local function changeSpeed(newSpeed)
                    local char = client.playerCharacter
                    if char then
                        local root = char.PrimaryPart
                        if root then
                            if root:FindFirstChild("IsLocalSpinning") then
                                root.IsLocalSpinning.AngularVelocity = Vector3.new(0, newSpeed, 0)
                            end
                        end
                    end
                end
                local spin_cache, speed_cache
                local function onCharacterAdded()
                    if global.ui_status.spinbot then
                        local char = player.Character
                        if char then
                            local root = char:WaitForChild("HumanoidRootPart")
                            if root then
                                doSpin(speed_cache.obj.Value or 1)    
                            end
                        end
                    end
                end
                player.CharacterAdded:connect(onCharacterAdded)
                local loopf
                local function tagService()
                    spin_cache = client.tags.new("spinbot", 0, false, function(val)
                        if val then
                            doSpin(speed_cache.obj.Value or 1)
                        else
                            local char = client.playerCharacter
                            if char then
                                local root = char.PrimaryPart
                                if root then
                                    if root:FindFirstChild("IsLocalSpinning") then
                                        root.IsLocalSpinning:Destroy()
                                    end
                                end
                            end
                        end
                    end)
                    speed_cache = client.tags.new("spinbot_speed", 1, 1, function(val)
                        changeSpeed(val)
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.spinbot
                    local speed = global.ui_status.spinbot_speed
                    if spin_cache then
                        spin_cache.obj.Value = bool
                    end 
                    if speed_cache then
                        speed_cache.obj.Value = speed
                    end
                end
                createloop(0, loop)
            end
            spinbot()
            local function flight()
                
            end
            flight()
            local function keycardCorrection()
                local sys = client.modules.inventoryItemSystem
                local function hook()
                    local bool = global.ui_status.always_keycard
                    if tostring(player.Team) == "Police" then
                        return true
                    end
                    if sys.playerHasItem(player, "Key") then
                        return true
                    end
                    if bool then
                        return true
                    end
                    return false
                end
                client.modules.playerUtils.hasKey = hook
            end
            keycardCorrection()
            local function juicedCorrection()
                local charUtil = client.modules.characterUtil
                local l
                local function loop()
                    local bool = global.ui_status.always_juiced
                    charUtil.IsJuiced = bool
                end
                local cache
                local function tagService()
                    cache = client.tags.new("always_juiced", 0, false, function(val)
                        if not val then
                            if l then
                                l:disconnect()
                                l = nil
                            end
                        else
                            l = createloop(0, loop)
                        end
                    end)
                end
                tagService()
                local function loop()
                    local always_juiced = global.ui_status.always_juiced
                    if cache then
                        cache.obj.Value = always_juiced
                    end
                end
                createloop(0, loop)
            end
            juicedCorrection()
            local function rollMechanics()
                local actionButtonService = client.modules.actionButtonService
                local roll = client.modules.roll
                local function onInfRoll(num)
                    for i,v in next, actionButtonService.active do
                        if table.find(v.keyCodes, Enum.KeyCode.LeftControl) then
                            v.useEvery = num
                            break
                        end
                    end
                end
                local function rollDuration(num)
                    if num == 0 then
                        num = 0.3
                    end
                    --83
                    setconstant(roll.attemptRoll, 84, tonumber(num))
                end
                local breakAnimt = tick()
                local function breakAnimations()
                    if tick() - breakAnimt > 0.2 then
                        local char = player.Character
                        if char then
                            local primaryPart = char.PrimaryPart
                            if primaryPart then
                                roll.attemptRoll()
                                breakAnimt = tick()
                            end
                        end
                    end
                end
                local cache = {}
                local is_always_roll
                local function tagService()
                    cache.infroll = client.tags.new("infinite_roll", 0, false, function(val)
                        if val then
                            onInfRoll(0)
                        else
                            onInfRoll(5)
                        end
                    end)
                    cache.roll_duration = client.tags.new("roll_duration", 1, 3, function(val)
                        if val then
                            rollDuration(val/10)
                        end
                    end)
                    cache.always_roll = client.tags.new("always_roll", 0, false, function(val)
                        if val then
                            is_always_roll = createloop(0, breakAnimations)
                        else
                            if is_always_roll then
                                is_always_roll:disconnect()
                                is_always_roll = nil
                            end
                        end
                    end)
                    cache.break_physics = client.tags.new("break_physics", 0, false, function(val)
                        if val then
                            setconstant(roll.attemptRoll, 72, "None")
                        else
                            setconstant(roll.attemptRoll, 72, "Physics")
                        end
                    end)
                    cache.frozen_roll = client.tags.new("frozen_roll", 0, false, function(val)
                        if val then
                            setconstant(roll.attemptRoll, 45, 0)
                        else
                            setconstant(roll.attemptRoll, 45, 500)
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.infinite_roll
                    if cache.infroll then
                        cache.infroll.obj.Value = bool
                    end
                    local roll_duration = global.ui_status.roll_duration
                    if cache.roll_duration then
                        cache.roll_duration.obj.Value = roll_duration
                    end
                    local always_roll = global.ui_status.always_roll
                    if cache.always_roll then
                        cache.always_roll.obj.Value = always_roll
                    end
                    local break_physics = global.ui_status.break_physics
                    if cache.break_physics then
                        cache.break_physics.obj.Value = break_physics
                    end
                    local frozen_roll = global.ui_status.frozen_roll
                    if cache.frozen_roll then
                        cache.frozen_roll.obj.Value = frozen_roll
                    end
                end
                createloop(0, loop)
            end
            rollMechanics()
            local function equipAfterDeath()
                local connection
                local cache
                local loopf
                local weaponName
                local equip = global.registry.equip
                local unequipAll = global.registry.unequipAll
                local equipOwnedItem = global.registry.equipOwnedItem
                local function onDied()
                    if not cache.obj.Value then
                        connection:disconnect()
                        connection = nil
                        return false
                    end
                    local gun = client.reg.getEquippedItem
                    if gun then
                        weaponName = gun.__ClassName
                        unequipAll()
                    end
                end
                local function onCharacterAdded(char)
                    if weaponName then
                        global._weaponName = weaponName
                        while true do
                            if not global.is_instant_reloading and not global.is_registering_item then
                                break
                            end
                            task.wait()
                        end
                        task.delay(1, function()
                            while true do
                                if table.find(client.reg.resolveEquippedItems, weaponName) then
                                    break
                                end
                                equipOwnedItem(weaponName)
                                task.wait(0.2)
                            end
                            while true do
                                if client.reg.getEquippedItem then
                                    break
                                end
                                equip(weaponName)
                                task.wait(0.2)
                            end
                            weaponName = nil
                            connection:disconnect()
                            connection = nil
                        end)
                    end
                end
                player.CharacterAdded:connect(onCharacterAdded)
                local function loop()
                    if connection then
                        if not global.CONNECTED_TO:IsDescendantOf(workspace) then
                            connection:disconnect()
                            connection = nil
                        end
                    end
                    if not connection then
                        local char = client.playerCharacter
                        if char then
                            local hum = char:FindFirstChild("Humanoid")
                            if hum then
                                global.CONNECTED_TO = char
                                connection = hum.Died:connect(onDied)
                            end
                        end
                    end
                end
                local function tagService()
                    cache = client.tags.new("automatic_equip_after_death", 0, false, function(val)
                        if val then
                            loopf = createloop(0, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                            if connection then
                                connection:disconnect()
                                connection = nil
                                weaponName = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_equip_after_death
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            equipAfterDeath()
            local function loop()
                local char = client.playerCharacter
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then
                        if global.IS_IN_NOCLIP then
                            hum.WalkSpeed = 0
                            return true
                        end
                        if client.confirmation.confirmed.ws then
                            if global.ui_status.master_switch_walkspeed then
                                hum.WalkSpeed = global.ui_status.walkspeed or 16
                            else
                                hum.WalkSpeed = hum.WalkSpeed
                            end
                        end
                        if client.confirmation.confirmed.jp then
                            if global.ui_status.master_switch_jumppower then
                                if global.ui_status.jp_disable_if_handcuffed and player.Folder:FindFirstChild("Cuffed") then
                                    hum.JumpPower = 50
                                    return true
                                end
                                hum.JumpPower = global.ui_status.jumppower or 50
                            else
                                hum.JumpPower = 50
                            end
                        end
                    end
                end
            end
            createloop(0, loop)
        end
        humanoidCorrection()
        local function confirmation()
            local ws = {
                msg = "WalkSpeed may be detected. Use at your own risk?";
                confirmationLoaded = false;
            };
            local jp = {
                msg = "JumpPower may be detected. Use at your own risk?";
                confirmationLoaded = false;
            }
            local one_way_noclip = {
                msg = "1 Way Noclip may be detected. Use at your own risk?";
                confirmationLoaded = false;
            }
            local function loop()
                if global.ui_status.master_switch_walkspeed then
                    if not client.confirmation.confirmed.ws and not ws.confirmationLoaded then
                        ws.confirmationLoaded = true
                        local new = client.confirmation.new(ws.msg)
                        client.confirmation.onYes(new, function()
                            new = nil
                            client.confirmation.confirmed.ws = true
                        end)
                        client.confirmation.onNo(new, function()
                            new = nil
                            client.confirmation.confirmed.ws = false
                        end)
                    end
                end
                if global.ui_status.master_switch_jumppower then
                    if not client.confirmation.confirmed.jp and not jp.confirmationLoaded then
                        jp.confirmationLoaded = true
                        local new = client.confirmation.new(jp.msg)
                        client.confirmation.onYes(new, function()
                            new = nil
                            client.confirmation.confirmed.jp = true
                        end)
                        client.confirmation.onNo(new, function()
                            new = nil
                            client.confirmation.confirmed.jp = false
                        end)
                    end
                end
                if global.ui_status.one_way_noclip then
                    if not client.confirmation.confirmed.one_way_noclip and not one_way_noclip.confirmationLoaded then
                        one_way_noclip.confirmationLoaded = true
                        local new = client.confirmation.new(one_way_noclip.msg)
                        client.confirmation.onYes(new, function()
                            new = nil
                            client.confirmation.confirmed.one_way_noclip = true
                        end)
                        client.confirmation.onNo(new, function()
                            new = nil
                            client.confirmation.confirmed.one_way_noclip = false
                        end)
                    end
                end
            end
            createloop(0, loop)
        end
        confirmation()
        local function smokeGrenadeCorrection()
            local smoke = client.modules.smoke
            local smokeGrenade = client.modules.smokeGrenade
            local function playExplosionFxCorrection()
                local _playExplosionFx = smoke._playExplosionFx
                local function hook(...)
                    local bool = global.ui_status.disable_smoke_grenade_effect
                    if bool then
                        return task.wait(9e9)
                    end
                    return _playExplosionFx(...)
                end
                client.modules.smoke._playExplosionFx = hook
            end
            playExplosionFxCorrection()
            local shootBegin = smokeGrenade.ShootBegin
            local function hook(...)
                return global.ui_status.anti_smoke_throw_limit and 0 or shootBegin(...)
            end
            setupvalue(shootBegin, 1, hook)
        end
        smokeGrenadeCorrection()
        local function waterPartsCorrection()
            local function instance()
                local function makePart()
                    local part = Instance.new("Part")
                    part.Name = "JESUS"
                    part.Parent = workspace
                    part.Anchored = true
                    part.Transparency = 1
                    part.Size = Vector3.new(200, 3, 200)
                end
                makePart()
                local function loop()
                    local bool = global.ui_status.jesus
                    if bool then
                        if not workspace:FindFirstChild("JESUS") then
                            makePart()
                        end
                    else
                        if workspace:FindFirstChild("JESUS") then
                            workspace.JESUS.Position = Vector3.new(0, -5, 0)
                        end
                    end
                end
                createloop(0, loop)
            end
            instance()
            local function isInWater()
                local char = client.playerCharacter
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local params = RaycastParams.new()
                        local ray = workspace:Raycast(root.Position, Vector3.new(0, -5, 0) + root.CFrame.LookVector * 5, params)
                        if ray then
                            if ray.Material == Enum.Material.Water then
                                return ray
                            end
                            if ray.Instance.Name == "JESUS" then
                                return ray
                            end
                        end
                    end
                end
                return false
            end
            local function isPartInWater(part)
                if not part then
                    return false
                end
                local params = RaycastParams.new()
                local ray = workspace:Raycast(part.Position, Vector3.new(0, -5, 0) + part.CFrame.LookVector * 5, params)
                if ray then
                    if ray.Material == Enum.Material.Water then
                        return ray
                    end
                end
                return false
            end
            local hasInVehicleTag = global.registry.hasInVehicleTag
            local function loop()
                if not client.playerCharacter then
                    return false
                end
                local inst = workspace:FindFirstChild("JESUS")
                if inst then
                    local char = client.playerCharacter
                    if char then
                        local jesusPart
                        if hasInVehicleTag(char) then
                            local regVehicle = client.reg.getLocalVehicle
                            if regVehicle and regVehicle.Model:FindFirstChild("Engine") then
                                jesusPart = regVehicle.Model.Engine
                            end
                        else
                            jesusPart = char:FindFirstChild("HumanoidRootPart")
                        end
                        if jesusPart then
                            local isPartInWater = isPartInWater(jesusPart)
                            if isPartInWater then
                                inst.Position = isPartInWater.Position - Vector3.new(0, 3, 0)
                                inst.Anchored = true
                                inst.Transparency = 1
                                inst.Size = Vector3.new(200, 4, 200)
                            end
                        end
                    end
                end
            end
            local cache
            local loopf
            local function tagService()
                cache = client.tags.new("jesus", 0, false, function(val)
                    if val then
                        loopf = createloop(0, loop)
                    else
                        if loopf then
                            loopf:disconnect()
                            loopf = nil
                        end
                    end
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.jesus
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        waterPartsCorrection()
        local function circleActions()
            local cache
            local function tagService()
                cache = client.tags.new("no_circle_delay", 0, false, function(val)
                    local specs = client.modules.ui.CircleAction.Specs
                    for i,v in next, specs do
                        if v and v.Name ~= "Rob" and v.Name ~= "Hack" and v.Name ~= "Open Crate" and v.Name ~= "Break In" then
                            if v.Duration then
                                if not v.oldVal then
                                    v.oldVal = v.Duration
                                    if val then
                                        v.Duration = 0
                                    end
                                else
                                    v.Duration = val and 0 or v.oldVal
                                end
                            end
                        end
                    end
                end)
            end
            tagService()
            local module_ui = client.modules.ui.CircleAction
            local localization = client.modules.localization
            local add = module_ui.Add
            local remove = module_ui.Remove
            local function hook(v, ...)
                if v and v.Name and v.Name ~= "Rob" and v.Name ~= "Hack" and v.Name ~= "Open Crate" and v.Name ~= "Break In" then
                    if v.Duration then
                        v.oldVal = v.Duration
                        if global.ui_status.master_switch_no_circle_delay then
                            v.Duration = 0
                        else
                            v.Duration = v.oldVal
                        end
                    end
                end
                return add(v, ...)
            end
            module_ui.Add = hook
            for i,v in next, module_ui.Specs do
                if v and v.Name and v.Duration and v.Name and v.Name ~= "Rob" and v.Name ~= "Hack" and v.Name ~= "Open Crate" and v.Name ~= "Break In" and not v.oldVal then
                    v.oldVal = v.Duration
                    if global.ui_status.master_switch_no_circle_delay then
                        v.Duration = 0
                    else
                        v.Duration = v.oldVal
                    end
                end
            end
            local function arrestCircleUpdate()
                for i,v in next, getconnections(runservice.Heartbeat) do
                    local func = v.Function
                    if func and type(func) == "function" and not is_synapse_function(func) then
                        local con = getconstants(func)
                        if table.find(con, "tick", 1) and table.find(con, "Value", 3) then
                            local f = getupvalue(func, 1)
                            local old = getupvalue(f, 4)
                            setupvalue(f, 4, function(action)
                                local bool = global.ui_status.master_switch_no_circle_delay
                                local o = old(action)
                                if bool then
                                    action.Duration = 0
                                end
                                return o
                            end)
                        end
                        if table.find(con, "Thread Loop", 7) then
                            local t = getupvalue(func, 2)
                            for i2,v2 in next, t do
                                if v2.i == 1 and type(v2.c) == "function" then
                                    v2.t = 0
                                    v2.i = math.huge
                                    v2.c = function()
                                        return task.wait(9e9)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            arrestCircleUpdate()
            local function loop()
                local bool = global.ui_status.master_switch_no_circle_delay
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        circleActions()
        local function punchCorrection()
            local function automatic()
                local lastPunch = tick()
                local function loop()
                    local bool = global.ui_status.automatic_punch
                    if not bool then
                        return false
                    end
                    local buttons = global.registry.buttons
                    if not buttons then
                        return false
                    end
                    local punchFreq = getconstant(buttons.attemptPunch, 3)
                    if tick() - lastPunch < punchFreq then
                        return false
                    end
                    buttons.attemptPunch()
                end
                createloop(0, loop)
            end
            automatic()
            local function loop()
                local bool = global.ui_status.infpunch
                local buttons = global.registry.buttons
                if buttons then
                    local c = bool and 0 or 0.5
                    setconstant(buttons.attemptPunch, 3, c)
                end
            end
            createloop(0, loop)
        end
        punchCorrection()
        local function gliderCorrection()
            local function onKey()
                local function onInputBegan(key)
                    if global.ui_status.glider_on_key then
                        if key.KeyCode.Name == global.ui_status.glider_key then
                            if client.modules.paraglide.IsFlying() then
                                client.modules.paraglide.GliderStop()
                            else
                                client.modules.paraglide.Glider()
                            end
                        end
                    end
                end
                uis.InputBegan:connect(onInputBegan)
            end
            onKey()
        end
        gliderCorrection()
        local function parachuteCorrection()
            local function onKey()
                local function onInputBegan(key)
                    if global.ui_status.parachute_on_key then
                        if key.KeyCode.Name == global.ui_status.parachute_key then
                            if client.modules.paraglide.IsFlying() then
                                client.modules.paraglide.ParachuteStop()
                            else
                                client.modules.paraglide.Parachute()
                            end
                        end
                    end
                end
                uis.InputBegan:connect(onInputBegan)
            end
            onKey()
            local parachute = client.modules.paraglide.Parachute
            local upv = getupvalue(getupvalue(parachute,1),6)
            local const5 = getconstant(upv,5)
            local const23 = getconstant(upv,23)
            local const26 = getconstant(upv,26)
            local const29 = getconstant(upv,29)
            local const31 = getconstant(upv,31)
            local function hook_parachute()
                local bool = global.ui_status.antiparachute
                if bool then
                    return task.wait(9e9)
                end
                return parachute()
            end
            client.modules.paraglide.Parachute = hook_parachute
            local function antizones()
                local upv3 = getupvalue(upv, 3)
                local function hook(...)
                    local bool = global.ui_status.disable_automatic_unparachute
                    if bool then
                        return false
                    end
                    return upv3(...)
                end
                setupvalue(upv, 3, hook)
            end
            antizones()
        end
        parachuteCorrection()
        local function skydivingCorrection()
            local getSkydiveTrack = client.modules.characterAnim.getSkydiveTrack
            local function hook()
                local bool = global.ui_status.antiskydive
                if bool then
                    return task.wait(9e9)
                end 
                return getSkydiveTrack()
            end
            client.modules.characterAnim.getSkydiveTrack = hook
            local upv = getupvalue(client.modules.fallingInit, 19)
            local function loop()
                local bool = global.ui_status.antiskydive
                if bool then
                    if getupvalue(upv, 14) ~= false then
                        setupvalue(upv, 14, false)
                    end
                end
            end
            createloop(0, loop)
        end
        skydivingCorrection()
        local function gunStoreCorrection()
            local region = client.modules.region.Update
            local vals = {
                Condition = nil;
            }
            local function hook(tbl, ...)
                if not string.find(debug.traceback(), "GunShopSystem") then
                    return region(tbl, ...)
                end
                if global.hideshopui or global.is_instant_reloading then
                    player.PlayerGui.GunShopGui.Enabled = false
                    player.PlayerGui.GunShopGui.Container.Visible = false
                else
                    player.PlayerGui.GunShopGui.Container.Visible = true
                end
                local bool = global.ui_status.open_gunstore_ui
                local open_shop = global.open_shop
                local is_instant_reloading = global.is_instant_reloading
                local function condition_hook(...)
                    if is_instant_reloading then
                        player.PlayerGui.GunShopGui.Container.Close.Visible = not is_instant_reloading
                        return is_instant_reloading
                    end
                    if bool then
                        player.PlayerGui.GunShopGui.Container.Close.Visible = not bool
                        return bool
                    end
                    if open_shop then
                        player.PlayerGui.GunShopGui.Container.Close.Visible = not open_shop
                        return open_shop
                    end
                    return vals.Condition ~= nil and vals.Condition(...)
                end
                if not vals.Condition then
                    vals.Condition = tbl.Condition
                end
                tbl.Condition = condition_hook
                return region(tbl, ...)
            end
            client.modules.region.Update = hook
        end
        gunStoreCorrection()
        local function stunnedCorrection()
            local function respawnOnTazed()
                local module = client.modules.falling.StartRagdolling
                local function fireTeamSwitch()
                    local teamSwitch = player.PlayerGui.AppUI.Buttons.Sidebar.TeamSwitch.TeamSwitch
                    if not teamSwitch then
                        log("ERROR occured while trying to respawn (TeamSwitch)")
                        return false
                    end
                    for i,v in next, getconnections(teamSwitch.MouseButton1Down) do
                        v.Function()
                        break
                    end
                end
                local function pressYes()
                    local confirm = player.PlayerGui.ConfirmationGui.Confirmation.Background.ContainerButtons.ContainerYes
                    if not confirm then
                        log("ERROR occured while trying to respawn (yes pressing)")
                        return false
                    end
                    for i,v in next, getconnections(confirm.Button.MouseButton1Down) do
                        v.Function()
                        break
                    end
                end
                local function goPrisoner()
                    local prisonerButton = player.PlayerGui.TeamGui.Container.ContainerTeam:FindFirstChild("Prisoner")
                    if not prisonerButton then
                        log("ERROR occured while trying to respawn (prisoner)")
                        return false
                    end
                    for i,v in next, getconnections(prisonerButton.MouseButton1Down) do
                        v.Function()
                        break
                    end
                end
                local function goPolice()
                    local policeButton = player.PlayerGui.TeamGui.Container.ContainerTeam:FindFirstChild("Police")
                    if not policeButton then
                        log("ERROR occured while trying to respawn (police)")
                        return false
                    end
                    for i,v in next, getconnections(policeButton.MouseButton1Down) do
                        v.Function()
                        break
                    end
                end
                local function goPlay()
                    local playgui = player.PlayerGui.TeamGui.Container.ContainerPlay.Play
                    if not playgui then
                        log("ERROR occured while trying to respawn (play pressing)")
                        return false
                    end
                    for i,v in next, getconnections(playgui.MouseButton1Down) do
                        v.Function()
                        break
                    end
                end
                local equip = global.registry.equip
                local function hook(num)
                    if string.find(debug.traceback(), "OnClientEvent") then
                        local __className
                        if client.reg.getEquippedItem then
                            __className = client.reg.getEquippedItem.__ClassName
                        end
                        local notaze = global.ui_status.antitaze
                        if notaze then
                            setupvalue(global.registry.stunnedFunc,1,false)
                            num = -1
                            if __className then
                                task.delay(0.1, function()
                                    equip(__className)
                                end)
                            end
                        end
                        local team = tostring(player.Team)
                        local bool = global.ui_status.automatic_respawn_on_taze
                        if bool then
                            task.delay(0.1, fireTeamSwitch)
                            task.delay(0.3, pressYes)
                            if team == "Prisoner" or team == "Criminal" then
                                task.delay(0.5, goPrisoner)
                            elseif team == "Police" then
                                task.delay(0.5, goPolice)
                            end
                            task.delay(0.7, goPlay)
                        end
                    end
                    return module(num)
                end
                client.modules.falling.StartRagdolling = hook
            end
            respawnOnTazed()
            local function removeTazeRagdoll()
                local stunned = client.modules.settings.Time.Stunned
                local function loop()
                    local bool = global.ui_status.antitaze
                    if bool then
                        client.modules.settings.Time.Stunned = 0
                    else
                        client.modules.settings.Time.Stunned = stunned
                    end
                end
                createloop(0, loop)
            end
            removeTazeRagdoll()
        end
        stunnedCorrection()
        local function jetpackCorrection()
            local function fuel()
                local init = getupvalue(client.modules.jetpack.Init, 9)
                local cache
                local function tagService()
                    cache = client.tags.new("fuel", 0, false, function(val)
                        if val then
                            init.LocalFuelType = "Rocket"
                            init.LocalMaxFuel = math.huge
                            init.LocalFuel = math.huge
                        else
                            init.LocalFuelType = "Standard"
                            init.LocalMaxFuel = 10
                            init.LocalFuel = 2.5
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.infinite_jetpack_fuel
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            fuel()
        end
        jetpackCorrection()
        local function sprintCorrection()
            local module = client.modules.defaultActions
            local function isSprinting()
                return module.sprintButton._pressed
            end
            local function pressSprint()
                if not isSprinting() and module.sprintButton._pressState then
                    module.sprintButton._pressState()
                end
            end
            local function loop()
                local bool = global.ui_status.alwayssprint
                if bool then
                    pressSprint()
                end
            end
            createloop(0, loop)
        end
        sprintCorrection()
        local function vehicleCorrection()
            local function force_bodycolor()

            end
            force_bodycolor()
            local function jump()
                local function onInputBegan(key)
                    if global.ui_status.vehicle_jump then
                        if client.state.isLocalInVehicle then
                            if key.KeyCode.Name == global.ui_status.vehicle_jump_key then
                                local char = client.playerCharacter
                                if char then
                                    local hum = char:FindFirstChild("Humanoid")
                                    if hum then
                                        hum:ChangeState("Jumping")
                                    end
                                end
                            end
                        end
                    end
                end
                uis.InputBegan:connect(onInputBegan)
            end
            jump()
            local function noTrailer()
                local cache
                local currentTrailer
                local currentVehicle
                local function tagService()
                    cache = client.tags.new("noTrailer", 0, false, function(val)
                        local vehicle = client.reg.getLocalVehicle
                        if val then
                            if vehicle and tostring(vehicle.Make) == "Semi" then
                                if vehicle and vehicle.Model.Preset:FindFirstChild("Trailer") then
                                    global.USER_INPUT_TYPE_SWITCH = true
                                    currentTrailer = vehicle.Model.Preset.Trailer
                                    currentVehicle = vehicle
                                    vehicle.Model.Preset.Trailer.Parent = nil
                                end
                            end
                        else
                            if currentTrailer and currentVehicle then
                                global.USER_INPUT_TYPE_SWITCH = false
                                currentTrailer.Parent = currentVehicle.Model.Preset
                                currentTrailer:SetPrimaryPartCFrame(currentVehicle.Model.PrimaryPart.CFrame)
                                currentTrailer = nil
                                currentVehicle = nil
                            end
                        end
                    end)
                end
                tagService()
                local function onVehicleEntered(obj)
                    if obj.Name == "InVehicle" then
                        if global.ui_status.no_trailer then
                            local vehicle
                            while true do
                                if vehicle then
                                    break
                                end
                                vehicle = client.reg.getLocalVehicle
                                task.wait()
                            end
                            if vehicle and tostring(vehicle.Make) == "Semi" then
                                local trailer = vehicle.Model.Preset:FindFirstChild("Trailer")
                                if trailer then
                                    global.USER_INPUT_TYPE_SWITCH = true
                                    currentTrailer = vehicle.Model.Preset.Trailer
                                    currentVehicle = vehicle
                                    vehicle.Model.Preset.Trailer.Parent = nil
                                end
                            end
                        end
                    end
                end
                local function onVehicleExit(obj)
                    if obj.Name == "InVehicle" then
                        if global.ui_status.no_trailer then
                            if currentTrailer and currentVehicle then
                                global.USER_INPUT_TYPE_SWITCH = false
                                currentTrailer.Parent = currentVehicle.Model.Preset
                                currentTrailer:SetPrimaryPartCFrame(currentVehicle.Model.PrimaryPart.CFrame)
                                currentTrailer = nil
                                currentVehicle = nil
                            end
                        end
                    end
                end
                local function onCharacterAdded()
                    player.Character.ChildAdded:connect(onVehicleEntered)
                    player.Character.ChildRemoved:connect(onVehicleExit)
                end
                onCharacterAdded()
                player.CharacterAdded:connect(onCharacterAdded)
                local onJumpPressed = client.modules.defaultActions.onJumpPressed._handlerListHead._fn
                local function onJumpPressedHook(...)
                    if global.ui_status.no_trailer then
                        if currentTrailer and currentVehicle then
                            global.USER_INPUT_TYPE_SWITCH = false
                            currentTrailer.Parent = currentVehicle.Model.Preset
                            currentTrailer:SetPrimaryPartCFrame(currentVehicle.Model.PrimaryPart.CFrame)
                            currentTrailer = nil
                            currentVehicle = nil
                        end
                        task.wait(0.2)
                    end
                    return onJumpPressed(...)
                end
                client.modules.defaultActions.onJumpPressed._handlerListHead._fn = onJumpPressedHook
                local onVehicleExited = client.modules.vehicle.OnVehicleExited._handlerListHead._fn
                local function onVehicleExitedHook(...)
                    if global.ui_status.no_trailer then
                        if currentTrailer and currentVehicle then
                            global.USER_INPUT_TYPE_SWITCH = false
                            currentTrailer.Parent = currentVehicle.Model.Preset
                            currentTrailer:SetPrimaryPartCFrame(currentVehicle.Model.PrimaryPart.CFrame)
                            currentTrailer = nil
                            currentVehicle = nil
                        end
                        task.wait(0.2)
                    end
                    return onVehicleExited(...)
                end
                client.modules.vehicle.OnVehicleExited._handlerListHead._fn = onVehicleExitedHook
                local function loop()
                    local bool = global.ui_status.no_trailer
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            noTrailer()
            local function headlights()
                local function headlights()
                    for i,v in next, client.modules.actionButtonService.active do
                        if type(v) == "table" and v.keyCodes then
                            if table.find(v.keyCodes, Enum.KeyCode.L) then
                                v.onPressed(true)
                            end
                        end
                    end
                end
                local function loop()
                    local master_switch_carmodify = global.ui_status.master_switch_carmodify
                    if master_switch_carmodify then
                        local bool = global.ui_status.spam_headlights
                        if bool then
                            local getLocalVehicle = client.reg.getLocalVehicle
                            if getLocalVehicle and getLocalVehicle.Type ~= "Heli" then
                                headlights()
                            end
                        end
                    end
                end
                createloop(0.2, loop)
            end
            headlights()
            local function lock()
                local function getVehicle()
                    local getLocalVehicle = client.reg.getLocalVehicle
                    if getLocalVehicle then
                        return getLocalVehicle
                    end
                    return false
                end
                local function getLocked()
                    local getVehicle = getVehicle()
                    if getVehicle then
                        return getVehicle.Model:GetAttribute("Locked")
                    end
                    return false
                end
                local function canLock()
                    return client.modules.vehicle.canLocalLock()
                end
                local function callLock()
                    return client.modules.vehicle.toggleLocalLocked()
                end
                local function loop()
                    local bool = global.ui_status.automatic_lock_vehicle
                    if bool then
                        local getVehicle = getVehicle()
                        if getVehicle then
                            local getLocked = getLocked()
                            if not getLocked then
                                local canLock = canLock()
                                if canLock then
                                    callLock()
                                end
                            end
                        end
                    end
                end
                createloop(1, loop)
            end
            lock()
            local function eject()
                local vehicle = client.modules.vehicle
                local function getVehicle()
                    local getLocalVehicle = client.reg.getLocalVehicle
                    return getLocalVehicle
                end
                local function canEject()
                    return vehicle.canLocalEject()
                end
                local function ejectPlayer(player)
                    if canEject() then
                        vehicle.attemptPassengerEject(player.Name)
                    end
                end
                local getSeats = global.registry.getSeats
                local function loop()
                    local bool = global.ui_status.automatic_eject_vehicle_player
                    if bool then
                        local canEject = canEject()
                        if canEject then
                            local getSeats = getSeats()
                            if getSeats then
                                for i,v in next, getSeats do
                                    ejectPlayer(v.Player)
                                end
                            end
                        end
                    end
                end
                createloop(1, loop)
            end
            eject()
            local function jeeproof()
                local function roof()
                    for i,v in next, client.modules.actionButtonService.active do
                        if type(v) == "table" and v.keyCodes then
                            if table.find(v.keyCodes, Enum.KeyCode.G) then
                                v.onPressed(true)
                            end
                        end
                    end
                end
                local function loop()
                    local master_switch_carmodify = global.ui_status.master_switch_carmodify
                    if master_switch_carmodify then
                        local bool = global.ui_status.spam_jeep_roof
                        if bool then
                            local getLocalVehicle = client.reg.getLocalVehicle
                            if getLocalVehicle and tostring(getLocalVehicle.Make) == "Jeep" then
                                roof()
                            end
                        end
                    end
                end
                createloop(0.1, loop)
            end
            jeeproof()
            local function drifts()
                local function drift()
                    for i,v in next, client.modules.actionButtonService.active do
                        if type(v) == "table" and v.keyCodes then
                            if table.find(v.keyCodes, Enum.KeyCode.LeftShift) then
                                v.onPressed(true)
                            end
                        end
                    end
                end
                local function loop()
                    local master_switch_carmodify = global.ui_status.master_switch_carmodify
                    if master_switch_carmodify then
                        local bool = global.ui_status.always_drift
                        if bool then
                            local getLocalVehicle = client.reg.getLocalVehicle
                            if getLocalVehicle then
                                drift()
                            end
                        end
                    end
                end
                createloop(0, loop)
            end
            drifts()
            local function hijack()
                local function hijack()
                    local localization = client.modules.localization
                    for i,v in next, client.modules.ui.CircleAction.Specs do
                        if v.Name == localization:FormatByKey("Action.Hijack") then
                            if v.Enabled then
                                v:Callback(true)
                            end
                        end
                    end
                end
                local function loop()
                    local bool = global.ui_status.automatic_hijack_vehicles
                    if bool then
                        hijack()
                    end
                end
                createloop(0.5, loop)
            end
            hijack()
            local function automaticflip()
                local function flip()
                    for i,v in next, client.modules.actionButtonService.active do
                        if type(v) == "table" and v.keyCodes then
                            if table.find(v.keyCodes, Enum.KeyCode.V) then
                                v.onPressed(true)
                            end
                        end
                    end
                end
                local function loop()
                    local master_switch_carmodify = global.ui_status.master_switch_carmodify
                    if master_switch_carmodify then
                        local bool = global.ui_status.automatic_flip_vehicle
                        if bool then
                            local getLocalVehicle = client.reg.getLocalVehicle
                            if getLocalVehicle then
                                flip()    
                            end
                        end
                    end
                end
                createloop(0.5, loop)
            end
            automaticflip()
            local function breakVehicles()
                global._oldItem = nil
                local itemName
                local function onCharacterAdded()
                    if global._oldItem then
                        global._oldItem = nil
                        itemName = nil
                    end
                end
                player.CharacterAdded:connect(onCharacterAdded)
                local function registerEquippedItem()
                    local equip = global.registry.equip
                    local unequipAll = global.registry.unequipAll
                    local equip_only = {"Rifle", "Pistol", "Shotgun", "Revolver", "Flintlock", "AK47", "Uzi", "Sniper"}
                    local function loop()
                        if global._oldItem then
                            return false
                        end
                        if #client.reg.resolveEquippedItems == 0 then
                            return false
                        end
                        local bool = global.ui_status.break_vehicles
                        local instant_break = global.ui_status.instant_break
                        local getEquippedItem = client.reg.getEquippedItem
                        local unequipAfter = false
                        if bool and not global._oldItem and not global.is_registering_item then
                            global.is_registering_item = true
                            local getEquippedItem = client.reg.getEquippedItem
                            if not getEquippedItem then
                                unequipAfter = true
                                for i,v in next, client.reg.resolveEquippedItems do
                                    if table.find(equip_only, v) then
                                        equip(v)
                                        while true do
                                            if getEquippedItem then
                                                break
                                            end
                                            getEquippedItem = client.reg.getEquippedItem
                                            task.wait()
                                        end
                                        break
                                    end
                                end
                            end
                            if global._oldItem then
                                return false
                            end
                            if getEquippedItem and table.find(equip_only, getEquippedItem.__ClassName) then
                                local className = getEquippedItem.__ClassName
                                if className then
                                    global._oldItem = getEquippedItem.BulletEmitter.OnHitSurface._handlerListHead._signal._handlerListHead._fn
                                    className = getEquippedItem.__ClassName
                                    itemName = className
                                    unequipAll()
                                    if instant_break then
                                        getEquippedItem.__ClassName = "Sniper"
                                        itemName = "Sniper"
                                    else
                                        getEquippedItem.__ClassName = className
                                        itemName = className
                                    end
                                end
                            end
                            task.delay(1, function()
                                if global._weaponName then
                                    while true do
                                        if client.reg.getEquippedItem then
                                            break
                                        end
                                        equip(global._weaponName)
                                        task.wait()
                                    end
                                    global._weaponName = nil
                                end
                            end)
                            global.is_registering_item = false
                        end
                    end
                    loop()
                    createloop(0.6, loop)
                end
                registerEquippedItem()
                local function popTire(v)
                    if global.ui_status.instant_break and itemName ~= "Sniper" then
                        global._oldItem = nil
                    elseif not global.ui_status.instant_break and itemName == "Sniper" then
                        if not table.find(client.reg.resolveOwnedItems, "Sniper") then
                            global._oldItem = nil
                        end
                    end
                    if not global._oldItem then
                        return false
                    end
                    local getPlayerVehicle = global.registry.getPlayerVehicle(v)
                    if getPlayerVehicle then
                        local engine = getPlayerVehicle:FindFirstChild("Engine") or getPlayerVehicle:FindFirstChild("BoundingBox")
                        if engine then
                            for i=1, 9 do
                                local break_vehicles = global.ui_status.break_vehicles
                                if not break_vehicles then
                                    break
                                end
                                pcall(function()
                                    global._oldItem(engine, engine.Position, Vector3.new(), Enum.Material.SmoothPlastic)
                                end)
                                task.wait()
                            end
                        end
                    end
                end
                local function loop()
                    local bool = global.ui_status.break_vehicles 
                    if not bool then
                        return false
                    end
                    if global._oldItem then
                        local only_on_weapon_equipped = global.ui_status.only_on_weapon_equipped
                        if only_on_weapon_equipped then
                            local getEquippedItem = client.reg.getEquippedItem
                            if not getEquippedItem then
                                return false
                            end
                        end 
                        local getClosestPlayerWithVehicleTag = global.registry.getClosestPlayerWithVehicleTag(1280)
                        if not getClosestPlayerWithVehicleTag then
                            return false
                        end
                        local isVulnerable = global.registry.isVulnerable
                        local target_enemy_team_only = global.ui_status.target_enemy_team_only  
                        for i,v in next, getClosestPlayerWithVehicleTag do
                            if target_enemy_team_only then
                                if isVulnerable(player.Team, v.Team) then
                                    popTire(v)
                                end
                            else
                                popTire(v)
                            end
                        end
                    end
                end
                createloop(1, loop)
            end
            breakVehicles()
            local function destroyDestructibles()
                local function destructAll(getLocalVehicle)
                    local folder = client.NonEmptyFolder:GetChildren()
                    for i,v in next, folder do
                        for i2,v2 in next, v:GetDescendants() do
                            if v2:FindFirstChild("TouchInterest") and v2:isA("Part") then
                                firetouchinterest(v2, getLocalVehicle.Model.Engine, 0)
                                firetouchinterest(v2, getLocalVehicle.Model.Engine, 1)
                            end
                        end
                    end
                end
                local delayLoopTick = tick()
                local function loop()
                    local bool = global.ui_status.destroy_all_destructibles
                    if bool then
                        local destruct_delay = global.ui_status.destruct_delay or 0
                        if tick() - delayLoopTick > destruct_delay then
                            local getLocalVehicle = client.reg.getLocalVehicle
                            if getLocalVehicle then
                                destructAll(getLocalVehicle)
                                delayLoopTick = tick()
                            end
                        end
                    end
                end
                createloop(0, loop)
            end
            destroyDestructibles()
            local function pitAura()
                local function loop()
                    if tostring(player.Team) ~= "Police" then
                        return false
                    end
                    local bool = global.ui_status.pit_aura
                    if bool then
                        local range = global.ui_status.pit_aura_range
                        local getLocalVehicle = client.reg.getLocalVehicle
                        if getLocalVehicle then
                            local bumperCollide = getLocalVehicle.Model:FindFirstChild("BumperCollide")
                            if bumperCollide then
                                local getClosestPlayer = global.registry.getClosestPlayer(range)
                                if getClosestPlayer then
                                    local getPlayerVehicle = global.registry.getPlayerVehicle(getClosestPlayer)
                                    if getPlayerVehicle then
                                        firetouchinterest(getPlayerVehicle.BoundingBox, bumperCollide, 0)
                                        firetouchinterest(getPlayerVehicle.BoundingBox, bumperCollide, 1)
                                    end
                                end
                            end
                        end
                    end
                end
                createloop(2, loop)
            end
            pitAura()
            local function heliModify()
                local function rope()
                    local module = client.modules.loadingBar.new
                    local geomUtils = client.modules.geomUtils
                    local function hook(...)
                        if string.find(debug.traceback(), "_hookNearest") then
                            local master_switch = global.ui_status.master_switch_heli_speed
                            if master_switch then
                                local bool = global.ui_status.instant_rope
                                if bool and not global.ui_status.rope_aura then
                                    if not global.ui_status.kill_all_in_vehicle then
                                        local getLocalVehicle = client.reg.getLocalVehicle
                                        if getLocalVehicle then
                                            local getHeliRope = global.registry.getHeliRope(getLocalVehicle)
                                            if getHeliRope then
                                                local getClosestHeliPickup = global.registry.getClosestHeliPickup(getHeliRope, 50)
                                                if getClosestHeliPickup then
                                                    local cf = getClosestHeliPickup.PrimaryPart.CFrame:PointToObjectSpace(geomUtils.closestPointInPart(getClosestHeliPickup.PrimaryPart, getHeliRope.Position))
                                                    getHeliRope.ReqLink:FireServer(getClosestHeliPickup, cf)
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        return module(...)
                    end
                    client.modules.loadingBar.new = hook
                    local function setRopeLength(getLocalVehicle, num)
                        local model = getLocalVehicle.Model
                        if model then
                            local winch = model:FindFirstChild("Winch")
                            if winch then
                                local ropeConstraint = winch:FindFirstChild("RopeConstraint")
                                if ropeConstraint then
                                    ropeConstraint.Length = num
                                end
                            end
                        end
                    end
                    local function teleportPlayer()
                        local module = client.modules.vehicle
                        local heli = module.Classes.Heli
                        local getPlayerVehicle = global.registry.getPlayerVehicle
                        local getHeliRope = global.registry.getHeliRope
                        local isUnderRoof = global.registry.isUnderRoof
                        local function setHeliY500(getLocalVehicle)
                            local model = getLocalVehicle.Model
                            if model then
                                model.PrimaryPart.CFrame = model.PrimaryPart.CFrame * CFrame.new(0, 500, 0)
                                task.wait(0.5)
                            end
                        end
                        local function getRopePull(getLocalVehicle)
                            return getHeliRope(getLocalVehicle)
                        end
                        local function getRopeConstraint(getLocalVehicle)
                            local model = getLocalVehicle.Model
                            if model then
                                local winch = model:FindFirstChild("Winch")
                                if winch then
                                    local ropeConstraint = winch:FindFirstChild("RopeConstraint")
                                    if ropeConstraint then
                                        return ropeConstraint
                                    end
                                end
                            end
                            return false
                        end
                        local function dropRope()
                            return heli.attemptDropRope()
                        end
                        local function fireReqLink(getLocalVehicle, vehicle)
                            local getRopePull = getRopePull(getLocalVehicle)
                            if getRopePull then
                                getRopePull.ReqLink:FireServer(vehicle, Vector3.new())
                            end
                        end
                        local findTarget = global.registry.findTarget
                        global.teleports = {}
                        local location = "None"
                        local statusRobberies = global.ui.statusRobberies
                        statusRobberies["SELECTED_LOCATION"] = ("Current teleport location: %s"):format(location)
                        local tp_locations = {
                            Bossroom = Vector3.new(3154, -204, -4538);
                            Casino = Vector3.new(237, -77, -4498);
                            Diamonds = Vector3.new(973, -86, -203);
                            Lava = Vector3.new(1333, -106, -1057);
                            Powerplant = Vector3.new(118, -11, 2109);
                            Bank = Vector3.new(113, 18, 925);
                            Jewelry = Vector3.new(116, 18, 1297);
                            Museum = Vector3.new(1133, 107, 1306);
                            Computer = Vector3.new(-84, 69, -4626);
                        }
                        local function setLocation(key)
                            assert(tp_locations[key], "Location invalid")
                            location = key
                            statusRobberies["SELECTED_LOCATION"] = ("Current teleport location: %s"):format(location)
                        end
                        global.teleports.setLocation = setLocation
                        local function getLocation()
                            if location == "None" then
                                return false
                            end
                            return tp_locations[location] or false
                        end
                        global.teleports.getLocation = getLocation
                        local is_teleporting = false
                        local is_killing_all = false
                        task.spawn(function()
                            for i,v in next, client.players do
                                local char = v.Character
                                if char then
                                    local root = char.PrimaryPart
                                    if root then
                                        player:RequestStreamAroundAsync(root.Position)
                                    end
                                end
                            end
                        end)
                        local function teleport_player(name, shouldKillall)
                            if is_teleporting then
                                return false
                            end
                            local location = shouldKillall and tp_locations["Lava"] or getLocation()
                            if not location then
                                global.notify("Select a location!", 5)
                                return false
                            end
                            is_teleporting = true
                            local getLocalVehicle = client.reg.getLocalVehicle
                            if not getLocalVehicle or getLocalVehicle and getLocalVehicle.Type ~= "Heli" then
                                is_teleporting = false
                                return global.notify("You have to be in a helicopter", 5)
                            end
                            if getLocalVehicle.Passenger then
                                is_teleporting = false
                                return false
                            end
                            local char = client.playerCharacter
                            if char then
                                local root = char.PrimaryPart
                                if root then
                                    if isUnderRoof(root) then
                                        is_teleporting = false
                                        return global.notify("You have something over you. Get to a open location!", 5)
                                    end
                                    local target = findTarget(name)
                                    if target then
                                        local character = target.Character
                                        if not character or character and not character:FindFirstChild("InVehicle") then
                                            is_teleporting = false
                                            return global.notify("Target has to be in a vehicle!", 5)
                                        end
                                        local primaryPart = character.PrimaryPart
                                        if primaryPart then
                                            local targetVehicle = getPlayerVehicle(target)
                                            if targetVehicle then
                                                if targetVehicle.Name == "BankTruck" then
                                                    is_teleporting = false
                                                    return global.notify(("%s is in Bank Truck. Failed!"):format(target.Name), 5)
                                                end
                                                if getLocalVehicle.Model.PrimaryPart.Position.y < 500 then
                                                    setHeliY500(getLocalVehicle)
                                                end    
                                                local preset = getLocalVehicle.Model.Preset
                                                local winch = getLocalVehicle.Model.Winch
                                                local rope = {
                                                    pull = preset:FindFirstChild("RopePull");
                                                    constraint = winch:FindFirstChild("RopeConstraint");
                                                }
                                                if not rope.pull then
                                                    heli.attemptDropRope()
                                                    local tg = tick()
                                                    while true do
                                                        if preset:FindFirstChild("RopePull") then
                                                            break
                                                        end
                                                        if tick() - tg > 3 then
                                                            is_teleporting = false
                                                            break
                                                        end
                                                        task.wait()
                                                    end
                                                    if not is_teleporting then
                                                        global.notify("Failed x3", 5)
                                                        return false
                                                    end
                                                    preset = getLocalVehicle.Model.Preset
                                                    winch = getLocalVehicle.Model.Winch
                                                    rope.pull = preset.RopePull
                                                    rope.constraint = winch.RopeConstraint
                                                end
                                                rope.pull.CanCollide = false
                                                rope.constraint.WinchEnabled = true
                                                local reqLink = rope.pull:FindFirstChild("ReqLink")
                                                if reqLink then
                                                    local hb, clock = nil, tick()
                                                    hb = runservice.Heartbeat:connect(function()
                                                        if tick() - clock > 2 then
                                                            is_teleporting = false
                                                            hb:disconnect()
                                                            hb = nil
                                                            return false
                                                        end
                                                        if not rope.pull or not rope.pull:IsDescendantOf(workspace) then
                                                            is_teleporting = false
                                                            hb:disconnect()
                                                            hb = nil
                                                            return false
                                                        end
                                                        if not root then
                                                            is_teleporting = false
                                                            hb:disconnect()
                                                            hb = nil
                                                            return false
                                                        end
                                                        if rope.pull:FindFirstChild("AttachedTo") and rope.pull.AttachedTo.Value then
                                                            hb:disconnect()
                                                            hb = nil
                                                            return false
                                                        end
                                                        rope.pull.CFrame = targetVehicle.PrimaryPart.CFrame
                                                        reqLink:FireServer(targetVehicle, Vector3.new())
                                                    end)
                                                    while true do
                                                        if not hb then
                                                            break
                                                        end
                                                        task.wait()
                                                    end
                                                    if not is_teleporting then
                                                        global.notify("Failed!", 5)
                                                        return false
                                                    else
                                                        local localWeld = root:FindFirstChild("Weld")
                                                        if localWeld then
                                                            localWeld.Part1 = targetVehicle.Seat
                                                        end
                                                        hb, clock = nil, tick()
                                                        hb = runservice.Heartbeat:connect(function()
                                                            if tick() - clock > 2 then
                                                                is_teleporting = false
                                                                hb:disconnect()
                                                                hb = nil
                                                                return false
                                                            end
                                                            if not client.reg.getLocalVehicle then
                                                                is_teleporting = false
                                                                hb:disconnect()
                                                                hb = nil
                                                                return false
                                                            end
                                                            if not rope.pull then
                                                                is_teleporting = false
                                                                hb:disconnect()
                                                                hb = nil
                                                                return false
                                                            end
                                                            if not rope.pull:FindFirstChild("AttachedTo") or not rope.pull.AttachedTo.Value then
                                                                hb:disconnect()
                                                                hb = nil
                                                                return false
                                                            end
                                                            if not character:FindFirstChild("InVehicle") then
                                                                hb:disconnect()
                                                                hb = nil
                                                                return false
                                                            end
                                                            character:PivotTo(CFrame.new(location))
                                                        end)
                                                        while true do
                                                            if not hb then
                                                                break
                                                            end
                                                            task.wait()
                                                        end
                                                        if not is_teleporting then
                                                            global.notify("Failed x2!", 5)
                                                            return false
                                                        end
                                                        if localWeld then
                                                            localWeld.Part1 = getLocalVehicle.Seat
                                                        end
                                                        if rope.pull and rope.pull:FindFirstChild("AttachedTo") and rope.pull.AttachedTo.Value then
                                                            heli.attemptDropRope()
                                                            while true do
                                                                if not rope.pull:IsDescendantOf(workspace) then
                                                                    break
                                                                end
                                                                task.wait()
                                                            end
                                                        end
                                                        if not shouldKillall then
                                                            if localWeld then -- doar sa fie sigur :)
                                                                localWeld.Part1 = getLocalVehicle.Seat
                                                            end
                                                            global.notify("Done.", 5)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        is_teleporting = false
                                        return global.notify(("Couldn't find target with name `%s`"):format(name), 5)
                                    end
                                end
                            end
                            is_teleporting = false
                        end
                        global.teleports.teleport_player = teleport_player
                        local function loop()
                            if is_killing_all then
                                return false
                            end
                            if client.reg.getLocalVehicle and client.reg.getLocalVehicle.Type == "Heli" then
                                is_killing_all = true
                                local kill_all_vehicle_ignore_teammates = global.ui_status.kill_all_vehicle_ignore_teammates
                                for i,v in next, client.players do
                                    if not global.ui_status.kill_all_in_vehicle then
                                        break
                                    end
                                    if kill_all_vehicle_ignore_teammates then
                                        if tostring(v.Team) == tostring(player.Team) then
                                            continue
                                        end
                                    end
                                    local char = v.Character
                                    if char then
                                        if char:FindFirstChild("InVehicle") then
                                            teleport_player(v.Name, true)
                                        end
                                    end
                                    task.wait(0.15)
                                end
                                is_killing_all = false
                            end
                        end
                        local tagCache
                        local loopf
                        local function tagService()
                            tagCache = client.tags.new("kill_all_in_vehicle", 0, false, function(val)
                                if val then
                                    local vehicle = client.reg.getLocalVehicle
                                    if not vehicle or vehicle and vehicle.Type ~= "Heli" then
                                        global.notify("You have to be in a helicopter", 5)
                                    end
                                    loopf = createloop(0, loop)
                                else
                                    if loopf then
                                        loopf:disconnect()
                                        loopf = nil
                                    end
                                end
                            end)
                        end
                        tagService()
                        local function loop()
                            local bool = global.ui_status.kill_all_in_vehicle
                            if tagCache then
                                tagCache.obj.Value = bool
                            end
                        end
                        createloop(0, loop)
                    end
                    teleportPlayer()
                    local function loop()
                        local master_switch = global.ui_status.master_switch_heli_speed
                        if master_switch then
                            local bool = global.ui_status.rope_aura
                            local getLocalVehicle = client.reg.getLocalVehicle
                            if getLocalVehicle then
                                if bool and global.ui_status.instant_rope and not global.ui_status.kill_all_in_vehicle then
                                    local getHeliRope = global.registry.getHeliRope(getLocalVehicle)
                                    if getHeliRope and getHeliRope.AttachedTo.Value == nil then
                                        local getClosestHeliPickup = global.registry.getClosestHeliPickup(getHeliRope, 150)
                                        if getClosestHeliPickup then
                                            local cf = getClosestHeliPickup.PrimaryPart.CFrame:PointToObjectSpace(geomUtils.closestPointInPart(getClosestHeliPickup.PrimaryPart, getHeliRope.Position))
                                            getHeliRope.ReqLink:FireServer(getClosestHeliPickup, cf)
                                        end
                                    end
                                end
                                local rope_length = global.ui_status.rope_length or 50
                                setRopeLength(getLocalVehicle, rope_length)
                            end
                        end
                    end
                    createloop(0.2, loop)
                end
                rope()
                local function speed()
                    local function loop()
                        local bool = global.ui_status.master_switch_heli_speed
                        local speed = global.ui_status.heli_speed
                        if not bool then
                            return false
                        end
                        if not client.state.isLocalInVehicle then
                            return false
                        end
                        local vehicle = client.reg.getLocalVehicle
                        if not vehicle then
                            return false
                        end
                        if vehicle.Type == "Heli" then
                            if not vehicle.Velocity then
                                return false
                            end
                            if not vehicle.Velocity.Velocity then
                                return false
                            end
                            local calc = vehicle.Velocity.Velocity * speed
                            vehicle.Velocity.Velocity = calc
                        end
                    end
                    createloop(0, loop)
                end
                speed()
                local function height()
                    local function loop()
                        local bool = global.ui_status.infinite_heli_height
                        if not client.state.isLocalInVehicle then
                            return false
                        end
                        local vehicle = client.reg.getLocalVehicle
                        if not vehicle then
                            return false
                        end
                        if not bool then
                            if vehicle.Type == "Heli" then
                                vehicle.MaxHeight = 400
                            end
                            return false
                        end
                        if vehicle.Type == "Heli" then
                            vehicle.MaxHeight = math.huge
                        end
                    end
                    createloop(0, loop)
                end
                height()
                local function droneHeight() 
                    local module = client.modules.rayCast.RayIgnoreNonCollideWithIgnoreList
                    local function hook(...)
                        if string.find(debug.traceback(), "Heli") then
                            local bool = global.ui_status.infinite_drone_height
                            local args = {...}
                            if bool then
                                for i,v in next, args[4] do
                                    if v == client.descendants.vehicles then
                                        return Vector3.new(0, math.huge, 0), ...
                                    end
                                end
                            end
                        end
                        return module(...)
                    end
                    table.insert(client.rayHooks, {
                        fn = hook
                    })
                end
                droneHeight()
            end
            heliModify()
            local function bikeModify()
                local bikes = {}
                local volts = {}
                local chassis2 = client.modules.alexChassis2
                local vehicleBikeEnter = chassis2.VehicleEnter
                local vehicleBikeLeave = chassis2.VehicleLeave
                local volt = client.modules.volt
                local vehicleEnter = volt.VehicleEnter
                local vehicleLeave = volt.VehicleLeave
                local function onVoltVehicleEnter(...)
                    if #volts > 0 then
                        table.clear(volts)
                    end
                    local onVehicleEnteredTick = tick()
                    volts[#volts + 1] = createloop(0, function()
                        local vehicle = client.reg.getLocalVehicle
                        if vehicle then
                            local master_switch_bike = global.ui_status.master_switch_bike
                            if master_switch_bike then
                                local bike_speed = global.ui_status.bike_speed or 1
                                vehicle.Force.Force = vehicle.Force.Force * tonumber(bike_speed)
                            end
                        else
                            if tick() - onVehicleEnteredTick > 5 then
                                volts[#volts]:disconnect()
                                table.clear(volts)
                            end
                        end
                    end)
                    return vehicleEnter(...)
                end 
                local function onVoltVehicleLeave(...)
                    if #volts > 0 then
                        volts[#volts]:disconnect()
                        table.clear(volts)
                    end
                    return vehicleLeave(...)
                end
                volt.VehicleEnter = onVoltVehicleEnter
                volt.VehicleLeave = onVoltVehicleLeave
                local function onBikeVehicleEnter(bike)
                    if tostring(bike.Make) == "Dirtbike" then
                        if #bikes > 0 then
                            bikes[#bikes]:disconnect()
                            table.clear(bikes)
                        end
                        global.BIKE_MEMORY = {
                            WHEELS_HEIGHT = bike.Wheels[1].Height;
                        }
                        bikes[#bikes + 1] = createloop(0, function()
                            local BIKE_MEMORY = global.BIKE_MEMORY
                            local master_switch_bike = global.ui_status.master_switch_bike
                            local dirt_bike_height = global.ui_status.dirt_bike_height
                            if master_switch_bike then
                                local bike_speed = global.ui_status.bike_speed or 1
                                bike.GarageEngineSpeed = 1 * tonumber(bike_speed) * 10
                            else
                                bike.GarageEngineSpeed = 0
                                if dirt_bike_height then
                                    if bike.Wheels[1].Height ~= BIKE_MEMORY.WHEELS_HEIGHT then
                                        for i,v in next, bike.Wheels do
                                            v.Height = BIKE_MEMORY.WHEELS_HEIGHT
                                        end
                                    end
                                end
                            end
                            if dirt_bike_height then
                                if master_switch_bike then
                                    local bike_height_value = global.ui_status.bike_height_value
                                    for i,v in next, bike.Wheels do
                                        v.Height = BIKE_MEMORY.WHEELS_HEIGHT * tonumber(bike_height_value)
                                    end
                                end
                            else
                                if bike.Wheels[1].Height ~= BIKE_MEMORY.WHEELS_HEIGHT then
                                    for i,v in next, bike.Wheels do
                                        v.Height = BIKE_MEMORY.WHEELS_HEIGHT
                                    end
                                end
                            end
                        end)
                    end
                    return vehicleBikeEnter(bike)
                end
                local function onBikeVehicleLeave(bike)
                    if tostring(bike.Make) == "Dirtbike" then
                        if #bikes > 0 then
                            bikes[#bikes]:disconnect()
                            table.clear(bikes)
                        end
                    end
                    return vehicleBikeLeave(bike)
                end
                chassis2.VehicleEnter = onBikeVehicleEnter
                chassis2.VehicleLeave = onBikeVehicleLeave
            end
            bikeModify()
            local function boatModify()
                local boat = client.modules.boat
                local mountPlayer = boat.MountPlayer
                local unmountSeat = boat.UnmountSeat
                local destroy = boat.Destroy
                local boats = {}
                local function onBoatMountPlayer(x, y, ...)
                    if y == player and not boats[x.Meta.Id] then
                        global.BOAT_MEMORY = {
                            SPEED_FORWARD = x.Config.SpeedForward;
                        }
                        boats[x.Meta.Id] = {
                            LIFE = createloop(0, function()
                                local master_switch_boat = global.ui_status.master_switch_boat
                                local boat_speed = global.ui_status.boat_speed or 1
                                local boat_on_land = global.ui_status.boat_on_land
                                local BOAT_MEMORY = global.BOAT_MEMORY
                                if master_switch_boat then
                                    if boat_on_land then
                                        x.WaterHeight = 20
                                    end
                                    x.Config.SpeedForward = BOAT_MEMORY.SPEED_FORWARD * tonumber(boat_speed)
                                else
                                    x.Config.SpeedForward = BOAT_MEMORY.SPEED_FORWARD
                                end
                            end);
                        }
                    end
                    return mountPlayer(x, y, ...)
                end
                local function onBoatUnmountSeat(x, y)
                    if boats[x.Meta.Id] and y.Player == player then
                        global.BOAT_MEMORY = nil
                        boats[x.Meta.Id].LIFE:disconnect()
                        table.clear(boats)
                    end
                    return unmountSeat(x, y)
                end
                local function onBoatDestroy(x)
                    if boats[x.Meta.Id] then
                        global.BOAT_MEMORY = nil
                        boats[x.Meta.Id]:disconnect()
                        table.clear(boats)
                    end
                    return destroy(x)
                end
                boat.MountPlayer = onBoatMountPlayer
                boat.UnmountSeat = unmountSeat
                boat.Destroy = onBoatDestroy
            end
            boatModify()
            local function planeModify()
                local plane = {}
                local function jet()
                    local jet = client.modules.jet
                    local jetMountPlayer = jet.MountPlayer
                    local jetUnmountSeat = jet.UnmountSeat
                    local jetDestroy = jet.Destroy
                    local seekingMissileUtils = client.modules.seekingMissileUtils
                    local setTargetPos = seekingMissileUtils.setTargetPos
                    local function onSetTargetPos(obj, x)
                        if #plane > 0 then
                            local getClosestPlayer = client.reg.getClosestPlayerByFov
                            if getClosestPlayer then
                                local char = getClosestPlayer.Character
                                if char then
                                    local primaryPart = char.PrimaryPart
                                    if primaryPart then
                                        x = primaryPart.Position
                                    end
                                end
                            end
                        end
                        return setTargetPos(obj, x)
                    end
                    local function onJetMountPlayer(x, y, ...)
                        if y == player and not plane[x.Plane.Id] then
                            global.PLANE_MEMORY = {
                                HEIGHT_MAX = x.Plane.CONST.HEIGHT_MAX;
                                MAX_THRUST = x.Plane.CONST.MAX_THRUST;
                            }
                            plane[x.Plane.Id] = {
                                LIFE = createloop(0, function()
                                    local master_switch_plane = global.ui_status.master_switch_plane
                                    local plane_speed = global.ui_status.plane_speed or 1
                                    local anti_max_height = global.ui_status.anti_max_height
                                    local automatic_jet_heat_seek = global.ui_status.automatic_jet_heat_seek
                                    local PLANE_MEMORY = global.PLANE_MEMORY
                                    if anti_max_height then
                                        if master_switch_plane then
                                            x.Plane.CONST.HEIGHT_MAX = math.huge
                                        else
                                            x.Plane.CONST.HEIGHT_MAX = PLANE_MEMORY.HEIGHT_MAX 
                                        end
                                    else
                                        x.Plane.CONST.HEIGHT_MAX = PLANE_MEMORY.HEIGHT_MAX
                                    end
                                    if master_switch_plane then
                                        if automatic_jet_heat_seek then
                                            local getClosestPlayer = client.reg.getClosestPlayerByFov
                                            if getClosestPlayer then
                                                local char = getClosestPlayer.Character
                                                if char then
                                                    local primaryPart = char.PrimaryPart
                                                    if primaryPart then
                                                        if x.targetPart ~= primaryPart then
                                                            x.targetPart = primaryPart
                                                            x.targetPartFoundAt = os.clock()
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        x.Plane.CONST.MAX_THRUST = PLANE_MEMORY.MAX_THRUST * tonumber(plane_speed)
                                    else
                                        x.Plane.CONST.MAX_THRUST = PLANE_MEMORY.MAX_THRUST
                                    end
                                end)
                            }
                        end
                        return jetMountPlayer(x, y, ...)
                    end
                    local function onJetUnmountSeat(x, y)
                        if plane[x.Plane.Id] and y.Player == player then
                            global.PLANE_MEMORY = nil
                            plane[x.Plane.Id].LIFE:disconnect()
                            plane[x.Plane.Id] = nil
                        end
                        return jetUnmountSeat(x, y)
                    end
                    local function onJetDestroy(x)
                        if plane[x.Plane.Id] then
                            global.PLANE_MEMORY = nil
                            plane[x.Plane.Id].LIFE:disconnect()
                            plane[x.Plane.Id] = nil
                        end
                        return jetDestroy(x)
                    end
                    seekingMissileUtils.setTargetPos = onSetTargetPos
                    jet.MountPlayer = onJetMountPlayer
                    jet.UnmountSeat = onJetUnmountSeat
                    jet.Destroy = onJetDestroy
                end
                jet()
                local function stunt()
                    local stunt = client.modules.stunt
                    local stuntMountPlayer = stunt.MountPlayer
                    local stuntUnmountSeat = stunt.UnmountSeat
                    local stuntDestroy = stunt.Destroy
                    local function onStuntMountPlayer(x, y, ...)
                        if y == player and not plane[x.Plane.Id] then
                            global.PLANE_MEMORY = {
                                HEIGHT_MAX = x.Plane.CONST.HEIGHT_MAX;
                                MAX_THRUST = x.Plane.CONST.MAX_THRUST;
                            }
                            plane[x.Plane.Id] = {
                                PLANE = global.PLANE_MEMORY;
                                CREATION_TIME = tick();
                                LIFE = createloop(0, function()
                                    local master_switch_plane = global.ui_status.master_switch_plane
                                    local plane_speed = global.ui_status.plane_speed or 1
                                    local anti_max_height = global.ui_status.anti_max_height
                                    local PLANE_MEMORY = global.PLANE_MEMORY
                                    if anti_max_height then
                                        if master_switch_plane then
                                            x.Plane.CONST.HEIGHT_MAX = math.huge
                                        else
                                            x.Plane.CONST.HEIGHT_MAX = PLANE_MEMORY.HEIGHT_MAX 
                                        end
                                    else
                                        x.Plane.CONST.HEIGHT_MAX = PLANE_MEMORY.HEIGHT_MAX
                                    end
                                    if master_switch_plane then
                                        x.Plane.CONST.MAX_THRUST = PLANE_MEMORY.MAX_THRUST * tonumber(plane_speed)
                                    else
                                        x.Plane.CONST.MAX_THRUST = PLANE_MEMORY.MAX_THRUST
                                    end
                                end)
                            }
                        end
                        return stuntMountPlayer(x, y, ...)
                    end
                    local function onStuntUnmountSeat(x, y)
                        if plane[x.Plane.Id] and y.Player == player then
                            global.PLANE_MEMORY = nil
                            plane[x.Plane.Id].LIFE:disconnect()
                            plane[x.Plane.Id] = nil
                        end
                        return stuntUnmountSeat(x, y)
                    end
                    local function onStuntDestroy(x)
                        if plane[x.Plane.Id] then
                            global.PLANE_MEMORY = nil
                            plane[x.Plane.Id].LIFE:disconnect()
                            plane[x.Plane.Id] = nil
                        end
                        return stuntDestroy(x)
                    end
                    stunt.MountPlayer = onStuntMountPlayer
                    stunt.UnmountSeat = onStuntUnmountSeat
                    stunt.Destroy = onStuntDestroy
                end
                stunt()
            end
            planeModify()
            local function carModify()
                local function on_loadup()
                    local function onVehicleEntered(obj)
                        if obj.Name == "InVehicle" then
                            local car
                            while true do
                                task.wait()
                                if car then
                                    break
                                end
                                car = client.reg.getLocalVehicle
                            end
                            if car.GarageEngineSpeed ~= nil and tostring(car.Make) ~= "Dirtbike" then
                                local memory = {
                                    speed = car.GarageEngineSpeed or 1;
                                    brakes = car.GarageBrakes or 1;
                                    turnspeed = car.TurnSpeed or 1;
                                    height = car.Height or 3;
                                }
                                global.registry.vehicle_memory = memory
                                local bool = global.ui_status.master_switch_carmodify
                                if not bool then
                                    local memory = global.registry.vehicle_memory
                                    if memory and car.GarageEngineSpeed ~= nil then
                                        car.GarageEngineSpeed = memory.speed
                                        car.GarageBrakes = memory.brakes
                                        car.TurnSpeed = memory.turnspeed
                                        car.Height = memory.height
                                    end
                                    return false
                                end
                                task.delay(0.1, function()
                                    local modifytbl = {
                                        speed = global.ui_status.car_speed or 1;
                                        brakes = global.ui_status.car_brakes or 1;
                                        turnspeed = global.ui_status.car_turnspeed or 1;
                                        height = global.ui_status.car_height or 3;
                                    }
                                    if car then
                                        car.GarageEngineSpeed = modifytbl.speed
                                        car.GarageBrakes = modifytbl.brakes
                                        car.TurnSpeed = modifytbl.turnspeed
                                        car.Height = modifytbl.height
                                    end
                                end)
                            end
                            return true
                        end
                    end
                    local function onVehicleExit(obj)
                        local bool = global.ui_status.master_switch_carmodify
                        if obj.Name == "InVehicle" then
                            if not bool and global.registry.vehicle_memory ~= nil then
                                global.registry.vehicle_memory = nil
                            end
                        end
                    end
                    local function onCharacterAdded()
                        player.Character.ChildAdded:connect(onVehicleEntered)
                    end
                    local function onCharacterRemoving()
                        player.Character.ChildRemoved:connect(onVehicleExit)
                    end
                    player.CharacterAdded:connect(onCharacterAdded)
                    player.CharacterRemoving:connect(onCharacterAdded)
                end
                on_loadup()
                local function loop()
                    local car = client.reg.getLocalVehicle
                    if not car then
                        return false
                    end
                    local memory = global.registry.vehicle_memory
                    local bool = global.ui_status.master_switch_carmodify
                    if not bool then
                        if memory then
                            if car and car.GarageEngineSpeed ~= nil and tostring(car.Make) ~= "Dirtbike" then
                                car.GarageEngineSpeed = memory.speed or 1
                                car.GarageBrakes = memory.brakes or 1
                                car.TurnSpeed = memory.turnspeed or 1
                                car.Height = memory.height or 3
                            end
                        end
                        return false
                    end
                    if car and not memory then
                        memory = {}
                        memory.speed = car.GarageEngineSpeed or 1
                        memory.brakes = car.GarageBrakes or 1
                        memory.turnspeed = car.TurnSpeed or 1
                        memory.height = car.Height or 3
                        global.registry.vehicle_memory = memory
                    end
                    if memory then
                        local car_speed = global.ui_status.car_speed or 1
                        local car_brakes = global.ui_status.car_brakes or 1
                        local car_turnspeed = global.ui_status.car_turnspeed or 1
                        local car_height = global.ui_status.car_height or 3
                        if car and car.GarageEngineSpeed ~= nil and tostring(car.Make) ~= "Dirtbike" then
                            car.GarageEngineSpeed = car_speed
                            car.GarageBrakes = car_brakes
                            car.TurnSpeed = car_turnspeed
                            car.Height = car_height
                        end
                    end
                end
                createloop(0, loop)
            end
            carModify()
            local function nitroCorrection()
                local function loop()
                    local master_switch_carmodify = global.ui_status.master_switch_carmodify
                    if not master_switch_carmodify then
                        return false
                    end
                    local bool = global.ui_status.infinite_nitro
                    if not bool then
                        return false
                    end
                    local nitro = global.registry.nitro
                    nitro.Nitro = 249
                    nitro.NitroLastMax = 250
                end
                createloop(0, loop)
            end
            nitroCorrection()
            local function hotbarCorrection()
                local hasInVehicleTag = global.registry.hasInVehicleTag
                local function loop()
                    local bool = global.ui_status.show_hotbar_in_vehicle
                    local hotbargui = player.PlayerGui:FindFirstChild("HotbarGui")
                    if client.playerCharacter and hasInVehicleTag(client.playerCharacter) then
                        hotbargui.Enabled = bool
                    else
                        hotbargui.Enabled = true
                    end
                end
                createloop(0, loop)
            end
            hotbarCorrection()
            local function tirePopCorrection()
                local cache
                local function tagService()
                    cache = client.tags.new("antibreakvehicle", 0, false, function(val)
                        local vehicle = client.reg.getLocalVehicle
                        if val then
                            if vehicle and vehicle.Type == "Heli" then
                                vehicle.FallOutOfSkyDuration = 0
                                vehicle.DisableDuration = 0
                            elseif vehicle and vehicle.Type == "Chassis" then
                                vehicle.TirePopDuration = 0
                                vehicle.DisableDuration = 0
                                vehicle.TirePopProportion = 0
                            end
                        else
                            if vehicle and vehicle.Type == "Heli" then
                                vehicle.FallOutOfSkyDuration = 10
                                vehicle.DisableDuration = 10
                            elseif vehicle and vehicle.Type == "Chassis" then
                                vehicle.TirePopDuration = 7.5
                                vehicle.DisableDuration = 7.5
                                vehicle.TirePopProportion = 0.5
                            end
                        end
                    end)
                end
                tagService()
                local function onVehicleEntered(obj)
                    if obj.Name == "InVehicle" then
                        if global.ui_status.antitirepop then
                            local vehicle
                            while true do
                                if vehicle then
                                    break
                                end
                                vehicle = client.reg.getLocalVehicle
                                task.wait()
                            end
                            if vehicle.Type == "Heli" then
                                vehicle.FallOutOfSkyDuration = 0
                                vehicle.DisableDuration = 0
                            end
                            if vehicle.Type == "Chassis" then
                                vehicle.TirePopDuration = 0
                                vehicle.DisableDuration = 0
                                vehicle.TirePopProportion = 0
                            end
                        end
                    end
                end
                local function onCharacterAdded()
                    player.Character.ChildAdded:connect(onVehicleEntered)
                end
                onCharacterAdded()
                player.CharacterAdded:connect(onCharacterAdded)
                local function loop()
                    local bool = global.ui_status.antitirepop
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            tirePopCorrection()
        end
        vehicleCorrection()
        local function equipCorrection()
            local function onDuck()
                local crawl = getupvalue(global.registry.iscrawling, 1)
                local function loop()
                    local bool = global.ui_status.allow_equip_on_duck
                    if bool then
                        if crawl.IsCrawling then
                            crawl.IsCrawling = false
                        end
                    end
                end
                createloop(0, loop)
            end
            onDuck()
            local function hasItems()
                local function loop()
                    local bool = global.ui_status.allow_equip_with_items
                    local gem = player.Folder:FindFirstChild("Gem")
                    local bag = player.Folder:FindFirstChild("Bag")
                    local crate = player.Folder:FindFirstChild("Crate")
                    local inventoryUtils = client.modules.inventoryItemUtils
                    if gem then
                        inventoryUtils.setLocked(gem, not bool)
                    end
                    if crate then
                        inventoryUtils.setLocked(crate, not bool)
                    end
                    if bag then
                        inventoryUtils.setLocked(bag, not bool)
                    end
                end
                createloop(1, loop)
            end
            hasItems()
            local function isFlying()
                local module = client.modules.jetpack.IsFlying
                local function hook(...)
                    local bool = global.ui_status.allow_equip_while_flying
                    if bool then
                        return false
                    end
                    return module(...)
                end
                client.modules.jetpack.IsFlying = hook
            end
            isFlying()
        end
        equipCorrection()
        local function soundCorrection()
            local function assignsounds()
                local config = global.config
                local cfg = config.playsounds
                local sounds = global.registry.sounds
                cfg.list = sounds
                task.delay(0.2, function()
                    cfg.reload(cfg.list)
                end)
            end
            assignsounds()
            local function playsounds()
                local callback = global.callback
                local playsounds = global.registry.playSounds
                local function loop()
                    local bool = global.ui_status.annoyserver
                    if not bool then
                        return false
                    end
                    playsounds("Horn", {
                        Source = client.playerCharacter;
                        MaxTime = 1;
                        Volume = math.huge;
                    })
                end
                createloop(1, loop)
            end
            playsounds()
        end
        soundCorrection()
        local function gunCorrection()
            local function cacheForGetEq()
                local cache
                local function tagService()
                    cache = client.tags.new("getEquippedItem", 0, false, function(val)
                        if val then
                            for i,v in next, client.onGetEq do
                                v._fn()
                            end
                        else
                            local playerGui = player.PlayerGui
                            local crosshairs = {}
                            for i,v in next, playerGui:GetChildren() do
                                if v.Name == "CrossHairGui" then
                                    table.insert(crosshairs, v)
                                end
                            end
                            task.delay(0.2, function()
                                for i,v in next, crosshairs do
                                    v:Destroy()
                                end
                            end)
                        end
                    end)
                end
                tagService()
                local function loop()
                    local getEquippedItem = client.reg.getEquippedItem and true or false
                    if cache then
                        cache.obj.Value = getEquippedItem
                    end
                end
                createloop(0, loop)
            end
            cacheForGetEq()
            local function wallbang()
                local cache
                local function tagService()
                    cache = client.tags.new("wallbang", 0, false, function(val)
                        local getEquippedItem = client.reg.getEquippedItem
                        if getEquippedItem and getEquippedItem.IgnoreList then
                            local ignoreList = getEquippedItem.IgnoreList
                            if val then
                                table.insert(ignoreList, workspace)
                            else
                                for i,v in next, ignoreList do
                                    if v == workspace then
                                        table.remove(ignoreList)
                                    end
                                end
                            end
                        end
                    end)
                end
                tagService()
                local function _fn()
                    local bool = global.ui_status.wallbang
                    if bool then
                        local getEquippedItem = client.reg.getEquippedItem
                        if getEquippedItem then
                            if getEquippedItem.IgnoreList then
                                table.insert(getEquippedItem.IgnoreList, workspace)
                            end
                        end
                    end
                end
                table.insert(client.onGetEq, {
                    _fn = _fn;
                })
                local function loop()
                    local bool = global.ui_status.wallbang
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            wallbang()
            local function scopegui()
                local function loop()
                    local bool = global.ui_status.anti_scope_ui
                    if bool then
                        local getEquippedItem = client.reg.getEquippedItem
                        if not getEquippedItem then
                            return false
                        end
                        local scopegui = getEquippedItem.ScopeGui
                        if not scopegui then
                            return false
                        end
                        scopegui.Enabled = false
                    end
                end
                createloop(0, loop)
            end
            scopegui()
            local function instantSeek()
                local rocketLauncherConsts = client.modules.rocketLauncherConsts
                setreadonly(rocketLauncherConsts, false)
                local cache
                local function tagService()
                    cache = client.tags.new("instantSeek", 0, false, function(val)
                        if val then
                            rocketLauncherConsts.SEEKING_LOCK_MIN_DURATION = 0
                        else
                            rocketLauncherConsts.SEEKING_LOCK_MIN_DURATION = 2
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.instant_seek
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            instantSeek()
            local function instantReload()
                local function getCurrentGun()
                    local gun = client.reg.getEquippedItem
                    if gun then
                        return gun
                    end
                    return false
                end
                local function getCurrentGunClassName()
                    local getCurrentGun = getCurrentGun()
                    if getCurrentGun and getCurrentGun.BulletEmitter then
                        return getCurrentGun.__ClassName
                    end
                    return "unknown"
                end
                local function hasPlayerEquippedClassNameGun(name)
                    if table.find(client.reg.resolveEquippedItems, name) then
                        return true
                    end
                    return false
                end
                local function isWeaponFlagOutOfAmmo(gun)
                    local getCurrentGun = gun
                    if getCurrentGun then
                        if getCurrentGun.IsReloading then
                            return true
                        end
                        if getCurrentGun.AmmoGui and getCurrentGun.AmmoGui.FlagOutOfAmmo then
                            return true
                        end
                    end
                    return false
                end
                local function getHotbarItems()
                    return client.modules.hotbarItemSystem.getSortedHotbarItemsFor(player)
                end
                local function setDisplayOrder(obj, num)
                    return client.modules.hotbarItemUtils.setDisplayOrder(obj, num)
                end
                local isReloading = false
                local onLastReload = tick()
                local function loop()
                    if isReloading and global.is_instant_reloading then
                        return false
                    end
                    local dropGun = global.registry.dropGun
                    local equipOwnedItem = global.registry.equipOwnedItem
                    local equip = global.registry.equip
                    local currentGun = getCurrentGun()
                    if currentGun and currentGun.BulletEmitter and isWeaponFlagOutOfAmmo(currentGun) then
                        global.is_instant_reloading = true
                        onLastReload = tick()
                        isReloading = true
                        local __ClassName = getCurrentGunClassName()
                        if __ClassName == "unknown" or __ClassName == "C4" or __ClassName == "RocketLauncher" or __ClassName == "Grenade" or __ClassName == "SmokeGrenade" then
                            isReloading = false
                            global.is_instant_reloading = false
                            return false
                        end
                        if __ClassName == "Flintlock" or __ClassName == "Sniper" then
                            task.wait(0.2)
                        end
                        local reload_timeout
                        reload_timeout = createloop(0, function()
                            if not client.playerCharacter or client.playerCharacter and not client.playerCharacter.PrimaryPart then 
                                isReloading = false
                                global.is_instant_reloading = false
                                reload_timeout:disconnect()
                                reload_timeout = nil
                                return false
                            end
                            if not isReloading then
                                reload_timeout:disconnect()
                                reload_timeout = nil
                            else
                                if tick() - onLastReload > 3 then
                                    log("RELOAD TIMEOUT")
                                    isReloading = false
                                    global.is_instant_reloading = false
                                    reload_timeout:disconnect()
                                    reload_timeout = nil
                                end
                            end
                        end)
                        local hotbar1 = getHotbarItems()
                        local oldPosition
                        for i,v in next, hotbar1 do
                            if v.obj and tostring(v.obj) == tostring(__ClassName) then
                                oldPosition = i
                                break
                            end
                        end
                        if not global.is_instant_reloading then
                            isReloading = false
                            global.is_instant_reloading = false
                            return false
                        end
                        equipOwnedItem(__ClassName, true)
                        while true do
                            if not getCurrentGun() then
                                equipOwnedItem(__ClassName)
                                break
                            end
                            if getCurrentGun() then
                                equipOwnedItem(__ClassName, true)
                            end
                            task.wait()
                        end
                        while true do
                            if hasPlayerEquippedClassNameGun(__ClassName) then
                                equip(__ClassName)
                                break
                            end
                            if not hasPlayerEquippedClassNameGun(__ClassName) then
                                equipOwnedItem(__ClassName)
                            end
                            task.wait()
                        end
                        while true do
                            if hasPlayerEquippedClassNameGun(__ClassName) then
                                if getCurrentGun() then
                                    break
                                end
                                equip(__ClassName)
                            else
                                equipOwnedItem(__ClassName)
                                while true do
                                    if hasPlayerEquippedClassNameGun(__ClassName) then
                                        equip(__ClassName)
                                        break
                                    end
                                    if not hasPlayerEquippedClassNameGun(__ClassName) then
                                        equipOwnedItem(__ClassName)
                                    end
                                    task.wait()
                                end
                                if not getCurrentGun() then
                                    equip(__ClassName)
                                end
                            end
                            if not getCurrentGun() then
                                equip(__ClassName)
                                if getCurrentGun() then
                                    break
                                else
                                    equip(__ClassName)
                                end
                            end
                            task.wait()
                        end
                        local hotbar2 = getHotbarItems()
                        for i,v in next, hotbar2 do
                            if v.obj and tostring(v.obj) == tostring(__ClassName) then
                                setDisplayOrder(v.obj, oldPosition)
                                break
                            end
                        end
                        global.is_instant_reloading = false
                        isReloading = false
                    end
                end
                local loopf
                local cache
                local function tagService()
                    cache = client.tags.new("instantReload", 0, false, function(val)
                        if val then
                            loopf = createloop(0, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.instant_reload
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            instantReload()
            local function weaponHooks()
                local rocketAccelerate
                local flintlockAccelerate
                local function rocketHook(...)
                    local bool = global.ui_status.no_recoil
                    if bool then
                        return true
                    end
                    return rocketAccelerate(...)
                end
                local function knockbackHook(...)
                    local bool = global.ui_status.anti_flintlock_knockback
                    if bool then
                        return task.wait(9e9)
                    end
                    return flintlockAccelerate(...)
                end
                local function knockback()
                    local getEquippedItem = client.reg.getEquippedItem
                    if getEquippedItem and getEquippedItem.__ClassName == "Flintlock" then
                        if not flintlockAccelerate then
                            flintlockAccelerate = getEquippedItem.SpringKnockback.Accelerate
                            getEquippedItem.SpringKnockback.Accelerate = knockbackHook
                        end
                    else
                        flintlockAccelerate = nil
                    end
                end
                local function recoil()
                    local getEquippedItem = client.reg.getEquippedItem
                    if getEquippedItem and getEquippedItem.__ClassName == "RocketLauncher" then
                        if not rocketAccelerate then
                            rocketAccelerate = getEquippedItem.SpringCamera.Accelerate
                            getEquippedItem.SpringCamera.Accelerate = rocketHook
                        end
                    else
                        rocketAccelerate = nil
                    end
                end
                local kbcache, kbloop
                local recoilcache, recoilloop
                local function tagService()
                    kbcache = client.tags.new("knockback", 0, false, function(val)
                        if val then
                            kbloop = createloop(0, knockback)
                        else
                            if kbloop then
                                kbloop:disconnect()
                                kbloop = nil
                            end
                        end
                    end)
                    recoilcache = client.tags.new("recoil", 0, false, function(val)
                        if val then
                            recoilloop = createloop(0, recoil)
                        else
                            if recoilloop then
                                recoilloop:disconnect()
                                recoilloop = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.no_recoil
                    if recoilcache then
                        recoilcache.obj.Value = bool
                    end
                    local kbbool = global.ui_status.anti_flintlock_knockback
                    if kbcache then
                        kbcache.obj.Value = kbbool
                    end
                end
                createloop(0, loop)
            end
            weaponHooks()
            local function killaura()
                local validGuns = {
                    "Rifle";
                    "Pistol";
                    "Shotgun";
                    "Revolver";
                    "Flintlock";
                    "AK47";
                    "Uzi";
                    "PlasmaPistol";
                    "Sniper";
                }
                local function isHoldingWeapon()
                    return client.reg.getEquippedItem
                end
                local function hasPistolInInventory()
                    return table.find(client.reg.resolveEquippedItems, "Pistol")
                end
                local equipOwnedItem = global.registry.equipOwnedItem
                local shootGun = global.registry.shootGun
                local unequipAll = global.registry.unequipAll
                local equip = global.registry.equip
                local last_shot_at = tick()
                local oldTarget
                local isScanning = false
                local weapon_used
                local function loop()
                    if global.is_instant_reloading then
                        return false
                    end
                    if global.is_registering_item then
                        return false
                    end
                    if client.state.isLocalInVehicle then
                        return false
                    end
                    if isScanning then
                        return false
                    end
                    isScanning = true
                    if weapon_used then
                        if weapon_used == "Sniper" or weapon_used == "Flintlock" then
                            task.wait(0.2)
                        end
                    end
                    local hasPistolEquipped = false
                    local getClosestVulnerablePlayer = client.reg.getClosestVulnerablePlayer
                    if getClosestVulnerablePlayer then
                        local isHolding = isHoldingWeapon()
                        if not isHolding then
                            hasPistolEquipped = false
                            local hasPistol = hasPistolInInventory()
                            if not hasPistol then
                                while true do
                                    if hasPistol then
                                        break
                                    end
                                    equipOwnedItem("Pistol")
                                    hasPistol = hasPistolInInventory()
                                    task.wait(0.2)
                                end
                            end
                            while true do
                                if isHolding then
                                    break
                                end
                                equip("Pistol")
                                isHolding = hasPistolInInventory()
                                task.wait(0.2)
                            end
                        else
                            if not table.find(validGuns, isHolding.__ClassName) then
                                unequipAll()
                                isScanning = false
                                return false
                            end
                            weapon_used = isHolding.__ClassName
                            hasPistolEquipped = true
                        end
                        if oldTarget ~= getClosestVulnerablePlayer then
                            oldTarget = getClosestVulnerablePlayer
                            local char = getClosestVulnerablePlayer.Character
                            if char then
                                local hum = char:FindFirstChild("Humanoid")
                                if hum then
                                    local connection
                                    connection = hum.Died:connect(function()
                                        connection:disconnect()
                                        print("closest player died")
                                        connection = nil
                                        oldTarget = nil
                                        if not hasPistolEquipped then
                                            unequipAll()
                                        end
                                    end)
                                end
                            end
                        end
                        shootGun()
                    end
                    isScanning = false
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("killaura", 0, false, function(val)
                        if val then
                            loopf = createloop(0, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.killaura_masterswitch
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            killaura()
            local function autoShoot()
                local lastUsedShoot = tick()
                local checkWallBeforePenetration = global.registry.checkWallBeforePenetration
                local function loop()
                    local master_switch = global.ui_status.master_switch_silentaim
                    if master_switch and global._loaded then
                        local bool = global.ui_status.automatic_shoot
                        if bool then
                            local getEquippedItem = client.reg.getEquippedItem 
                            if getEquippedItem then
                                local getClosestPlayerByFov = client.reg.getClosestPlayerByFov
                                if getClosestPlayerByFov then
                                    if global.ui_status.no_wall_penetration then
                                        if not checkWallBeforePenetration(getClosestPlayerByFov) then
                                            return false
                                        end
                                    end
                                    if getEquippedItem.__ClassName == "RocketLauncher" or getEquippedItem.__ClassName == "C4" or getEquippedItem.__ClassName == "SmokeGrenade" then
                                        return false
                                    end
                                    if getEquippedItem.__ClassName == "Sniper" or getEquippedItem.__ClassName == "Flintlock" then
                                        if tick() - lastUsedShoot < 1 then
                                            return false
                                        end
                                        lastUsedShoot = tick()
                                        task.wait(0.2)
                                    end
                                    local shootGun = global.registry.shootGun
                                    if shootGun then
                                        return shootGun()
                                    end
                                end
                            end
                        end
                    end
                end
                createloop(0, loop)
            end
            autoShoot()
            local function automatic_fire()
                local automaticweapons = {
                    Flintlock = true;
                    NerfPistol = true;
                    NerfResolver = true;
                    Pistol = true;
                    PlasmaPistol = true;
                    Revolver = true;
                    Shotgun = true;
                    Sniper = true;
                }
                local function loop()
                    local bool = global.ui_status.automatic_fire
                    local getEquippedItem = client.reg.getEquippedItem
                    if getEquippedItem then
                        if automaticweapons[getEquippedItem.__ClassName] then
                            getEquippedItem.Config.FireAuto = bool
                        end
                    end
                end
                createloop(0, loop)
            end
            automatic_fire()
            local function no_recoil()
                local camShake = {
                    AK47 = 10;
                    Flintlock = 150;
                    NerfPistol = 10;
                    NerfResolver = 100;
                    Pistol = 10;
                    PlasmaPistol = 15;
                    Revolver = 100;
                    Rifle = 10;
                    Shotgun = 80;
                    Sniper = 80;
                    Uzi = 15;
                }
                local function loop()
                    local bool = global.ui_status.no_recoil
                    local getEquippedItem = client.reg.getEquippedItem
                    if getEquippedItem then
                        if not bool then
                            if camShake[getEquippedItem.__ClassName] then
                                getEquippedItem.Config.CamShakeMagnitude = camShake[getEquippedItem.__ClassName]
                            end
                        else
                            if getEquippedItem.Config.CamShakeMagnitude ~= nil then
                                getEquippedItem.Config.CamShakeMagnitude = 0
                            end
                        end
                    end
                end
                createloop(0, loop)
            end
            no_recoil()
            local function no_spread()
                local function loop()
                    local bool = global.ui_status.no_spread
                    local getEquippedItem = client.reg.getEquippedItem
                    if getEquippedItem then
                        local cfg = getEquippedItem.Config
                        if not cfg.DefaultSpread then
                            cfg.DefaultSpread = cfg.BulletSpread
                        else
                            if not bool then
                                cfg.BulletSpread = cfg.DefaultSpread
                            else
                                cfg.BulletSpread = 0
                            end
                        end
                    end
                end
                createloop(0, loop)
            end
            no_spread()
            local function quickfire()
                local shootGun = global.registry.shootGun
                global.inputs = {
                    mouse1 = false; 
                }
                local function onInputBegan(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        global.inputs.mouse1 = true
                    end
                end
                local function onInputEnded(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        global.inputs.mouse1 = false
                    end
                end
                uis.InputBegan:connect(onInputBegan)
                uis.InputEnded:connect(onInputEnded)
                local function _fn()
                    if global.ui_status.quickfire and global._loaded then
                        local loop
                        local lastTimeShot = tick()
                        loop = createloop(0, function()
                            if not global.ui_status.quickfire then
                                loop:disconnect()
                                loop = nil
                                return false
                            end
                            local gun = client.reg.getEquippedItem
                            if not gun then
                                loop:disconnect()
                                loop = nil
                                return false
                            end
                            if not gun or gun and not gun.CheckNextShotPossible then
                                return false
                            end
                            if gun.CheckNextShotPossible and not gun:CheckNextShotPossible() then
                                return false
                            end
                            if gun.__ClassName == "Sniper" or gun.__ClassName == "Flintlock" then
                                if tick() - lastTimeShot < 0.4 then
                                    return false
                                end
                                lastTimeShot = tick()
                            end
                            if global.inputs.mouse1 then
                                shootGun()
                            end
                        end)
                    end
                end
                local tagCache
                local function tagService()
                    tagCache = client.tags.new("quickfire", 0, false, function(val)
                        if val then
                            _fn()
                        end
                    end)
                end
                tagService()
                table.insert(client.onGetEq, {
                    _fn = _fn;
                })
                local function loop()
                    local bool = global.ui_status.quickfire
                    if tagCache then
                        tagCache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            quickfire()
        end
        gunCorrection()
        local function npcCorrection()
            local function isAirdrop()
                local module = client.modules.guardNPCshared.canSeeTarget
                local function hook(x, y)
                    local bool = global.ui_status.break_npcs
                    if bool or global.ui_status.break_mansion_npcs then
                        return false
                    end
                    return module(x, y)
                end
                client.modules.guardNPCshared.canSeeTarget = hook
            end
            isAirdrop()
        end
        npcCorrection()
        local function airdropCorrection()
            local holdEAction
            local actionButtonService = client.modules.actionButtonService
            task.spawn(function()
                for i,v in next, actionButtonService.active do
                    if v.image == "rbxassetid://10770151584" then
                        holdEAction = v
                        break
                    end
                end
            end)
            local function isNearAirdrop()
                local char = client.playerCharacter
                if not char then
                    return false
                end
                local root = char.PrimaryPart
                if not root then
                    return false
                end
                local airdrops_on_map = global.airdrops_on_map
                if #airdrops_on_map == 0 then
                    return false
                end
                for i,v in next, airdrops_on_map do
                    if (root.Position - v.Position).magnitude < 10 then
                        return true
                    end
                end
                return false
            end
            local isPlayerNearAirdrop
            local cache
            local function loop()
                if not isPlayerNearAirdrop.obj.Value then
                    cache:disconnect()
                    cache = nil
                    return false
                end
                if not holdEAction._pressed then
                    holdEAction._pressState()
                end
            end
            local function tagService()
                isPlayerNearAirdrop = client.tags.new("isPlayerNearAirdrop", 0, false, function(val)
                    if val then
                        cache = createloop(0, loop)
                    else
                        holdEAction._pressed = false
                        if cache then
                            cache:disconnect()
                            cache = nil
                        end
                    end
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.automatic_hold
                if isPlayerNearAirdrop then
                    if bool then
                        isPlayerNearAirdrop.obj.Value = isNearAirdrop()
                    else
                        isPlayerNearAirdrop.obj.Value = false
                    end
                end
            end
            createloop(0, loop)
        end
        airdropCorrection()
        local function worldLoadingCorrection()
            setreadonly(client.modules.worldUnloadConsts, false)
            setreadonly(client.modules.humanoidUnloadConsts, false)
            local WorldUnloadMaxDistToLoad = client.modules.worldUnloadConsts.MAX_DIST_TO_LOAD
            local HumanoidUnloadMaxDistToLoad = client.modules.humanoidUnloadConsts.MAX_DIST_TO_LOAD
            local function loop()
                local bool = global.ui_status.never_unload_world
                local extended_aimbot_range = global.ui_status.extended_aimbot_range
                if bool or extended_aimbot_range then
                    client.modules.worldUnloadConsts.MAX_DIST_TO_LOAD = math.huge
                    client.modules.humanoidUnloadConsts.MAX_DIST_TO_LOAD = math.huge
                else
                    client.modules.worldUnloadConsts.MAX_DIST_TO_LOAD = WorldUnloadMaxDistToLoad
                    client.modules.humanoidUnloadConsts.MAX_DIST_TO_LOAD = HumanoidUnloadMaxDistToLoad
                end
            end
            createloop(0, loop)
        end
        worldLoadingCorrection()
        local function museumCorrection()
            local function puzzleCorrection()
                local museum = workspace:FindFirstChild("Museum")
                local function loop()
                    if not museum then
                        museum = workspace:FindFirstChild("Museum")
                        if not museum then
                            return false
                        end
                    end
                    local puzzle1 = museum.Puzzle1:GetDescendants()
                    local puzzle2 = museum.Puzzle2:GetDescendants()
                    for i,v in next, puzzle1 do
                        if v:FindFirstChild("ClickDetector") then
                            for i=1, math.random(1, 5) do
                                task.wait()
                                fireclickdetector(v.ClickDetector)
                            end
                        end
                    end
                    for i,v in next, puzzle2 do
                        if v:FindFirstChild("ClickDetector") then
                            for i=1, math.random(1, 5) do
                                task.wait()
                                fireclickdetector(v.ClickDetector)
                            end
                        end
                    end
                end
                local loopf
                local cache
                local function tagService()
                    cache = client.tags.new("puzzle", 0, false, function(val)
                        if val then
                            loopf = createloop(1, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.break_museum_puzzle
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            puzzleCorrection()
            local function mouseClickCorrection()
                local mouse = global.LocalMouse
                local function onPressedMouse()
                    if global.ui_status.clicklightning then
                        local lightningSystem = client.modules.lightningSystem
                        lightningSystem.StrikePosition(mouse.Hit.p + Vector3.new(0, 100, 0), mouse.Hit.p)
                    end
                    if global.ui_status.clicknuke then
                        local settings = {
                            Nuke = {
                                Speed = global.ui_status.nuke_speed or 650;
                                Duration = global.ui_status.nuke_duration or 10;
                                TimeDilation = global.ui_status.nuke_timedilation or 1.5;
                            };
                            Shockwave = {
                                MaxRadius = global.ui_status.nuke_shockwave_maxradius or 10000;
                                Duration = global.ui_status.nuke_shockwave_duration or 10;
                            };
                        }
                        local nukecontrol = global.registry.nukecontrol
                        settings.Nuke.Target = mouse.Hit.p
                        settings.Nuke.Origin = mouse.Hit.p
                        nukecontrol(settings)
                    end
                end
                mouse.Button1Down:connect(onPressedMouse)
            end
            mouseClickCorrection()
            local function museumResolverCorrection()
                local function puzzle1()
                    local museum = workspace:FindFirstChild("Museum")
                    if not museum then
                        return false
                    end
                    if museum.Puzzle2Door.Closed.CanCollide then
                        return false
                    end
                    local spinners = museum.Puzzle1.Spinners
                    local connections = museum.Puzzle1.Connections
                    for i,v in next, spinners:GetChildren() do
                        local name = connections:FindFirstChild(v.Name)
                        if name and name.Color == Color3.fromRGB(89, 144, 255) then
                            fireclickdetector(v.ClickDetector)
                        end
                    end
                end
                local function puzzle2()
                    local museum = workspace:FindFirstChild("Museum")
                    if not museum then
                        return false
                    end
                    if museum.Puzzle1Door.Closed.CanCollide then
                        return false
                    end
                    local pieces = museum.Puzzle2.Pieces
                    local targetOnlyPieces = {2, 3, 10, 11, 12, 19, 20, 13, 14}
                    for i,v in next, targetOnlyPieces do
                        local v = pieces:FindFirstChild(tostring(v))
                        if table.find(targetOnlyPieces, tonumber(v.Name)) then
                            if tonumber(v.Name) == 2 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 0) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 3 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 0) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 10 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 180) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 11 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 180) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 12 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 0) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 19 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 180) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 20 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, -90) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 13 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 90) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                            if tonumber(v.Name) == 14 then
                                while true do
                                    if v.Orientation == Vector3.new(0, -38, 0) then
                                        break
                                    end
                                    fireclickdetector(v.ClickDetector)
                                    task.wait(0.3)
                                end
                            end
                        end
                    end
                end
                local loopf
                local cache
                local function loop()
                    local break_museum_puzzle = global.ui_status.break_museum_puzzle
                    if break_museum_puzzle then
                        return false
                    end
                    local isInMuseum = global.registry.isInMuseum()
                    if isInMuseum then
                        puzzle1()
                        puzzle2()
                    end
                end
                local function tagService()
                    cache = client.tags.new("museumPuzzle", 0, false, function(val)
                        if val then
                            loopf = createloop(0.3, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_resolve_museum_puzzle
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            museumResolverCorrection()
            local function dynamiteCorrection()
                local dynamite = collectionservice:GetTagged("Museum_DynamiteNode")
                local function isDetonatorDown()
                    local museum = workspace.Museum
                    if museum.Roof.Hole.RoofPart.Transparency == 1 then
                        return false
                    end
                    for i,v in next, museum.Roof:GetDescendants() do
                        if v.Name == "Arm" then
                            if v.Transparency == 1 then
                                if v.Parent.Name == "Detonator0" then
                                    for i2,v2 in next, client.modules.ui.CircleAction.Specs do
                                        if v2.Name == "Place Dynamite" and v2.Part:IsDescendantOf(workspace.Museum) then
                                            v2:Callback(true)
                                        end
                                    end
                                end
                                if v.Parent.Name == "Detonator1" then
                                    for i2,v2 in next, client.modules.ui.CircleAction.Specs do
                                        if v2.Name == "Place Dynamite" and v2.Part:IsDescendantOf(workspace.Museum) then
                                            v2:Callback(true)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                local getRobberyStatus = global.registry.getRobberyStatus
                local function getMuseumStatus()
                    local getMuseumStatus = getRobberyStatus("MUSEUM")
                    if getMuseumStatus then
                        return true
                    elseif getMuseumStatus == 0 then
                        return 0
                    elseif not getMuseumStatus then
                        return false
                    end
                    return false
                end
                local function loop()
                    if tostring(player.Team) ~= "Criminal" then
                        return false
                    end
                    if getMuseumStatus() == true then
                        isDetonatorDown()
                    end
                end
                local loopf
                local cache
                local function tagService()
                    cache = client.tags.new("placeDynamite", 0, false, function(val)
                        if val then
                            loopf = createloop(1, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_place_dynamite
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            dynamiteCorrection()
        end
        museumCorrection()
        local function robberyMarkerDelayCorrection()
            local doesPlayerOwn = client.modules.gamepassSystem.DoesPlayerOwn
            local function hook(num)
                if num == 5 then
                    local bool = global.ui_status.no_robberymarker_delay
                    if not bool then
                        return doesPlayerOwn(num)
                    end
                    return true
                end
                return doesPlayerOwn(num)
            end
            client.modules.gamepassSystem.DoesPlayerOwn = hook
        end
        robberyMarkerDelayCorrection()
        local function c4Exploits()
            local c4s = {}
            local function onAddedWorkspace(obj)
                if obj.Name == "C4" then
                    if obj:FindFirstChild("CreatorId") then
                        local creator = tonumber(obj.CreatorId.Value)
                        if creator == player.UserId then
                            table.insert(c4s, obj)
                        end
                    end
                end
            end
            table.insert(client.onWorkspaceSpawnRun, {
                _fn = onAddedWorkspace
            })
            local function onRemovedWorkspace(obj)
                if obj.Name == "C4" then
                    for i,v in next, c4s do
                        if v == obj then
                            table.remove(c4s, i)
                        end
                    end
                end
            end
            table.insert(client.onWorkspaceRemovedRun, {
                _fn = onRemovedWorkspace
            })
            local function getC4s()
                return c4s
            end
            local function setC4Pos(target, idx, c4)
                local override_length = global.ui_status.override_length
                if override_length then
                    local dick_length = global.ui_status.dick_length or 1
                    if dick_length and idx > dick_length then
                        return false
                    end
                end
                if c4 and c4:FindFirstChild("StickRemote") then
                    local lowerTorso = target.Character:FindFirstChild("LowerTorso")
                    if lowerTorso then
                        c4.StickRemote:FireServer(lowerTorso, CFrame.new(0, -2 * idx, 0) * CFrame.Angles(math.rad(80), 0, 0))
                    end
                end
            end
            local hasItemEquipped = global.registry.hasItemEquipped
            local function isHoldingC4()
                if hasItemEquipped("C4") then
                    return true
                end
                return false
            end
            local function hasC4InInventory()
                return table.find(client.reg.resolveEquippedItems, "C4")
            end
            local function equipC4()
                local equip = global.registry.equip
                if equip then
                    equip("C4")
                end
            end
            local function ownsC4()
                return table.find(client.reg.resolveOwnedItems, "C4")
            end
            local findTarget = global.registry.findTarget
            local function getC4AmmoCurrent()
                local c4 = player.Folder:FindFirstChild("C4")
                if c4 then
                    return c4:GetAttribute("AmmoCurrent")
                end
                return "_n"
            end
            local equipOwnedItem = global.registry.equipOwnedItem
            local unequipAll = global.registry.unequipAll
            local getPlayerVehicle = global.registry.getPlayerVehicle
            local function explodeTruck()
                local isInProcess = false
                local function throw_c4_on_truck(truck)
                    if not ownsC4() then
                        return global.notify("You do not own C4.", 5)
                    end
                    if client.reg.getLocalVehicle then
                        return global.notify("Get out of the vehicle.", 5)
                    end
                    if isInProcess then
                        return global.notify("Already in process.", 3)
                    end
                    isInProcess = true
                    local hasC4 = hasC4InInventory()
                    if not hasC4 then
                        local c4
                        while true do
                            c4 = hasC4InInventory()
                            if c4 then
                                break
                            end
                            equipOwnedItem("C4")
                            task.wait(0.4)
                        end
                        hasC4 = c4
                    end
                    local ammoCurrent = getC4AmmoCurrent()
                    if ammoCurrent == "_n" then
                        isInProcess = false
                        return global.notify("Failed throwing c4 on truck!", 5)
                    else
                        if ammoCurrent < 1 then
                            local ammo
                            while true do
                                ammo = getC4AmmoCurrent()
                                if ammo >= 1 then
                                    break
                                end
                                equipOwnedItem("C4Ammo")
                                task.wait(0.4)
                            end
                            ammoCurrent = ammo
                        end
                    end
                    if hasC4 then
                        if not isHoldingC4() then
                            equipC4()
                            task.wait(0.2)
                        end
                        if truck then
                            local backDoorRight = truck:FindFirstChild("BackDoorRight")
                            if backDoorRight and not truck:FindFirstChild("LockMovement") then
                                local decal = backDoorRight.Decal
                                if decal then
                                    local c4s = getC4s()
                                    while #c4s == 0 do
                                        c4s = getC4s()
                                        task.wait()
                                    end
                                    local c4 = c4s[1] or c4s[#c4s]
                                    if c4 and c4:FindFirstChild("StickRemote") and not c4.Stuck.Value then
                                        c4.PrimaryPart.CFrame = decal.CFrame
                                        c4.StickRemote:FireServer(decal, c4.PrimaryPart.CFrame:ToObjectSpace(decal.CFrame))
                                        local stuck_at, detonated = tick(), false
                                        while true do
                                            if detonated then
                                                break
                                            end
                                            if tick() - stuck_at > 3 then
                                                detonated = false
                                                break
                                            end
                                            if c4:FindFirstChild("DetonateRemote") then
                                                if tick() - stuck_at > 0.4 then
                                                    detonated = true
                                                    break
                                                end
                                            end
                                            task.wait()
                                        end
                                        if detonated then 
                                            c4.DetonateRemote:FireServer()
                                        end
                                    end
                                end
                            end
                        end
                    end
                    unequipAll()
                    isInProcess = false
                end
                global.registry.throw_c4_on_truck = throw_c4_on_truck
                local tagCache
                local loopf
                local function getRobberyStatus(key)
                    key = key:upper()
                    local getRobberyStatus = global.registry.getRobberyStatus
                    local status = getRobberyStatus(key)
                    if status == "OPENED" then
                        return true
                    end
                    if status == "STARTED" then
                        return 0
                    end
                    return false
                end
                local loopInProcess = false
                local function loop()
                    if tostring(player.Team) == "Police" then
                        return false
                    end
                    if loopInProcess then
                        return false
                    end
                    if isInProcess then
                        return false
                    end
                    if not ownsC4() then
                        return false
                    end
                    if not getRobberyStatus("money_truck") then
                        return false
                    end
                    loopInProcess = true
                    local char = client.playerCharacter
                    if char then
                        local root = char.PrimaryPart
                        if root then
                            local bankTruck = client.descendants.vehicles:FindFirstChild("BankTruck")
                            if bankTruck then
                                if not bankTruck:FindFirstChild("BackDoorLeft") or not bankTruck:FindFirstChild("BackDoorRight") then
                                    loopInProcess = false
                                    return false
                                end
                                if bankTruck:FindFirstChild("LockMovement") then
                                    loopInProcess = false
                                    return false
                                end
                                local primaryPart = bankTruck.PrimaryPart
                                if primaryPart then
                                    if (root.Position - primaryPart.Position).magnitude < 80 then
                                        throw_c4_on_truck(bankTruck)
                                    end
                                end
                            end
                        end
                    end
                    loopInProcess = false
                end
                local function tagService()
                    tagCache = client.tags.new("automatic_explode_truck", 0, false, function(val)
                        if val then
                            loopf = createloop(0.5, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_explode_truck
                    if tagCache then
                        tagCache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            explodeTruck()
            local function bombVest()
                local isInProcess = false
                local function spawn_vest(name)
                    if not ownsC4() then
                        return global.notify("You do not own C4.", 5)
                    end
                    if client.reg.getLocalVehicle then
                        return global.notify("Get out of the vehicle.", 5)
                    end
                    if isInProcess then
                        return global.notify("Bomb vest spawning is already in process. Wait!", 5)
                    end
                    isInProcess = true
                    local hasC4 = hasC4InInventory()
                    if not hasC4 then
                        local c4
                        while true do
                            c4 = hasC4InInventory()
                            if c4 then
                                break
                            end
                            equipOwnedItem("C4")
                            task.wait(0.2)
                        end
                        hasC4 = c4
                    end
                end
            end
            bombVest()
            local function kill()
                local isInProcess, kill_started_at = false, tick()
                local function kill_player(name)
                    if not ownsC4() then
                        return global.notify("You do not own C4.", 5)
                    end
                    if client.reg.getLocalVehicle then
                        return global.notify("Get out of the vehicle.", 5)
                    end
                    if isInProcess then
                        if tick() - kill_started_at > 10 then
                            isInProcess = false
                        end
                        return global.notify("Killing already in process. Wait!", 5)
                    end
                    isInProcess = true
                    kill_started_at = tick()
                    local hasC4 = hasC4InInventory()
                    if not hasC4 then
                        local c4
                        while true do
                            c4 = hasC4InInventory()
                            if c4 then
                                break
                            end
                            equipOwnedItem("C4")
                            task.wait(0.2)
                        end
                        hasC4 = c4
                    end
                    if hasC4 then
                        local target = findTarget(name)
                        if target then
                            if target.Name == player.Name then
                                isInProcess = false
                                return global.notify("hey, don't kill yourself. :)", 5)
                            end
                            local char = target.Character
                            if not char then
                                isInProcess = false
                                return global.notify("Target has no character.", 5)
                            end
                            local torso = char:FindFirstChild("LowerTorso")
                            if not torso then
                                isInProcess = false
                                return global.notify("Target has no torso. Get closer to the target!", 5)
                            end
                            local limit = 0
                            local function spawnAndStickC4()
                                if limit > 5 then
                                    isInProcess = false
                                    unequipAll()
                                    return false
                                end
                                local c4s = getC4s()
                                while #c4s == 0 do
                                    task.wait()
                                    c4s = getC4s()
                                end
                                for i, obj in next, c4s do
                                    if obj and obj:FindFirstChild("StickRemote") and not obj.Stuck.Value then
                                        local rate = i == 1 and 0.2 or 3.2 * i
                                        obj.PrimaryPart.CFrame = torso.CFrame * CFrame.new(rate, -1.5 * rate, rate)
                                        obj.StickRemote:FireServer(torso, obj.PrimaryPart.CFrame:ToObjectSpace(torso.CFrame))
                                    end
                                end
                                task.delay(0.1, function()
                                    unequipAll()
                                    limit += 1
                                    if limit < 3 then
                                        task.delay(0.1, function()
                                            equipC4()
                                            task.delay(0.2, function()
                                                spawnAndStickC4()
                                            end)
                                        end)
                                    else
                                        global.notify("Great! Do not detonate the C4's if you want to kill them. Might take some time!", 5)
                                        local loop
                                        loop = createloop(0, function()
                                            if not target.Character then
                                                loop:disconnect()
                                                loop = nil
                                                for i, obj in next, c4s do
                                                    if obj and obj:FindFirstChild("DetonateRemote")  then
                                                        obj.DetonateRemote:FireServer()
                                                    end
                                                end
                                            end
                                            if target.Character and target.Character.Humanoid and target.Character.Humanoid.Health < 1 then
                                                loop:disconnect()
                                                loop = nil
                                                for i, obj in next, c4s do
                                                    if obj and obj:FindFirstChild("DetonateRemote") then
                                                        obj.DetonateRemote:FireServer()
                                                    end
                                                end
                                            end
                                        end)
                                    end
                                end)
                            end
                            if isHoldingC4() then
                                spawnAndStickC4()
                            else
                                equipC4()
                                task.wait(0.2)
                                spawnAndStickC4()
                            end
                        else
                            global.notify(("Couldn't find player with name `%s`"):format(name), 10)
                        end
                    end
                    isInProcess = false
                end
                global.registry.kill_player = kill_player
            end
            kill()
            local function dick()
                local function dick_player(name)
                    if not ownsC4() then
                        return global.notify("You do not own C4.", 5)
                    end
                    --creds to Nexus42 and Snipehype200
                    if global.ui_status.c4dick_masterswitch then
                        local hasC4 = hasC4InInventory()
                        if not hasC4 then
                            local c4
                            while true do
                                c4 = hasC4InInventory()
                                if c4 then
                                    break
                                end
                                warn("Waiting to equipOwnItem C4 X2")
                                equipOwnedItem("C4")
                                task.wait(0.2)
                            end
                            hasC4 = c4
                        end
                        if hasC4 then
                            if name == player.Name then
                                local target = player
                                if isHoldingC4() then
                                    unequipAll()
                                    task.wait(0.4)
                                    equipC4()
                                    task.wait(0.4)
                                else
                                    equipC4()
                                    task.wait(0.4)
                                end
                                local c4s = getC4s()
                                while #c4s == 0 do
                                    task.wait()
                                    c4s = getC4s()
                                end
                                for i,v in next, c4s do
                                    setC4Pos(target, i, v)
                                    v.PrimaryPart.Anchored = false
                                    task.wait()
                                end
                                table.clear(c4s)
                            else
                                local target = findTarget(name)
                                if target then
                                    if isHoldingC4() then
                                        unequipAll()
                                        task.wait(0.4)
                                        equipC4()
                                        task.wait(0.4)
                                    else
                                        equipC4()
                                        task.wait(0.4)
                                    end
                                    local c4s = getC4s()
                                    while #c4s == 0 do
                                        task.wait()
                                        c4s = getC4s()
                                    end
                                    for i,v in next, c4s do
                                        setC4Pos(target, i, v)
                                        v.PrimaryPart.Anchored = false
                                        task.wait()
                                    end
                                    table.clear(c4s)
                                else
                                    global.notify(("Couldn't find player with name `%s`"):format(name), 10)
                                end
                            end
                            task.wait(1)
                            global.registry.unequipAll()
                        end
                    end
                end
                global.registry.dick_player = dick_player
            end
            dick()
        end
        c4Exploits()
        local function rocketLauncherExploits()
            local hasItemEquipped = global.registry.hasItemEquipped
            local unequipAll = global.registry.unequipAll
            local equip = global.registry.equip
            local equipOwnedItem = global.registry.equipOwnedItem
            local sh = client.modules.seekingMissileShared
            local run = sh._run
            local explode = sh._explode
            local netObjPool = client.modules.netObjPool._constructor
            local get = netObjPool.Get
            local cf = CFrame.new()
            local function ownsItem()
                return table.find(client.reg.resolveOwnedItems, "RocketLauncher")
            end
            local function isInInventory()
                return table.find(client.reg.resolveEquippedItems, "RocketLauncher")
            end
            local function isEquipped()
                return hasItemEquipped("RocketLauncher")
            end
            local function getMissileHolderPool()
                local rL = player.Folder:FindFirstChild("RocketLauncher")
                if rL then
                    local poolHolder = rL:FindFirstChild("RocketLauncherHolderMissilePool")
                    if poolHolder then
                        return poolHolder
                    end
                end
                return false
            end
            local findTarget = global.registry.findTarget
            local function hasRocketAmmo()
                local getEquippedItem = client.reg.getEquippedItem
                return getEquippedItem and getEquippedItem.__ClassName == "RocketLauncher" and getEquippedItem.inventoryItemValue:GetAttribute("AmmoCurrentLocal") or 0
            end
            local function canPurchaseAmmo()
                return player.leaderstats.Money.Value >= 1000
            end
            local function getObjInPool()
                local holder = getMissileHolderPool()
                local obj
                local noPoolError = pcall(function()
                    obj = get({obj = holder}) or nil
                end)
                if not noPoolError then
                    obj = nil
                end
                return obj
            end
            local function launchRocket()
                local getEquippedItem = client.reg.getEquippedItem
                if getEquippedItem and getEquippedItem.__ClassName == "RocketLauncher" then
                    local currentAmmo = getEquippedItem.inventoryItemValue:GetAttribute("AmmoCurrentLocal")
                    getEquippedItem:LaunchRocket(cf, cf.LookVector, 0)
                    task.delay(0.1, function()
                        getEquippedItem.inventoryItemValue:SetAttribute("AmmoCurrentLocal", currentAmmo - 1)
                    end)
                end
            end
            local is_spawning = false
            local target
            local function spawnRocket(_target, shouldInstantExplode)
                assert(_target, "Target is missing")
                if is_spawning then
                    global.notify("Killing is already in process", 3)
                    return false
                end
                if not ownsItem() then
                    return global.notify("You have to own a Rocket Launcher to spawn a rocket", 5)
                end
                is_spawning = true
                if not isInInventory() then
                    while true do
                        if isInInventory() then
                            break
                        end
                        equipOwnedItem("RocketLauncher")
                        task.wait()
                    end
                end
                local objects
                if not isEquipped() then
                    while true do
                        if client.reg.getEquippedItem and client.reg.getEquippedItem.__ClassName == "RocketLauncher" then
                            break
                        end
                        equip("RocketLauncher")
                        task.wait()
                    end
                end
                local tic, reset = tick(), false
                while true do
                    if objects then
                        task.wait()
                        break
                    end
                    objects = getObjInPool()
                    if tick() - tic > 0.2 and not objects then
                        reset = true
                        break
                    end
                    task.wait()
                end
                if reset then
                    unequipAll()
                    while true do
                        if not client.reg.getEquippedItem then
                            break
                        end
                        task.wait()
                    end
                    is_spawning = false
                    spawnRocket(_target, shouldInstantExplode or false)
                    return false
                end
                local getObjInPool = objects
                if not getObjInPool or getObjInPool and not getObjInPool.obj then
                    unequipAll()
                    while true do
                        if not client.reg.getEquippedItem then
                            break
                        end
                        task.wait()
                    end
                    task.wait()
                    while true do
                        if client.reg.getEquippedItem then
                            break
                        end
                        equip("RocketLauncher")
                        task.wait()
                    end
                    task.wait()
                end
                if getObjInPool then
                    local getEquippedItem = client.reg.getEquippedItem
                    target = _target
                    local ammo
                    if shouldInstantExplode then
                        local bool = Instance.new("BoolValue")
                        bool.Name = "ShouldInstantExplode"
                        bool.Parent = getObjInPool.obj
                    else
                        ammo = hasRocketAmmo()
                        if ammo == 0 then
                            if not canPurchaseAmmo() then
                                global.notify("You need at least $1,000 to spawn a rocket.", 5)
                                is_spawning = false
                                return false
                            end
                            equipOwnedItem("RocketAmmo")
                            while true do
                                if ammo > 0 then
                                    break
                                end
                                ammo = hasRocketAmmo()
                                task.wait()
                            end
                        end
                        local bool = Instance.new("BoolValue")
                        bool.Name = "ShouldTrail"
                        bool.Parent = getObjInPool.obj
                    end
                    pcall(launchRocket)
                    is_spawning = false
                else
                    is_spawning = false
                end
            end
            local function spawn_rocket(name, spawnExplosion)
                if not spawnExplosion then
                    if not ownsItem() then
                        return global.notify("You have to own a Rocket Launcher to spawn a rocket", 5)
                    end
                    if hasRocketAmmo() == 0 then
                        if not canPurchaseAmmo() then
                            global.notify("You need at least $1,000 to spawn a rocket.", 5)
                            return false
                        end
                    end
                end
                local target
                local isSelf = false
                if player.Name == name then
                    target = player
                    isSelf = true
                else
                    target = findTarget(name)
                end
                if target then
                    local char = target.Character
                    if char then
                        local primaryPart = char.PrimaryPart
                        local explosion_size = global.ui_status.explosion_size or 1
                        if spawnExplosion then
                            for i=1, explosion_size do
                                spawnRocket(primaryPart, true)
                            end
                        else
                            if not isSelf then
                                local cr = player.Character
                                if cr then
                                    local pp = cr.PrimaryPart
                                    if pp then
                                        if (pp.Position - primaryPart.Position).magnitude > 500 then --@scoate asta mai incolo, nu prea are sens.
                                            return global.notify("Target is too far away! Cannot render Missile", 10)
                                        end
                                    end
                                end
                            end
                            spawnRocket(primaryPart)
                        end
                    else
                        global.notify("Couldn't find target's character.", 10)
                    end
                else
                    global.notify(("Couldn't find player with name `%s`"):format(name), 10)
                end
            end
            global.registry.spawn_rocket = spawn_rocket
            local function explode_hook(missile)
                if missile.obj:FindFirstChild("ShouldInstantExplode") then
                    missile.obj.CFrame = target.CFrame + Vector3.new(math.random(0, 10), 0, math.random(0, 10))
                    return explode(missile)
                end
                if missile.obj:FindFirstChild("ShouldTrail") then
                    return false
                end
                return explode(missile)
            end
            local function run_hook(missile)
                if missile.obj:FindFirstChild("ShouldInstantExplode") then
                    missile.obj.CFrame = target.CFrame + Vector3.new(math.random(0, 10), 0, math.random(0, 10))
                    return explode(missile)
                end
                if missile.obj:FindFirstChild("ShouldTrail") and global.ui_status.rocket_trail then
                    local run_at = tick()
                    local _loop
                    local is_new_connected = false
                    local target = target
                    _loop = createloop(0, function()
                        if is_new_connected then
                            _loop:disconnect()
                            _loop = nil
                            return false
                        end
                        if tick() - run_at > 1.2 then
                            _loop:disconnect()
                            _loop = nil
                            return false
                        end
                        local _tasks = missile.runMaid._tasks
                        _tasks[1] = runservice.Heartbeat:connect(function()
                            if not is_new_connected then
                                is_new_connected = true
                            end
                            if _loop then
                                _loop:disconnect()
                                _loop = nil
                                return false
                            end
                            missile.obj.CFrame = target.CFrame * CFrame.new(0, 0, 5) * CFrame.Angles(math.rad(180), 0, 0)
                        end)
                    end)
                end
                return run(missile)
            end
            sh._run = run_hook
            sh._explode = explode_hook
        end
        rocketLauncherExploits()
        local function placeDynamite()
            local function place_dynamite()
                for i,v in next, client.modules.ui.CircleAction.Specs do
                    if v.Name == "Place Dynamite" and v.Part.Name == "BankDoor" then
                        if v.Enabled then
                            v:Callback(true)
                        end
                    end
                end
            end
            local function loop()
                local getClosestBankDoor = global.registry.getClosestBankDoor
                if getClosestBankDoor(300) then
                    place_dynamite()
                end
            end
            local loopf
            local cache
            local function tagService()
                cache = client.tags.new("placeBankDynamite", 0, false, function(val)
                    if val then
                        loopf = createloop(3, loop)
                    else
                        if loopf then
                            loopf:disconnect()
                            loopf = nil
                        end
                    end
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.auto_place_dynamite
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        placeDynamite()
        local function touchClosestVault()
            --@aici se fute performanta, sa dai recode candva (9.12.2022)
            local function touchVault(part)
                local char = client.playerCharacter
                if not char then
                    return false
                end
                local PrimaryPart = char.PrimaryPart
                if not PrimaryPart then
                    return false
                end
                if char and PrimaryPart then
                    firetouchinterest(PrimaryPart, part, 0)
                    task.wait(0.5)
                    firetouchinterest(PrimaryPart, part, 1)
                end
            end
            local door
            local function loop()
                local getClosestTriggerDoor = global.registry.getClosestTriggerDoor(400)
                if not getClosestTriggerDoor then
                    door = nil
                    return false
                end
                if door ~= getClosestTriggerDoor then
                    door = getClosestTriggerDoor
                end
                if not door then
                    return false
                end
                touchVault(door)
            end
            local loopf
            local cache
            local function tagService()
                cache = client.tags.new("touchVault", 0, false, function(val)
                    if val then
                        loopf = createloop(2, loop)
                    else
                        if loopf then
                            loopf:disconnect()
                            loopf = nil
                            door = nil
                        end
                    end
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.auto_touch_vault
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        touchClosestVault()
        local function resolvePuzzle()
            local flow = getupvalue(client.modules.puzzleFlow.Init,3)
            local resolvePowerplant = global.registry.resolvePowerplant
            local cache
            local upv
            local function tagService()
                cache = client.tags.new("puzzle_resolver", 0, false, function(val)
                    if flow.IsOpen and val then
                        resolvePowerplant(flow)
                    end
                end)
                upv = client.tags.new("flow_IsOpen", 0, false, function(val)
                    if cache.obj.Value and val then
                        resolvePowerplant(flow)
                    end
                end)
            end
            tagService()
            local function loop()
                local isOpen = flow.IsOpen
                if upv then
                    upv.obj.Value = isOpen
                end
                local bool = global.ui_status.puzzle_resolver
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        resolvePuzzle()
        local function museumFillBag()
            local cashLeftBeforeMax = global.registry.cashLeftBeforeMax
            local function grab(player)
                local char = client.playerCharacter
                if not char then
                    return false
                end
                local primarypart = char.PrimaryPart
                if not primarypart then
                    return false
                end
                for i,v in next, client.modules.ui.CircleAction.Specs do
                    if string.find(v.Name, "Grab") then
                        if v.Part:IsDescendantOf(workspace.Museum) and (v.Part.Position - primarypart.Position).magnitude < 10 then
                            v:Callback(true)
                        end
                    end
                end
            end
            local function loop()
                if tostring(player.Team) == "Police" then
                    return false
                end
                local isInMuseum = global.registry.isInMuseum()
                if isInMuseum then
                    grab(player)
                    return true
                end
                return false
            end
            local cache
            local loopf
            local function tagService()
                cache = client.tags.new("fillbag", 0, false, function(val)
                    if val then
                        loopf = createloop(1, loop)
                    else
                        if loopf then
                            loopf:disconnect()
                            loopf = nil
                        end
                    end
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.auto_fill_bag
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        museumFillBag()
        local function hackClosestComputer()
            local function hackComputer()
                for i,v in next, client.modules.ui.CircleAction.Specs do
                    if v.Name == "Hack" or v.Name == "Disable Vault Security" then
                        v:Callback(true)
                    end
                end
            end
            local function loop()
                local bool = global.ui_status.hack_nearby_computers
                if bool then
                    local getClosestComputer = global.registry.getClosestComputer
                    if getClosestComputer(20) then
                        hackComputer()
                    end
                end
            end
            createloop(0.5, loop)
        end
        hackClosestComputer()
        local function cargoPlaneCorrection()
            local function autoCollectPlaneCrate()
                local function collectCrate(crate)
                    for i,v in next, client.modules.ui.CircleAction.Specs do
                        if v.Name == "Inspect Crate" and v.Part == crate then
                            v:Callback(true)
                        end
                    end
                end
                local function loop()
                    local bool = global.ui_status.automatic_inspect_crate
                    if bool then
                        local getClosestCrate = global.registry.getClosestCrate()
                        if getClosestCrate then
                            collectCrate(getClosestCrate)
                        end
                    end
                end
                createloop(1, loop)
            end
            autoCollectPlaneCrate()
            local function automaticOpenPlaneDoor()
                local function openDoor()
                    for i,v in next, client.modules.ui.CircleAction.Specs do
                        if v.Name == "Open Door" then
                            if v.Part.Name == "Lever" then
                                v:Callback(true)
                                break
                            end
                        end
                    end
                end
                local function doorLogic()
                    local getEquippedItem = client.reg.getEquippedItem
                    if getEquippedItem then
                        if getEquippedItem.__ClassName == "Crate" then
                            openDoor()
                        end
                    end
                end
                local function loop()
                    local bool = global.ui_status.automatic_open_cargoplane_door
                    if bool then
                        doorLogic()
                    end
                end
                createloop(1, loop)
            end
            automaticOpenPlaneDoor()
        end
        cargoPlaneCorrection()
        local function autoCollectCasinoLoot()
            local cashLeftBeforeMax = global.registry.cashLeftBeforeMax
            local function collectCash()
                for i,v in next, client.modules.ui.CircleAction.Specs do
                    if string.find(v.Name, "Collect") then
                        v:Callback(true)
                    end
                end
            end
            local function loop()
                if tostring(player.Team) == "Police" then
                    return false
                end
                local bool = global.ui_status.auto_collect_cash
                if bool then
                    local getClosestCasinoLoot = global.registry.getClosestCasinoLoot
                    if getClosestCasinoLoot(20) then
                        collectCash()
                    end
                end
            end
            createloop(1, loop)
        end
        autoCollectCasinoLoot()
        local function collectClosestCash()
            local function collectCash(droppedcash)
                for i,v in next, client.modules.ui.CircleAction.Specs do
                    if string.find(v.Name, "Collect") and string.find(v.Name, "from") and v.Part == droppedcash then
                        v:Callback(droppedcash, true)
                        break
                    end
                end
            end
            local function loop()
                local bool = global.ui_status.droppedcashaura
                if bool then
                    local range = global.ui_status.droppedcashrange
                    local getClosestDroppedCash = global.registry.getClosestDroppedCash
                    if getClosestDroppedCash then
                        local droppedCash = getClosestDroppedCash(range)
                        if droppedCash then
                            collectCash(droppedCash)
                        end
                    end
                end
            end
            createloop(0.2, loop)
        end
        collectClosestCash()
        local function damageDealersCorrection()
            --@doamne ajuta functiuna asta ca e cea mai proasta pe care am scris o vreo data.
            local function lasers()
                local function hookForBank(bool)
                    for i,v in next, collectionservice:GetAllTags() do
                        for i2,v2 in next, collectionservice:GetTagged(v) do
                            if workspace:FindFirstChild("Banks") and v2:IsDescendantOf(workspace.Banks) and v2:FindFirstChild("TouchInterest") then
                                v2.CanTouch = not bool
                            end
                        end
                    end
                end
                local function hookForTrain(bool)
                    for i,v in next, collectionservice:GetAllTags() do
                        for i2,v2 in next, collectionservice:GetTagged(v) do
                            if v2:IsDescendantOf(workspace.Trains) and v2:FindFirstChild("TouchInterest") then
                                v2.CanTouch = not bool
                            end
                        end
                    end
                end
                local function hookForJewelry(bool)
                    for i,v in next, collectionservice:GetAllTags() do
                        for i2,v2 in next, collectionservice:GetTagged(v) do
                            if workspace:FindFirstChild("Jewelrys") and v2:IsDescendantOf(workspace.Jewelrys) and v2:FindFirstChild("TouchInterest") and v2.Name ~= "LaserTouch" then
                                v2.CanTouch = not bool
                            end
                        end
                    end
                end
                local function hookForMansion(bool)
                    for i,v in next, workspace.MansionRobbery.Lasers:GetDescendants() do
                        if v.Name == "Laser" then
                            v.CanTouch = not bool
                        end
                    end
                end
                local function breakCasinoLasers(bool)
                    local casino = workspace:FindFirstChild("Casino")
                    if casino then
                        local vaultLaserControl = casino:FindFirstChild("VaultLaserControl")
                        if vaultLaserControl then
                            for i,v in next, vaultLaserControl:GetDescendants() do
                                if v:FindFirstChild("TouchInterest") then
                                    v.CanTouch = not bool
                                end
                            end
                        end
                        local lasersMoving = casino:FindFirstChild("LasersMoving")
                        if lasersMoving then
                            for i,v in next, lasersMoving:GetDescendants() do
                                if v:FindFirstChild("TouchInterest") then
                                    v.CanTouch = not bool
                                end
                            end
                        end
                        local laserCarousel = casino:FindFirstChild("LaserCarousel")
                        if laserCarousel then
                            for i,v in next, laserCarousel:GetDescendants() do
                                if v:FindFirstChild("TouchInterest") then
                                    v.CanTouch = not bool
                                end
                            end
                        end
                        local lasers = casino:FindFirstChild("Lasers")
                        if lasers then
                            for i,v in next, lasers:GetDescendants() do
                                if v:FindFirstChild("TouchInterest") then
                                    v.CanTouch = not bool
                                end
                            end
                        end
                    end
                end
                global.registry.breakCasinoLasers = breakCasinoLasers
                local function breakLasers(bool)
                    for i,v in next, workspace:GetDescendants() do
                        if v.Name == "BarbedWire" then
                            v.CanTouch = not bool
                        end
                    end
                end
                local cache
                local function bank()
                    hookForBank(not cache.obj.Value)
                    task.wait(1)
                    hookForBank(cache.obj.Value)
                end
                local function jewelry()
                    hookForJewelry(not cache.obj.Value)
                    task.wait(1)
                    hookForJewelry(cache.obj.Value)
                end
                local function mansion()
                    hookForMansion(not cache.obj.Value)
                    task.wait(1)
                    hookForMansion(cache.obj.Value)
                end
                local function train(child)
                    for i,v in next, child:GetDescendants() do
                        if v:FindFirstChild("TouchInterest") then
                            hookForTrain(not cache.obj.Value)
                            task.wait(1)
                            hookForTrain(cache.obj.Value)
                        end
                    end
                end
                local function onCasinoSpawned()
                    breakLasers(not cache.obj.Value)
                    task.wait(1)
                    breakLasers(cache.obj.Value)
                end
                local function mansionRobberyLasers(bool)
                    if workspace.MansionRobbery.InRobberyFolder:FindFirstChild(player.UserId) then
                        for i,v in next, workspace.MansionRobbery.Lasers:GetDescendants() do
                            if v:IsA("BasePart") then
                                v.CanTouch = not global.ui_status.disable_lasers
                            end
                        end
                    end
                end
                local loopf
                local function tagService()
                    cache = client.tags.new("lasers", 0, false, function(val)
                        breakLasers(val)
                        hookForBank(val)
                        hookForJewelry(val)
                        hookForTrain(val)
                        hookForMansion(val)
                        if loopf then
                            loopf:disconnect()
                            loopf = nil
                        else
                            loopf = createloop(0.5, function()
                                mansionRobberyLasers(val)
                            end)
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.disable_lasers
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
                local function workspaceChildAdded(obj)
                    local barbedWire = obj:FindFirstChild("BarbedWire", true)
                    if barbedWire then
                        barbedWire.CanTouch = cache.obj.Value
                        task.delay(0.1, function()
                            barbedWire.CanTouch = not cache.obj.Value
                        end)
                    end
                    if obj.Name == "BarbedWire" then
                        obj.CanTouch = cache.obj.Value
                        task.delay(0.1, function()
                            obj.CanTouch = not cache.obj.Value
                        end)
                    end
                    if obj:IsA("Model") then
                        for i,v in next, obj:GetDescendants() do
                            if v.Name == "BarbedWire" then
                                v.CanTouch = not cache.obj.Value
                            end
                        end
                    end
                    local Model = obj:FindFirstChild("Model", true)
                    if Model then
                        local barbedWire = Model:FindFirstChild("BarbedWire", true)
                        if barbedWire then
                            for i2,v2 in next, Model:GetChildren() do
                                if v2:IsA("Part") then
                                    v2.CanTouch = not cache.obj.Value
                                end
                            end
                        end
                    end
                    if obj.Name == "Banks" then
                        workspace.Banks.ChildAdded:connect(function(obj)
                            local bank1 = workspace.Banks:FindFirstChild("Bank")
                            if bank1 then
                                local layout = bank1:FindFirstChild("Layout")
                                if layout then
                                    layout.ChildAdded:connect(bank)
                                end
                            end
                            local bank2 = workspace.Banks:FindFirstChild("Bank2")
                            if bank2 then
                                local layout = bank2:FindFirstChild("Layout")
                                if layout then
                                    layout.ChildAdded:connect(bank2)
                                end
                            end
                        end)
                    end
                    if obj.Name == "Jewelrys" then
                        workspace.Jewelrys.ChildAdded:connect(function(obj)
                            workspace.Jewelrys:GetChildren()[1]:FindFirstChild("Floors").ChildAdded:connect(jewelry)
                        end)
                    end
                    if obj.Name == "Casino" then
                        onCasinoSpawned()
                        breakCasinoLasers(cache.obj.Value)
                    end
                    if obj.Name == "MansionRobbery" then
                        mansion()
                        workspace.MansionRobbery.Lasers.Changed:connect(mansion)
                    end
                end
                if workspace:FindFirstChild("Banks") then
                    local bank1 = workspace.Banks:FindFirstChild("Bank")
                    if bank1 then
                        bank1:FindFirstChild("Layout").ChildAdded:connect(bank)
                    end
                    local bank2 = workspace.Banks:FindFirstChild("Bank2")
                    if bank2 then
                        bank2:FindFirstChild("Layout").ChildAdded:connect(bank)
                    end
                end
                if workspace:FindFirstChild("Jewelrys") then
                    local getFirstChild = workspace.Jewelrys:GetChildren()[1]
                    if getFirstChild then
                        getFirstChild:FindFirstChild("Floors").ChildAdded:connect(jewelry)
                    end
                end
                if workspace:FindFirstChild("Casino") then
                    onCasinoSpawned()
                    breakCasinoLasers(cache.obj.Value)
                end
                if workspace:FindFirstChild("MansionRobbery") then
                    workspace.MansionRobbery.Lasers.Changed:connect(mansion)
                end
                table.insert(client.onWorkspaceSpawnRun, {
                    _fn = workspaceChildAdded
                })
                workspace.Trains.ChildAdded:connect(train)
            end
            lasers()
            local function powerplant()
                local function powerplant_piston()
                    local piston = client.modules.piston.SlamPlayer
                    local function hook(...)
                        local bool = global.ui_status.disable_piston_damage
                        if bool then
                            return task.wait(9e9)
                        end
                        return piston(...)
                    end
                    client.modules.piston.SlamPlayer = hook
                end
                powerplant_piston()
                local function powerplant_powerwire()
                    local function breakPowerwire(bool)
                        for i,v in next, workspace.PowerPlant:GetDescendants() do
                            if v.Name == "PowerWire" then
                                v.CanTouch = not bool
                            end
                        end
                    end
                    local cache
                    local function tagService()
                        cache = client.tags.new("powerwire", 0, false, function(val)
                            breakPowerwire(val)
                        end)
                    end
                    tagService()
                    local function forceChange()
                        breakPowerwire(not cache.obj.Value)
                        task.wait(0.1)
                        breakPowerwire(cache.obj.Value)
                    end
                    local function onConnection()
                        local flow = getupvalue(client.modules.puzzleFlow.Init,3)
                        local onConnection = flow.OnConnection
                        local isFirstTime = true
                        local function hook(...)
                            if isFirstTime then
                                local getTagByName = client.tags:getTagByName("lasers")
                                for i,v in next, workspaceChildren do
                                    local Model = v:FindFirstChild("Model", true)
                                    if Model then
                                        local barbedWire = Model:FindFirstChild("BarbedWire", true)
                                        if barbedWire then
                                            for i2,v2 in next, Model:GetChildren() do
                                                v2.CanTouch = not getTagByName.obj.Value
                                            end
                                            isFirstTime = false
                                            break
                                        end
                                    end
                                end
                            end
                            return onConnection(...)
                        end
                        flow.OnConnection = hook
                    end
                    onConnection()
                    local function onPowerPlantAdded(obj)
                        if obj.Name == "PowerPlant" then
                            forceChange()
                        end
                    end
                    table.insert(client.onWorkspaceSpawnRun, {
                        _fn = onPowerPlantAdded
                    })
                    local function loop()
                        local bool = global.ui_status.disable_powerwire_damage
                        if cache then
                            cache.obj.Value = bool
                        end
                    end
                    createloop(0, loop)
                end
                powerplant_powerwire()
            end
            powerplant()
            local function tomb()
                local function resolver()
                    local function isLocalNearbyTeleporter()
                        local robberyTomb = workspace:FindFirstChild("RobberyTomb")
                        if not robberyTomb then
                            return false
                        end
                        local Top = robberyTomb.DartRoom.Teleporter:FindFirstChild("Top")
                        if Top then
                            local char = client.playerCharacter
                            if char then
                                local root = char:FindFirstChild("HumanoidRootPart")
                                if root then
                                    if (Top.Position - root.Position).magnitude < 10 then
                                        root.CFrame = Top.CFrame
                                        return true
                                    elseif (Top.Position - root.Position).magnitude < 30 then
                                        global.notify("Automatically resolving Dart Room... Do not move!", 5)
                                    end
                                end 
                            end
                        end
                        return false
                    end
                    local isTeleporting = false
                    local function teleportToEveryPillar()
                        if isTeleporting then
                            return false
                        end
                        if not isLocalNearbyTeleporter() then
                            return false
                        end
                        local char = client.playerCharacter
                        if char then
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if root then
                                isTeleporting = true
                                for i=1, 27 do
                                    task.wait(0.2)
                                    if i == 27 then
                                        isTeleporting = false
                                        break
                                    end
                                    local pos = workspace.RobberyTomb.DartRoom.Pillars:FindFirstChild(tostring(i)).InnerModel.Platform.CFrame
                                    root.CFrame = pos + Vector3.new(0, 1, 0)
                                end
                            end
                        end
                    end
                    local function loop()
                        if not isTeleporting and isLocalNearbyTeleporter() then
                            teleportToEveryPillar()
                        end
                    end
                    local cache
                    local loopf
                    local function tagService()
                        cache = client.tags.new("automaticresolvedart", 0, false, function(val)
                            if val then
                                loopf = createloop(0.1, loop)
                            else
                                if loopf then
                                    loopf:disconnect()
                                    loopf = nil
                                end
                            end
                        end)
                    end
                    tagService()
                    local function loop()
                        local bool = global.ui_status.automatic_resolve_dart_room
                        if cache then
                            cache.obj.Value = bool
                        end
                    end
                    createloop(0, loop)
                end
                resolver()
                local function darts()
                    local dartFire = client.modules.dartDispenser._fire
                    local function hook(...)
                        local bool = global.ui_status.disable_darts
                        if bool then
                            return task.wait(9e9)
                        end
                        return dartFire(...)
                    end
                    client.modules.dartDispenser._fire = hook
                end
                darts()
                local function wood()
                    local function breakWoods(bool)
                        for i,v in next, workspace.RobberyTomb.Cart.Planks:GetDescendants() do
                            if v.Name == "Wood" then
                                v.CanTouch = not bool
                            end
                        end
                    end
                    local cache
                    local function tagService()
                        cache = client.tags.new("wood", 0, false, function(val)
                            breakWoods(val)
                        end)
                    end
                    tagService()
                    local function forceChange()
                        breakWoods(not cache.obj.Value)
                        task.wait(0.1)
                        breakWoods(cache.obj.Value)
                    end
                    local function robberyTombAdded(obj)
                        if obj.Name == "RobberyTomb" then
                            forceChange()
                        end
                    end
                    table.insert(client.onWorkspaceSpawnRun, {
                        _fn = robberyTombAdded
                    })
                    local function loop()
                        local bool = global.ui_status.disable_wood
                        if cache then
                            cache.obj.Value = bool
                        end
                    end
                    createloop(0, loop)
                end
                wood()
                local function spikes()
                    local function breakSpikes(bool)
                        for i,v in next, workspace.RobberyTomb.SpikeRoom:GetDescendants() do
                            if v.Name == "Door" then
                                v.CanTouch = not bool
                            end
                        end
                    end
                    local cache
                    local function tagService()
                        cache = client.tags.new("spikes", 0, false, function(val)
                            breakSpikes(val)
                        end)
                    end
                    tagService()
                    local function forceChange()
                        breakSpikes(not cache.obj.Value)
                        task.wait(0.1)
                        breakSpikes(cache.obj.Value)
                    end
                    local function robberyTombAdded(obj)
                        if obj.Name == "RobberyTomb" then
                            forceChange()
                        end
                    end
                    table.insert(client.onWorkspaceSpawnRun, {
                        _fn = robberyTombAdded
                    })
                    local function loop()
                        local bool = global.ui_status.disable_spikes
                        if cache then
                            cache.obj.Value = bool
                        end
                    end
                    createloop(0, loop)
                end
                spikes()
                local function lava()
                    local function breakLava(bool)
                        for i,v in next, workspace.RobberyTomb.Kill:GetDescendants() do
                            if v.Name == "LavaKill" then
                                v.CanTouch = not bool
                            end
                        end
                    end
                    local cache
                    local function tagService()
                        cache = client.tags.new("lava", 0, false, function(val)
                            breakLava(val)
                        end)
                    end
                    tagService()
                    local function forceChange()
                        breakLava(not cache.obj.Value)
                        task.wait(0.1)
                        breakLava(cache.obj.Value)
                    end
                    local function robberyTombAdded(obj)
                        if obj.Name == "RobberyTomb" then
                            forceChange()
                        end
                    end
                    table.insert(client.onWorkspaceSpawnRun, {
                        _fn = robberyTombAdded
                    })
                    local function loop()
                        local bool = global.ui_status.disable_lava
                        if cache then
                            cache.obj.Value = bool
                        end
                    end
                    createloop(0, loop)
                end
                lava()
            end
            tomb()
            local function cameras()
                local function breakLights(bool)
                    local museum = workspace:FindFirstChild("Museum")
                    if museum then
                        local lights = museum.Lights
                        if lights then
                            for i,v in next, lights:GetDescendants() do
                                if v.Name == "Light" then
                                    v.CanTouch = not bool
                                end
                            end
                        end
                    end
                    local casino = workspace:FindFirstChild("Casino")
                    if casino then
                        local camerasMoving = casino.CamerasMoving
                        if camerasMoving then
                            for i,v in next, camerasMoving:GetDescendants() do
                                if v.Name == "Part" then
                                    v.CanTouch = not bool
                                end
                            end
                        end
                    end
                    local jewelrys = workspace:FindFirstChild("Jewelrys")
                    if jewelrys then
                        if #jewelrys:GetChildren() > 0 then 
                            local floors = jewelrys:GetChildren()[1].Floors
                            if floors then
                                for i,v in next, floors:GetDescendants() do
                                    if v.Name == "Part" then
                                        v.CanTouch = not bool
                                    end
                                end
                            end
                        end
                    end
                end
                local cache
                local function tagService()
                    cache = client.tags.new("cameras", 0, false, function(val)
                        breakLights(val)
                    end)
                end
                tagService()
                local function changeOnChildAdded()
                    task.wait(0.1)
                    breakLights(not cache.obj.Value)
                    task.wait(0.1)
                    breakLights(cache.obj.Value)
                end
                local function onAddedWorkspace(obj)
                    if obj.Name == "Jewelrys" then
                        changeOnChildAdded()
                        workspace.Jewelrys:GetChildren()[1]:FindFirstChild("Floors").ChildAdded:connect(changeOnChildAdded)
                    end
                    if obj.Name == "Museum" then
                        changeOnChildAdded()
                    end
                    if obj.Name == "Casino" then
                        changeOnChildAdded()
                    end
                end
                table.insert(client.onWorkspaceSpawnRun, {
                    _fn = onAddedWorkspace
                })
                if workspace:FindFirstChild("Jewelrys") then
                    local findFirstChild = workspace.Jewelrys:GetChildren()[1]
                    if findFirstChild then
                        findFirstChild:FindFirstChild("Floors").ChildAdded:connect(changeOnChildAdded)
                    end
                end
                local function loop()
                    local bool = global.ui_status.disable_cameras
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            cameras()
        end
        damageDealersCorrection()
        local function robberyStatusCorrection()
            local getRobbery = global.registry.getRobberyStatus
            local function getRobberyStatus(key)
                if key == "airdrop" then
                    return workspace:FindFirstChild("Drop") ~= nil
                end
                key = key:upper()
                local status = getRobbery(key)
                if status == "OPENED" then
                    return true
                end
                if status == "STARTED" then
                    return 0
                end
                return false
            end
            local cache
            local function tagService()
                cache = client.tags.new("casino_status", 0, false, function(val)
                    local breakCasinoLasers = global.registry.breakCasinoLasers
                    if breakCasinoLasers then
                        breakCasinoLasers(val)
                    end
                end)
            end
            tagService()
            local openColor = Color3.fromRGB(178, 255, 104)
            local startedColor = Color3.fromRGB(255, 178, 102)
            local closedColor = Color3.fromRGB(255, 102, 102)
            local status = {
                start = "Status: Started";
                open = "Status: Open";
                closed = "Status: Closed";
            }
            local function loop()
                local statusRobberies = global.ui.statusRobberies
                local colorForcing = global.ui.colorForcing
                if statusRobberies["Bank Status"] then
                    local getBankStatus = getRobberyStatus("bank")
                    if getBankStatus == 0 then
                        statusRobberies["Bank Status"] = "Rising City: Started"
                        colorForcing["Bank Status"] = startedColor
                    elseif getBankStatus then
                        statusRobberies["Bank Status"] = "Rising City: Open"
                        colorForcing["Bank Status"] = openColor
                    elseif not getBankStatus then
                        statusRobberies["Bank Status"] = "Rising City: Closed"
                        colorForcing["Bank Status"] = closedColor
                    end
                end
                if statusRobberies["BANK2_ROBBERY_STATUS"] then
                    local getBank2Status = getRobberyStatus("BANK2")
                    if getBank2Status == 0 then
                        statusRobberies["BANK2_ROBBERY_STATUS"] = "Crater City: Started"
                        colorForcing["BANK2_ROBBERY_STATUS"] = startedColor
                    elseif getBank2Status then
                        statusRobberies["BANK2_ROBBERY_STATUS"] = "Crater City: Open"
                        colorForcing["BANK2_ROBBERY_STATUS"] = openColor
                    elseif not getBank2Status then
                        statusRobberies["BANK2_ROBBERY_STATUS"] = "Crater City: Closed"
                        colorForcing["BANK2_ROBBERY_STATUS"] = closedColor
                    end
                end
                if statusRobberies["Museum Status"] then
                    local getMuseumStatus = getRobberyStatus("museum")
                    if getMuseumStatus == 0 then
                        statusRobberies["Museum Status"] = status.start
                        colorForcing["Museum Status"] = startedColor
                    elseif getMuseumStatus then
                        statusRobberies["Museum Status"] = status.open
                        colorForcing["Museum Status"] = openColor
                    elseif not getMuseumStatus then
                        statusRobberies["Museum Status"] = status.closed
                        colorForcing["Museum Status"] = closedColor
                    end
                end
                if statusRobberies["Jewelry Status"] then
                    local getJewelryStatus = getRobberyStatus("jewelry")
                    if getJewelryStatus == 0 then
                        statusRobberies["Jewelry Status"] = status.start
                        colorForcing["Jewelry Status"] = startedColor
                    elseif getJewelryStatus then
                        statusRobberies["Jewelry Status"] = status.open
                        colorForcing["Jewelry Status"] = openColor
                    elseif not getJewelryStatus then
                        statusRobberies["Jewelry Status"] = status.closed
                        colorForcing["Jewelry Status"] = closedColor
                    end
                end
                if statusRobberies["Casino Status"] then
                    local getCasinoStatus = getRobberyStatus("casino")
                    if cache then
                        if global.ui_status.disable_lasers then
                            local status = getCasinoStatus or getCasinoStatus == 0 and true or false
                            cache.obj.Value = status
                        else
                            cache.obj.Value = false
                        end
                    end
                    if getCasinoStatus == 0 then
                        statusRobberies["Casino Status"] = status.start
                        colorForcing["Casino Status"] = startedColor
                    elseif getCasinoStatus then
                        statusRobberies["Casino Status"] = status.open
                        colorForcing["Casino Status"] = openColor
                    elseif not getCasinoStatus then
                        statusRobberies["Casino Status"] = status.closed
                        colorForcing["Casino Status"] = closedColor
                    end
                end
                if statusRobberies["Trains Status"] then
                    local getTrainStatus = getRobberyStatus("train_passenger") or getRobberyStatus("train_cargo")
                    if getTrainStatus == 0 then
                        statusRobberies["Trains Status"] = status.start
                        colorForcing["Trains Status"] = startedColor
                    elseif getTrainStatus then
                        statusRobberies["Trains Status"] = status.open
                        colorForcing["Trains Status"] = openColor
                    else
                        statusRobberies["Trains Status"] = status.closed
                        colorForcing["Trains Status"] = closedColor
                    end
                end
                if statusRobberies["Airdrop Status"] then
                    local getAirdropStatus = getRobberyStatus("airdrop")
                    if getAirdropStatus then
                        statusRobberies["Airdrop Status"] = status.open
                        colorForcing["Airdrop Status"] = openColor
                    elseif not getAirdropStatus then
                        statusRobberies["Airdrop Status"] = status.closed
                        colorForcing["Airdrop Status"] = closedColor
                    end
                end
                if statusRobberies["Tomb Status"] then
                    local getTombStatus = getRobberyStatus("tomb")
                    if getTombStatus == 0 then
                        statusRobberies["Tomb Status"] = status.start
                        colorForcing["Tomb Status"] = startedColor
                    elseif getTombStatus then
                        statusRobberies["Tomb Status"] = status.open
                        colorForcing["Tomb Status"] = openColor
                    elseif not getTombStatus then
                        statusRobberies["Tomb Status"] = status.closed
                        colorForcing["Tomb Status"] = closedColor
                    end
                end
                if statusRobberies["Cargoplane Status"] then
                    local getCargoplaneStatus = getRobberyStatus("cargo_plane")
                    if getCargoplaneStatus == 0 then
                        statusRobberies["Cargoplane Status"] = status.start
                        colorForcing["Cargoplane Status"] = startedColor
                    elseif getCargoplaneStatus then
                        statusRobberies["Cargoplane Status"] = status.open
                        colorForcing["Cargoplane Status"] = openColor
                    elseif not getCargoplaneStatus then
                        statusRobberies["Cargoplane Status"] = status.closed
                        colorForcing["Cargoplane Status"] = closedColor
                    end
                end
                if statusRobberies["Banktruck Status"] then
                    local getBankTruckStatus = getRobberyStatus("money_truck")
                    if getBankTruckStatus == 0 then
                        statusRobberies["Banktruck Status"] = status.start
                        colorForcing["Banktruck Status"] = startedColor
                    elseif getBankTruckStatus then
                        statusRobberies["Banktruck Status"] = status.open
                        colorForcing["Banktruck Status"] = openColor
                    elseif not getCargoplaneStatus then
                        statusRobberies["Banktruck Status"] = status.closed
                        colorForcing["Banktruck Status"] = closedColor
                    end
                end
                if statusRobberies["Powerplant Status"] then
                    local getPowerplantStatus = getRobberyStatus("power_plant")
                    if getPowerplantStatus == 0 then
                        statusRobberies["Powerplant Status"] = status.start
                        colorForcing["Powerplant Status"] = startedColor
                    elseif getPowerplantStatus then
                        statusRobberies["Powerplant Status"] = status.open
                        colorForcing["Powerplant Status"] = openColor
                    elseif not getPowerplantStatus then
                        statusRobberies["Powerplant Status"] = status.closed
                        colorForcing["Powerplant Status"] = closedColor
                    end
                end
                if statusRobberies["Cargoship Status"] then
                    local getCargoshipStatus = getRobberyStatus("cargo_ship")
                    if getCargoshipStatus == 0 then
                        statusRobberies["Cargoship Status"] = status.start
                        colorForcing["Cargoship Status"] = startedColor
                    elseif getCargoshipStatus then
                        statusRobberies["Cargoship Status"] = status.open
                        colorForcing["Cargoship Status"] = openColor
                    elseif not getCargoshipStatus then
                        statusRobberies["Cargoship Status"] = status.closed
                        colorForcing["Cargoship Status"] = closedColor
                    end
                end
                if statusRobberies["Mansion Status"] then
                    local getMansionStatus = getRobberyStatus("mansion")
                    if getMansionStatus == 0 then
                        statusRobberies["Mansion Status"] = status.start
                        colorForcing["Mansion Status"] = startedColor
                    elseif getMansionStatus then
                        statusRobberies["Mansion Status"] = status.open
                        colorForcing["Mansion Status"] = openColor
                    elseif not getMansionStatus then
                        statusRobberies["Mansion Status"] = status.closed
                        colorForcing["Mansion Status"] = closedColor
                    end
                end
                if statusRobberies["Donut Shop"] then
                    local getDonutShopStatus = getRobberyStatus("store_donut")
                    if getDonutShopStatus == 0 then
                        statusRobberies["Donut Shop"] = ("%s"):format("Donut Shop: Started")
                        colorForcing["Donut Shop"] = startedColor
                    elseif getDonutShopStatus then
                        statusRobberies["Donut Shop"] = ("%s"):format("Donut Shop: Opened")
                        colorForcing["Donut Shop"] = openColor
                    elseif not getDonutShopStatus then
                        statusRobberies["Donut Shop"] = ("%s"):format("Donut Shop: Closed")
                        colorForcing["Donut Shop"] = closedColor
                    end
                end
                if statusRobberies["Gas Station"] then
                    local getGasStationStatus = getRobberyStatus("store_gas")
                    if getGasStationStatus == 0 then
                        statusRobberies["Gas Station"] = ("%s"):format("Gas Station: Started")
                        colorForcing["Gas Station"] = startedColor
                    elseif getGasStationStatus then
                        statusRobberies["Gas Station"] = ("%s"):format("Gas Station: Opened")
                        colorForcing["Gas Station"] = openColor
                    elseif not getGasStationStatus then
                        statusRobberies["Gas Station"] = ("%s"):format("Gas Station: Closed")
                        colorForcing["Gas Station"] = closedColor
                    end
                end
            end
            createloop(0, loop)
        end
        robberyStatusCorrection()
        local function minimapCorrection()
            local function noFlash()
                local roact = client.modules.roact
                local minimapService = client.modules.minimapService
                local isVulnerable = global.registry.isVulnerable
                local function loop()
                    local bool = global.ui_status.disable_minimap_flash
                    for i,v in next, minimapService.points do
                        local plr = players:FindFirstChild(v.name)
                        if plr then
                            if isVulnerable(player.Team, plr.Team) then
                                v.flash = not bool
                            end
                        end
                    end
                end
                createloop(1, loop)
            end
            noFlash()
        end
        minimapCorrection()
        local function radioCorrection()
            local actionButtonService = client.modules.actionButtonService
            task.spawn(function()
                for i,v in next, actionButtonService.active do
                    if table.find(v.keyCodes, Enum.KeyCode.R) and v._groupKey == "outer" then
                        local onPressed = v.onPressed   
                        v.onPressed = function(...)
                            if global.ui_status.disable_radio_keybind then
                                return task.wait(9e9)
                            end
                            return onPressed(...)
                        end
                    end
                end
            end)
        end
        radioCorrection()
        local function givingCorrection()
            local isProjectile = global.registry.isProjectile
            local function always_equip()
                local equipOwnedItem = global.registry.equipOwnedItem
                local function loop()
                    local bool = global.ui_status.always_equip_owned_guns
                    if bool then
                        if not client.playerCharacter then
                            return false
                        end
                        if global.is_instant_reloading then
                            return false
                        end
                        if global.ui_status.spam_drop_guns then
                            return false
                        end
                        local resolveOwnedItems = client.reg.resolveOwnedItems
                        local resolveEquippedItems = client.reg.resolveEquippedItems
                        for i,v in next, resolveOwnedItems do
                            if not table.find(resolveEquippedItems, v) and not isProjectile(v) then
                                equipOwnedItem(v)
                            end
                        end
                    end
                end
                createloop(0.5, loop)
            end
            always_equip()
            local function dropdown()
                local isProjectile = global.registry.isProjectile
                local config = global.config
                local function assignGuns()
                    local cfg = config.equip_guns
                    local list = {}
                    for i,v in next, client.reg.resolveOwnedItems do
                        if not isProjectile(v) then
                            table.insert(list, v)
                        end
                    end
                    cfg.list = list
                    task.delay(0.2, function()
                        cfg.reload(cfg.list)
                    end)
                end
                assignGuns()
                local function onNewItem(obj)
                    if isProjectile(obj.Name) then
                        return false
                    end
                    local cfg = config.equip_guns
                    cfg.list = {obj.Name}
                    task.delay(0.2, function()
                        cfg.reload(cfg.list)
                    end)
                end
                local items = player.Items or player:WaitForChild("Items")
                items.ChildAdded:connect(onNewItem)
            end
            dropdown()
        end
        givingCorrection()
        local function jewelryCorrection()
            local function isInJewelry()
                local getPartsInRegion = global.registry.getPartsInRegion
                local char = client.playerCharacter
                if char then
                    local primarypart = char.PrimaryPart
                    if primarypart then
                        local tbl = {
                            x = {
                                max = 156;
                                min = 103;
                            };
                            y = {
                                max = 70;
                                min = 15;
                            };
                            z = {
                                max = 1350;
                                min = 1265;
                            };
                        }
                        local pos = {
                            x = primarypart.Position.x;
                            y = primarypart.Position.y;
                            z = primarypart.Position.z;
                        }
                        local getPartsInRegion = getPartsInRegion(pos.x, pos.y, pos.z, tbl.x.min, tbl.y.min, tbl.z.min, tbl.x.max, tbl.y.max, tbl.z.max)
                        if getPartsInRegion then
                            return true
                        end
                    end
                end
                return false
            end
            local function grabGems()
                local function loop()
                    if tostring(player.Team) == "Police" then
                        return false
                    end
                    local bool = global.ui_status.automatic_grab_nearby_jewels
                    if bool then
                        local isInJewelry = isInJewelry()
                        if isInJewelry then
                            if workspace:FindFirstChild("Jewelrys") then
                                for i,v in next, client.modules.ui.CircleAction.Specs do
                                    if v.Name == "Grab Jewel" and v.Part:IsDescendantOf(workspace.Jewelrys) then
                                        v:Callback(true)
                                    end
                                end
                            end
                        end
                    end
                end
                createloop(0.2, loop)
            end
            grabGems()
            local function automaticPunch()
                local getPartsInRegion = global.registry.getPartsInRegion
                local parts = {}
                local function scanParts()
                    local scan = {"Head", "RightLowerArm", "RightUpperArm", "LeftLowerArm", "LeftUpperArm"}
                    local function onCharacterAdded(char)
                        for i=1, #scan do
                            local v = scan[i]
                            local part = char:WaitForChild(v)
                            if part then
                                table.insert(parts, part)
                            end
                        end
                    end
                    player.CharacterAdded:connect(onCharacterAdded)
                    local function onCharacterRemoving(char)
                        for i=1, #parts do
                            table.remove(parts, i)
                        end
                    end
                    player.CharacterRemoving:connect(onCharacterRemoving)
                    local char = client.playerCharacter
                    if char then
                        for i,v in next, char:GetChildren() do
                            if table.find(scan, v.Name) then
                                table.insert(parts, v)
                            end
                        end
                    end
                end
                scanParts()
                local function getJewelrys()
                    return workspace:FindFirstChild("Jewelrys")
                end
                local function getJewelryModel()
                    local getJewelrys = getJewelrys()
                    if not getJewelrys then
                        return false
                    end
                    return getJewelrys:GetChildren()[1]
                end
                local function getBoxes()
                    return getJewelryModel().Boxes:GetChildren()
                end
                local function getJewelryFloor()
                    return getJewelryModel().Floors:GetChildren()[1]
                end
                local function getJewelryFloorPart()
                    return getJewelryFloor().PrimaryPart
                end
                local function isBoxBroken(box)
                    return box.Transparency ~= -2
                end
                local function isFacingBox(box, part)
                    local u = ((box.Position - part.Position) * Vector3.new(1,0,1)).unit
                    local lookvec = part.CFrame.LookVector * Vector3.new(1, 0, 1)
                    return lookvec:Dot(u) > 0.78
                end
                local function isPlayerNearbyBox(box, part)
                    local mag = (box.Position - part.Position).magnitude
                    if mag < 5 then
                        return true
                    end
                    return false
                end
                local lastPunch = tick()
                local function canPunch()
                    if tick() - lastPunch > 0.2 then
                        return true
                    end
                    return false
                end
                local function attemptPunch()
                    local buttons = global.registry.buttons
                    if canPunch() then
                        buttons.attemptPunch()
                        lastPunch = tick()
                    end
                end
                local function getJewelryStatus()
                    local getJewelryStatus = global.registry.getRobberyStatus("jewelry")
                    return getJewelryStatus
                end
                local function loop()
                    if tostring(player.Team) == "Police" then
                        return false
                    end
                    local bool = global.ui_status.automatic_punch_jewelry_boxes
                    if bool then
                        if client.reg.getEquippedItem then
                            return false
                        end
                        if not canPunch() then
                            return false
                        end
                        local getJewelryStatus = getJewelryStatus()
                        if getJewelryStatus or getJewelryStatus == 0 then
                            local isInJewelry = isInJewelry()
                            if isInJewelry then
                                local getBoxes = getBoxes()
                                if getBoxes then
                                    local partsindex = #parts
                                    if partsindex > 0 then
                                        for i=1, partsindex do
                                            local v = parts[i]
                                            for i2=1, #getBoxes do
                                                local v2 = getBoxes[i2]
                                                local isBoxBroken = isBoxBroken(v2)
                                                if not isBoxBroken then
                                                    local isPlayerNearbyBox = isPlayerNearbyBox(v2, v)
                                                    if isPlayerNearbyBox then
                                                        local isFacingBox = isFacingBox(v2, v)
                                                        if isFacingBox then
                                                            attemptPunch()
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                createloop(0, loop)
                --@NU LE STERGE!!!!!!!!! 
                global.registry.scannedParts = parts
                global.registry.getBoxes = getBoxes
                global.registry.getJewelryFloorPart = getJewelryFloorPart
                global.registry.isJewelryBoxBroken = isJewelryBoxBroken
                global.registry.getJewelryFloor = getJewelryFloor
                global.registry.getJewelryModel = getJewelryModel
                global.registry.isFacingPart = isFacingBox
                global.registry.isNearbyJewelryBox = isPlayerNearbyJewelryBox
                global.registry.isInJewelry = isInJewelry
                global.registry.lastUsedPunchingForJewelry = lastPunch
            end
            automaticPunch()
        end
        jewelryCorrection()
        local function casinoCorrection()
            local function elevator()
                local call_elevator_to_floor = global.registry.call_elevator_to_floor
                local function loop()
                    local bool = global.ui_status.break_elevator
                    if bool then
                        call_elevator_to_floor("Vaults")
                        return true
                    end
                    return false
                end
                createloop(1, loop)
            end
            elevator()
            local function vault()
                local ui = client.modules.ui
                local specs = ui.CircleAction.Specs
                local vaults = {}
                local actions = {}
                local vaultPuzzle = collectionservice:GetTagged("VaultDoorPuzzle")
                local function onLEDChange(obj, v2, v, model)
                    if v.puzzle:GetAttribute("VaultHackerId") ~= nil and v.puzzle:GetAttribute("VaultHackerId") ~= player.UserId then
                        return false
                    end
                    if string.find(obj, "BrickColor") then
                        local led = model.UnlockedLED
                        if led.BrickColor == BrickColor.new("Lime green") then
                            v2:Callback(true)
                        end
                    end
                end
                local function onLightChange(obj, v2, v, model)
                    if v.puzzle:GetAttribute("VaultHackerId") ~= nil and v.puzzle:GetAttribute("VaultHackerId") ~= player.UserId then
                        return false
                    end
                    if string.find(obj, "BrickColor") then
                        local light = model.Light
                        if light.BrickColor == BrickColor.new("Lime green") then
                            v2:Callback(true)
                        end
                    end
                end
                local function onInstanceAdded(obj)
                    if obj.Parent.Parent.Name ~= "Vault" then
                        table.insert(vaults, {
                            puzzle = obj;
                            doorName = obj.Parent.Parent.Name;
                            specPart = obj.Part;
                        })
                        specs = ui.CircleAction.Specs
                        for i,v in next, vaults do
                            for i2,v2 in next, specs do
                                if v2.Part == v.specPart then
                                    local model = v.puzzle.Parent.Model
                                    if v.doorName == "VaultDoorMain" then
                                        local unlockedLed = model.UnlockedLED
                                        unlockedLed.Changed:connect(function(obj)
                                            onLEDChange(obj, v2, v, model) 
                                        end)
                                    elseif v.doorName == "VaultDoorSlider" then
                                        local light = model.Light
                                        light.Changed:connect(function(obj)
                                            onLightChange(obj, v2, v, model)
                                        end)
                                    end
                                    v2.vaultIdx = i
                                    v2.vaultType = v.doorName
                                    v2.puzzle = v.puzzle
                                    table.insert(actions, v2)
                                end
                            end
                        end
                    end
                end
                collectionservice:GetInstanceAddedSignal("VaultDoorPuzzle"):connect(onInstanceAdded)
                for i,v in next, vaultPuzzle do
                    if v.Parent.Parent.Name ~= "Vault" then
                        table.insert(vaults, {
                            puzzle = v;
                            doorName = v.Parent.Parent.Name;
                            specPart = v.Part;
                        })
                    end
                end 
                for i,v in next, vaults do
                    for i2,v2 in next, specs do
                        if v2.Part == v.specPart then
                            local model = v.puzzle.Parent.Model
                            if v.doorName == "VaultDoorMain" then
                                local unlockedLed = model.UnlockedLED
                                unlockedLed.Changed:connect(function(obj)
                                    onLEDChange(obj, v2, v, model) 
                                end)
                            elseif v.doorName == "VaultDoorSlider" then
                                local light = model.Light
                                light.Changed:connect(function(obj)
                                    onLightChange(obj, v2, v, model)
                                end)
                            end
                            v2.vaultIdx = i
                            v2.vaultType = v.doorName
                            v2.puzzle = v.puzzle
                            table.insert(actions, v2)
                        end
                    end
                end
                local function getClosestVault()
                    local char = client.playerCharacter
                    if not char then
                        return false
                    end
                    local root = char.PrimaryPart
                    if not root then
                        return false
                    end
                    local closest, dist = nil, 10
                    for i,v in next, actions do
                        local magnitude = (root.Position - v.Part.Position).magnitude
                        if magnitude < dist then
                            closest = v
                            dist = magnitude
                        end
                    end
                    return closest
                end
                global.registry.getClosestVault = getClosestVault
                local function loop()
                    if tostring(player.Team) ~= "Criminal" then
                        return false
                    end
                    local getClosestVault = getClosestVault()
                    if not getClosestVault or getClosestVault and getClosestVault.puzzle.Parent.Parent:GetAttribute("DoorOpen") == true then
                        return false
                    end
                    if getClosestVault and getClosestVault.puzzle:GetAttribute("VaultHackerId") == nil then
                        getClosestVault:Callback(true)
                    end
                end
                local loopf
                local tagCache
                local function tagService()
                    tagCache = client.tags.new("auto_crack_vault", 0, false, function(val)
                        if val then
                            loopf = createloop(0.2, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.auto_crack_vault
                    if tagCache then
                        tagCache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            vault()
        end
        casinoCorrection()
        local function trainCorrection()
            local function switches()
                local click_switch1
                local rail1
                local function switch1()
                    local switches = workspace:FindFirstChild("Switches")
                    if not switches then 
                        return false
                    end
                    local branchBack = switches:FindFirstChild("BranchBack")
                    if not branchBack then
                        return false
                    end
                    for i,v in next, branchBack:GetDescendants() do
                        if v.Name == "Click" then
                            click_switch1 = v.ClickDetector
                        end
                        if v.Name == "Rail" then
                            rail1 = v
                        end
                    end
                end
                switch1()
                local click_switch2
                local rail2
                local function switch2()
                    local switches = workspace:FindFirstChild("Switches")
                    if not switches then 
                        return false
                    end
                    local branchForward = switches:FindFirstChild("BranchForward")
                    if not branchForward then
                        return false
                    end
                    for i,v in next, branchForward:GetDescendants() do
                        if v.Name == "Click" then
                            click_switch2 = v.ClickDetector
                        end
                        if v.Name == "Rail" then
                            rail2 = v
                        end
                    end
                end
                switch2()
                local function loop()
                    if not rail1 then
                        return false
                    end
                    if not rail2 then
                        return false
                    end
                    if rail1.Transparency ~= 1 then
                        fireclickdetector(click_switch1)
                    end
                    if rail2.Transparency ~= 0 then
                        fireclickdetector(click_switch2)
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("anti_station_stop", 0, false, function(val)
                        if val then
                            loopf = createloop(0.1, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.anti_station_stop
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            switches()
            local function isTrainClose()
                local trains = workspace.Trains
                if #trains:GetChildren() == 0 then
                    return false
                end
                local char = client.playerCharacter
                if not char then
                    return false
                end
                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then
                    return false
                end
                local cart = trains:GetChildren()[1]:FindFirstChildWhichIsA("Part")
                if (cart.Position - root.Position).magnitude < 35 then
                    return true
                end
            end
            local function passenger()
                local function grab()
                    local grabber = {"computer", "documents", "briefcase", "phone", "Cash", "spyglasses"}
                    for i,v in next, client.modules.ui.CircleAction.Specs do
                        for i2,v2 in next, grabber do
                            if string.find(v.Name, ("Grab %s"):format(v2)) then
                                if v.Part:IsDescendantOf(workspace.Trains) and v.Enabled then
                                    v:Callback(true)
                                    task.wait(2)
                                end
                            end
                        end
                    end
                end
                local function loop()
                    local trains = workspace.Trains
                    if #trains:GetChildren() == 0 then
                        return false
                    end
                    local automatic_delivery = global.ui_status.automatic_delivery
                    if automatic_delivery then
                        if tostring(player.Team) ~= "Police" then
                            return false
                        end
                        local isTrainClose = isTrainClose()
                        if isTrainClose then
                            grab()
                        end
                        return true 
                    end
                    local bool = global.ui_status.automatic_train_fillbag
                    if bool then
                        if tostring(player.Team) == "Police" then
                            return false
                        end
                        local isTrainClose = isTrainClose()
                        if isTradeClose then
                            grab()
                        end
                    end
                end
                createloop(3, loop)
            end
            passenger()
            local function cargo()
                local function openDoor()
                    for i,v in next, client.modules.ui.CircleAction.Specs do
                        if v.Name == "Open Door" and v.Part:IsDescendantOf(workspace.Trains) then
                            if v.Enabled then
                                v:Callback(true)
                            end
                        end
                    end  
                end
                local function breachVault()
                    for i,v in next, client.modules.ui.CircleAction.Specs do
                        if v.Name == "Breach Vault" and v.Part:IsDescendantOf(workspace.Trains) then
                            if v.Enabled then
                                v:Callback(true)
                            end
                        end
                    end
                end
                local function loop()
                    local bool = global.ui_status.automatic_breach_vault
                    if bool then
                        local isTrainClose = isTrainClose()
                        if isTrainClose then
                            openDoor()
                            breachVault()
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("automatic_breach_vault", 0, false, function(val)
                        if val then
                            loopf = createloop(1, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_breach_vault
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            cargo()
        end
        trainCorrection()
        local function prisonCorrection()
            local function elevator()
                local tagElevator = collectionservice:GetTagged("Elevator")
                local function getMaxSecurityElevator()
                    for i,v in next, tagElevator do
                        for i2,v2 in next, v:GetDescendants() do
                            if v2:IsA("TextLabel") and v2.Text:find("*") then
                                return v2.Parent.Parent
                            end
                        end
                    end
                    return false
                end
                local maxSecurityElevator = getMaxSecurityElevator()
                if not maxSecurityElevator then
                    return false
                end
                local function callElevatorTo1()
                    fireclickdetector(maxSecurityElevator.ClickDetector)
                end
                local tagCache
                local loopf
                local function tagService()
                    tagCache = client.tags.new("elevator_manipulation_prison", 0, false, function(val)
                        if val then
                            loopf = createloop(0.5, callElevatorTo1)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.break_maximum_security_elevator
                    if tagCache then
                        tagCache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            elevator()
            local function ext()
                --@astea le-am furat din ice tray v2 ca inca merg si sunt bune :D:D:D
                global.ext = {
                    doors = {};
                    gates = {};
                    cells = {};
                    new_doors = {};
                }
                for i,v in next, getgc(true) do
                    if type(v) == "table" and rawget(v, "OpenFun") and rawget(v, "State") then
                        table.insert(global.ext.doors, v)
                    end
                    if type(v) == "function" and islclosure(v) and not is_synapse_function(v) then
                        local con = getconstants(v)
                        if table.find(con, "SequenceRequireState") then
                            global.registry.attemptOpenDoor = v
                        end
                    end
                end
                for i,v in next, global.ext.doors do
                    if type(v) == "table" then
                        for i2,v2 in next, v do
                            if typeof(v2) == "Instance" then
                                if not v2.Model:FindFirstChild("Fence_Post") and not v2.Parent.Name == "Cell" then
                                    table.insert(global.ext.new_doors, v)
                                end
                                if v2.Model:FindFirstChild("Fence_Post") then
                                    table.insert(global.ext.gates, {
                                        call = v;
                                        pos = tostring(v2.Model.PrimaryPart.Position);
                                    })
                                end
                                if v2.Parent.Name == "Cell" then
                                    table.insert(global.ext.cells, v)
                                end
                            end
                        end
                    end
                end
            end
            ext()
            local function spotlights()
                local trackingSpotlight = client.modules.trackingSpotlight._constructor
                local trackPlayer = trackingSpotlight.TrackPlayer
                local function hook(...)
                    local bool = global.ui_status.disable_spotlight_tracking
                    if bool then
                        return false
                    end
                    return trackPlayer(...)
                end
                trackingSpotlight.TrackPlayer = hook
            end
            spotlights()
            local function automatic_open_main_gate()
                local function open()
                    local prisonGate = global.registry.prisonGate
                    if prisonGate then
                        for i,v in next, prisonGate do
                            for i2,v2 in next, getconnections(v) do
                                v2.Function(player)
                            end
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("automatic_open_main_gate", 0, false, function(val)
                        if val then
                            loopf = createloop(2, open) 
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_open_main_gate
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            automatic_open_main_gate()
            local function automatic_open_cells()
                local function open()
                    local attemptOpen = global.registry.attemptOpenDoor
                    local cells = global.ext.cells
                    if cells and attemptOpen then
                        for i,v in next, cells do
                            attemptOpen(v)
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("automatic_open_cells", 0, false, function(val)
                        if val then
                            loopf = createloop(1, open)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_open_cells
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            automatic_open_cells()
            local function automatic_open_front_gates()
                local function open()
                    local attemptOpen = global.registry.attemptOpenDoor
                    local gates = global.ext.gates
                    for i,v in next, gates do
                        if v.pos:find("-1196") or v.pos:find("-1159") then -- @doamne ajuta sa nu se schimbe pos-ul
                            attemptOpen(v.call)
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("automatic_open_front_gates", 0, false, function(val)
                        if val then
                            loopf = createloop(1, open)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_open_front_gates
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            automatic_open_front_gates()
            local function automatic_open_side_gate()
                local function open()
                    local attemptOpen = global.registry.attemptOpenDoor
                    local gates = global.ext.gates
                    for i,v in next, gates do
                        if v.pos:find("-1438") or v.pos:find("-1428") then -- @ si aici la fel
                            attemptOpen(v.call)
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("automatic_open_side_gate", 0, false, function(val)
                        if val then
                            loopf = createloop(1, open)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_open_side_gate
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            automatic_open_side_gate()
            local function automatic_punch_electric_gate()
                local function open()
                    local attemptOpen = global.registry.attemptOpenDoor
                    local gates = global.ext.gates
                    for i,v in next, gates do
                        if v.pos:find("-1138") then -- @ si aici
                            attemptOpen(v.call)
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("automatic_punch_electric_gate", 0, false, function(val)
                        if val then
                            loopf = createloop(1, open)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_punch_electric_gate
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            automatic_punch_electric_gate()
            local function automatic_open_yard_gates()
                local function open()
                    local attemptOpen = global.registry.attemptOpenDoor
                    local gates = global.ext.gates
                    for i,v in next, gates do
                        if v.pos:find("-1341") or v.pos:find("-1291") or v.pos:find("-1192") then -- @ si aici
                            attemptOpen(v.call)
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("automatic_open_yard_gates", 0, false, function(val)
                        if val then
                            loopf = createloop(1, open)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.automatic_open_yard_gates
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            automatic_open_yard_gates()
        end
        prisonCorrection()
        local function bulletCorrection()
            local function prediction(target)
                local function predict(part)
                    return part.Position + part.Velocity * 0.13
                end
                local predict = predict(target)
                if predict then
                    return predict
                end
                return false
            end
            local a = 0
            local hsv --culoarea normal din jailbreak: Color3.fromHSV(1, 0.921569, 0.552941)
            local function createColorfulTable()
                --@nu mai stiu de unde am furat asta dar mersi! 
                while true do
                    for i=0, 1, 1/300 do
                        hsv = Color3.fromHSV(i, 1, 1)
                        task.wait()
                    end
                end
            end
            task.spawn(createColorfulTable)
            local function colorBullet()
                local update = client.modules.bulletEmitter.Update
                local function hook(...)
                    local bool = global.ui_status.rainbowbullets
                    if bool then
                        unpack({...}).Color = hsv
                    end
                    return update(...)
                end
                client.modules.bulletEmitter.Update = hook
            end
            colorBullet()
            local function silentaim()
                local update = client.modules.bulletEmitter.Update
                local function loop()
                    local bool = global.ui_status.master_switch_silentaim
                    if bool then
                        local no_wall_penetration = global.ui_status.no_wall_penetration
                        if no_wall_penetration then
                            local getEquippedItem = client.reg.getEquippedItem
                            if getEquippedItem then
                                local always_predict = global.ui_status.always_predict
                                local checkWallBeforePenetration = global.registry.checkWallBeforePenetration
                                local target = client.reg.getClosestPlayerByFov
                                if target then
                                    local bulletEmitter = getEquippedItem.BulletEmitter
                                    if bulletEmitter then
                                        local bullets = bulletEmitter.Bullets
                                        if bullets then
                                            local char = client.playerCharacter
                                            if char then
                                                for i=1, #bullets do
                                                    local v = bullets[i]
                                                    if target:FindFirstChild("Head") then
                                                        local Head = target.Head
                                                        if always_predict then
                                                            local prediction = prediction(Head)
                                                            if prediction then
                                                                v[2] = (prediction - char.Head.Position).unit
                                                            else
                                                                v[2] = (Head.Position - char.Head.Position).unit
                                                            end
                                                        else
                                                            v[2] = (Head.Position - char.Head.Position).unit
                                                        end
                                                    elseif players[target.Name] then
                                                        if checkWallBeforePenetration(target) then
                                                            if always_predict then
                                                                local prediction = prediction(target.Character.Head)
                                                                if prediction then
                                                                    v[2] = (prediction - char.Head.Position).unit
                                                                else
                                                                    v[2] = (target.Character.Head.Position - char.Head.Position).unit
                                                                end
                                                            else
                                                                v[2] = (target.Character.Head.Position - char.Head.Position).unit
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                createloop(0, loop)
            end
            silentaim()
            local function rayIgnoreNonCollideHooks()
                local module = client.modules.rayCast.RayIgnoreNonCollideWithIgnoreList
                local function selectTaserTarget()
                    local getTarget = client.reg.getClosestPlayerByFov
                    if not getTarget then
                        return false
                    end
                    local char = getTarget.Character
                    local primaryPart = char and char.PrimaryPart
                    return primaryPart
                end
                local function selectTarget(...)
                    local getTarget = client.reg.getClosestPlayerByFov
                    if not getTarget then
                        return false
                    end
                    if getTarget:FindFirstChild("DefenseObjValueName") then
                        local root = getTarget.HumanoidRootPart
                        if root then
                            return root
                        end
                    end
                    if getTarget:IsDescendantOf(workspace.MansionRobbery) then
                        local always_head = global.ui_status.always_target_boss_head
                        if getTarget.Name == "ActiveBoss" then
                            local head = getTarget:FindFirstChild("Head")
                            if head then
                                return head
                            end
                        end
                        if getTarget.Parent.Name == "GuardsFolder" then
                            return getTarget.PrimaryPart
                        end
                    end
                    local char = getTarget.Character
                    local primaryPart = char and char.PrimaryPart
                    return primaryPart
                end
                local traceback = debug.traceback
                local function hook(...)
                    if not client.playerCharacter or client.playerCharacter and not client.playerCharacter.PrimaryPart then
                        return module(...)
                    end
                    local getEquippedItem = client.reg.getEquippedItem
                    if not getEquippedItem then
                        return module(...)
                    end
                    if global.ui_status.killaura_masterswitch then
                        if traceback():find("BulletEmitter") then
                            local target = client.reg.getClosestVulnerablePlayer
                            if target then
                                local char = target.Character
                                if char then
                                    local primaryPart = char.PrimaryPart
                                    if primaryPart then
                                        return primaryPart, primaryPart.Position, ...
                                    end
                                end
                            end
                        end
                    end
                    if global.ui_status.master_switch_silentaim and not global.ui_status.no_wall_penetration then
                        if traceback():find("BulletEmitter") then
                            if not getEquippedItem.BulletEmitter or getEquippedItem.__ClassName == "RocketLauncher" then
                                return module(...)
                            end
                            local target = selectTarget()
                            if not target then
                                return module(...)
                            end
                            local position = target.Position
                            local always_predict = global.ui_status.always_predict
                            if not always_predict then
                                return target, position, ...
                            end
                            local prediction = prediction(target)
                            if prediction then
                                return target, prediction, ...
                            end
                            return target, position, ...
                        end
                    end
                    if traceback():find("Taser") then
                        if global.ui_status.master_switch_silentaim and global.ui_status.allow_taser_aimbot then
                            local target = selectTaserTarget()
                            if not target then
                                return module(...)
                            end
                            local position = target.Position
                            return target, position, ...
                        elseif global.ui_status.allow_tase_target and global.AI_TASER_USE then
                            local target = selectTaserTarget()
                            if not target then
                                return module(...)
                            end
                            return target, target.Position, ...
                        end
                    end
                    return module(...)
                end
                table.insert(client.rayHooks, {
                    silent = true;
                    fn = hook;
                })
                local function rayHooks(...)
                    if traceback():find("Taser") or traceback():find("BulletEmitter") then
                        for i,v in next, client.rayHooks do
                            if v.silent then
                                return v.fn(...)
                            end
                        end
                    else
                        for i,v in next, client.rayHooks do
                            if not v.silent then
                                return v.fn(...)
                            end
                        end
                    end
                end
                client.modules.rayCast.RayIgnoreNonCollideWithIgnoreList = rayHooks
            end
            rayIgnoreNonCollideHooks()
        end
        bulletCorrection()
        local function itemCameraCorrection()
            local onItemEquipped = client.modules.itemCamera.OnItemEquipped
            local onItemUnequipped = client.modules.itemCamera.OnItemUnequipped
            local scopebegin = client.modules.sniper.ScopeBegin
            local scopeend = client.modules.sniper.ScopeEnd
            local function hook(...)
                if global.ui_status.spam_drop_guns then
                    return onItemUnequipped()
                end
                return onItemEquipped(...)
            end
            client.modules.itemCamera.OnItemEquipped = hook
            local function hook2(...)
                if global.ui_status.spam_drop_guns then
                    return scopeend(...)
                end
                return scopebegin(...)
            end
            client.modules.sniper.ScopeBegin = hook2
        end
        itemCameraCorrection()
        local function fovCorrection()
            local function loop()
                local num = global.ui_status.fov or 70
                workspace.CurrentCamera.FieldOfView = num
            end
            createloop(0, loop)
        end
        fovCorrection()
        local function arrestCorrection()
            local function ejectPlayer(vehicle)
                if not vehicle then
                    return false
                end
                local shouldEject = global.registry.shouldEject
                shouldEject({
                    ShouldEject = true;
                    Part = vehicle;
                }, true)
            end
            local function arrestPlayer(target)
                if not target or not target.Name then
                    return false
                end
                local shouldArrest = global.registry.shouldArrest
                shouldArrest({
                    PlayerName = target.Name
                })
            end
            local function tasePlayer()
                local hasItemEquipped = global.registry.hasItemEquipped
                if hasItemEquipped("Taser") then
                    local useTaser = global.registry.useTaser
                    if useTaser then
                        useTaser()
                    end
                end
            end
            local function equipTaser()
                local equip = global.registry.equip
                equip("Taser")
            end
            local function equipHandcuffs()
                local equip = global.registry.equip
                equip("Handcuffs")
            end
            local function taserLogic()
                local unequipAll = global.registry.unequipAll
                local bool = global.ui_status.allow_tase_target
                if bool then
                    local getEquippedItem = client.reg.getEquippedItem
                    local hasItemEquipped = global.registry.hasItemEquipped
                    if getEquippedItem and hasItemEquipped("Taser") then
                        equipTaser()
                        local canUseTaser = global.registry.canUseTaser(getEquippedItem)
                        if canUseTaser then
                            tasePlayer()
                        else
                            unequipAll()
                        end
                    elseif getEquippedItem and not hasItemEquipped("Taser") then
                        local unequipAll = global.registry.unequipAll
                        unequipAll()
                        if not client.reg.getEquippedItem then
                            local equip = global.registry.equip
                            equipTaser()
                            if hasItemEquipped("Taser") then
                                getEquippedItem = client.reg.getEquippedItem
                                if getEquippedItem then
                                    local canUseTaser = global.registry.canUseTaser(getEquippedItem)
                                    if canUseTaser then
                                        tasePlayer()
                                    else
                                        unequipAll()
                                    end
                                end
                            end
                        end
                    elseif not getEquippedItem then
                        equipTaser()
                        local unequipAll = global.registry.unequipAll
                        local getEquippedItem = client.reg.getEquippedItem
                        local hasItemEquipped = global.registry.hasItemEquipped
                        if getEquippedItem and hasItemEquipped("Taser") then
                            local canUseTaser = global.registry.canUseTaser(getEquippedItem)
                            if canUseTaser then
                                tasePlayer()
                            else
                                unequipAll()
                            end
                        end
                    end
                end
                local a = true
                task.delay(0.1, function()
                    a = false
                end)
                while true do
                    if not a then
                        break
                    end
                    task.wait()
                end
                unequipAll()
                task.delay(0.1, function()
                    a = true
                end)
                while true do
                    if a then
                        break
                    end
                    task.wait()
                end
                equipHandcuffs()
            end
            local function getVehicle(target)
                local getPlayerVehicle = global.registry.getPlayerVehicle
                local vehicle = getPlayerVehicle(target, true)
                if vehicle then
                    return getPlayerVehicle(target, true)
                end
                return false
            end
            local function hasHandcuffs()
                local hasItemEquipped = global.registry.hasItemEquipped
                if hasItemEquipped("Handcuffs") then
                    return true
                end
                return false
            end
            local last_time_trashtalked = tick()
            local isTrashtalking = false
            local function trashtalk()
                local talk_on_arrest = global.ui_status.talk_on_arrest
                if not talk_on_arrest then
                    return false
                end
                if tick() - last_time_trashtalked < 1.5 then
                    return false
                end
                last_time_trashtalked = tick()
                local phrase2 = {
                    [1] = {
                        "e prea usor cu ice tray";
                        "icetray.lua > all";
                    };
                    [2] = {
                        "all dogs say reported but me BLESSED by ice tray 😈";
                    };
                    [3] = {
                        "loool";
                        "that was so easy";
                        "why you so bad XD";
                    };
                    [4] = {
                        "ez noob";
                        "get better";
                    };
                    [5] = {
                        "l2p noob";
                        "please dont cry XD";
                    };
                    [6] = {
                        "hahahah";
                        "that was so easy";
                        "you're so bad";
                        "XD";
                    };
                }
                local event = textService.TextChannels.RBXGeneral
                if not isTrashtalking then
                    isTrashtalking = true
                    for i,v in next, phrase2[math.random(1, #phrase2)] do
                        event:SendAsync(v)
                        task.wait(1.5)
                    end
                    isTrashtalking = false
                end
            end
            local lastEquippedCuffs = tick()
            local lastUsedTaser = tick()
            local function aura()
                local getClosestPlayerWithNoHandcuffs = global.registry.getClosestPlayerWithNoHandcuffs
                local equip = global.registry.equip
                local unequipAll = global.registry.unequipAll
                local checkWallBeforePenetration = global.registry.checkWallBeforePenetration
                local hasInVehicleTag = global.registry.hasInVehicleTag
                local hasItemEquipped = global.registry.hasItemEquipped
                local function loop()
                    if player.Team ~= teams.Police then
                        return false
                    end
                    if global.ui_status.ignore_while_driving and client.reg.getLocalVehicle then
                        return false
                    end
                    local automatic_equip_handcuffs = global.ui_status.automatic_equip_handcuffs
                    local automatic_eject_player = global.ui_status.automatic_eject_player
                    local allow_tase_target = global.ui_status.allow_tase_target
                    local through_walls = global.ui_status.through_walls
                    local talk_on_arrest = global.ui_status.talk_on_arrest
                    local range = global.ui_status.range_arrestaura
                    local target = getClosestPlayerWithNoHandcuffs(range)
                    if target then
                        if tostring(target.Team) == "Prisoner" then
                            return false
                        end
                        if target.Character and target.Folder:FindFirstChild("Cuffed") then
                            return false
                        end
                        if not hasHandcuffs() and not automatic_equip_handcuffs then
                            return false
                        end
                        if not through_walls then
                            if not checkWallBeforePenetration(target) then
                                return false
                            end
                        end
                        if allow_tase_target then
                            if tick() - lastUsedTaser > 10 then
                                taserLogic()
                                lastUsedTaser = tick()
                            end
                        end
                        if hasHandcuffs() and automatic_equip_handcuffs then
                            if tick() - lastEquippedCuffs > 5 then
                                unequipAll()
                            end
                        end
                        while true do
                            if hasHandcuffs() then
                                break
                            end
                            if target and target.Folder:FindFirstChild("Cuffed") then
                                break
                            end
                            if automatic_equip_handcuffs then
                                equipHandcuffs()
                            end
                            task.wait()
                        end
                        local succees = false
                        if not succees then
                            if not target.Character then --@nu fa var-ul "char" pentru ca o sa se futa toata functiunea :D
                                return false
                            end
                            if hasInVehicleTag(target.Character) then
                                local targetVehicle = getVehicle(target)
                                if targetVehicle and automatic_eject_player then
                                    ejectPlayer(targetVehicle)
                                    task.delay(0.1, function()
                                        arrestPlayer(target)
                                    end)
                                end
                            end
                            if target and target.Folder:FindFirstChild("Cuffed") then
                                succees = true
                            end
                            if not succees then
                                if hasInVehicleTag(target.Character) then
                                    if targetVehicle and automatic_eject_player then
                                        ejectPlayer(targetVehicle)
                                    end
                                end
                                if hasHandcuffs() and automatic_equip_handcuffs then
                                    if tick() - lastEquippedCuffs > 2 then
                                        lastEquippedCuffs = tick()
                                        unequipAll()
                                        task.delay(0.1, function()
                                            equipHandcuffs()
                                        end)
                                        while true do
                                            if hasHandcuffs() then
                                                break
                                            end
                                            task.wait()
                                        end
                                    end
                                end
                                local attempts = 0
                                while true do
                                    if not global.ui_status.master_switch_arrestaura then
                                        break
                                    end
                                    if not hasHandcuffs() then
                                        break
                                    end
                                    if not target then
                                        break
                                    end
                                    if target and not target.Character then
                                        break
                                    end
                                    if target and target.Folder:FindFirstChild("Cuffed") then
                                        succees = true
                                        break
                                    end
                                    if attempts == 3 then
                                        if target and target.Folder:FindFirstChild("Cuffed") then
                                            succees = true 
                                        end
                                        attempts = 0
                                        break
                                    end
                                    arrestPlayer(target)
                                    attempts += 1
                                    task.wait(0.6)
                                end
                            end
                        end
                        if succees then
                            if talk_on_arrest then
                                if target and target.Folder:FindFirstChild("Cuffed") then
                                    trashtalk()
                                end
                            end
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("master_switch_arrestaura", 0, false, function(val)
                        if val then
                            loopf = createloop(0, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.master_switch_arrestaura
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            aura()
        end
        arrestCorrection()
        local function ejectCorrection()
            local function ejectPlayer(vehicle)
                if not vehicle then
                    return false
                end
                local shouldEject = global.registry.shouldEject
                shouldEject({
                    ShouldEject = true;
                    Part = vehicle;
                }, true)
            end
            local hasInVehicleTag = global.registry.hasInVehicleTag
            local function loop()
                if tostring(player.Team) ~= "Police" then
                    return false
                end
                local bool = global.ui_status.master_switch_eject_aura
                if bool then
                    local range = global.ui_status.range_ejectaura
                    local target = global.registry.getClosestPlayerWithNoHandcuffs(range)
                    if target then
                        local char = target.Character
                        if char then
                            local inVehicle = hasInVehicleTag(char)
                            if inVehicle then
                                local getPlayerVehicle = global.registry.getPlayerVehicle(target, true)
                                if getPlayerVehicle then
                                    ejectPlayer(getPlayerVehicle)
                                end
                            end
                        end
                    end
                end
            end
            createloop(0, loop)
        end
        ejectCorrection()
        local function breakoutCorrection()
            local function breakoutPlayer(player)
                local shouldBreakout = global.registry.shouldBreakout
                shouldBreakout({
                    ShouldBreakout = true;
                    PlayerName = player.Name;
                }, true)
            end
            local getClosestPlayerForBreakouts = global.registry.getClosestPlayerForBreakouts
            local lastTimeBreakout = tick()
            local function loop()
                if tick() - lastTimeBreakout < 20 then
                    return false
                end
                local bool = global.ui_status.master_switch_breakout_aura
                if bool then
                    local range = global.ui_status.range_breakoutaura
                    local target = getClosestPlayerForBreakouts(range)
                    if target and target.Folder:FindFirstChild("Cuffed") then
                        lastTimeBreakout = tick()
                        breakoutPlayer(target)
                    end
                end
            end
            createloop(0, loop)
        end
        breakoutCorrection()
        local function pickpocketCorrection()
            local function pickpocketPlayer(player)
                local shouldPickpocket = global.registry.shouldPickpocket
                shouldPickpocket({
                    ShouldPickpocket = true;
                    PlayerName = player.Name;
                }, true)
            end
            local getClosestPlayerWithTagPolice = global.registry.getClosestPlayerWithTagPolice
            local function loop()
                local bool = global.ui_status.pickpocketaura
                if tostring(player.Team) == "Police" then
                    return false
                end
                if not bool then
                    return false
                end
                local range = global.ui_status.range_pickpocketaura
                local target = getClosestPlayerWithTagPolice(range)
                if target then
                    pickpocketPlayer(target)
                end
            end
            createloop(1, loop)
        end
        pickpocketCorrection()
        local function dropCorrection()
            local function spam_drop_guns()
                local isSpamming = false
                local neverDropItems = global.registry.neverDropItems()
                local equipOwnedItem = global.registry.equipOwnedItem
                local equip = global.registry.equip
                local dropGun = global.registry.dropGun
                local isProjectile = global.registry.isProjectile
                local function loop()
                    local bool = global.ui_status.spam_drop_guns
                    if bool and not isSpamming then
                        isSpamming = true
                        for i,v in next, client.reg.resolveOwnedItems do
                            if not isProjectile(v) then
                                equipOwnedItem(v)
                            end
                        end
                        for i,v in next, client.reg.resolveEquippedItems do
                            if bool and not table.find(neverDropItems, v) then
                                while true do
                                    if client.reg.getEquippedItem then
                                        dropGun()
                                        break
                                    end
                                    equip(v)
                                    task.wait()
                                end
                                while true do
                                    if not client.reg.getEquippedItem then
                                        break
                                    end
                                    dropGun()
                                    task.wait()
                                end
                            end
                        end
                        isSpamming = false
                    end
                end
                createloop(0.1, loop)
            end
            spam_drop_guns()
        end
        dropCorrection()
        local function chatCorrection()
            local function color3_to_hex(color) --@ puuuuuup ;3 https://devforum.roblox.com/t/converting-a-color-to-a-hex-string/793018/3
                return string.format("#%02X%02X%02X", color.R * 0xFF, color.G * 0xFF, color.B * 0xFF)
            end
            local function onChat(player, message)
                if not global.ui_status.chatspy then
                    return false
                end
                local color = player.Team.TeamColor.Color
                message = ("<font color='#F5CD30'>CHAT SPY: </font><font color='%s'>%s</font>: %s"):format(color3_to_hex(color), player.DisplayName, message)
                textService.TextChannels["RBXSystem"]:DisplaySystemMessage(message)
            end
            task.spawn(function()
                for i,v in next, client.players do
                    v.Chatted:connect(function(msg)
                        onChat(v, msg)
                    end)
                end
            end)
            local function fn(player)
                player.Chatted:connect(function(msg)
                    onChat(player, msg)
                end)
            end
            table.insert(client.run_on_player_connect, {
                _fn = fn
            })
        end
        chatCorrection()
        local function turretCorrection()
            local function home()
                local module = client.modules.playerUtils.getRootPart
                local function hook(...)
                    local bool = global.ui_status.disable_home_turrets
                    if bool then
                        if string.find(debug.traceback(), "Fabricate.Turret") then
                            return task.wait(9e9)
                        end
                    end
                    return module(...)
                end
                client.modules.playerUtils.getRootPart = hook
            end
            home()
            local function military()
                local _fire = client.modules.militaryTurret._fire
                local function hook(x, y)
                    local bool = global.ui_status.disable_military_turrets
                    local turretmilitary = global.registry.turretmilitary
                    if bool then
                        return task.wait(9e9)
                    end
                    return _fire(x, y)
                end
                client.modules.militaryTurret._fire = hook
            end
            military()
            local function mansionCorrection()
                local function getMansionStatus()
                    local getRobberyStatus = global.registry.getRobberyStatus
                    local status = getRobberyStatus("MANSION")
                    if status == "OPENED" then
                        return true
                    end
                    if status == "STARTED" then
                        return 0
                    end
                    return false
                end
                local function autoentry()
                    local mansionRobbery = workspace.MansionRobbery
                    local function hasMansioninvite()
                        return global.registry.hasMansioninvite()
                    end
                    local getPartsInRegion = global.registry.getPartsInRegion
                    local function isInMansion()
                        local char = client.playerCharacter
                        if char then
                            local primarypart = char.PrimaryPart
                            if primarypart then
                                local tbl = {
                                    x = {
                                        max = 3225;
                                        min = 3103;
                                    };
                                    y = {
                                        max = 104;
                                        min = 56;
                                    };
                                    z = {
                                        max = -4520;
                                        min = -4691;
                                    };
                                }
                                local pos = {
                                    x = primarypart.Position.x;
                                    y = primarypart.Position.y;
                                    z = primarypart.Position.z;
                                }
                                local getPartsInRegion = getPartsInRegion(pos.x, pos.y, pos.z, tbl.x.min, tbl.y.min, tbl.z.min, tbl.x.max, tbl.y.max, tbl.z.max)
                                if getPartsInRegion then
                                    return true
                                end
                            end
                        end
                        return false
                    end
                    local utils = client.modules.mansionRobberyUtils
                    local function getNumPlayersInElevator()
                        return utils.getNumPlayersInElevator(mansionRobbery)
                    end
                    local function isPlayerInElevator(player)
                        return utils.isPlayerInElevator(mansionRobbery, player)
                    end
                    local function loop()
                        local bool = global.ui_status.automatic_elevator_entry
                        if bool then
                            if not global.ui_status.allow_on_police_team and tostring(player.Team) == "Police" then
                                return false
                            end
                            if not hasMansioninvite() then
                                return false
                            end
                            local char = client.playerCharacter
                            if not char then
                                return false
                            end
                            local primarypart = char.PrimaryPart
                            if not primarypart then
                                return false
                            end
                            if not isInMansion() then
                                return false
                            end
                            local status = getMansionStatus()
                            if status then
                                local getNumPlayersInElevator = getNumPlayersInElevator()
                                if getNumPlayersInElevator < 3 then
                                    local isPlayerInElevator = isPlayerInElevator(player)
                                    if not isPlayerInElevator then
                                        firetouchinterest(mansionRobbery.Lobby.EntranceElevator.TouchToEnter, primarypart, 0)
                                        firetouchinterest(mansionRobbery.Lobby.EntranceElevator.TouchToEnter, primarypart, 1)
                                    end
                                end
                            end
                        end
                    end
                    createloop(0, loop)
                end
                autoentry()
                local function noTraps(bool)
                    local function laserTraps(bool)
                        if workspace.MansionRobbery.InRobberyFolder:FindFirstChild(player.UserId) then
                            for i,v in next, workspace.MansionRobbery.LaserTraps:GetDescendants() do
                                if v:IsA("BasePart") and v.CanTouch ~= not bool then
                                    v.CanTouch = not bool
                                end
                            end
                        end
                    end
                    local function loop()
                        local bool = global.ui_status.disable_traps
                        laserTraps(bool)
                    end
                    createloop(0, loop)
                end
                noTraps()
                local function noRagdoll()
                    local module = client.modules.falling.StartRagdolling
                    local function hook(...)
                        local bool = global.ui_status.anti_boss_ragdoll
                        if string.find(debug.traceback(), "BossNPCBinder") then
                            return not bool
                        end
                        return module(...)
                    end
                    client.modules.falling.StartRagdolling = hook
                end
                noRagdoll()
                local function noDamage()
                    local playLaserSweepVisual = client.modules.bossNpcBinder._constructor.PlayLaserSweepVisual
                    local playArmGrab = client.modules.bossNpcBinder._constructor.PlayArmGrab
                    local function hookLaserSweep(...)
                        local bool = global.ui_status.anti_boss_attack
                        if bool then
                            return false
                        end
                        return playLaserSweepVisual(...)
                    end
                    local function hookArmGrab(...)
                        local bool = global.ui_status.anti_boss_attack
                        if bool then
                            return false
                        end
                        return playArmGrab(...)
                    end
                    client.modules.bossNpcBinder._constructor.PlayLaserSweepVisual = hookLaserSweep
                    client.modules.bossNpcBinder._constructor.PlayArmGrab = hookArmGrab
                end
                noDamage()
            end
            mansionCorrection()
            --[[
            local function cargoship()
                local cargoShipTurret = client.modules.cargoShipTurret.Shoot
                local function hook(x, y)
                    local bool = global.ui_status.disable_cargoship_turrets
                    if bool then
                        return task.wait(9e9)
                    end
                    return cargoShipTurret(x, y)
                end
                client.modules.cargoShipTurret.Shoot = hook
            end
            cargoship()--]]
            local function cargoShip()
                local turret = client.modules.turret
                local shoot = turret.ShootRocket
                local function hook(...)
                    if global.ui_status.disable_cargoship_turrets then
                        if string.find(debug.traceback(), "CargoShip") then
                            print("cargo ship")
                            return task.wait(9e9)
                        end
                    end
                    return shoot(...)
                end
                client.modules.turret.ShootRocket = hook
            end
            cargoShip()
        end
        turretCorrection()
        local function doorCorrection()
            local function secretBases()
                local function getDoors(bool)
                    local secretBasePolice = workspace.SecretBasePolice:GetDescendants()
                    local secretBaseCriminal = workspace.SecretBaseCriminal:GetDescendants()
                    local policeSecretBase2 = workspace.PoliceSecretBase2:GetDescendants()
                    for i,v in next, secretBasePolice do
                        if v:IsA("Part") then
                            v.CanCollide = not bool
                            if bool then
                                v.Transparency = 1
                            else
                                v.Transparency = 0
                            end
                        end
                    end
                    for i,v in next, secretBaseCriminal do
                        if v:IsA("Part") and v.Name ~= "Region" then
                            v.CanCollide = not bool
                            if bool then
                                v.Transparency = 1
                            else
                                v.Transparency = 0
                            end
                        end
                    end
                    for i,v in next, policeSecretBase2 do
                        if v:IsA("MeshPart") then
                            v.CanCollide = not bool
                            if bool then
                                v.Transparency = 1
                            else
                                v.Transparency = 0
                            end
                        end
                    end
                end
                local cache
                local function tagService()
                    cache = client.tags.new("secretbases", 0, false, function(val)
                        getDoors(val)
                    end)
                end
                tagService()
                local function onWorkspaceSpawnRun(obj)
                    if obj.Name == "SecretBasePolice" then
                        getDoors(cache.obj.Value)
                    end
                    if obj.Name == "SecretBaseCriminal" then
                        getDoors(cache.obj.Value)
                    end
                    if obj.Name == "PoliceSecretBase2" then
                        getDoors(cache.obj.Value)
                    end
                end
                table.insert(client.onWorkspaceSpawnRun, {
                    _fn = onWorkspaceSpawnRun
                })
                local function loop()
                    local bool = global.ui_status.open_secretbases
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            secretBases()
            local function casino()
                local function loop()
                    local bool = global.ui_status.auto_open_door
                    if bool then
                        local getCasinoDoor = global.registry.getCasinoDoor()
                        if getCasinoDoor then
                            local getKeycode = global.registry.getKeycode()
                            if getKeycode ~= "" then
                                local pad = collectionservice:GetTagged("CasinoKeypadPrompt")[1]
                                local casinoKeypadSubmit = pad and pad:FindFirstChild("CasinoKeypadSubmit")
                                if casinoKeypadSubmit then
                                    casinoKeypadSubmit:FireServer(getKeycode)
                                    casinoKeypadSubmit:FireServer(getKeycode:reverse())
                                end
                            end
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("auto_open_door", 0, false, function(val)
                        if val then
                            loopf = createloop(1, loop)
                        else
                            if loopf then
                                loopf:disconnect()
                                loopf = nil
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.auto_open_door
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            casino()
            local function loop()
                local bool = global.ui_status.master_switch_open_doors
                if not bool then
                    return false
                end
                local success, err = pcall(function()
                    for i,v in next, global.registry.doors do
                        v()
                    end
                end)
            end
            createloop(2.5, loop)
        end
        doorCorrection()
        local function markerCorrection()
            local function playerMarkers()
                local teams = {}
                local function addTeam(team)
                    table.insert(teams, tostring(team))
                end
                local function removeTeam(team)
                    for num, name in next, teams do
                        if name == team then
                            table.remove(teams, num)
                        end
                    end
                end
                local function isTeamAllowed(team)
                    if table.find(teams, tostring(team)) then
                        return true
                    end
                    return false
                end
                local function teamCheck()
                    local function loop()
                        local allow_police_marker = global.ui_status.allow_police_marker
                        local allow_criminal_marker = global.ui_status.allow_criminal_marker
                        local allow_prisoner_marker = global.ui_status.allow_prisoner_marker
                        local function getTeams()
                            local findPrisoner = table.find(teams, "Prisoner")
                            local findPolice = table.find(teams, "Police")
                            local findCriminal = table.find(teams, "Criminal")
                            if allow_prisoner_marker and not findPrisoner then
                                addTeam("Prisoner")
                            elseif not allow_prisoner_marker and findPrisoner then
                                removeTeam("Prisoner")
                            end
                            if allow_criminal_marker and not findCriminal then
                                addTeam("Criminal")
                            elseif not allow_criminal_marker and findCriminal then
                                removeTeam("Criminal")
                            end
                            if allow_police_marker and not findPolice then
                                addTeam("Police")
                            elseif not allow_police_marker and findPolice then
                                removeTeam("Police")
                            end
                        end
                        getTeams()
                    end
                    createloop(0, loop)
                end
                teamCheck()
                local function playerMarkerLogic()
                    local doesMarkerExist = global.registry.doesMarkerExist
                    local constructMarker = global.registry.constructMarker
                    local destructMarker = global.registry.destructMarker
                    local setColor = global.registry.setColor
                    local markerColors = global.registry.markerColors
                    local function destructMarkers()
                        for i,v in next, client.players do
                            if doesMarkerExist(v) then
                                destructMarker(v)
                            end
                        end
                        return true
                    end
                    task.spawn(destructMarkers)
                    local bounties = {}
                    local function loop()
                        local master_switch = global.ui_status.master_switch_marker
                        if not master_switch then
                            return destructMarkers()
                        end
                        local mark_forced_target = global.ui_status.mark_forced_target
                        local mark_bounty_criminals = global.ui_status.mark_bounty_criminals
                        local getPlayersWithBounty = global.registry.getPlayersWithBounty()
                        local force_target = global.aimbot.force_target
                        for i,v in next, client.players do
                            if mark_forced_target and force_target and force_target == v then
                                local char = v.Character
                                if char then
                                    local hum = char:FindFirstChild("Humanoid")
                                    if hum then
                                        if hum.Health < 1 then
                                            if doesMarkerExist(v) then
                                                destructMarker(v)
                                            end
                                        else    
                                            if not doesMarkerExist(v) then
                                                constructMarker(v)
                                                setColor(v, markerColors.Target)
                                            end
                                        end
                                    end
                                end
                                continue
                            end
                            if mark_forced_target then
                                if force_target == v then
                                    if doesMarkerExist(v) then
                                        destructMarker(v)
                                        continue
                                    end
                                end
                            end
                            if not table.find(getPlayersWithBounty, v) or not mark_bounty_criminals then
                                if table.find(bounties, v) and mark_bounty_criminals then
                                    if doesMarkerExist(v) then
                                        destructMarker(v)
                                    end
                                    for _, bounty in next, bounties do
                                        if bounty == v then
                                            table.remove(bounties, _)
                                        end
                                    end
                                    return true
                                end
                                if mark_forced_target then
                                    if force_target == v then
                                        if doesMarkerExist(v) then
                                            destructMarker(v)
                                            continue
                                        end
                                    end
                                end
                                if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                    local team, teamString = v.Team, tostring(v.Team)
                                    local isTeamAllowed = isTeamAllowed(team)
                                    local color
                                    if isTeamAllowed then
                                        if markerColors[teamString] then
                                            color = markerColors[teamString]
                                        end
                                        if not doesMarkerExist(v) then
                                            if not color then
                                                return false
                                            end
                                            constructMarker(v)
                                            setColor(v, color)
                                        end
                                    else
                                        local doesMarkerExist = doesMarkerExist(v)
                                        if master_switch and not doesMarkerExist then
                                            if teamString == tostring(player.Team) then
                                                color = markerColors[teamString]
                                                if color then
                                                    constructMarker(v)
                                                    setColor(v, color)
                                                    return true
                                                end
                                                return false
                                            end
                                        end
                                        if doesMarkerExist then
                                            if teamString ~= tostring(player.Team) then
                                                destructMarker(v)
                                            end
                                        end
                                    end
                                end
                                if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health == 0 and doesMarkerExist(v) then
                                    destructMarker(v)
                                end
                                if v.Character and v.Folder:FindFirstChild("Cuffed") and doesMarkerExist(v) then
                                    destructMarker(v)
                                end
                            elseif table.find(getPlayersWithBounty, v) then
                                if mark_bounty_criminals then
                                    if mark_forced_target then
                                        if force_target == v then
                                            if doesMarkerExist(v) then
                                                destructMarker(v)
                                                continue
                                            end
                                        end
                                    end
                                    if not table.find(bounties, v) then
                                        table.insert(bounties, v)
                                        if doesMarkerExist(v) then
                                            destructMarker(v)
                                        end
                                        return true
                                    end
                                    if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                                        local team, teamString = v.Team, tostring(v.Team)
                                        local isTeamAllowed = isTeamAllowed(team)
                                        local color
                                        if isTeamAllowed then
                                            if markerColors.Bounty then
                                                color = markerColors.Bounty
                                            end
                                            if not doesMarkerExist(v) then
                                                if not color then
                                                    return false
                                                end
                                                constructMarker(v)
                                                setColor(v, color)
                                            end
                                        else
                                            local doesMarkerExist = doesMarkerExist(v)
                                            if master_switch and not doesMarkerExist then
                                                if teamString == tostring(player.Team) then
                                                    color = markerColors.Bounty
                                                    if color then
                                                        constructMarker(v)
                                                        setColor(v, color)
                                                        return true
                                                    end
                                                    return false
                                                end
                                            end
                                            if doesMarkerExist then
                                                if teamString ~= tostring(player.Team) then
                                                    destructMarker(v)
                                                end
                                            end
                                        end
                                    end
                                    if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health == 0 and doesMarkerExist(v) then
                                        destructMarker(v)
                                    end
                                    if v.Character and v.Folder:FindFirstChild("Cuffed") then
                                        destructMarker(v)
                                    end
                                end
                            end
                        end
                    end
                    local loopf
                    local cache
                    local function tagService()
                        cache = client.tags.new("markers", 0, false, function(val)
                            if val then
                                loopf = createloop(0, loop)
                            else
                                if loopf then
                                    destructMarkers()
                                    loopf:disconnect()
                                    loopf = nil
                                else
                                    warn("no loopf")
                                end
                            end
                        end)
                    end
                    tagService()
                    local function loop()
                        local bool = global.ui_status.master_switch_marker
                        if cache then
                            cache.obj.Value = bool
                        end
                    end
                    createloop(0, loop)
                end
                playerMarkerLogic()
            end
            playerMarkers()
            local function airdropMarkers()
                local image = getsynasset("icetray/resource/airdrop.png")
                if not image then
                    warn("error while trying to get synapse asset `airdrop.png`")
                end
                local markerColors = global.registry.markerColors
                local worldmarker = client.modules.worldMarker
                local system = client.modules.system
                local group = client.modules.group
                local airdrop = {}
                local function markerCreate(part)
                    local function makeAirdropGroups(drop, group)
                        table.insert(airdrop, {
                            part = part;
                            drop = drop;
                            group = group;
                        })
                    end
                    local function makeMarker()
                        local group = group.new()
                        system.addGroup(group)
                        group:SetEnabled(true)
                        local new = worldmarker.new()
                        new:SetAdornee(part)
                        new:SetScreenGui(system.gui)
                        new:SetSizes({8, {24, 0}, {math.huge, 8}})
                        local function createImageLabel()
                            local imagelabel = Instance.new("ImageLabel")
                            imagelabel.BorderSizePixel = 0
                            imagelabel.BackgroundTransparency = 1
                            imagelabel.Size = UDim2.new(1.2, 0, 1.2, 0)
                            imagelabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                            imagelabel.AnchorPoint = Vector2.new(0.5, 0.5)
                            imagelabel.ZIndex = 3
                            imagelabel.Parent = new.FrameInner
                            imagelabel.Image = image
                        end
                        createImageLabel()
                        local function walls()
                            local walls = part.Parent:FindFirstChild("Walls")
                            if not walls then
                                new.FrameInner.ImageColor3 = markerColors.Airdrop
                                return
                            end
                            local wall = walls:FindFirstChild("Wall")
                            if not wall then
                                new.FrameInner.ImageColor3 = markerColors.Airdrop
                                return
                            end
                            new.FrameInner.ImageColor3 = wall.Color
                        end
                        walls()
                        group:Add(new)
                        makeAirdropGroups(new, group)
                    end
                    makeMarker()
                end
                local function markerRemove(root)
                    if not root then
                        for i,v in next, airdrop do
                            if not v.part:IsDescendantOf(workspace) then
                                v.group:Remove(v.drop)
                                v.drop:Destroy()
                                v.drop = nil
                                table.remove(airdrop, i)
                                return true
                            end
                            if v.part ~= nil then
                                if v.drop and v.group then
                                    v.group:Remove(v.drop)
                                    v.drop:Destroy()
                                    v.drop = nil
                                end
                                table.remove(airdrop, i)
                            end
                        end
                        return false
                    end
                    for i,v in next, airdrop do
                        if not v.part:IsDescendantOf(workspace) then
                            v.group:Remove(v.drop)
                            v.drop:Destroy()
                            v.drop = nil
                            table.remove(airdrop, i)
                            return true
                        end
                        if v.part == root then
                            v.group:Remove(v.drop)
                            v.drop:Destroy()
                            v.drop = nil
                            table.remove(airdrop, i)
                        end
                    end
                end
                local function doesMarkerExist(root)
                    local result = false
                    if not root then
                        for i,v in next, airdrop do
                            result = v.drop ~= nil
                        end
                        return result
                    end
                    for i,v in next, airdrop do
                        if v.part == root then
                            result = v.drop ~= nil
                        end
                    end
                    return result
                end
                global.airdrops_on_map = {}
                local function onChildAdded(part)
                    local bool = global.ui_status.master_switch_marker
                    if not bool then
                        return false
                    end
                    local allow_airdrop_marker = global.ui_status.allow_airdrop_marker
                    if not allow_airdrop_marker then
                        return false
                    end
                    if part.Name == "Drop" then
                        table.insert(global.airdrops_on_map, part.PrimaryPart)
                        local root = part:FindFirstChild("Root")
                        if root then
                            if not doesMarkerExist(root) then
                                markerCreate(root)
                            end
                        end
                    end
                end
                local function onChildRemoved(part)
                    if part.Name == "Drop" then
                        task.spawn(function()
                            for i,v in next, global.airdrops_on_map do
                                if not v:IsDescendantOf(workspace) then -- @ ar trebui sa stearga toate airdropurile din table care nu mai sunt in workspace
                                    table.remove(global.airdrops_on_map, i)
                                    break
                                end
                            end
                        end)
                        local root = part:FindFirstChild("Root")
                        if root then
                            if doesMarkerExist(root) then
                                markerRemove(root)    
                            end
                        end
                    end
                end
                table.insert(client.onWorkspaceSpawnRun, {
                    _fn = onChildAdded
                })
                table.insert(client.onWorkspaceRemovedRun, {
                    _fn = onChildRemoved
                })
                local function loop()
                    local master_switch = global.ui_status.master_switch_marker
                    if not master_switch then
                        if doesMarkerExist() then
                            markerRemove()
                        end
                        return false
                    end
                    local bool = global.ui_status.allow_airdrop_marker
                    if bool then
                        for i,v in next, workspaceChildren do
                            if v.Name == "Drop" then
                                if v:FindFirstChild("Root") then
                                    if not doesMarkerExist(v.Root) then
                                        markerCreate(v.Root)
                                    end
                                else
                                    if doesMarkerExist() then
                                        markerRemove()
                                    end
                                end
                            end
                        end
                    else
                        if doesMarkerExist() then
                            markerRemove()
                        end
                    end
                end
                local cache
                local loopf
                local function tagService()
                    cache = client.tags.new("markersairdrop", 0, false, function(val)
                        if val then
                            loopf = createloop(0.5, loop)
                        else
                            if loopf then
                                if doesMarkerExist() then
                                    markerRemove()
                                end
                                loopf:disconnect()
                                loopf = nil
                            else
                                warn("no loopf")
                            end
                        end
                    end)
                end
                tagService()
                createloop(0.5, loop)
            end
            airdropMarkers()
            local function footballMarker()
                local image = getsynasset("icetray/resource/football.png")
                if not image then
                    warn("error while trying to get synapse asset `football.png`")
                end
                local markerColors = global.registry.markerColors
                local worldmarker = client.modules.worldMarker
                local system = client.modules.system
                local group = client.modules.group
                local football = {}
                local function markerCreate(part)
                    local function makeFootballGroups(drop, group)
                        table.insert(football, {
                            part = part;
                            drop = drop;
                            group = group;
                        })
                    end
                    local function makeMarker()
                        local group = group.new()
                        system.addGroup(group)
                        group:SetEnabled(true)
                        local new = worldmarker.new()
                        new:SetAdornee(part)
                        new:SetScreenGui(system.gui)
                        new:SetSizes({8, {24, 0}, {math.huge, 8}})
                        local function createImageLabel()
                            local imagelabel = Instance.new("ImageLabel")
                            imagelabel.BorderSizePixel = 0
                            imagelabel.BackgroundTransparency = 1
                            imagelabel.Size = UDim2.new(0.7, 0, 0.7, 0)
                            imagelabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                            imagelabel.AnchorPoint = Vector2.new(0.5, 0.5)
                            imagelabel.ZIndex = 3
                            imagelabel.Parent = new.FrameInner
                            imagelabel.Image = image
                        end
                        createImageLabel()
                        new.FrameInner.ImageColor3 = markerColors.Football
                        group:Add(new)
                        makeFootballGroups(new, group)
                    end
                    makeMarker()
                end
                local function markerRemove(root)
                    if not root then
                        for i,v in next, football do
                            if not v.part:IsDescendantOf(workspace) then
                                v.group:Remove(v.drop)
                                v.drop:Destroy()
                                v.drop = nil
                                table.remove(football, i)
                                return true
                            end
                            if v.part ~= nil then
                                if v.drop and v.group then
                                    v.group:Remove(v.drop)
                                    v.drop:Destroy()
                                    v.drop = nil
                                end
                                table.remove(football, i)
                            end
                        end
                        return false
                    end
                    for i,v in next, football do
                        if not v.part:IsDescendantOf(workspace) then
                            v.group:Remove(v.drop)
                            v.drop:Destroy()
                            v.drop = nil
                            table.remove(football, i)
                            return true
                        end
                        if v.part == root then
                            v.group:Remove(v.drop)
                            v.drop:Destroy()
                            v.drop = nil
                            table.remove(football, i)
                        end
                    end
                end
                local function doesMarkerExist(root)
                    local result = false
                    if not root then
                        for i,v in next, football do
                            result = v.drop ~= nil
                        end
                        return result
                    end
                    for i,v in next, football do
                        if v.part == root then
                            result = v.drop ~= nil
                        end
                    end
                    return result
                end
                local function onChildAdded(part)
                    local bool = global.ui_status.master_switch_marker
                    if not bool then
                        return false
                    end
                    local allow_football_marker = global.ui_status.allow_football_marker
                    if not allow_football_marker then
                        return false
                    end
                    if part.Name == "SoccerBall" then
                        if not doesMarkerExist(part) then
                            markerCreate(part)
                        end
                    end
                end
                local function onChildRemoved(part)
                    if part.Name == "SoccerBall" then
                        if doesMarkerExist(part) then
                            markerRemove(part)
                        end
                    end
                end
                table.insert(client.onWorkspaceSpawnRun, {
                    _fn = onChildAdded
                })
                table.insert(client.onWorkspaceRemovedRun, {
                    _fn = onChildRemoved
                })
                local function loop()
                    local master_switch = global.ui_status.master_switch_marker
                    if not master_switch then
                        if doesMarkerExist() then
                            markerRemove()
                        end
                        return false
                    end
                    local bool = global.ui_status.allow_football_marker
                    if bool then
                        local soccerBall = workspace:FindFirstChild("SoccerBall")
                        if soccerBall then
                            if not doesMarkerExist(soccerBall) then
                                markerCreate(soccerBall)
                            end
                        end
                    else
                        if doesMarkerExist() then
                            markerRemove()
                        end
                    end
                end
                createloop(0.5, loop)
            end
            footballMarker()
            local function npcsMarker()
                local image = getsynasset("icetray/resource/robot.png")
                if not image then
                    warn("error while trying to get synapse asset `robot.png`")
                end
                local markerColors = global.registry.markerColors
                local worldmarker = client.modules.worldMarker
                local system = client.modules.system
                local group = client.modules.group
                local npcs = {}
                local function markerCreate(part)
                    local function makeNPCsGroups(drop, group)
                        table.insert(npcs, {
                            part = part;
                            drop = drop;
                            group = group;
                        })
                    end
                    local function makeMarker()
                        local group = group.new()
                        system.addGroup(group)
                        group:SetEnabled(true)
                        local new = worldmarker.new()
                        new:SetAdornee(part)
                        new:SetScreenGui(system.gui)
                        new:SetSizes({8, {24, 0}, {math.huge, 8}})
                        local function createImageLabel()
                            local imagelabel = Instance.new("ImageLabel")
                            imagelabel.BorderSizePixel = 0
                            imagelabel.BackgroundTransparency = 1
                            imagelabel.Size = UDim2.new(0.7, 0, 0.7, 0)
                            imagelabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                            imagelabel.AnchorPoint = Vector2.new(0.5, 0.5)
                            imagelabel.ZIndex = 3
                            imagelabel.Parent = new.FrameInner
                            imagelabel.Image = image
                        end
                        createImageLabel()
                        new.FrameInner.ImageColor3 = markerColors.NPCs
                        group:Add(new)
                        makeNPCsGroups(new, group)
                    end
                    makeMarker()
                end
                local function markerRemove(root)
                    if not root then
                        for i,v in next, npcs do
                            if not v.part:IsDescendantOf(workspace) then
                                v.group:Remove(v.drop)
                                v.drop:Destroy()
                                v.drop = nil
                                table.remove(npcs, i)
                                return true
                            end
                            if v.part ~= nil then
                                if v.drop and v.group then
                                    v.group:Remove(v.drop)
                                    v.drop:Destroy()
                                    v.drop = nil
                                end
                                table.remove(npcs, i)
                            end
                        end
                        return false
                    end
                    for i,v in next, npcs do
                        if not v.part:IsDescendantOf(workspace) then
                            v.group:Remove(v.drop)
                            v.drop:Destroy()
                            v.drop = nil
                            table.remove(npcs, i)
                            return true
                        end
                        if v.part == root then
                            v.group:Remove(v.drop)
                            v.drop:Destroy()
                            v.drop = nil
                            table.remove(npcs, i)
                        end
                    end
                end
                local function doesMarkerExist(root)
                    local result = false
                    if not root then
                        for i,v in next, npcs do
                            result = v.drop ~= nil
                        end
                        return result
                    end
                    for i,v in next, npcs do
                        if v.part == root then
                            result = v.drop ~= nil
                        end
                    end
                    return result
                end
                local function onChildAdded(part)
                    local bool = global.ui_status.master_switch_marker
                    if not bool then
                        return false
                    end
                    local allow_npcs_marker = global.ui_status.allow_npcs_marker
                    if not allow_npcs_marker then
                        return false
                    end
                    if part and part.Value and part.Value.HumanoidRootPart then
                        if not doesMarkerExist(part.Value.HumanoidRootPart) then
                            markerCreate(part.Value.HumanoidRootPart)
                        end
                    end
                end
                local function onChildRemoved(part)
                    if part and part.Value and part.Value.HumanoidRootPart then
                        if doesMarkerExist(part.Value.HumanoidRootPart) then
                            markerRemove(part.Value.HumanoidRootPart)
                        end
                    end
                end
                workspace.GuardNPCPlayers.ChildAdded:connect(onChildAdded)
                workspace.GuardNPCPlayers.ChildRemoved:connect(onChildRemoved)
                local function onChildAdded2(part)
                    local bool = global.ui_status.master_switch_marker
                    if not bool then
                        return false
                    end
                    local allow_npcs_marker = global.ui_status.allow_npcs_marker
                    if not allow_npcs_marker then
                        return false
                    end
                    if not doesMarkerExist(part.HumanoidRootPart) then
                        markerCreate(part.HumanoidRootPart)
                    end
                end
                local function onChildRemoved2(part)
                    if doesMarkerExist(part.HumanoidRootPart) then
                        markerRemove(part.HumanoidRootPart)
                    end
                end
                workspace.MansionRobbery.GuardsFolder.ChildAdded:connect(onChildAdded2)
                workspace.MansionRobbery.GuardsFolder.ChildRemoved:connect(onChildRemoved2)
                local function destroyOnNoNDescendant()
                    for i,v in next, npcs do
                        if not v.part:IsDescendantOf(workspace) then
                            v.group:Remove(v.drop)
                            v.drop:Destroy()
                            v.drop = nil
                            table.remove(npcs, i)
                        end
                        task.wait(1)
                    end
                end
                local function loop()
                    local master_switch = global.ui_status.master_switch_marker
                    if not master_switch then
                        if doesMarkerExist() then
                            destroyOnNoNDescendant()
                        end
                        return false
                    end
                    local bool = global.ui_status.allow_npcs_marker
                    if bool then
                        if #workspace.MansionRobbery.GuardsFolder:GetChildren() > 0 then
                            for i,v in next, workspace.MansionRobbery.GuardsFolder:GetChildren() do
                                local root = v:FindFirstChild("HumanoidRootPart")
                                if root then
                                    if not doesMarkerExist(root) then
                                        markerCreate(root)
                                    end
                                end
                            end
                        end
                        if #workspace.GuardNPCPlayers:GetChildren() > 0 then
                            for i,v in next, workspace.GuardNPCPlayers:GetChildren() do
                                if v and v.Value then
                                    local root = v.Value:FindFirstChild("HumanoidRootPart")
                                    if root then
                                        if not doesMarkerExist(root) then
                                            markerCreate(root)
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if doesMarkerExist() then
                            markerRemove()
                        end
                    end
                end
                local loopf
                local cache
                local function tagService()
                    cache = client.tags.new("markersnpcs", 0, false, function(val)
                        if val then
                            loopf = createloop(0, loop)
                        else
                            if loopf then
                                markerRemove()
                                loopf:disconnect()
                                loopf = nil
                            else
                                warn("no loopf")
                            end
                        end
                    end)
                end
                tagService()
                local function loop()
                    local bool = global.ui_status.allow_npcs_marker
                    if cache then
                        cache.obj.Value = bool
                    end
                end
                createloop(0, loop)
            end
            npcsMarker()
        end
        markerCorrection()
    end
    Corrections()
    local function icetraygui()
        local function hideSectionsOnMarkersOff()
            local markerSection = global.ui.markerSection
            local getTeamsSection = markerSection.teamsSection
            local getObjSection = markerSection.objSection
            local getSettingsSection = markerSection.settingsSection
            local cache
            task.spawn(function()
                for i,v in next, markerSection do
                    v.Visible = global.ui_status.master_switch_marker
                end
            end)
            local function tagService()
                cache = client.tags.new("markers_master_switch", 0, false, function(val)
                    for i,v in next, markerSection do
                        v.Visible = val
                    end
                end)
            end
            tagService()
            local function loop()
                local bool = global.ui_status.master_switch_marker
                if cache then
                    cache.obj.Value = bool
                end
            end
            createloop(0, loop)
        end
        hideSectionsOnMarkersOff()
    end
    icetraygui()
    local function createFOVCircle()
        local drawing = global.functions.drawing
        if not drawing then
            warn("Drawing is not supported.")
            return false
        end
        local circle = drawing.new("Circle")
        local camera = workspace.CurrentCamera
        local mouseLocation = uis:GetMouseLocation()
        circle.Position = Vector2.new(mouseLocation.X, mouseLocation.Y)
        circle.Transparency = 0.7
        circle.Color = Color3.fromRGB(255, 255, 255)
        circle.Filled = false
        circle.NumSides = 64
        circle.Thickness = 0
        circle.Visible = false
        circle.Radius = 0
        local function loop()
            if global.ui_status.master_switch_silentaim then 
                local mouseLocation = uis:GetMouseLocation()
                circle.Visible = global.ui_status.fov_circle
                circle.Position = Vector2.new(mouseLocation.X, mouseLocation.Y)
                circle.Radius = global.ui_status.fov_silentaim
            else
                circle.Visible = false
            end
        end
        local cache
        local loopf
        local function tagService()
            cache = client.tags.new("fovcircle", 0, false, function(val)
                if val then
                    loopf = createloop(0, loop)
                else
                    if loopf then
                        loopf:disconnect()
                        loopf = nil
                    end
                end
            end)
        end
        tagService()
        local function loop()
            local bool = global.ui_status.fov_circle
            if cache then
                cache.obj.Value = bool
            end
        end
        createloop(0, loop)
    end
    createFOVCircle()
    local function on_loadup()
        local function showContextMessage()
            local contextMessage = client.contextModule
            if contextMessage then
                if contextMessage.status() then
                    contextMessage.close()
                    while true do
                        if contextModule.status() then
                            contextMessage.close()
                            break
                        else
                            break
                        end
                        task.wait()
                    end
                    contextMessage.open()
                else
                    contextMessage.open()
                end
                contextMessage.setmsg("Loaded ice tray v4")
                task.delay(5, function()
                    if contextMessage.status() then
                        contextMessage.close()
                    end
                end)
            end
        end
        local function doFireworks()
            local fireworks = global.registry.fireworks.Fireworks
            fireworks(5)
        end
        local function on_loadup()
            if not global.ui_status then
                error("Failed loading Configuration")
            end
            local cacheFolder = "icetray/cache"
            local configFolder = "icetray/config"
            local makefolder = global.functions.makefolder
            local isfolder = global.functions.isfolder
            local isfile = global.functions.isfile
            local readfile = global.functions.readfile
            local listfiles = global.functions.listfiles
            local function makeCache()
                local function getLatestLoadedConfig()
                    local isfolder = isfolder(cacheFolder)
                    if not isfolder then
                        makefolder(cacheFolder)
                        global.ui_status.config_name = "new"
                    end
                    local getCfg = isfile(cacheFolder.."/cfg.json")
                    if not getCfg then
                        writefile(("%s/cfg.json"):format(cacheFolder), httpservice:JSONEncode({cfg = "new"}))
                        while true do
                            if isfile(("%s/cfg.json"):format(cacheFolder)) then
                                break
                            end
                            task.wait()
                        end
                    end
                    local file = readfile(("%s/cfg.json"):format(cacheFolder))
                    local decoded = httpservice:JSONDecode(file)
                    global.ui_status.config_name = decoded.cfg
                end
                getLatestLoadedConfig()
            end
            makeCache()
            local function makeConfiguration()
                local function createConfiguration()
                    local fileName = global.ui_status.config_name or "new"
                    local function checkAutoSaveJson()
                        local file = isfile(("%s/%s.json"):format(configFolder, fileName))
                        if not file then
                            return false
                        end
                        file = readfile(("%s/%s.json"):format(configFolder, fileName))
                        return httpservice:JSONDecode(file)
                    end
                    local checkAutoSaveJson = checkAutoSaveJson()
                    if not checkAutoSaveJson then
                        global.ui_status.mainUI = true
                        writefile(("%s/%s.json"):format(configFolder, fileName), httpservice:JSONEncode(global.ui_status))
                    else
                        if checkAutoSaveJson.open_gunstore_ui then  -- asta nu trebuie sa fie salvata. daca e, atunci se va pune pe false.
                            checkAutoSaveJson.open_gunstore_ui = false 
                        end
                        if checkAutoSaveJson.kill_all_in_vehicle then
                            checkAutoSaveJson.kill_all_in_vehicle = false
                        end
                        global.ui_status = checkAutoSaveJson
                    end
                end
                createConfiguration()
                local _oldCfg = {}
                local function getDefaultValues()
                    local config = global.config
                    for i,v in next, config do
                        if v and v.Get then
                            local state = global.ui_status[i]
                            table.insert(_oldCfg, {
                                name = i;
                                state = v.Get();
                            })
                        else
                            table.insert(_oldCfg, {
                                name = i;
                                state = "";
                            })
                        end
                    end
                end
                task.spawn(getDefaultValues)
                local function configurationSet()
                    local config = global.config
                    for i,v in next, config do
                        local ui_status = global.ui_status[i]
                        if v and v.Set and ui_status ~= nil then
                            v.Set(ui_status)
                        end
                    end
                end
                configurationSet()
                local do_not_save = false
                local tagCache
                local function tagService()
                    tagCache = client.tags.new("ShouldAutoSaveCurrentCfg", 0, false, function(val)
                        global.force_hide_ui = val
                        if val then
                            global.notify("Loading config...", 4)
                        else
                            global.force_hide_ui = false
                            global.ui_status.mainUI = true
                            global.notify("Successfully loaded config", 4)
                        end
                    end)
                    local function loop()
                        local bool = do_not_save
                        if tagCache then
                            tagCache.obj.Value = bool
                        end
                    end
                    createloop(0, loop)
                end
                tagService()
                local statusRobberies = global.ui.statusRobberies
                local getLoadedLabel = statusRobberies["LOADED_CONFIG"]
                local function load_config(name)
                    name = tostring(name)
                    if do_not_save then
                        global.notify("Config load failed", 2)
                        return false
                    end
                    do_not_save = true
                    local file = isfile(("%s/%s.json"):format(configFolder, name))
                    if not file then
                        global.notify(("Could not find config with name %s"):format(name), 4)
                        do_not_save = false
                        return false
                    end
                    file = readfile(("%s/%s.json"):format(configFolder, name))
                    if not file then
                        global.notify("Failed reading config file", 5)
                        do_not_save = false
                        return false
                    end
                    local decoded = httpservice:JSONDecode(file)
                    if decoded.open_gunstore_ui then
                        decoded.open_gunstore_ui = false
                    end
                    if decoded.kill_all_in_vehicle then
                        decoded.kill_all_in_vehicle = false
                    end
                    global.ui_status = decoded
                    if global.ui_status.config_name ~= name then
                        print(("cfg name is now file name `%s`"):format(name))
                    end
                    global.ui_status.config_name = name
                    statusRobberies["LOADED_CONFIG"] = ("Currently loaded config: %s%s"):format(global.ui_status.config_name, ".json")
                    local _newstate = {}
                    local config = global.config
                    for i,v in next, _oldCfg do
                        _newstate[v.name] = v.state
                    end
                    for i,v in next, config do
                        local new, state = _newstate[i], global.ui_status[i]
                        if v and v.Set then
                            if state == nil then
                                v.Set(_newstate[i])
                            else
                                v.Set(state)
                            end
                        end
                    end
                    writefile(("%s/%s.json"):format(configFolder, global.ui_status.config_name), httpservice:JSONEncode(global.ui_status))
                    writefile(("%s/cfg.json"):format(cacheFolder), httpservice:JSONEncode({cfg = global.ui_status.config_name}))
                    task.delay(0.1, function()
                        do_not_save = false
                    end)
                end
                global.load_config = load_config
                local function refresh_config()
                    local cfgs = {}
                    for i,v in next, listfiles(configFolder) do
                        if v and string.find(v, "json") then
                            local _, cfg_json = unpack(string.split(v, "\\"))
                            local cfg_name = unpack(string.split(cfg_json, ".json"))
                            table.insert(cfgs, cfg_name)
                        else
                            print(("Couldn't recognise path: %s. Is this a JSON type file?"):format(v))
                        end
                    end
                    local lcfg = global.config.load_config
                    lcfg.list = cfgs
                    task.delay(0.1, function()
                        lcfg.reload(lcfg.list, true)
                    end)
                end
                refresh_config()
                global.refresh_config = refresh_config
                local function save_config()
                    local fileName = global.ui_status.config_name
                    writefile(("%s/%s.json"):format(configFolder, fileName), httpservice:JSONEncode(global.ui_status))
                    writefile(("%s/cfg.json"):format(cacheFolder), httpservice:JSONEncode({cfg = global.ui_status.config_name}))
                    global.notify("Saved config successfully.", 5)
                end
                global.save_config = save_config
                local function autoSaveConfiguration()
                    statusRobberies["LOADED_CONFIG"] = ("Currently loaded config: %s%s"):format(global.ui_status.config_name, ".json")
                    local function loop()
                        if do_not_save then
                            return false
                        end
                        local fileName = global.ui_status.config_name
                        writefile(("%s/%s.json"):format(configFolder, fileName), httpservice:JSONEncode(global.ui_status))
                        writefile(("%s/cfg.json"):format(cacheFolder), httpservice:JSONEncode({cfg = global.ui_status.config_name}))
                    end
                    createloop(10, loop)
                end
                autoSaveConfiguration()
            end
            makeConfiguration()
            global._loaded = true
            while true do
                if global._loaded then
                    break
                end
                task.wait()
            end
            pcall(showContextMessage)
            doFireworks()
        end
        on_loadup()
    end
    on_loadup()
    global.is_stable_version = not IS_NOT_OBFUSCATED
    log(`Executor: {global.getExecutor}`)
    log(("Loaded ice tray v4 in %s second(s). Build: %s-%s"):format(tostring(math.floor(tick() - execution_time)), global.version, IS_NOT_OBFUSCATED and "debug" or "stable"))
end
loadup()
