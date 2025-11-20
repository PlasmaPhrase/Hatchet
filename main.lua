SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBlinds", 
    path = "CustomBlinds.png", 
    px = 34,
    py = 34, 
    frames = 21, 
    atlas_table = "ANIMATION_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {32,18,5,12,19,36,42,37,10,3,23,28,20,24,44,21,4,9,15,8,33,41,30,34,29,14,40,1,47,25,7,26,43,27,35,38,45,22,39,17,31,2,46,6,16,13,11}

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/jokers"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #jokerIndexList do
        local file_name = files[jokerIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("jokers/" .. file_name))()
        end
    end
end


local consumableIndexList = {7,3,1,2,5,11,9,6,12,8,4,10}

local function load_consumables_folder()
    local mod_path = SMODS.current_mod.path
    local consumables_path = mod_path .. "/consumables"
    local files = NFS.getDirectoryItemsInfo(consumables_path)
    local set_file_number = #files + 1
    for i = 1, #files do
        if files[i].name == "sets.lua" then
            assert(SMODS.load_file("consumables/sets.lua"))()
            set_file_number = i
        end
    end    
    for i = 1, #consumableIndexList do
        local j = consumableIndexList[i]
        if j >= set_file_number then 
            j = j + 1
        end
        local file_name = files[j].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("consumables/" .. file_name))()
        end
    end
end


local enhancementIndexList = {3,1,2}

local function load_enhancements_folder()
    local mod_path = SMODS.current_mod.path
    local enhancements_path = mod_path .. "/enhancements"
    local files = NFS.getDirectoryItemsInfo(enhancements_path)
    for i = 1, #enhancementIndexList do
        local file_name = files[enhancementIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("enhancements/" .. file_name))()
        end
    end
end

local deckIndexList = {2,1}

local function load_decks_folder()
    local mod_path = SMODS.current_mod.path
    local decks_path = mod_path .. "/decks"
    local files = NFS.getDirectoryItemsInfo(decks_path)
    for i = 1, #deckIndexList do
        local file_name = files[deckIndexList[i]].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("decks/" .. file_name))()
        end
    end
end

assert(SMODS.load_file("src/blinds.lua"))()
assert(SMODS.load_file("src/challenges.lua"))()

local function load_boosters_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("boosters.lua"))()
end

load_boosters_file()
load_jokers_folder()
load_consumables_folder()
load_enhancements_folder()
load_decks_folder()
SMODS.ObjectType({
    key = "hatch_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "hatch_hatch_jokers",
    cards = {
        ["j_hatch_airmissile"] = true,
        ["j_hatch_blackjoker"] = true,
        ["j_hatch_blueshoes"] = true,
        ["j_hatch_cave"] = true,
        ["j_hatch_composter"] = true,
        ["j_hatch_d20"] = true,
        ["j_hatch_etzchaim"] = true,
        ["j_hatch_giraffe"] = true,
        ["j_hatch_graveyardshift"] = true,
        ["j_hatch_handout"] = true,
        ["j_hatch_loveletter"] = true,
        ["j_hatch_musketeer"] = true,
        ["j_hatch_needlenonsense"] = true,
        ["j_hatch_nightvision"] = true,
        ["j_hatch_ninelives"] = true,
        ["j_hatch_nodice"] = true,
        ["j_hatch_pizza"] = true,
        ["j_hatch_plantparty"] = true,
        ["j_hatch_riskyrevolver"] = true,
        ["j_hatch_staircase"] = true,
        ["j_hatch_stockexchange"] = true,
        ["j_hatch_sunset"] = true,
        ["j_hatch_swindler"] = true,
        ["j_hatch_trickyjoker"] = true,
        ["j_hatch_wildside"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end