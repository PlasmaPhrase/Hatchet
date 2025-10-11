SMODS.Joker{ --Tricky Joker
    key = "trickyjoker",
    config = {
        extra = {
            basediscardsperround = 0,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tricky Joker',
        ['text'] = {
            [1] = 'Your {C:blue}Hands{} are set to',
            [2] = 'the number of {C:red}discards{} you',
            [3] = 'have per round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 2
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

    calculate = function(self, card, context)
        if context.setting_blind  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Set to "..tostring(G.GAME.round_resets.discards).." Hands", colour = G.C.BLUE})
                G.GAME.current_round.hands_left = G.GAME.round_resets.discards
                return true
            end
                }
        end
    end
}