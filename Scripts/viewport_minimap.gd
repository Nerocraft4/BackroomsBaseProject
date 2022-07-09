extends ColorRect

onready var device = get_node("../..")

var player
export var zoom = 1.5
onready var grid = get_node(".")
onready var player_marker = $Player_Marker
onready var mob_marker = $Mob_Marker
onready var icons = {"mob":mob_marker}
onready var markers = {}

var grid_scale
var rot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_tree().get_nodes_in_group("Player"))
	if get_tree().get_nodes_in_group("Player").size()==0:
		return
	player_marker.position = grid.rect_size/2
	player_marker.position.y += 100
	grid_scale = grid.rect_size/(get_viewport_rect().size*zoom)
	var map_objects = get_tree().get_nodes_in_group("Enemy")
	player = get_tree().get_nodes_in_group("Player")[0]
	for item in map_objects:
		print("Detected ",item)
		var new_marker = mob_marker.duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker

func _on_Timer_timeout():
	if !player:
		return
	for item in markers:
		if item.isMoving:
			if device.scanning:
				$Detection.play()
				markers[item].show()
				print("Something is moving")
				var x = (player.to_local(item.transform.origin).x)*2
				var y = (player.to_local(item.transform.origin).z)*2
				var obj_pos = Vector2(x,y)
				if abs(x)<300 and abs(y)<300:
					markers[item].scale=Vector2(0.4,0.4)
				else:
					markers[item].scale=Vector2(0.1,0.1)
				rot = player.get_node("Head").rotation.y
				markers[item].position = obj_pos.rotated(rot)+player_marker.position
			else:
				#Maybe play alternate sound?
				pass				
		else:
			markers[item].hide()
