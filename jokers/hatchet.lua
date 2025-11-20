
SMODS.Joker{ --Hatchet
    key = "hatchet",
    config = {
        extra = {
            Xmult = 2.5,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Hatchet',
        ['text'] = {
            [1] = '{X:red,C:white}X2.5{} Mult on {C:attention}first',
            [2] = 'hand of round{} and',
            [3] = 'destroy scored cards'
        },
        ['unlock'] = {
            [1] = ''
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
    cost = 6,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if (G.GAME.current_round.hands_played == 0 and to_big(#context.full_hand) >= to_big(1)) then
                context.other_card.should_destroy = true
                return {
                    message = "Destroyed!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}