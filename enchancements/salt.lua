SMODS.Enhancement {
    key = 'salt',
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            odds = 2,
            retrigger_times = 2
        }
    },
    loc_txt = {
        name = 'Salt',
        text = {
        [1] = 'Enhanced card has a {C:green}1 in 2{} chance',
        [2] = 'to retrigger twice when scored'
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
        if context.repetition and card.should_retrigger then
            return { repetitions = card.ability.extra.retrigger_times }
        end
        if context.main_scoring and context.cardarea == G.play then
            card.should_retrigger = false
            if SMODS.pseudorandom_probability(card, 'group_0_739e6c78', 1, card.ability.extra.odds, 'm_hatchet_salt') then
                card.should_retrigger = true
            card.ability.extra.retrigger_times = 2
            end
        end
    end
}