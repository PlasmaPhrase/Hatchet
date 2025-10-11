SMODS.Joker{ --Lucky 7
    key = "lucky7",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Lucky 7',
        ['text'] = {
            [1] = 'All played {C:orange}7{} cards become',
            [2] = '{C:orange}Lucky{} cards when scored'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:get_id() == 7 then
                context.other_card:set_ability(G.P_CENTERS.m_lucky)
                return {
                    message = "Lucky!"
                }
            end
        end
    end
}