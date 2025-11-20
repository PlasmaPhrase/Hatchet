
SMODS.Joker{ --Seven Sisters
    key = "sevensisters",
    config = {
        extra = {
            Xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'Seven Sisters',
        ['text'] = {
            [1] = '{X:red,C:white}X2{} Mult if played hand',
            [2] = 'has a scoring {C:attention}7 {}and a',
            [3] = 'scoring card of any other rank'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}