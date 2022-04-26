extends Node2D

var map = {}
var currentScene = null

export var mapPath = ""
export var tileset1Path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root()
	currentScene = root.get_child(root.get_child_count() - 1)
	loadmap()



func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		loadmap()

func loadmap():
	var file = File.new();
	file.open(mapPath, File.READ);
	map = parse_json(file.get_as_text())
	
	if map.has("properties"):
		for prop in map.properties:
			if prop.name == "music":
				if prop.value != "":
					print("map has a music track called ", prop.value)
	
	if map.has("layers"):
		for layers in range(0,map.layers.size()):
			var tilemap = TileMap.new() 
			tilemap.cell_size = Vector2(map.tilewidth,map.tileheight)
			tilemap.name = map.layers[layers].name
			tilemap.tile_set = load(tileset1Path)
			tilemap.cell_y_sort = true
			
			var collection = false
			
			#if map.layers[layers].has("properties"):
				#for prop in map.layers[layers].properties:
					#var props = prop
					#if props.name == "imagesCollection":
						#if props.value == true:
							#tilemap.tile_set = load(tileset2Path)
							#collection = true
							
						
					
							
						
			
			currentScene.add_child(tilemap)
			if map.layers[layers].has("data"):
				for i in range(0,map.layers[layers].data.size()):
					var tile = -1
					tile = int(map.layers[layers].data[i]-1)
					
					
					var array_x = (int(i)%int(map.layers[layers].width))*map.tilewidth
					var array_y = floor(i/map.layers[layers].width)*map.tileheight
					var pos = Vector2(array_x,array_y)
					var cell = tilemap.world_to_map(pos)
					
					var atlas_image = tilemap.tile_set.tile_get_texture(0)
					var atlas_X = tile % (atlas_image.get_width()/int(map.tilewidth))
					var atlas_Y = floor(tile / (atlas_image.get_width()/int(map.tilewidth)))
					
					
					if map.tilesets.size() != 1:
						if tile >= map.tilesets[1].firstgid-1:
							tilemap.set_cell(
								cell.x,
								cell.y,
								tile-(map.tilesets[1].firstgid-2))
						else:
							tilemap.set_cell(
								cell.x,
								cell.y,
								0,
								false,
								false,
								false,
								Vector2(atlas_X,atlas_Y))
					else:
						tilemap.set_cell(
								cell.x,
								cell.y,
								0,
								false,
								false,
								false,
								Vector2(atlas_X,atlas_Y))
						
						
					
							
						
						
			elif map.layers[layers].has("objects"):
				for object in map.layers[layers].objects:
					if object.type == "npc":
						var node = load("res://npc.tscn")
						var npcNode = node.instance()
						npcNode.position = Vector2(object.x+(object.width/2),object.y+(object.height/2))
						
						for props in object.properties:
							if props.name == "sprite":
								print(props.value)
							if props.name == "dialogue":
								print(props.value)
						
						tilemap.add_child(npcNode)
						
					if object.type == "door":
						var node = load("res://door.tscn")
						var doorNode = node.instance()
						doorNode.get_node("CollisionShape2D").shape = doorNode.get_node("CollisionShape2D").shape.duplicate()
						doorNode.get_node("CollisionShape2D").shape.extents = Vector2(object.width/2,object.height/2)
						doorNode.position = Vector2(object.x+object.width/2,object.y+object.height/2)
						tilemap.add_child(doorNode)
	file.close()
						

