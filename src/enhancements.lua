-- Sulfur 🜍
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
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.sulfur}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra.sulfur = (card.ability.extra.sulfur) + 1
            return {
                message = "Upgrade!",
                extra = {
                    mult = card.ability.extra.sulfur
                }
            }
        end
    end
}

-- Mercury ☿
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
            return {
                chips = pseudorandom('chips_8d51b6f1', card.ability.extra.chips_min, card.ability.extra.chips_max)
            }
        end
    end
}

-- Salt 🜔
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
        [1] = 'Enhanced card has a {C:green}#1# in 2{} chance',
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
            if SMODS.pseudorandom_probability(card, 'group_0_739e6c78', 1, card.ability.extra.odds, 'm_hatch_salt') then
                card.should_retrigger = true
            card.ability.extra.retrigger_times = 2
            end
        end
    end
}