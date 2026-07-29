SMODS.Joker({
    key = "eightone",
    atlas = "HatchetCrossJokers",
    config = { extra = { mult = 1 } },
    rarity = 1,
    cost = 10,
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = false,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 8) then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) +
                card.ability.extra.mult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
    end
})

SMODS.Joker({
    key = "winnt5",
    atlas = "HatchetCrossJokers",
    config = { extra = { xmult = 2.5 } },
    rarity = 1,
    cost = 10,
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = false,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 5) then
            local is_first_five = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 5 then
                    is_first_five = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first_five then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local evolution = card
                        play_sound('hatch_wnt5')
                        return true
                    end
                }))
                return {
                    xmult = card.ability.extra.xmult,
                }
            end
        end
    end
})

SMODS.Joker({
    key = "mint",
    atlas = "HatchetCrossJokers",
    config = { extra = { mult = 0, mult_gain = 4 } },
    rarity = 1,
    cost = 10,
    pos = { x = 4, y = 0 },
    unlocked = true,
    discovered = false,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,

    calculate = function(self, card, context)
        if context.pseudorandom_result then
            if context.result then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = "Success!",
                    colour = G.C.FILTER
                }
            else
                if not context.result then
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_gain
                    return {
                        message = "Failure!",
                        colour = G.C.FILTER
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})
