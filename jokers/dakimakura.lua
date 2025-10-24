SMODS.Joker{ --Dakimakura
    key = "dakimakura",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Dakimakura',
        ['text'] = {
            [1] = 'If played hand contains a {C:attention}Flush{}',
            [2] = 'convert each card into',
            [3] = '{C:attention}random suits{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
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
            if next(context.poker_hands["Flush"]) then
                assert(SMODS.change_base(context.other_card, pseudorandom_element(SMODS.Suits, 'edit_card_suit').key, nil))
                return {
                    message = "Card Modified!"
                    }
                end
            end
        end
}