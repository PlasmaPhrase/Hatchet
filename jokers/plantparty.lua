SMODS.Joker{ --Plant Party
    key = "plantparty",
    config = {
        extra = {
            xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Plant Party',
        ['text'] = {
            [1] = '{X:red,C:white}X0.25{} Mult for each hand',
            [2] = 'played without a {C:attention}face card{}',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{}{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatch_hatch_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult}}
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if not ((function()
                local rankCount = 0
                for i, c in ipairs(context.scoring_hand) do
                    if c:is_face() then
                        rankCount = rankCount + 1
                    end
                end
                
                return rankCount >= 1
                end)()) then
                    card.ability.extra.xmult = (card.ability.extra.xmult) + 0.25
                    return {
                        Xmult = card.ability.extra.xmult
                    }
                elseif (function()
                    local rankCount = 0
                    for i, c in ipairs(context.scoring_hand) do
                        if c:is_face() then
                            rankCount = rankCount + 1
                        end
                    end
                    
                    return rankCount >= 1
                    end)() then
                        return {
                            Xmult = card.ability.extra.xmult
                        }
                    end
                end
            end
}