extends Spatial

#export(PackedScene) var Map

var ChunkCoords = Vector2()
var difficulty = 9
var size = 20
var MapSize = Vector2(1,1)
var k = 0
var rng = RandomNumberGenerator.new()

var ceilWithLight = preload("res://prefabs/CeilingGroup.tscn")
var ceilWoutLight = preload("res://prefabs/CeilingGroupNoLit.tscn")
var spawnChunk = preload("res://prefabs/Chunks/Chunk1.tscn")
var plazaChunk = preload("res://prefabs/Chunks/Chunk2.tscn")
var minosChunk = preload("res://prefabs/Chunks/Chunk3.tscn")
var enemy = preload("res://prefabs/Enemy.tscn")
onready var player = $Player
onready var timer = $Timer
var ceiling

func _ready():
	var e = enemy.instance()
	e.translation = Vector3((4)*size, 0, (2)*size)
	e.rotation.y=180
	add_child(e)
	generate_Initial_Level()
	timer.start()

func _process(delta):
#	print(ChunkCoords)
	pass

#fer una array de chunks (array buida) 
#mida del mapa predefinida
var Map = [[null,null,null],[null,"SPAWN",null],[null,null,null]]

func generate_Initial_Level():
	var iterator = 0
	makeChunkCeiling(0,0)
	var SP = spawnChunk.instance()
	#SP.rotate_object_local(Vector3(0, 1, 0), (PI/2)*(k%4))
	Map[1][1]=SP
	add_child(SP)

func makeChunkCeiling(a,b):
	for i in range(7):
		for j in range(7):
			rng.randomize()
			k = rng.randi_range(0,100)
			if k < difficulty*10:
				ceiling = ceilWoutLight.instance()
			else:
				ceiling = ceilWithLight.instance()
			ceiling.translation = Vector3((i-4+a*9)*size, 10, (j-4+b*9)*size)
			ceiling.rotate_object_local(Vector3(0, 0, 1), PI)
			add_child(ceiling)
	print("Ceiling Complete in "+str(a)+","+str(b))


func _on_Timer_timeout():
	#Això GENERA el sostre (pel "cos" serà igual de fàcil)
	ChunkCoords = getChunkCoords(player)
	#print(ChunkCoords)
	var ArrCoords = ChunkCoords + MapSize #Ajust desplaçament array começa 0,0
	#print(ArrCoords)
	#mirar veí obert (si currentChunk.conn!=Vec2.ZERO)
	#o mirar directament ChunkCoords+CurrentChunk.conn (serà ell mateix si
	#conn és (0,0), però podem NO mirar aquest cas ja que suposem que si 
	#"estem" en un chunk, aquest està generat
	if !Map[ArrCoords.x][ArrCoords.y]:
		makeChunkCeiling(ChunkCoords.x,ChunkCoords.y)
		Map[ArrCoords.x][ArrCoords.y]="generated"
	#Ara falta "desgenerar"

func getChunkCoords(spatial):
	var v = Vector2(int(spatial.translation.x)/90,int(spatial.translation.z)/90)
	return v
