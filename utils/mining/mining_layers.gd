class_name MiningGameplay
extends Node




#region MiningTiles
const TILE_SOURCE_ID : int = 1
const UNDESTRUCTIBLE_TILE_CORDS : Vector2i = Vector2i(6,0)

const TETRIS_SHAPES : Array[Array]= [
	[Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(3, 0)], # I shape
	[Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 1), Vector2i(1, 2)], # S shape
	[Vector2i(0, 0), Vector2i(1, 0), Vector2i(1, 1), Vector2i(2, 1)], # Z shape
	[Vector2i(0, 0), Vector2i(1, 0), Vector2i(0, 1), Vector2i(1, 1)], # O shape
	[Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0), Vector2i(1, 1)], # T shape
	[Vector2i(0, 0), Vector2i(0, 1), Vector2i(0, 2), Vector2i(1, 2)], # L shape
	[Vector2i(1, 0), Vector2i(1, 1), Vector2i(1, 2), Vector2i(0, 2)]  # J shape
]



const MINING_TILEMAP_CORDS : Array[Vector2i]= [
	Vector2i(1,0),
	Vector2i(2,0),
	Vector2i(3,0),
	Vector2i(4,0),
	Vector2i(5,0),
	
]

@onready var mineable_tiles_1: MiningTileLayer = $MineableTiles1
@onready var mineable_tiles_2: MiningTileLayer = $MineableTiles2
@onready var mineable_tiles_3: MiningTileLayer = $MineableTiles3
@onready var mineable_tiles_4: MiningTileLayer = $MineableTiles4
@onready var mineable_tiles_5: MiningTileLayer = $MineableTiles5
@onready var mineable_tiles_6: MiningTileLayer = $MineableTiles6

@onready var mineable_tiles : Array[MiningTileLayer]=[
	mineable_tiles_6,
	mineable_tiles_5,
	mineable_tiles_4,
	mineable_tiles_3,
	mineable_tiles_2,
mineable_tiles_1,

]




#endregion

const ILMENITE_TITANIUM : MiningGem  = preload("uid://ugi7i0evcrkl")
const PLATINUM : MiningGem  = preload("uid://burj3k8r83vs8")
const RHUTENIUM : MiningGem  = preload("uid://q3a7408j4bsp")


const OPAL : MiningGem = preload("uid://choxc80k5nmsu")
const RUBY : MiningGem = preload("uid://cnv21encgt00m")
const SANS : MiningGem  = preload("uid://b3tijewe3ljie")
const STAR : MiningGem  = preload("uid://bc748uh3ddd2g")

var mining_gems : Array[MiningGem]=[
	ILMENITE_TITANIUM,
	PLATINUM,
	RHUTENIUM,
	
	
]

var UNIQUE_GEMS : Array[MiningGem]=[
	ILMENITE_TITANIUM,
	PLATINUM,
	RHUTENIUM,
	
	
	
]



const GEM_TILE_SOURCE_ID : int = 0




const GRID_SIZE :Vector2i = Vector2i(14, 15)


const MINING_MAX_AMOUNT : int = 60
const PRECISE_DURABILITY_DAMAGE : int = 1
const BROAD_DURABILITY_DAMAGE : int = 4


const GEM_MIN_AMOUNT : int = 5
const CHANCE_TO_PLACE_GEM_PER_TILE : float = 0.02

const CHANCE_TO_PLACE_UNDESCTRUCTIBLE_TILE_SHAPE_PER_TILE : float = 0.09

const CHANCE_TO_PLACE_THIRD_LAYER_TILE_SHAPE_PER_TILE : float = 0.1
const CHANCE_TO_PLACE_FOURTH_LAYER_TILE_SHAPE_PER_TILE : float = 0.05




@onready var undestructible_tiles: MiningTileLayer = $UndestructibleTiles
@onready var gem_tiles: MiningTileLayer = $GemTiles


@onready var find_gems_button: Button = $FindGemsButton

@onready var mining_bar: MiningProgressBar = $MiningBar

@onready var switch_mining_mode_button: Button = $SwitchMiningModeButton


var mining_amount : float:
	set(value):
		mining_amount = clampf(value,0.0,MINING_MAX_AMOUNT) 
		mining_bar.update_bar(mining_amount)
		
		

enum MiningModes {
	PRECISE,
	BROAD,
	
}

var mining_mode : MiningModes:
	set(value):
		mining_mode = value
		if mining_mode == MiningModes.PRECISE:
			switch_mining_mode_button.text = "Precise"
		elif mining_mode == MiningModes.BROAD:
			switch_mining_mode_button.text = "Broad"
			


func _ready() -> void:
	mining_bar.max_value = MINING_MAX_AMOUNT
	mining_amount = MINING_MAX_AMOUNT
	
	
	mining_mode = MiningModes.PRECISE
	
	
	switch_mining_mode_button.pressed.connect(on_switch_mining_mode)
	find_gems_button.pressed.connect(func():finished_mining.emit() )
	
	#create_map() ## NOTE debug


func on_switch_mining_mode()->void:
	
	match mining_mode:
		MiningModes.PRECISE:
			mining_mode = MiningModes.BROAD
		MiningModes.BROAD:
			mining_mode = MiningModes.PRECISE
	
	


func create_map()->void:
	
	place_undestructible_shapes()
	
	place_gems()
	
	
	
	place_mineable_tiles()
	
	
	
	
	
	


#region Gem placement

var placed_gem_amount : int = 0




func place_gems()->void:
	await get_tree().process_frame
	placed_gem_amount = 0
	
	while placed_gem_amount < GEM_MIN_AMOUNT:
		for x : int in range(GRID_SIZE.x):
			for y : int in range(GRID_SIZE.y):
				if randf() < CHANCE_TO_PLACE_GEM_PER_TILE:
					print(str(mining_gems))
					
					var random_gem = load("uid://ugi7i0evcrkl")
					if random_gem is not MiningGem:
						print(str(random_gem))
						continue
					
					_place_gem(Vector2i(x, y),random_gem)
					#place_shape(Vector2i(x, y), UNDESTRUCTIBLE_TILE_CORDS, random_shape, undestructible_tiles)
					
					
		

func _place_gem(place_location : Vector2i, mining_gem : MiningGem)->void:
	
	var gem_placement_positions : Array[Vector2i] = []
	
	for shape_pos : Vector2i in mining_gem.gem_shape_tile_map_pos_dict.keys():
		
		gem_placement_positions.append(shape_pos+place_location)
	
	
	for gem_placement_pos : Vector2i in gem_placement_positions:
		
		if gem_tiles.get_cell_tile_data(gem_placement_pos):
			return
		
		if not (gem_placement_pos.x >= 0 and gem_placement_pos.x < GRID_SIZE.x and \
		   gem_placement_pos.y >= 0 and gem_placement_pos.y < GRID_SIZE.y):
			return
	
	
	for shape_pos : Vector2i in mining_gem.gem_shape_tile_map_pos_dict.keys():
		var gem_placement_pos : Vector2i = shape_pos+place_location
		
		
		var gem_tilemap_cords : Vector2i = mining_gem.gem_shape_tile_map_pos_dict.get(shape_pos)
		
		
		gem_tiles.set_cell(gem_placement_pos, GEM_TILE_SOURCE_ID, gem_tilemap_cords)
		
	
	
	placed_gem_amount+=1
	
#finished_mining.emit()

func find_gems()-> Array[MiningGem]:
	var gems : Array[MiningGem] = []
	
	for x : int in range(GRID_SIZE.x):
		for y : int in range(GRID_SIZE.y):
			for gem : MiningGem in UNIQUE_GEMS:
				if _find_gem(Vector2i(x,y),gem):
					#print(gem.gem_name)
					gems.append(gem)
				
			
		
	
	return gems
	


func _check_if_tile_is_covered(tile_cords : Vector2i)->bool:
	
	
	for mineable_tile : MiningTileLayer in mineable_tiles:
		
		if mineable_tile.get_cell_tile_data(tile_cords):
			return true
		
	
	
	return false


## returns false if gem is covered by something
func _find_gem(tile_cords : Vector2i, gem : MiningGem)->bool:
	var gem_tile_map_cords : Vector2i = gem.gem_shape_tile_map_pos_dict.values().get(0)
	
	
	if gem_tiles.get_cell_atlas_coords(tile_cords) != gem_tile_map_cords:
		return false
	
	var tile_offset : Vector2i = tile_cords - gem.gem_shape_tile_map_pos_dict.keys().get(0)
	
	for tile_shape_pos : Vector2i in gem.gem_shape_tile_map_pos_dict.keys():
		var tile_map_pos : Vector2i = tile_shape_pos + tile_offset
		
		if _check_if_tile_is_covered(tile_map_pos):
			return false
		
	
	
	
	
	
	return true
#endregion





func place_mineable_tiles()->void:
	
	
	
	for x : int in range(GRID_SIZE.x):
		for y : int in range(GRID_SIZE.y):
			mineable_tiles_1.set_cell(Vector2i(x,y), TILE_SOURCE_ID,MINING_TILEMAP_CORDS[0])
			
	
	
	
	for x : int in range(GRID_SIZE.x):
		for y : int in range(GRID_SIZE.y):
			mineable_tiles_2.set_cell(Vector2i(x,y), TILE_SOURCE_ID,MINING_TILEMAP_CORDS[1])
			
	
	
	#if randf() < CHANCE_TO_PLACE_UNDESCTRUCTIBLE_TILE_SHAPE_PER_TILE:
				#var random_shape : Array = TETRIS_SHAPES[randi() % TETRIS_SHAPES.size()]
				#place_shape(Vector2i(x, y), UNDESTRUCTIBLE_TILE_CORDS, random_shape, undestructible_tiles)
	#
	#CHANCE_TO_PLACE_THIRD_LAYER_TILE_SHAPE_PER_TILE
	
	for x : int in range(GRID_SIZE.x):
		for y : int in range(GRID_SIZE.y):
			if randf() < CHANCE_TO_PLACE_THIRD_LAYER_TILE_SHAPE_PER_TILE:
				var random_shape : Array = TETRIS_SHAPES[randi() % TETRIS_SHAPES.size()]
				place_shape(Vector2i(x, y), MINING_TILEMAP_CORDS[2], random_shape, mineable_tiles_3)
				
				
			
			
			#mineable_tiles_3.set_cell(Vector2i(x,y), TILE_SOURCE_ID,MINING_TILEMAP_CORDS[2])
			
	
	#for x : int in range(GRID_SIZE.x):
		#for y : int in range(GRID_SIZE.y):
			#mineable_tiles_4.set_cell(Vector2i(x,y), TILE_SOURCE_ID,MINING_TILEMAP_CORDS[3])
			#
	
	for x : int in range(GRID_SIZE.x):
		for y : int in range(GRID_SIZE.y):
			if randf() < CHANCE_TO_PLACE_FOURTH_LAYER_TILE_SHAPE_PER_TILE:
				var random_shape : Array = TETRIS_SHAPES[randi() % TETRIS_SHAPES.size()]
				place_shape(Vector2i(x, y), MINING_TILEMAP_CORDS[3], random_shape, mineable_tiles_4)
				
	
	









func place_undestructible_shapes():
	
	
	for x : int in range(GRID_SIZE.x):
		for y : int in range(GRID_SIZE.y):
			if randf() < CHANCE_TO_PLACE_UNDESCTRUCTIBLE_TILE_SHAPE_PER_TILE:
				var random_shape : Array = TETRIS_SHAPES[randi() % TETRIS_SHAPES.size()]
				#place_shape(Vector2i(x, y), UNDESTRUCTIBLE_TILE_CORDS, random_shape, undestructible_tiles)
				place_shape_unbreakable_tiles(Vector2i(x, y),random_shape,undestructible_tiles)
				
				

func place_shape(place_location : Vector2i, tilemap_tile_cords : Vector2i, shape_cords : Array, mining_tile_layer : MiningTileLayer)->void:
	
	
	for coord : Vector2i in shape_cords:
		
		var final_position : Vector2i = place_location + coord
		
		
		if final_position.x >= 0 and final_position.x < GRID_SIZE.x and \
		   final_position.y >= 0 and final_position.y < GRID_SIZE.y:
			
			mining_tile_layer.set_cell(final_position, TILE_SOURCE_ID, tilemap_tile_cords)
		
		

func place_shape_unbreakable_tiles(place_location : Vector2i, shape_cords : Array, mining_tile_layer : MiningTileLayer)->void:
	
	var final_pos_shape_cords : Array[Vector2i] = []
	
	for coord : Vector2i in shape_cords:
		var final_position : Vector2i = place_location + coord
		if not( final_position.x >= 0 and final_position.x < GRID_SIZE.x and 
		   final_position.y >= 0 and final_position.y < GRID_SIZE.y):
			
			return
		
		
		final_pos_shape_cords.append(final_position)
	
	mining_tile_layer.set_cells_terrain_connect(final_pos_shape_cords,0,0)
	
	
	#
	#for coord : Vector2i in shape_cords:
		#
		#var final_position : Vector2i = place_location + coord
		#
		#
		#if final_position.x >= 0 and final_position.x < GRID_SIZE.x and \
		   #final_position.y >= 0 and final_position.y < GRID_SIZE.y:
			#
			#mining_tile_layer.set_cell(final_position, TILE_SOURCE_ID, tilemap_tile_cords)
			#mining_tile_layer.set_cells_terrain_connect([final_position],0,0)
		#



func _find_top_tile_layer(tile_cords : Vector2i)->MiningTileLayer:
	
	
	for mineable_tile : MiningTileLayer in mineable_tiles:
		
		if mineable_tile.get_cell_tile_data(tile_cords):
			return mineable_tile
		
	
	
	return null




signal mined

signal finished_mining


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		
		var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		var local_pos: Vector2 = mineable_tiles_6.to_local(mouse_pos)
		var cell_coords: Vector2i = mineable_tiles_6.local_to_map(local_pos)
		#print("Clicked tile at:", cell_coords)
		
		if not _find_top_tile_layer(cell_coords):
			return
		
		
		if mining_amount <=0:
			finished_mining.emit()
			return
		
		match mining_mode:
			MiningModes.PRECISE:
				mine_precise(cell_coords)
				mining_amount -=PRECISE_DURABILITY_DAMAGE
			
			MiningModes.BROAD:
				mine_broad(cell_coords)
				mining_amount -=BROAD_DURABILITY_DAMAGE
				
		
		mined.emit()
		
	

const BROAD_TILE_BREAK_DIST : int = 3

func mine_broad(center_cell_cords: Vector2i)->void:
	
	for _i : int in BROAD_TILE_BREAK_DIST:
		
		mine_cell(center_cell_cords)
		
		
		mine_cell(center_cell_cords + Vector2i.UP) 
		mine_cell(center_cell_cords + Vector2i.UP + Vector2i.RIGHT) 
		mine_cell(center_cell_cords + Vector2i.RIGHT) 
		mine_cell(center_cell_cords + Vector2i.DOWN + Vector2i.RIGHT) 
		mine_cell(center_cell_cords + Vector2i.DOWN) 
		mine_cell(center_cell_cords + Vector2i.DOWN + Vector2i.LEFT)  
		mine_cell(center_cell_cords + Vector2i.LEFT)  
		mine_cell(center_cell_cords + Vector2i.UP + Vector2i.LEFT)  
		
	


func mine_precise(center_cell_cords: Vector2i)->void:
	
	
	
	mine_cell(center_cell_cords)
	mine_cell(center_cell_cords)
	
	if _find_top_tile_layer(center_cell_cords) || gem_tiles.get_cell_tile_data(center_cell_cords) || not undestructible_tiles.get_cell_tile_data(center_cell_cords):
		mine_cell(center_cell_cords + Vector2i.UP)
		mine_cell(center_cell_cords + Vector2i.DOWN)
		mine_cell(center_cell_cords + Vector2i.RIGHT)
		mine_cell(center_cell_cords + Vector2i.LEFT)
		
		
		
	
	
	
	
	
	
	
	
	
	
	



func mine_cell(cell_cords : Vector2i)->void:
	if not (cell_cords.x >= 0 and cell_cords.x < GRID_SIZE.x and cell_cords.y >= 0 and cell_cords.y < GRID_SIZE.y):
		return
	
	
	var top_tile_layer : MiningTileLayer = _find_top_tile_layer(cell_cords)
	if not top_tile_layer:
			return
		
	
	
	top_tile_layer.set_cell(cell_cords)
	
