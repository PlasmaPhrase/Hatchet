SMODS.Joker{ --Wheelbarrow
    key = "wheelbarrow",
    config = { extra = { multvar = 1} },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'vremade_wheelbarrow' .. G.GAME.round_resets.ante)
        return { vars = { numerator, denominator }, card.ability.extra.mult }
    end,
    loc_txt = {
        ['name'] = 'Wheelbarrow',
        ['text'] = {
            [1] = 'Gains {X:red,C:white}X0.5{} Mult per round',
            [2] = '{C:green}1 of 2{} cards get drawn face down',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 6,
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
    pools = { ["hatch_hatch_jokers"] = true },

    calculate = function(self, blind, context)
        if context.stay_flipped and context.to_area == G.hand and
                SMODS.pseudorandom_probability(blind, 'vremade_wheelbarrow', 1, 2) then
                return {
                    stay_flipped = true
                }
            end
            if context.end_of_round and context.game_over == false and context.main_eval  then
        return {
            func = function()
                blind.ability.extra.multvar = (blind.ability.extra.multvar) + 0.5
                return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = blind.ability.extra.multvar
            }
        end
    end
}