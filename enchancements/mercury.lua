SMODS.Enhancement {
    key = 'mercury',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            chips_min = 0,
            chips_max = 75
        }
    },
    loc_txt = {
        name = 'Mercury',
        text = {
        [1] = 'Enhanced card gives between {C:blue}+0{} to {C:blue}+75{} Chips when scored'
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { chips = pseudorandom('chips_8d51b6f1', card.ability.extra.chips_min, card.ability.extra.chips_max) }
        end
    end
}