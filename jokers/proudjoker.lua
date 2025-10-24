SMODS.Joker{ --Proud Joker
    key = "proudjoker",
    config = {
        extra = {
            mult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Proud Joker',
        ['text'] = {
            [1] = 'Played {C:attention}Stone {}cards give {C:mult}+3{} Mult when scored'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}