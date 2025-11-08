SMODS.Joker{ --Night Vision
    key = "nightvision",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Night Vision',
        ['text'] = {
            [1] = '{X:red,C:white}X0.25{} Mult if poker hand has {C:attention}not{}',
            [2] = 'already been played during round',
            [3] = 'Resets per {C:attention}Ante{}',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not (G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1) then
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.25
            else
                return {
                    Xmult = card.ability.extra.xmult
                }
            end
        end
        if context.ante_change  then
            return {
                func = function()
                    card.ability.extra.xmult = 1
                    return true
                    end
                }
            end
        end
}