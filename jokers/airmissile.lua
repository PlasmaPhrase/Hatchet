SMODS.Joker{ --Air Missile
    key = "airmissile",
    config = {
        extra = {
            xmult = 1,
            odds = 4,
            levels = -1
        }
    },
    loc_txt = {
        ['name'] = 'Air Missile',
        ['text'] = {
            [1] = '{C:green}#2# in #3#{} chance to downgrade',
            [2] = 'level of played {C:attention}poker hand{}',
            [3] = 'and gain {X:red,C:white}X0.5{} Mult',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 4
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatchet_airmissile') 
        return {vars = {card.ability.extra.xmult, new_numerator, new_denominator}}
    end,

    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_f9f9ec2e', 1, card.ability.extra.odds, 'j_hatchet_airmissile', false) then
                    local target_hand = (context.scoring_name or "High Card")
                        SMODS.calculate_effect({level_up = card.ability.extra.levels,
                    level_up_hand = target_hand}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex'), colour = G.C.RED})
                        SMODS.calculate_effect({func = function()
                            card.ability.extra.xmult = (card.ability.extra.xmult) + 0.5
                            return true
                            end}, card)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "x0.5", colour = G.C.GREEN})
                        end
                    end
                end
                if context.cardarea == G.jokers and context.joker_main  then
                    return {
                        Xmult = card.ability.extra.xmult
                    }
                end
            end
}