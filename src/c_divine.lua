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
    
    use = function(self, card, area, copier) -- Sound event
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('hatch_mega')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, #G.jokers.highlighted do -- Flip Animation #1
            local percent = 1.15 - (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Set Ability
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local evolution = G.jokers.highlighted[1]
                    evolution:set_ability("j_hatch_divine_hatchet") -- The Divine Joker
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Flip Animation #2
            local percent = 0.85 + (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        SMODS.calculate_effect({message = "Evolve!", colour = G.C.SECONDARY_SET.Spectral}, G.jokers.highlighted[1])
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 and
            G.jokers.highlighted[1].config.center.key == "j_hatch_hatchet" -- The Original Joker
    end
}

-- Soul of Love Letter
SMODS.Consumable {
    key = 'soul_of_loveletter',
    set = 'divine',
    pos = { x = 2, y = 1 },
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
    
    use = function(self, card, area, copier) -- Sound event
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('hatch_mega')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, #G.jokers.highlighted do -- Flip Animation #1
            local percent = 1.15 - (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Set Ability
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local evolution = G.jokers.highlighted[1]
                    evolution:set_ability("j_hatch_divine_loveletter") -- The Divine Joker
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Flip Animation #2
            local percent = 0.85 + (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        SMODS.calculate_effect({message = "Evolve!", colour = G.C.SECONDARY_SET.Spectral}, G.jokers.highlighted[1])
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 and
            G.jokers.highlighted[1].config.center.key == "j_hatch_loveletter" -- The Original Joker
    end
}

-- Soul of Wildside
SMODS.Consumable {
    key = 'soul_of_wildside',
    set = 'divine',
    pos = { x = 3, y = 1 },
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
    
    use = function(self, card, area, copier) -- Sound event
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('hatch_mega')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, #G.jokers.highlighted do -- Flip Animation #1
            local percent = 1.15 - (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Set Ability
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local evolution = G.jokers.highlighted[1]
                    evolution:set_ability("j_hatch_divine_wildside") -- The Divine Joker
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Flip Animation #2
            local percent = 0.85 + (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        SMODS.calculate_effect({message = "Evolve!", colour = G.C.SECONDARY_SET.Spectral}, G.jokers.highlighted[1])
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 and
            G.jokers.highlighted[1].config.center.key == "j_hatch_wildside" -- The Original Joker
    end
}

-- Soul of Steel Ball
SMODS.Consumable {
    key = 'soul_of_ball',
    set = 'divine',
    pos = { x = 4, y = 1 },
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
    
    use = function(self, card, area, copier) -- Sound event
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('hatch_mega')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, #G.jokers.highlighted do -- Flip Animation #1
            local percent = 1.15 - (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Set Ability
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local evolution = G.jokers.highlighted[1]
                    evolution:set_ability("j_hatch_divine_ball") -- The Divine Joker
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Flip Animation #2
            local percent = 0.85 + (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        SMODS.calculate_effect({message = "Evolve!", colour = G.C.SECONDARY_SET.Spectral}, G.jokers.highlighted[1])
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 and
            G.jokers.highlighted[1].config.center.key == "j_hatch_steelball" -- The Original Joker
    end
}

-- Soul of Clover
SMODS.Consumable {
    key = 'soul_of_clover',
    set = 'divine',
    pos = { x = 5, y = 1 },
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
    
    use = function(self, card, area, copier) -- Sound event
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('hatch_mega')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, #G.jokers.highlighted do -- Flip Animation #1
            local percent = 1.15 - (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Set Ability
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local evolution = G.jokers.highlighted[1]
                    evolution:set_ability("j_hatch_divine_fourleaf") -- The Divine Joker
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.highlighted do -- Flip Animation #2
            local percent = 0.85 + (i - 0.999) / (#G.jokers.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.jokers.highlighted[i]:flip()
                    G.jokers.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        SMODS.calculate_effect({message = "Evolve!", colour = G.C.SECONDARY_SET.Spectral}, G.jokers.highlighted[1])
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1 and
            G.jokers.highlighted[1].config.center.key == "j_hatch_fourleaf" -- The Original Joker
    end
}