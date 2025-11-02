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
            set_probability = 0,
            set_probability2 = 6,
            set_probability3 = 0,
            set_probability4 = 0,
            set_probability5 = 1000,
            set_probability6 = 0,
            set_probability7 = 0,
            set_probability8 = 0,
            set_probability9 = 0,
            set_probability10 = 0,
            set_probability11 = 0,
            set_probability12 = 4,
            set_probability13 = 7,
            set_probability14 = 0,
            set_probability15 = 0,
            set_probability16 = 0,
            set_probability17 = 7,
            numerator = 0
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
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
            if context.identifier == "8ball" then
                numerator = card.ability.extra.set_probability
            elseif context.identifier == "gros_michel" then
                numerator = card.ability.extra.set_probability2
            elseif context.identifier == "business" then
                numerator = card.ability.extra.set_probability3
            elseif context.identifier == "space" then
                numerator = card.ability.extra.set_probability4
            elseif context.identifier == "cavendish" then
                numerator = card.ability.extra.set_probability5
            elseif context.identifier == "parking" then
                numerator = card.ability.extra.set_probability6
            elseif context.identifier == "halu1" then
                numerator = card.ability.extra.set_probability7
            elseif context.identifier == "bloodstone" then
                numerator = card.ability.extra.set_probability8
            elseif context.identifier == "wheel_of_fortune" then
                numerator = card.ability.extra.set_probability9
            elseif context.identifier == "lucky_mult" then
                numerator = card.ability.extra.set_probability10
            elseif context.identifier == "lucky_money" then
                numerator = card.ability.extra.set_probability11
            elseif context.identifier == "glass" then
                numerator = card.ability.extra.set_probability12
            elseif context.identifier == "wheel" then
                numerator = card.ability.extra.set_probability13
            elseif context.identifier == "j_hatchet_d20" then
                numerator = card.ability.extra.set_probability14
            elseif context.identifier == "j_hatchet_riskyrevolver" then
                numerator = card.ability.extra.set_probability15
            elseif context.identifier == "j_hatchet_staircase" then
                numerator = card.ability.extra.set_probability16
            elseif context.identifier == "j_hatchet_wheelbarrow" then
                numerator = card.ability.extra.set_probability17
            end
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
    end
}