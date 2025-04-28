--- STEAMODDED HEADER
--- MOD_NAME: All_In
--- MOD_ID: All_In
--- MOD_AUTHOR: [playfulrainbow]
--- MOD_DESCRIPTION: Adds "All In" button. Risk all your money to beat the next round in 1 hand or lose everything.

----------------------------------------------
------------MOD CODE -------------------------

G.START_BET_ROLL = false
G.PAYOUT_CASH = false
G.BET_SIZE = 0
G.SAVED_BLIND =  0
G.LAST_USED_HAND = ''
G.HAND_BET_SELECTED = ''
G.HAND_BET_SELECTED_UI = ''
G.WIN_AMT_EARNINGS = 0
G.WIN_AMT_EARNINGS_UI = 0
G.WIN_INTEREST_TOTAL = 0
G.WIN_INTEREST_TOTAL_UI = 0


function Game:update_menu(dt)
G.START_BET_ROLL = false
G.PAYOUT_CASH = false
G.BET_SIZE = 0
G.SAVED_BLIND =  0
G.LAST_USED_HAND = ''
G.HAND_BET_SELECTED = ''
G.HAND_BET_SELECTED_UI = ''
G.WIN_AMT_EARNINGS = 0
G.WIN_AMT_EARNINGS_UI = 0
G.WIN_INTEREST_TOTAL = 0
G.WIN_INTEREST_TOTAL_UI = 0
end

function G.UIDEF.shop()


  G.shop_jokers = CardArea(
    G.hand.T.x+0,
    G.hand.T.y+G.ROOM.T.y + 9,
    G.GAME.shop.joker_max*1.02*G.CARD_W,
    1.05*G.CARD_H, 
    {card_limit = G.GAME.shop.joker_max, type = 'shop', highlight_limit = 1})


  G.shop_vouchers = CardArea(
    G.hand.T.x+0,
    G.hand.T.y+G.ROOM.T.y + 9,
    2.1*G.CARD_W,
    1.05*G.CARD_H, 
    {card_limit = 1, type = 'shop', highlight_limit = 1})

  G.shop_booster = CardArea(
    G.hand.T.x+0,
    G.hand.T.y+G.ROOM.T.y + 9,
    2.4*G.CARD_W,
    1.15*G.CARD_H, 
    {card_limit = 2, type = 'shop', highlight_limit = 1, card_w = 1.27*G.CARD_W})

  local shop_sign = AnimatedSprite(0,0, 4.4, 2.2, G.ANIMATION_ATLAS['shop_sign'])
  shop_sign:define_draw_steps({
    {shader = 'dissolve', shadow_height = 0.05},
    {shader = 'dissolve'}
  })
  G.SHOP_SIGN = UIBox{
    definition = 
      {n=G.UIT.ROOT, config = {colour = G.C.DYN_UI.MAIN, emboss = 0.05, align = 'cm', r = 0.1, padding = 0.1}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.1, minw = 4.72, minh = 3.1, colour = G.C.DYN_UI.DARK, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.O, config={object = shop_sign}}
          }},
          {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {localize('ph_improve_run')}, colours = {lighten(G.C.GOLD, 0.3)},shadow = true, rotate = true, float = true, bump = true, scale = 0.5, spacing = 1, pop_in = 1.5, maxw = 4.3})}}
          }},
        }},
      }},
    config = {
      align="cm",
      offset = {x=0,y=-15},
      major = G.HUD:get_UIE_by_ID('row_blind'),
      bond = 'Weak'
    }
  }
  G.E_MANAGER:add_event(Event({
    trigger = 'immediate',
    func = (function()
        G.SHOP_SIGN.alignment.offset.y = 0
        return true
    end)
  }))



G.GAME.option_list3 = {3.5, 3, 2.5, 2, 1.8, 1.5, 1.3, 1}
G.GAME.current_option_index3 = 1
G.GAME.current_option3 = {option_text3 = G.GAME.option_list3[G.GAME.current_option_index3]}



G.GAME.option_list = {"Any Hand", "Two Pair", "Three of a Kind", "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush"}
G.GAME.current_option_index = 1
G.GAME.current_option = {option_text = G.GAME.option_list[G.GAME.current_option_index]}

G.BET_SIZE_UI = G.GAME.dollars

G.WIN_INTEREST_TOTAL_UI = math.floor(G.GAME.dollars/5)

if G.WIN_INTEREST_TOTAL_UI > (G.GAME.interest_cap/5) then
G.WIN_INTEREST_TOTAL_UI = (G.GAME.interest_cap/5)
end

G.WIN_AMT_EARNINGS_UI = math.ceil(G.BET_SIZE_UI / G.GAME.current_option3.option_text3)

if G.WIN_AMT_EARNINGS_UI > 25 then
G.WIN_AMT_EARNINGS_UI = 25
end

G.WIN_AMT_EARNINGS_UI = G.WIN_AMT_EARNINGS_UI + G.WIN_INTEREST_TOTAL_UI 

local isTalismanFolderPresent_UI = G.FUNCS.checkTalismanFolder()

if isTalismanFolderPresent_UI then
    G.WIN_AMT_EARNINGS_UI = G.WIN_AMT_EARNINGS_UI + G.BET_SIZE_UI
else
    G.WIN_AMT_EARNINGS_UI = (G.WIN_AMT_EARNINGS_UI + G.BET_SIZE_UI) + G.GAME.dollars
end

G.GAME.option_list2 = {"1:3.5 | $25 Max", "1:3 | $25 Max", "1:2.5 | $25 Max", "1:2 | $50 Max", "1:1.8 | $50 Max", "1:1.5 | $50 Max", "1:1.3 | $100 Max", "1:1 | $100 Max"}
G.GAME.option_list2[1] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[2] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[3] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[4] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[5] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[6] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[7] = string.format("$%d | $100 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[8] = string.format("$%d | $100 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.current_option_index2 = 1
G.GAME.current_option2 = {option_text2 = G.GAME.option_list2[G.GAME.current_option_index2]}


local t = {n=G.UIT.ROOT, config = {align = 'cl', colour = G.C.CLEAR}, nodes={
          UIBox_dyn_container({
              {n=G.UIT.C, config={align = "cm", padding = 0.1, emboss = 0.05, r = 0.1, colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
                  {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                      {n=G.UIT.R,config={id = 'next_round_button', align = "cm", minw = 2.8, minh = 0.6, r=0.15,colour = G.C.RED, one_press = true, button = 'toggle_shop', hover = true,shadow = true}, nodes = {
                        {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'y', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                          {n=G.UIT.T, config={text = localize('b_next_round_1') .. " " .. localize('b_next_round_2') , scale = 0.4, colour = G.C.WHITE, shadow = true}},   
                        }},              
                      }},
                      {n=G.UIT.R, config={align = "cm", minw = 2.8, minh = 1.0, r=0.15,colour = G.C.GREEN, button = 'reroll_shop', func = 'can_reroll', hover = true,shadow = true}, nodes = {
                        {n=G.UIT.R, config={align = "cm", padding = 0.03, focus_args = {button = 'x', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                          {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                            {n=G.UIT.T, config={text = localize('k_reroll'), scale = 0.4, colour = G.C.WHITE, shadow = true}},
                          }},
                          {n=G.UIT.R, config={align = "cm", maxw = 1.3, minw = 1}, nodes={
                            {n=G.UIT.T, config={text = localize('$'), scale = 0.7, colour = G.C.WHITE, shadow = true}},
                            {n=G.UIT.T, config={ref_table = G.GAME.current_round, ref_value = 'reroll_cost', scale = 0.75, colour = G.C.WHITE, shadow = true}},
                          }}
                        }}
                      }},


-- New Section: Text Field and Navigation Buttons
--{n = G.UIT.R, config = {align = "cm", padding = 0.0}, nodes = {
    -- Row Container for Left Arrow, Text Field, and Right Arrow
    --{n = G.UIT.R, config = {align = "cm", padding = 0.0, r = 0.2, colour = G.C.L_BLACK}, nodes = {
        -- Text Field

        -- Right Arrow Button
        {n = G.UIT.R, config = {align = "cm", minw = 0.5, minh = 0.4, r = 0.2, colour = G.C.BLUE, button = "NEXT_OPTION", hover = true, shadow = true}, nodes = {
            {n = G.UIT.T, config = {text = "Next Hand >", scale = 0.3, colour = G.C.WHITE, shadow = true}}
        }},
        {n = G.UIT.R, config = {align = "cm", minw = 0.7, minh = 0.3, r = 0.4, colour = G.C.CLEAR}, nodes = {
            {n = G.UIT.T, config = {text = "Any Hand", ref_table = G.GAME.current_option, ref_value = 'option_text', scale = 0.3, colour = G.C.WHITE, shadow = true}}
        }},
        {n = G.UIT.R, config = {align = "cm", minw = 0.7, minh = 0.4, r = 0.4, colour = G.C.CLEAR}, nodes = {
            {n = G.UIT.T, config = {text = G.GAME.option_list2[1], ref_table = G.GAME.current_option2, ref_value = 'option_text2', scale = 0.3, colour = G.C.WHITE, shadow = true}}
        }},

    --}}
--}},

                      {n=G.UIT.R, config={align = "cm", minw = 2.8, minh = 0.5, r = 1, colour = G.C.GOLD, one_press = true, hover = true, shadow = true, button="START_BET_ROLL"}, nodes = {
                        {n=G.UIT.T, config={text = "All In", scale = 0.5, colour = HEX("564620"), shadow = true}}
                      }},
                    }},
                    {n=G.UIT.C, config={align = "cm", padding = 0.1, r=0.2, colour = G.C.L_BLACK, emboss = 0.05, minw = 8.2}, nodes={
                        {n=G.UIT.O, config={object = G.shop_jokers}},
                    }},
                  }},
                  {n=G.UIT.R, config={align = "cm", minh = 0.1}, nodes={}},
                  {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                      {n=G.UIT.C, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.BLACK, maxh = G.shop_vouchers.T.h+0.4}, nodes={
                        {n=G.UIT.T, config={text = localize{type = 'variable', key = 'ante_x_voucher', vars = {G.GAME.round_resets.ante}}, scale = 0.45, colour = G.C.L_BLACK, vert = true}},
                        {n=G.UIT.O, config={object = G.shop_vouchers}},
                      }},
                    }},
                    {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                      {n=G.UIT.O, config={object = G.shop_booster}},
                    }},
                  }}
              }
            },
            
            }, false)
      }}
  return t


end






Game.updateShopRef = Game.update_shop
function Game:update_shop(dt)
  self:updateShopRef(dt)


G.BET_SIZE_UI = G.GAME.dollars

G.WIN_INTEREST_TOTAL_UI = math.floor(G.GAME.dollars/5)

if G.WIN_INTEREST_TOTAL_UI > (G.GAME.interest_cap/5) then
G.WIN_INTEREST_TOTAL_UI = (G.GAME.interest_cap/5)
end

-- cycle through an array to change rate
G.WIN_AMT_EARNINGS_UI = math.ceil(G.BET_SIZE_UI / G.GAME.current_option3.option_text3)

G.HAND_BET_SELECTED_UI = G.GAME.current_option.option_text
if G.HAND_BET_SELECTED_UI == 'Any Hand' or G.HAND_BET_SELECTED_UI == 'Two Pair' or G.HAND_BET_SELECTED_UI == 'Three of a Kind' then

if G.WIN_AMT_EARNINGS_UI > 25 then
G.WIN_AMT_EARNINGS_UI = 25
end

elseif G.HAND_BET_SELECTED_UI == 'Straight' or G.HAND_BET_SELECTED_UI == 'Flush' or G.HAND_BET_SELECTED_UI == 'Full House' then
if G.WIN_AMT_EARNINGS_UI > 50 then
G.WIN_AMT_EARNINGS_UI = 50
end
else
if G.WIN_AMT_EARNINGS_UI > 100 then
G.WIN_AMT_EARNINGS_UI = 100
end
end

G.WIN_AMT_EARNINGS_UI = G.WIN_AMT_EARNINGS_UI + G.WIN_INTEREST_TOTAL_UI 

local isTalismanFolderPresent_UI = G.FUNCS.checkTalismanFolder()

if isTalismanFolderPresent_UI then
    G.WIN_AMT_EARNINGS_UI = G.WIN_AMT_EARNINGS_UI + G.BET_SIZE_UI
else
    G.WIN_AMT_EARNINGS_UI = (G.WIN_AMT_EARNINGS_UI + G.BET_SIZE_UI) + G.GAME.dollars
end



G.GAME.option_list2[1] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[2] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[3] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[4] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[5] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[6] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[7] = string.format("$%d | $100 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[8] = string.format("$%d | $100 Max", G.WIN_AMT_EARNINGS_UI)

G.GAME.current_option2.option_text2 = G.GAME.option_list2[G.GAME.current_option_index2]

  if G.START_BET_ROLL and G.GAME.dollars > 4 then
G.HAND_BET_SELECTED = G.GAME.current_option.option_text
G.BET_SIZE = G.GAME.dollars
G.PAYOUT_CASH = true
    G.START_BET_ROLL = false
G.SAVED_BLIND =  G.GAME.round

G.WIN_INTEREST_TOTAL = math.floor(G.BET_SIZE/5)

if G.WIN_INTEREST_TOTAL > (G.GAME.interest_cap/5) then
G.WIN_INTEREST_TOTAL = (G.GAME.interest_cap/5)
end

    ease_dollars(-G.BET_SIZE)
  end



local isTalismanFolderPresent = G.FUNCS.checkTalismanFolder()




if G.HAND_BET_SELECTED == 'Any Hand' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 3.5)
if G.WIN_AMT_EARNINGS > 25 then
G.WIN_AMT_EARNINGS = 25
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end


elseif G.HAND_BET_SELECTED == 'Two Pair' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH and (G.LAST_USED_HAND == 'Two Pair' or G.LAST_USED_HAND == 'Full House') then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 3)
if G.WIN_AMT_EARNINGS > 25 then
G.WIN_AMT_EARNINGS = 25
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end

elseif G.HAND_BET_SELECTED == 'Three of a Kind' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH and (G.LAST_USED_HAND == 'Three of a Kind' or G.LAST_USED_HAND == 'Four of a Kind' or G.LAST_USED_HAND == 'Five of a Kind' or G.LAST_USED_HAND == 'Full House' or G.LAST_USED_HAND == 'Flush Five') then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 2.5)
if G.WIN_AMT_EARNINGS > 25 then
G.WIN_AMT_EARNINGS = 25
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end

elseif G.HAND_BET_SELECTED == 'Straight' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH and (G.LAST_USED_HAND == 'Straight' or G.LAST_USED_HAND == 'Straight Flush' or G.LAST_USED_HAND == 'Royal Flush') then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 2)
if G.WIN_AMT_EARNINGS > 50 then
G.WIN_AMT_EARNINGS = 50
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end

elseif G.HAND_BET_SELECTED == 'Flush' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH and (G.LAST_USED_HAND == 'Flush' or G.LAST_USED_HAND == 'Flush House' or G.LAST_USED_HAND == 'Straight Flush' or G.LAST_USED_HAND == 'Royal Flush' or G.LAST_USED_HAND == 'Flush Five') then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 1.8)
if G.WIN_AMT_EARNINGS > 50 then
G.WIN_AMT_EARNINGS = 50
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end

elseif G.HAND_BET_SELECTED == 'Full House' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH and (G.LAST_USED_HAND == 'Full House' or G.LAST_USED_HAND == 'Flush House') then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 1.5)
if G.WIN_AMT_EARNINGS > 50 then
G.WIN_AMT_EARNINGS = 50
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end

elseif G.HAND_BET_SELECTED == 'Four of a Kind' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH and (G.LAST_USED_HAND == 'Four of a Kind' or G.LAST_USED_HAND == 'Five of a Kind') then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 1.3)
if G.WIN_AMT_EARNINGS > 100 then
G.WIN_AMT_EARNINGS = 100
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end

elseif G.HAND_BET_SELECTED == 'Straight Flush' then
if G.GAME.current_round.hands_played == 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH and (G.LAST_USED_HAND == 'Straight Flush' or G.LAST_USED_HAND == 'Royal Flush' or G.LAST_USED_HAND == 'Flush Five') then
G.WIN_AMT_EARNINGS = math.ceil(G.BET_SIZE / 1)
if G.WIN_AMT_EARNINGS > 100 then
G.WIN_AMT_EARNINGS = 100
end
G.WIN_AMT_EARNINGS = G.WIN_AMT_EARNINGS + G.WIN_INTEREST_TOTAL
if isTalismanFolderPresent then
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE))
else
    ease_dollars((G.WIN_AMT_EARNINGS + G.BET_SIZE) + G.GAME.dollars)
end
G.WIN_AMT_EARNINGS = 0
G.HAND_BET_SELECTED = ''
G.PAYOUT_CASH = false
G.BET_SIZE = 0
elseif G.GAME.current_round.hands_played > 1 and G.GAME.round > G.SAVED_BLIND and G.PAYOUT_CASH then
G.PAYOUT_CASH = false
G.HAND_BET_SELECTED = ''
G.BET_SIZE = 0
G.WIN_AMT_EARNINGS = 0
end

end





end

function G.FUNCS.START_BET_ROLL()
if G.GAME.dollars > 4 then
   G.START_BET_ROLL = true
end
end

function G.FUNCS.NEXT_OPTION()
    G.GAME.current_option_index3 = (G.GAME.current_option_index3 % #G.GAME.option_list3) + 1

    G.GAME.current_option3.option_text3 = G.GAME.option_list3[G.GAME.current_option_index3]






G.BET_SIZE_UI = G.GAME.dollars

G.WIN_INTEREST_TOTAL_UI = math.floor(G.GAME.dollars/5)

if G.WIN_INTEREST_TOTAL_UI > (G.GAME.interest_cap/5) then
G.WIN_INTEREST_TOTAL_UI = (G.GAME.interest_cap/5)
end

-- cycle through an array to change rate
G.WIN_AMT_EARNINGS_UI = math.ceil(G.BET_SIZE_UI / G.GAME.current_option3.option_text3)

G.HAND_BET_SELECTED_UI = G.GAME.current_option.option_text
if G.HAND_BET_SELECTED_UI  == 'Any Hand' or G.HAND_BET_SELECTED_UI  == 'Two Pair' or G.HAND_BET_SELECTED_UI  == 'Three of a Kind' then

if G.WIN_AMT_EARNINGS_UI > 25 then
G.WIN_AMT_EARNINGS_UI = 25
end

elseif G.HAND_BET_SELECTED_UI  == 'Straight' or G.HAND_BET_SELECTED_UI  == 'Flush' or G.HAND_BET_SELECTED_UI  == 'Full House' then
if G.WIN_AMT_EARNINGS_UI > 50 then
G.WIN_AMT_EARNINGS_UI = 50
end
else
if G.WIN_AMT_EARNINGS_UI > 100 then
G.WIN_AMT_EARNINGS_UI = 100
end
end

G.WIN_AMT_EARNINGS_UI = G.WIN_AMT_EARNINGS_UI + G.WIN_INTEREST_TOTAL_UI 

local isTalismanFolderPresent_UI = G.FUNCS.checkTalismanFolder()

if isTalismanFolderPresent_UI then
    G.WIN_AMT_EARNINGS_UI = G.WIN_AMT_EARNINGS_UI + G.BET_SIZE_UI
else
    G.WIN_AMT_EARNINGS_UI = (G.WIN_AMT_EARNINGS_UI + G.BET_SIZE_UI) + G.GAME.dollars
end



G.GAME.option_list2[1] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[2] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[3] = string.format("$%d | $25 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[4] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[5] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[6] = string.format("$%d | $50 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[7] = string.format("$%d | $100 Max", G.WIN_AMT_EARNINGS_UI)
G.GAME.option_list2[8] = string.format("$%d | $100 Max", G.WIN_AMT_EARNINGS_UI)


    -- Update option_text2 for the second option list
    G.GAME.current_option_index2 = (G.GAME.current_option_index2 % #G.GAME.option_list2) + 1
    G.GAME.current_option2.option_text2 = G.GAME.option_list2[G.GAME.current_option_index2]

    -- Update option_text for the first option list
    G.GAME.current_option_index = (G.GAME.current_option_index % #G.GAME.option_list) + 1
    G.GAME.current_option.option_text = G.GAME.option_list[G.GAME.current_option_index]


end


function G.FUNCS.checkTalismanFolder()
    local folderPath = "Mods/Talisman/"
    local folderInfo = love.filesystem.getInfo(folderPath, "directory")

    if folderInfo then
        return true
    else
        return false
    end
end


Game.updateHandUpRef = Game.update_hand_played
function Game:update_hand_played(dt)
  self:updateHandUpRef(dt)
if G.GAME.current_round.current_hand.handname ~= '' then
G.LAST_USED_HAND = G.GAME.current_round.current_hand.handname
end
end

