
SMODS.Joker{ --Super Sevens
    key = "supersevens",
    config = {
        extra = {
            seven = 0
        }
    },
    loc_txt = {
        ['name'] = 'Super Sevens',
        ['text'] = {
            [1] = 'Earn {C:chips}+7{} Chips',
            [2] = 'for each {C:attention}7{} played',
            [3] = '{C:inactive}(Currently {C:blue}#1#{}){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
        y = 0
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
    discovered = false,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.seven}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:get_id() == 7 then
                card.ability.extra.seven = (card.ability.extra.seven) + 7
                return {
                    message = "+7 Chips"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.seven
            }
        end
    end
}