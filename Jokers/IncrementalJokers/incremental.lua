--- STEAMODDED HEADER
--- MOD_NAME: d_incremental
--- MOD_ID: d_incremental
--- MOD_AUTHOR: [Donovanth1]
--- MOD_DESCRIPTION: Adds 25 Incremental XMult Jokers
--- PREFIX: incr
----------------------------------------------
------------MOD CODE -------------------------
SMODS.Atlas {
	-- Key for code to find it with
	key = "Jokers",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers.png",
	-- Width of each sprite in 1x size
	px = 70,
	-- Height of each sprite in 1x size
	py = 95
}

-- Determines which rarity a card should be based on how much XMult it gives (return [rarity]) where 1=common, 2=uncommon, 3=rare, 4=legendary.
local function determine_rarity(xmult)
	if xmult <= 3 then -- default=2.5
		return 2 -- default=2
	elseif xmult <= 6.5 then -- default=6.5
		return 3 -- default=3
	else -- Left this blank so its easier to account for changes to how many jokers are being made.
		return 4 -- default=4
	end
end

-- Determines how expensive a card should be based on its rarity (return [cost]).
local function determine_cost_by_rarity(rarity)
	if rarity == 2 then -- default=2
		return 4 -- default=4
	elseif rarity == 3 then -- default=3
		return 9 -- default=10
	elseif rarity == 4 then -- default=4
		return 12 -- default=15
	end
end

-- Template function for each incremental joker (recommended not to mess with)
local function create_increment_joker(index, xmult)
	local key = 'increment' .. index
	local name = 'Increment Joker ' .. tostring(index)
	local rarity = determine_rarity(xmult)
	local cost = determine_cost_by_rarity(rarity)

	SMODS.Joker {
		key = key,
		loc_txt = {
			name = name,
			text = {
				"{X:mult,C:white} X#1# {} Mult",
			}
		},
		config = { extra = { Xmult = xmult } },
		rarity = rarity,
		atlas = 'Jokers',
		blueprint_compat = true,
		pos = { x = 0, y = 0 },
		cost = cost,
		unlocked = true,
		discovered = true,
		eternal_compat = true,
		perishable_compat = true,
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.Xmult } }
		end,

		calculate = function(self, card, context)
			if context.joker_main then
				return 
				{
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
					Xmult_mod = card.ability.extra.Xmult
				}
			end
		end
	}
end

-- Dynamically creates (default=25) jokers with increments of (default=0.5) XMult
for i = 1, 12 do
	local mult = 1 + (i * 0.5)
	create_increment_joker(i, mult)
end