-- Mega Sephirot Pack
SMODS.Booster {
    key = 'mega_sephirot_pack',
    loc_txt = {
        name = "Mega Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}4{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "hatch_sephirot"
    },
    config = { extra = 4, choose = 2 },
    weight = 2,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    kind = 'Sephirot',
    group_key = "hatch_sephirot",
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                set = 'divine',
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
end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}

-- Jumbo Sephirot Pack    
SMODS.Booster {
    key = 'jumbosephirotpack',
    loc_txt = {
        name = "Jumbo Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}4{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "hatch_sephirot"
    },
    config = { extra = 4, choose = 1 },
    weight = 2,
    atlas = "CustomBoosters",
    pos = { x = 1, y = 0 },
    kind = 'Sephirot',
    group_key = "hatch_sephirot",
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                set = 'divine',
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
end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}

    -- Sephirot Pack #2
    SMODS.Booster {
    key = 'sephirot_pack2',
    loc_txt = {
        name = "Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}3{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "hatch_sephirot"
    },
    config = { extra = 3, choose = 1 },
    weight = 1,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    kind = 'Sephirot',
    group_key = "hatch_sephirot",
    draw_hand = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                set = 'divine',
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack2"
            }
        else
            _card = {
                set = "sephirot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = "hatch_sephirot_pack2"
        }
    end
    return _card
end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}

-- Sephirot Pack #1
SMODS.Booster {
    key = 'sephirot_pack',
    loc_txt = {
        name = "Sephirot Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to',
            [2] = '{C:attention}3{} {C:green}Sephirot{} cards to',
            [3] = 'be used immediately'
        },
        group_name = "hatch_sephirot"
    },
    config = { extra = 3, choose = 1 },
    weight = 1,
    atlas = "CustomBoosters",
    pos = { x = 1, y = 0 },
    kind = 'Sephirot',
    group_key = "hatch_sephirot",
    draw_hand = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        local _card
        if (G.GAME.daat_summon or 0) > 9 and i == 1 then
            _card = {
                set = 'divine',
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
end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("298197"))
        ease_background_colour({ new_colour = HEX('298197'), special_colour = HEX("30c2b8"), contrast = 2 })
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}
