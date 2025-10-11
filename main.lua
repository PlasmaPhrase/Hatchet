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

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local jokerIndexList = {23,4,12,26,9,13,16,27,8,2,17,20,14,18,29,15,3,6,11,5,24,7,22,25,21,10,28,1,30,19}

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

load_jokers_folder()
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
        ["j_hatchet_d20"] = true,
        ["j_hatchet_dawn"] = true,
        ["j_hatchet_handout"] = true,
        ["j_hatchet_musketeer"] = true,
        ["j_hatchet_needlenonsense"] = true,
        ["j_hatchet_pizza"] = true,
        ["j_hatchet_riskyrevolver"] = true,
        ["j_hatchet_stockexchange"] = true,
        ["j_hatchet_trickyjoker"] = true
    },
})