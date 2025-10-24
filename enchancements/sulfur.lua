SMODS.Enhancement {
    key = 'sulfur',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            sulfur = 0
        }
    },
    loc_txt = {
        name = 'Sulfur',
        text = {
        [1] = 'Permanently gain {C:hearts}+1{} Mult when scored'
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = true,
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
            card.ability.extra.sulfur = (card.ability.extra.sulfur) + 1
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Upgrade!", colour = G.C.GREEN})
            SMODS.calculate_effect({mult = card.ability.extra.sulfur}, card)
        end
    end
}