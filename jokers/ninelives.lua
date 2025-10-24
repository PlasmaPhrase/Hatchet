SMODS.Joker{ --Nine Lives
    key = "ninelives",
    config = {
        extra = {
            ninelives = 0,
            mult = 9,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Nine Lives',
        ['text'] = {
            [1] = 'Every {C:attention}9{} held in hand gives {C:red}+9{} Mult',
            [2] = '{C:attention}Self destructs{} after nine uses',
            [3] = '{C:inactive}(Used #1# times){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.ninelives}}
    end,

    
    calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.end_of_round  then
        if context.other_card:get_id() == 9 then
            return {
                mult = card.ability.extra.mult,
                extra = {
                func = function()
                    card.ability.extra.ninelives = (card.ability.extra.ninelives) + 1
                    return true
                    end,
                    message = "-1 Life",
                    colour = G.C.GREEN
                }
            }
        end
    end
    if context.cardarea == G.jokers and context.joker_main  then
        if (card.ability.extra.ninelives or 0) >= 9 then
            return {
                func = function()
                    card:start_dissolve()
                    return true
                    end
                }
            end
        end
    end
}