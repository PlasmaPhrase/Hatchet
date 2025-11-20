
SMODS.Joker{ --No Dice
    key = "nodice",
    config = {
        extra = {
            mult = 3,
            mult2 = 3,
            mult3 = 3,
            mult4 = 3,
            mult5 = 3,
            mult6 = 3,
            set_probability = 6,
            set_probability2 = 1000,
            set_probability3 = 1,
            set_probability4 = 1,
            set_probability5 = 1,
            set_probability6 = 4,
            set_probability7 = 7,
            set_probability8 = 1,
            set_probability9 = 2,
            set_probability10 = 1,
            numerator = 0,
            denominator = 0
        }
    },
    loc_txt = {
        ['name'] = 'No Dice',
        ['text'] = {
            [1] = 'Each played {C:attention}A{}, {C:attention}2{}, {C:attention}3{}, {C:attention}4{}, {C:attention}5{}, {C:attention}6{}',
            [2] = 'give {C:red}+3{} Mult when scored',
            [3] = 'All {C:attention}successful {}{C:green}probabilities{} fail',
            [4] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                return {
                    mult = card.ability.extra.mult
                }
            elseif context.other_card:get_id() == 2 then
                return {
                    mult = card.ability.extra.mult2
                }
            elseif context.other_card:get_id() == 3 then
                return {
                    mult = card.ability.extra.mult3
                }
            elseif context.other_card:get_id() == 4 then
                return {
                    mult = card.ability.extra.mult4
                }
            elseif context.other_card:get_id() == 5 then
                return {
                    mult = card.ability.extra.mult5
                }
            elseif context.other_card:get_id() == 6 then
                return {
                    mult = card.ability.extra.mult6
                }
            end
        end
        if context.fix_probability  then
            local numerator, denominator = context.numerator, context.denominator
            if context.identifier == "gros_michel" then
                numerator = card.ability.extra.set_probability
            elseif context.identifier == "cavendish" then
                numerator = card.ability.extra.set_probability2
            elseif (context.identifier == "bloodstone" or context.identifier == "halu1" or context.identifier == "parking" or context.identifier == "space" or context.identifier == "space" or context.identifier == "8ball") then
                numerator = card.ability.extra.set_probability3
            elseif context.identifier == "wheel_of_fortune" then
                numerator = card.ability.extra.set_probability4
            elseif (context.identifier == "lucky_money" or context.identifier == "lucky_mult") then
                numerator = card.ability.extra.set_probability5
            elseif context.identifier == "glass" then
                numerator = card.ability.extra.set_probability6
            elseif context.identifier == "wheel" then
                numerator = card.ability.extra.set_probability7
            elseif (context.identifier == "j_hatchet_d20" or context.identifier == "j_hatchet_riskyrevolver" or context.identifier == "j_hatchet_staircase" and context.identifier == "j_hatchet_airmissile") then
                numerator = card.ability.extra.set_probability8
            elseif context.identifier == "j_hatchet_wheelbarrow" then
                numerator = card.ability.extra.set_probability9
            elseif context.identifier == "j_hatchet_snakeeyes" then
                denominator = card.ability.extra.set_probability10
            end
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
    end
}