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
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                  trigger = 'after',
                  delay = 0.4,
                  func = function()
                      play_sound('timpani')
                      local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_hatch_etzchaim' })
                      if new_joker then
                      end
                      used_card:juice_up(0.3, 0.5)
                      return true
                  end
              }))
              G.GAME.daat_summon = 0
              delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}