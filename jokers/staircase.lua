SMODS.Joker{ --Staircase
    key = "staircase",
    config = {
        extra = {
            odds = 8,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Staircase',
        ['text'] = {
            [1] = 'Every played {C:attention}face card{} has a {C:green}#2# in #3#{} chance',
            [2] = 'to create a {C:green}Sephirot{} card',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatchet_staircase') 
        return {vars = {card.ability.extra.n, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_face() then
                if SMODS.pseudorandom_probability(card, 'group_0_8534ce80', 1, card.ability.extra.odds, 'j_hatchet_staircase', false) then
                    for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                        G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            play_sound('timpani')
                            SMODS.add_card({ set = 'sephirot', })                            
                            card:juice_up(0.3, 0.5)
                            return true
                            end
                        }))
                    end
                    delay(0.6)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_consumable and localize('k_plus_consumable') or nil, colour = G.C.PURPLE})
                end
            end
        end
    end
}