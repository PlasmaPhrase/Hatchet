
SMODS.Joker{ --Blue Shoes
    key = "blueshoes",
    config = {
        extra = {
            chips = 200,
            start_dissolve = 0,
            n = 0,
            no = 0,
            var1 = 0
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
    pools = { ["hatch_hatchet_jokers"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
                local target_joker = card
                
                if target_joker then
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                end
            else
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}