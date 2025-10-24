SMODS.Joker{ --Dawn
    key = "dawn",
    config = {
        extra = {
            xchips = 2
        }
    },
    loc_txt = {
        ['name'] = 'Dawn',
        ['text'] = {
            [1] = 'On the first hand',
            [2] = 'double all played {C:blue}chips{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
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
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    x_chips = card.ability.extra.xchips
                }
            end
        end
    end
}