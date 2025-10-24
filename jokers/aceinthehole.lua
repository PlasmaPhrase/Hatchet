SMODS.Joker{ --Ace in the Hole
    key = "aceinthehole",
    config = {
        extra = {
            chips = 100
        }
    },
    loc_txt = {
        ['name'] = 'Ace in the Hole',
        ['text'] = {
            [1] = 'Each {C:orange}Ace{} held in hand gives {C:blue}+100{} Chips'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round  then
        if context.other_card:get_id() == 14 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
end
}