-- Rose Stake
SMODS.Stake {
    name = "Rose Stake",
    key = "rose",
    prefix_config = {  applied_stakes = { mod = false } },
    applied_stakes = { "gold" },
    pos = { x = 0, y = 0 },
    sticker_pos = { x = 1, y = 0 },
    loc_txt = {
    name = "Rose Stake",
        text = {
            "Shop can have {C:attention}Burdened{} Jokers",
            "{C:inactive,s:0.8}(Take up an extra slot)",
            "{s:0.8}Applies all previous Stakes",
        },
    sticker = {
    name = "Rose Sticker",
    text = {
        "Used this Joker",
        "to win on {C:attention}Rose",
        "{C:attention}Stake{} difficulty",
        },
    }
},
    atlas = 'CustomStakes',
    sticker_atlas = 'CustomStickers',
    shiny = true,
    modifiers = function()
        G.GAME.modifiers.enable_hatch_burdened = true
    end,
    colour = G.C.RED,
}

-- Diamond Stake
SMODS.Stake {
    name = "Crystal Stake",
    key = "crystal",
    prefix_config = {  applied_stakes = { mod = false } },
    applied_stakes = { "hatch_rose" },
    pos = { x = 0, y = 1 },
    sticker_pos = { x = 2, y = 0 },
    loc_txt = {
    name = "Crystal Stake",
        text = {
            "{C:red}-1{} Hand Size",
            "{s:0.8}Applies all previous Stakes",
        },
    sticker = {
    name = "Crystal Sticker",
    text = {
            "Used this Joker",
            "to win on {C:attention}Crystal",
            "{C:attention}Stake{} difficulty",
        },
    }
},
    atlas = 'CustomStakes',
    shiny = true,
    sticker_atlas = 'CustomStickers',
    modifiers = function()
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size - 1
    end,
    colour = G.C.BLUE,
}