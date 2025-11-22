-- Divine
SMODS.Shader({ key = 'divine', path = 'divine.fs' })

SMODS.Edition {
    key = 'divine',
    weight = 14,
    sound = { sound = "gong", per = 1.2, vol = 0.4 },
    loc_txt = {
        name = 'Divine',
        label = 'Divine',
        text = {
            [1] = 'A {C:enhanced}temporary evolution{}',
            [2] = 'Lasts {C:attention}5{} rounds'
        }
    },
    shader = 'divine',
}