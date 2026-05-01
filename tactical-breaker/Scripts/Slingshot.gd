extends Node2D

@export var max_velocity: float = 800.0
@export var trajectory_dots: int = 20

var is_dragging: bool = false
var start_touch_pos: Vector2
var current_direction: Vector2

@onready var trajectory_line = $Trajectory_Line



func _ready():
	print("Slingshot is alive and waiting...")
	# Force state to AIM if GameManager isn't doing it yet
	if GameManager.current_state != GameManager.GameState.AIM:
		GameManager.change_state(GameManager.GameState.AIM)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("1. Mouse Click Detected")
	if GameManager.current_state != GameManager.GameState.AIM:
		print("   - FAILED: GameManager state is: ", GameManager.GameState.keys()[GameManager.current_state])
		return
		
	if event is InputEventMouseButton:
		is_dragging = true
		start_touch_pos = get_local_mouse_position()
		trajectory_line.visible = true
	elif is_dragging:
		is_dragging = false
		trajectory_line.visible = false
		if current_direction.length() > 0.1:
			owner.spawn_and_launch(current_direction)
			GameManager.change_state(GameManager.GameState.ACTION)

	if event is InputEventMouseMotion and is_dragging:
		print("2. Mouse Released")
		var mouse_local = get_local_mouse_position()
		var drag_vector = start_touch_pos - mouse_local
		current_direction = drag_vector.normalized()
		update_trajectory(event.position)

func update_trajectory(touch_pos:Vector2):
	trajectory_line.clear_points()
	trajectory_line.add_point(Vector2.ZERO)
	
	var line_end = current_direction * 200
	trajectory_line.add_point(line_end)
	
	var drag_vec = start_touch_pos - touch_pos
	current_direction= drag_vec.normalized()
	queue_redraw()

func launch_ball():
	## Main scene spawn and fire the ball
	#var main_node = get_tree().root.find_child("Main", true, false)
	#
	#if main_node:
	#	main_node.spawn_and_launch(current_direction)
	#	GameManager.change_state(GameManager.GameState.ACTION)
	#else:
	#	print("ERROR: Slingshot could not find the Main Node!!")
	print("3. Attempting to Launch...")
	var main_node = get_tree().root.find_child("Main", true, false)
	if main_node:
		print("4. Main Node Found! Calling spawn_and_launch")
		main_node.spawn_and_launch(current_direction)
		GameManager.change_state(GameManager.GameState.ACTION)
	else:
		print("4. ERROR: Main Node NOT found in the tree!")
	
