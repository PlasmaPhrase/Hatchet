
SMODS.Consumable {
    key = 'soulofhatchet',
    set = 'divine',
    pos = { x = 1, y = 1 },
    config = { 
        extra = {
            destroy_count = 1,
            destroy_count2 = 1,
            destroy_count3 = 1   
        } 
    },
    loc_txt = {
        name = 'Soul of Hatchet',
        text = {
            [1] = 'A mysterious card with',
            [2] = 'a {C:enhanced}unique effect{}',
            [3] = '{C:inactive}(Cannot be used on',
            [4] = 'stickered Jokers){}'
        }
    },
    cost = 3,
    unlocked = false,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (to_big(#G.jokers.highlighted) == to_big(1) and not ((function()
            return G.jokers.highlighted[1].ability.eternal
        end)())) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("hatch_mega")
                    
                    return true
                end,
            }))
            local jokers_to_destroy = {}
            local deletable_jokers = {}
            
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and not SMODS.is_eternal(joker, card) then
                    deletable_jokers[#deletable_jokers + 1] = joker
                end
            end
            
            if #deletable_jokers > 0 then
                local temp_jokers = {}
                for _, joker in ipairs(deletable_jokers) do 
                    temp_jokers[#temp_jokers + 1] = joker 
                end
                
                pseudoshuffle(temp_jokers, 98765)
                
                for i = 1, math.min(card.ability.extra.destroy_count, #temp_jokers) do
                    jokers_to_destroy[#jokers_to_destroy + 1] = temp_jokers[i]
                end
            end
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            
            local _first_dissolve = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    for _, joker in pairs(jokers_to_destroy) do
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_hatch_divinehatchet' })
                    if new_joker then
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
        if (to_big(#G.jokers.highlighted) == to_big(1) and not ((function()
            return G.jokers.highlighted[1].ability.rental
        end)())) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("hatch_mega", 0.7, 0.55)
                    return true
                end,
            }))
            local jokers_to_destroy = {}
            local deletable_jokers = {}
            
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and not SMODS.is_eternal(joker, card) then
                    deletable_jokers[#deletable_jokers + 1] = joker
                end
            end
            
            if #deletable_jokers > 0 then
                local temp_jokers = {}
                for _, joker in ipairs(deletable_jokers) do 
                    temp_jokers[#temp_jokers + 1] = joker 
                end
                
                pseudoshuffle(temp_jokers, 98765)
                
                for i = 1, math.min(card.ability.extra.destroy_count2, #temp_jokers) do
                    jokers_to_destroy[#jokers_to_destroy + 1] = temp_jokers[i]
                end
            end
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            
            local _first_dissolve = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    for _, joker in pairs(jokers_to_destroy) do
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_hatch_divinehatchet' })
                    if new_joker then
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
        if (to_big(#G.jokers.highlighted) == to_big(1) and not ((function()
            return G.jokers.highlighted[1].ability.perishable
        end)())) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("hatch_mega")
                    
                    return true
                end,
            }))
            local jokers_to_destroy = {}
            local deletable_jokers = {}
            
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and not SMODS.is_eternal(joker, card) then
                    deletable_jokers[#deletable_jokers + 1] = joker
                end
            end
            
            if #deletable_jokers > 0 then
                local temp_jokers = {}
                for _, joker in ipairs(deletable_jokers) do 
                    temp_jokers[#temp_jokers + 1] = joker 
                end
                
                pseudoshuffle(temp_jokers, 98765)
                
                for i = 1, math.min(card.ability.extra.destroy_count3, #temp_jokers) do
                    jokers_to_destroy[#jokers_to_destroy + 1] = temp_jokers[i]
                end
            end
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            
            local _first_dissolve = nil
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    for _, joker in pairs(jokers_to_destroy) do
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_hatch_divinehatchet' })
                    if new_joker then
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
    end,
    can_use = function(self, card)
        return ((to_big(#G.jokers.highlighted) == to_big(1) and not ((function()
            return G.jokers.highlighted[1].ability.eternal
        end)()))) or ((to_big(#G.jokers.highlighted) == to_big(1) and not ((function()
            return G.jokers.highlighted[1].ability.rental
        end)()))) or ((to_big(#G.jokers.highlighted) == to_big(1) and not ((function()
            return G.jokers.highlighted[1].ability.perishable
        end)())))
    end
}