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

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {25,13,4,10,14,29,32,30,9,2,17,22,15,18,34,16,3,7,12,6,26,8,24,27,23,11,31,1,35,19,5,20,33,21,28}

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


local deckIndexList = {1}

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

load_jokers_folder()
load_enhancements_folder()
load_decks_folder()
SMODS.ObjectType({
    key = "hatchet_food",
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
    key = "hatchet_hatchet_jokers",
    cards = {
        ["j_hatchet_blackjoker"] = true,
        ["j_hatchet_blueshoes"] = true,
        ["j_hatchet_composter"] = true,
        ["j_hatchet_d20"] = true,
        ["j_hatchet_dawn"] = true,
        ["j_hatchet_handout"] = true,
        ["j_hatchet_musketeer"] = true,
        ["j_hatchet_needlenonsense"] = true,
        ["j_hatchet_nightvision"] = true,
        ["j_hatchet_ninelives"] = true,
        ["j_hatchet_nodice"] = true,
        ["j_hatchet_pizza"] = true,
        ["j_hatchet_riskyrevolver"] = true,
        ["j_hatchet_stockexchange"] = true,
        ["j_hatchet_swindler"] = true,
        ["j_hatchet_trickyjoker"] = true
    },
})