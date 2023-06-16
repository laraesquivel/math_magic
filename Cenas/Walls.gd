extends TileMap

var cellMain
var cellColised

func _ready():
	var destructibleTile
	destructibleTile = Global.connect("wallHitted", self, "destroy")
	
func destroy():
	var cellSelect
	cellMain = world_to_map(Global.magicShot)
	cellColised = Vector2(-10,-10)
	
	for x in range(-1,2):
		for y in range(-1,2):
			cellSelect = Vector2(cellMain.x + x, cellMain.y + y)
			if (get_cellv(cellSelect) >= 0):
				if (Global.magicShot.distance_to(centerCoordenate(cellSelect))) < (Global.magicShot.distance_to(centerCoordenate(cellColised))):
					cellColised = cellSelect
					
	if get_cellv(cellColised) < 3:
		set_cellv(cellColised, -1)

func centerCoordenate(tile : Vector2) -> Vector2:
	return Vector2(map_to_world(tile) + cell_size/2)
	
func distance(tile : Vector2) -> float:
	var coordTile = centerCoordenate(tile)
	var dX = Global.magicShot.x - coordTile.x
	var dY = Global.magicShot.y - coordTile.y
	return (((dX)*2+(dY)*2)^(0.5))

