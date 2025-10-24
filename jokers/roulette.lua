SMODS.Joker{ --Roulette
    key = "roulette",
    config = {
        extra = {
            mult = 12
        }
    },
    loc_txt = {
        ['name'] = 'Roulette',
        ['text'] = {
            [1] = '{C:red}+12 {}Mult if played suit is a {C:attention}#1#{},',
            [2] = 'suit changes at end of round'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 3,
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

    loc_vars = function(self, info_queue, card)
        
        return {vars = {localize((G.GAME.current_round.suitvar_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.suitvar_card or {}).suit or 'Spades']}}
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.suitvar_card = { suit = 'Spades' }
    end,

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (function()
                local suitFound = false
                for i, c in ipairs(context.scoring_hand) do
                    if c:is_suit(G.GAME.current_round.suitvar_card.suit) then
                        suitFound = true
                        break
                    end
                end
                
                return suitFound
                end)() then
                    return {
                        mult = card.ability.extra.mult
                    }
                end
            end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if G.playing_cards then
                local valid_suitvar_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_suitvar_cards[#valid_suitvar_cards + 1] = v
                    end
                end
                if valid_suitvar_cards[1] then
                    local suitvar_card = pseudorandom_element(valid_suitvar_cards, pseudoseed('suitvar' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.suitvar_card.suit = suitvar_card.base.suit
                end
            end
        end
    end
}