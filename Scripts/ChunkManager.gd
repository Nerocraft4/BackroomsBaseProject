extends Spatial

var conn = Vector2.ZERO
var NX = Vector2.LEFT
var PX = Vector2.RIGHT
var NZ = Vector2.DOWN
var PZ = Vector2.UP
#var spawnChunk = preload("res://prefabs/Chunks/Chunk1.tscn")
var plazaChunk = preload("res://prefabs/Chunks/Chunk2.tscn")
var minosChunk = preload("res://prefabs/Chunks/Chunk3.tscn")

func _ready():
	pass # Replace with function body.

func _on_AreaNX_body_entered(body):
	if(body.is_in_group("Player")):
		conn = NX
		print("Entered NX")

func _on_AreaNX_body_exited(body):
	if(body.is_in_group("Player") and conn==NX):
		conn = Vector2.ZERO #cal?
		print("Left NX")

func _on_AreaPX_body_entered(body):
	if(body.is_in_group("Player")):
		conn = PX
		print("Entered PX")

func _on_AreaPX_body_exited(body):
	if(body.is_in_group("Player") and conn==PX):
		conn = Vector2.ZERO #cal?
		print("Left PX")

func _on_AreaNZ_body_entered(body):
	if(body.is_in_group("Player")):
		conn = NZ
		print("Entered NZ")

func _on_AreaNZ_body_exited(body):
	if(body.is_in_group("Player") and conn==NZ):
		conn = Vector2.ZERO #cal?
		print("Left NZ")

func _on_AreaPZ_body_entered(body):
	if(body.is_in_group("Player")):
		conn = PZ
		print("Entered PZ")

func _on_AreaPZ_body_exited(body):
	if(body.is_in_group("Player") and conn==PZ):
		conn = Vector2.ZERO #cal?
		print("Left PZ")
