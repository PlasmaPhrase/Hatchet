-- Mega Sephirot Pack
SMODS.Booster {
    key = "sephirot_mega_1",
    weight = 0.07,
    atlas = "CustomBoosters",
    loc_txt = {
        name = "Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}2{} of up to',
            [2] = '{C:attention}5{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "Sephirot Pack"
    },
    cost = 5,
    pos = { x = 0, y = 0 },
    config = { extra = 5, choose = 2 },
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                key = 'c_hatch_daat',
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
            }
        else
            _card = {
                set = "sephirot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
        }
    end
    return _card
end
}

-- Jumbo Sephirot Pack    
SMODS.Booster {
    key = "sephirot_jumbo_1",
    weight = 0.3,
    atlas = "CustomBoosters",
    loc_txt = {
        name = "Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}5{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "Sephirot Pack"
    },
    cost = 5,
    pos = { x = 1, y = 0 },
    config = { extra = 5, choose = 1 },
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                key = 'c_hatch_daat',
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
            }
        else
            _card = {
                set = "sephirot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
        }
    end
    return _card
end
}

-- Sephirot Packs (Normal)

SMODS.Booster {
    key = "sephirot_normal_1",
    weight = 0.3,
    atlas = "CustomBoosters",
    loc_txt = {
        name = "Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}3{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "Sephirot Pack"
    },
    cost = 5,
    pos = { x = 2, y = 0 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                key = 'c_hatch_daat',
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
            }
        else
            _card = {
                set = "sephirot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
        }
    end
    return _card
end
}

SMODS.Booster {
    key = "sephirot_normal_2",
    weight = 0.3,
    atlas = "CustomBoosters",
    loc_txt = {
        name = "Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}3{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "Sephirot Pack"
    },
    cost = 5,
    pos = { x = 3, y = 0 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                key = 'c_hatch_daat',
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
            }
        else
            _card = {
                set = "sephirot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack"
        }
    end
    return _card
end
}

-- Divine Pack
SMODS.Booster {
    key = "divine_pack",
    weight = 0.07,
    atlas = "CustomBoosters",
    loc_txt = {
        name = "Divine Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}3{} {C:dark_edition}Divine{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "Divine Pack"
    },
    cost = 5,
    pos = { x = 4, y = 0 },
    config = { extra = 3, choose = 1 },
    draw_hand = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra },
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("5c61c5"))
        ease_background_colour({ new_colour = HEX('424466'), special_colour = HEX("5c61c5"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    select_card = "consumeables",
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "divine",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_divine_pack",
        }
    return _card
end
}