SMODS.Joker{ --Musketeer
    key = "musketeer",
    config = {
        extra = {
            investment = 0
        }
    },
    loc_txt = {
        ['name'] = 'Musketeer',
        ['text'] = {
            [1] = 'If played hand contains',
            [2] = 'a {C:attention}Three of a Kind{} and',
            [3] = 'a {C:attention}4{}, create an',
            [4] = '{C:attention}Investment Tag{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
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
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["hatchet_hatchet_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (next(context.poker_hands["Three of a Kind"]) and (function()
                local rankCount = 0
                for i, c in ipairs(context.scoring_hand) do
                    if c:get_id() == 4 then
                        rankCount = rankCount + 1
                    end
                end
                
                return rankCount >= 1
                end)()) then
                    G.E_MANAGER:add_event(Event({
                    func = function()
                        local tag = Tag("tag_investment")
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                        end
                    }))
                    return {
                        message = "Created Tag!"
                    }
                end
            end
        end
}