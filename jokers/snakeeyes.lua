SMODS.Joker{ --Snake Eyes
    key = "snakeeyes",
    config = {
        extra = {
            set_probability = 2,
            denominator = 0
        }
    },
    loc_txt = {
        ['name'] = 'Snake Eyes',
        ['text'] = {
            [1] = 'All {C:green}denominators{} are set to {C:attention}2{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',

    
    calculate = function(self, card, context)
        if context.fix_probability  then
            local numerator, denominator = context.numerator, context.denominator
            denominator = card.ability.extra.set_probability
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
    end
}