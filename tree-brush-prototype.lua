require ("tree-brush-pictures")

data:extend({

  {
    type = "item",
    name = "tree-brush",
    icon = "__TreeBrush__/tree-brush/transport-belt-icon.png",
    flags = {"goes-to-quickbar"},
    subgroup = "terrain",
    order = "c[landfill]-b[tree-brush]",
    place_result = "tree-brush",
    stack_size = 200
  },
  
  
  {
    type = "recipe",
    name = "tree-brush",
	 energy_required = 2,
	 enabled = true,
	 category = "crafting",
    ingredients =
    {
      {"raw-wood", 4}
    },
    result = "tree-brush",
	 enabled = true,
    result_count = 1,
    requester_paste_multiplier = 4,
  },


{
    type = "transport-belt",
    name = "tree-brush",
    icon = "__TreeBrush__/tree-brush/transport-belt-icon.png",
	 
    --flags = {"placeable-neutral", "player-creation"},
	 
	 flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
	 
    minable = {hardness = 0.2, mining_time = 0.3, result = "tree-brush"},
    max_health = 50,
    corpse = "small-remnants",
    resistances =
    {
      {
        type = "fire",
        percent = 60
      }
    },
	collision_mask = {},
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/transport-belt.ogg",
        volume = 0.4
      },
      max_sounds_per_type = 3
    },
    animation_speed_coefficient = 32,
    animations =
    {
      filename = "__TreeBrush__/tree-brush/transport-belt.png",
      priority = "extra-high",
      width = 40,
      height = 40,
      frame_count = 1,
      direction_count = 12
    },
    belt_horizontal = basic_belt_horizontal,
    belt_vertical = basic_belt_vertical,
    ending_top = basic_belt_ending_top,
    ending_bottom = basic_belt_ending_bottom,
    ending_side = basic_belt_ending_side,
    starting_top = basic_belt_starting_top,
    starting_bottom = basic_belt_starting_bottom,
    starting_side = basic_belt_starting_side,
    ending_patch = ending_patch_prototype,
    fast_replaceable_group = "transport-belt",
    speed = 0.03125,
    connector_frame_sprites = transport_belt_connector_frame_sprites,
    circuit_connector_sprites = transport_belt_circuit_connector_sprites,
    circuit_wire_connection_point = transport_belt_circuit_wire_connection_point,
    circuit_wire_max_distance = transport_belt_circuit_wire_max_distance
  }
  

  
 })