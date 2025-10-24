SMODS.Joker{ --Diary Entry
    key = "diaryentry",
    config = {
        extra = {
            xmultvar = 1,
            chipvar = 30
        }
    },
    loc_txt = {
        ['name'] = 'Diary Entry',
        ['text'] = {
            [1] = 'This Joker gains {C:clubs}+30 chips{} per',
            [2] = '{C:attention}consecutive{} hand played without',
            [3] = 'playing your most played {C:attention}poker hand{}',
            [4] = ''
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
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
                chips = card.ability.extra.chipvar
            }
        end
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if not ((function()
                local current_played = G.GAME.hands[context.scoring_name].played or 0
                for handname, values in pairs(G.GAME.hands) do
                    if handname ~= context.scoring_name and values.played > current_played and values.visible then
                        return false
                        end
                    end
                    return true
                    end)()) then
                        return {
                            func = function()
                                card.ability.extra.chipvar = (card.ability.extra.chipvar) + 30
                                return true
                                end
                            }
                        elseif (function()
                            local current_played = G.GAME.hands[context.scoring_name].played or 0
                            for handname, values in pairs(G.GAME.hands) do
                                if handname ~= context.scoring_name and values.played > current_played and values.visible then
                                    return false
                                    end
                                end
                                return true
                                end)() then
                                    return {
                                        func = function()
                                            card.ability.extra.chipvar = 0
                                            return true
                                            end,
                                            message = "Reset!"
                                        }
                                    end
                                end
                            end
}