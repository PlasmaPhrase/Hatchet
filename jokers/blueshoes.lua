SMODS.Joker{ --Blue Shoes
    key = "blueshoes",
    config = {
        extra = {
            chips = 200,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Blue Shoes',
        ['text'] = {
            [1] = '{C:blue}+200{} Chips',
            [2] = '{C:red}Self-destruct{} if',
            [3] = 'played {C:attention}poker hand{} has',
            [4] = 'already been played',
            [5] = 'this round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 0
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
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                        end
                    }
                else
                    return {
                        chips = card.ability.extra.chips
                    }
                end
            end
        end
}