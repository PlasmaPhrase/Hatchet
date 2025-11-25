

-- Da'at
SMODS.Consumable {
    key = 'daat',
    set = 'divine',
    pos = { x = 0, y = 1 },
    loc_txt = {
        name = 'Daat',
        text = {
            [1] = 'Create {C:dark_edition}Etz Chaim{}'
        }
    },
    cost = 10,
    unlocked = false,
    discovered = false,
    hidden = true,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_hatch_etz_chaim")
        card:add_to_deck()
        card:start_materialize()
        G.jokers:emplace(card)
        G.GAME.daat_summon = 0
    end,
    can_use = function(self, card)
        return true
    end
}

-- Soul of Hatchet
SMODS.Consumable {
    key = 'soul_of_hatchet',
    set = 'divine',
    pos = { x = 1, y = 1 },
    config = { 
        extra = {
            destroy_count = 1   
        } 
    },
    loc_txt = {
        name = 'Soul of Hatchet',
        text = {
            [1] = 'A mysterious card with',
            [2] = 'a {C:enhanced}unique effect{}',
            [3] = '{C:inactive}(Cannot be used on',
            [4] = '{C:inactive}stickered Jokers){}'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = false,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
        local joker = G.jokers.highlighted[1]
        if not joker.ability.eternal and not joker.ability.rental and not joker.ability.perishable then
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
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.75,
                func = function()
                    local explode = nil
                    for _, joker in pairs(jokers_to_destroy) do
                        joker:explode(nil, explode)
                        explode = true
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
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_hatch_divine_hatchet' })
                    if new_joker then
                        new_joker:set_edition("e_hatch_divine", true)
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
            return {
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = "Evolve!",
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Spectral,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true,
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            }
        end
    end,
    can_use = function(self, card)
        if #G.jokers.highlighted ~= 1 or G.jokers.highlighted[1].config.center.key ~= 'j_hatch_hatchet' then
            return false
        end
        local joker = G.jokers.highlighted[1]
        return not joker.ability.eternal and not joker.ability.rental and not joker.ability.perishable
    end,
}