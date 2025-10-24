SMODS.Joker{ --Saving Grace
    key = "savinggrace",
    config = {
        extra = {
            levels = 2,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Saving Grace',
        ['text'] = {
            [1] = 'Upgrade level of',
            [2] = 'played poker hand by 2',
            [3] = 'in {C:attention}final hand{} of the round',
            [4] = '{C:red}Self destructs{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers  then
            if G.GAME.current_round.hands_left == 0 then
                local target_hand = (context.scoring_name or "High Card")
                return {
                    level_up = card.ability.extra.levels,
                    level_up_hand = target_hand,
                    message = localize('k_level_up_ex'),
                    extra = {
                    func = function()
                        card:start_dissolve()
                        return true
                        end,
                        colour = G.C.RED
                    }
                }
            end
        end
    end
}