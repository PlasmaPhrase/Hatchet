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
            destroy = 1   
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
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("hatch_mega")
                return true
            end,
        }))
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                G.jokers.highlighted[1]:explode()
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', key = 'j_hatch_divine_hatchet', edition = "e_hatch_divine" })
                card:juice_up(0.3, 0.5)
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
        
    end,

    can_use = function(self, card)
    local has_target = false
    for i, joker in ipairs(G.jokers.cards) do
        if not SMODS.is_eternal(joker, card) and joker.config.center.key == "j_hatch_hatchet" then
            has_target = true
            break
        end
    end
    
    if #G.jokers.highlighted ~= 1 or G.jokers.highlighted[1].config.center.key ~= 'j_hatch_hatchet' then
        return false
    end
        local joker = G.jokers.highlighted[1]
        return not joker.ability.eternal and not joker.ability.rental and not joker.ability.perishable and has_target
    end,
}

-- Soul of Love Letter
SMODS.Consumable {
    key = 'soul_of_loveletter',
    set = 'divine',
    pos = { x = 2, y = 1 },
    config = { 
        extra = {
            destroy = 1
        } 
    },
    loc_txt = {
        name = 'Soul of Love Letter',
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
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("hatch_mega")
                return true
            end,
        }))
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                G.jokers.highlighted[1]:explode()
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', key = 'j_hatch_divine_loveletter', edition = "e_hatch_divine" })
                card:juice_up(0.3, 0.5)
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
        
    end,

    can_use = function(self, card)
    local has_target = false
    for i, joker in ipairs(G.jokers.cards) do
        if not SMODS.is_eternal(joker, card) and joker.config.center.key == "j_hatch_loveletter" then
            has_target = true
            break
        end
    end
    
    if #G.jokers.highlighted ~= 1 or G.jokers.highlighted[1].config.center.key ~= 'j_hatch_loveletter' then
        return false
    end
        local joker = G.jokers.highlighted[1]
        return not joker.ability.eternal and not joker.ability.rental and not joker.ability.perishable and has_target
    end,
}

-- Soul of Wildside
SMODS.Consumable {
    key = 'soul_of_wildside',
    set = 'divine',
    pos = { x = 3, y = 1 },
    config = { 
        extra = {
            destroy = 1
        } 
    },
    loc_txt = {
        name = 'Soul of Wildside',
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
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("hatch_mega")
                return true
            end,
        }))
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                G.jokers.highlighted[1]:explode()
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', key = 'j_hatch_divine_wildside', edition = "e_hatch_divine" }) -- Replace with the relevant Divine Joker
                card:juice_up(0.3, 0.5)
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
        
    end,

    can_use = function(self, card)
    local has_target = false
    for i, joker in ipairs(G.jokers.cards) do
        if not SMODS.is_eternal(joker, card) and joker.config.center.key == "j_hatch_wildside" then -- Replace with relevant Joker
            has_target = true
            break
        end
    end
    
    if #G.jokers.highlighted ~= 1 or G.jokers.highlighted[1].config.center.key ~= 'j_hatch_wildside' then -- Replace with relevant Joker
        return false
    end
        local joker = G.jokers.highlighted[1]
        return not joker.ability.eternal and not joker.ability.rental and not joker.ability.perishable and has_target
    end,
}

-- Soul of Steel Ball
SMODS.Consumable {
    key = 'soul_of_ball',
    set = 'divine',
    pos = { x = 4, y = 1 },
    config = { 
        extra = {
            destroy = 1
        } 
    },
    loc_txt = {
        name = 'Soul of Steel Ball',
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
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("hatch_mega")
                return true
            end,
        }))
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                G.jokers.highlighted[1]:explode()
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                SMODS.add_card({ set = 'Joker', key = 'j_hatch_divine_ball', edition = "e_hatch_divine" }) -- Replace with the relevant Divine Joker
                card:juice_up(0.3, 0.5)
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
        
    end,

    can_use = function(self, card)
    local has_target = false
    for i, joker in ipairs(G.jokers.cards) do
        if not SMODS.is_eternal(joker, card) and joker.config.center.key == "j_hatch_steelball" then -- Replace with relevant Joker
            has_target = true
            break
        end
    end
    
    if #G.jokers.highlighted ~= 1 or G.jokers.highlighted[1].config.center.key ~= 'j_hatch_steelball' then -- Replace with relevant Joker
        return false
    end
        local joker = G.jokers.highlighted[1]
        return not joker.ability.eternal and not joker.ability.rental and not joker.ability.perishable and has_target
    end,
}

-- Soul of Clover
SMODS.Consumable {
    key = 'soul_of_clover',
    set = 'divine',
    pos = { x = 5, y = 1 },
    config = { 
        extra = {
            destroy = 1
        } 
    },
    loc_txt = {
        name = 'Soul of Clover',
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
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("hatch_mega")
                return true
            end,
        }))
        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.75,
            func = function()
                G.jokers.highlighted[1]:explode()
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', key = 'j_hatch_divine_fourleaf', edition = "e_hatch_divine" }) -- Replace with the relevant Divine Joker
                card:juice_up(0.3, 0.5)
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
        
    end,

    can_use = function(self, card)
    local has_target = false
    for i, joker in ipairs(G.jokers.cards) do
        if not SMODS.is_eternal(joker, card) and joker.config.center.key == "j_hatch_fourleaf" then -- Replace with relevant Joker
            has_target = true
            break
        end
    end
    
    if #G.jokers.highlighted ~= 1 or G.jokers.highlighted[1].config.center.key ~= 'j_hatch_fourleaf' then -- Replace with relevant Joker
        return false
    end
        local joker = G.jokers.highlighted[1]
        return not joker.ability.eternal and not joker.ability.rental and not joker.ability.perishable and has_target
    end,
}