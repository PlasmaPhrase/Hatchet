
SMODS.Joker{ --Nine Lives
    key = "ninelives",
    config = {
        extra = {
            ninelives = 0,
            mult = 9,
            start_dissolve = 0,
            n = 0,
            no = 0,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Nine Lives',
        ['text'] = {
            [1] = 'Every {C:attention}9{} held in hand gives {C:red}+9{} Mult',
            [2] = '{C:attention}Self destructs{} after nine rounds',
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatchet_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.ninelives}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.end_of_round  then
            if context.other_card:get_id() == 9 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big((card.ability.extra.ninelives or 0)) >= to_big(9) then
                local target_joker = card
                
                if target_joker then
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                end
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            return {
                func = function()
                    card.ability.extra.ninelives = (card.ability.extra.ninelives) + 1
                    return true
                end,
                message = "-1 Life"
            }
        end
    end
}