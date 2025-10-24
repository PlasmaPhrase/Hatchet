SMODS.Joker{ --Handout
    key = "handout",
    config = {
        extra = {
            handsleft = 0,
            handsremaining = 0
        }
    },
    loc_txt = {
        ['name'] = 'Handout',
        ['text'] = {
            [1] = 'Gain {C:money}$1{} per remaining {C:blue}hand{}',
            [2] = 'at the end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval  then
        return {
            dollars = G.GAME.current_round.hands_left
        }
    end
end
}