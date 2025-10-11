SMODS.Joker{ --Fortress
    key = "fortress",
    config = {
        extra = {
            multvar = 0,
            discardsusedthisround = 0
        }
    },
    loc_txt = {
        ['name'] = 'Fortress',
        ['text'] = {
            [1] = '{C:red}+1{} Mult per discard',
            [2] = 'Resets if no discards',
            [3] = 'are used in a round',
            [4] = '{C:inactive}(Does not apply to The Water){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    mult = card.ability.extra.multvar
                }
        end
        if context.discard  then
                return {
                    func = function()
                    card.ability.extra.multvar = (card.ability.extra.multvar) + 1
                    return true
                end,
                    message = "+1 Mult"
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if (0 == G.GAME.current_round.discards_used and not (G.GAME.blind.config.blind.key == "bl_water")) then
                return {
                    func = function()
                    card.ability.extra.multvar = 1
                    return true
                end,
                    message = "Reset!"
                }
            end
        end
    end
}