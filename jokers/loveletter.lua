
SMODS.Joker{ --Love Letter
    key = "loveletter",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Love Letter',
        ['text'] = {
            [1] = 'On the {C:attention}final hand{} of a round,',
            [2] = 'if a {C:attention}High Card{} is played,',
            [3] = 'add {C:dark_edition}Polychrome{} to it'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 7,
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
    pools = { ["hatch_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (to_big(G.GAME.current_round.hands_left) == to_big(1) and next(context.poker_hands["High Card"])) then
                context.other_card:set_edition("e_polychrome", true)
                return {
                    message = "Card Modified!"
                }
            end
        end
    end
}