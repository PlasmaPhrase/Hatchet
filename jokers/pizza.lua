SMODS.Joker{ --Pizza
    key = "pizza",
    config = {
        extra = {
            pizza = 0,
            chips = 80,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Pizza',
        ['text'] = {
            [1] = '{C:blue}+80{} Chips',
            [2] = 'Lasts 8 rounds',
            [3] = '(Used {C:blue}#1#{} times)'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.pizza}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (card.ability.extra.pizza or 0) >= 8 then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                        end
                    }
                else
                    card.ability.extra.pizza = (card.ability.extra.pizza) + 1
                    return {
                        chips = card.ability.extra.chips
                    }
                end
            end
            if context.after and context.cardarea == G.jokers  then
                return {
                    message = "-1 Slice"
                }
            end
        end
}