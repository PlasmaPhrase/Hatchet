SMODS.Joker{ --D20
    key = "d20",
    config = {
        extra = {
            odds = 20,
            dollars = 20
        }
    },
    loc_txt = {
        ['name'] = 'D20',
        ['text'] = {
            [1] = '{C:green}#1# in 20{} chance to get {C:money}$20{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_hatchet_d20') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_bb3f3a02', 1, card.ability.extra.odds, 'j_hatchet_d20', false) then
              SMODS.calculate_effect({dollars = card.ability.extra.dollars}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Rolled a 20!", colour = G.C.MONEY})
          end
            end
        end
    end
}