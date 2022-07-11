extends Spatial

var div = 9*6
export var scalarMapSize = 2
var MapSize = Vector2(scalarMapSize,scalarMapSize)
var CeilingChunk = preload("res://prefabs/CeilingChunk.tscn")
onready var player = $Player
var CCords = Vector2.ZERO
var iCCords = Vector2.ZERO
#nota, donar un marge extra a la array de chunks, que sigui la "vora" del mapa
#nota, fer la array dinàmica XD
var Map

func _ready():
	Map = readyMap(scalarMapSize)
	for i in range(scalarMapSize*2+1):
		for j in range(scalarMapSize*2+1):
			makeChunkCeiling(i-scalarMapSize,j-scalarMapSize)
	pass 

func readyMap(siz):
	var myMap = []
	var border = []
	for i in range(2*siz+1):
		border.append("Border")
	var column = ["Border"]
	for i in range(2*siz-1):
		column.append(null)
	column.append("Border")
	myMap.append(border)
	for i in range(2*siz-1):
		var c = column.duplicate(true)
		myMap.append(c)
	myMap.append(border)
	myMap[siz][siz] = "Spawn"
	return myMap
	
func getChunkCoords(spatial):
	var v = Vector2(int(spatial.translation.x)/div,int(spatial.translation.z)/div)
	return v

func getChunkInnerCoords(spatial):
	var v = Vector2((int(spatial.translation.x)/(div/2))%2,
					(int(spatial.translation.z)/(div/2))%2)
	return v

func _on_Timer_timeout():
#	CCords = getChunkCoords(player)
#	iCCords = getChunkInnerCoords(player)
#	var ArrCoords = CCords + MapSize
#	print(Map[ArrCoords.x][ArrCoords.y])
#	if !Map[ArrCoords.x][ArrCoords.y]:
#		makeChunkCeiling(CCords.x,CCords.y)
#		Map[ArrCoords.x][ArrCoords.y]="generated"
#	print("PlayerTrans"+str(player.transform.origin))
#	print("ChunkCoords"+str(CCords))
#	print("InnerCoords"+str(iCCords))
	pass # Replace with function body.

func makeChunkCeiling(a,b):
	var myCeil = CeilingChunk.instance()
	myCeil.translation = Vector3(a*div*2,2,b*div*2)
	$CeilingContainer.add_child(myCeil)
	Map[a][b] = myCeil
	pass

func removeAdjacents(a,b):
	 pass
