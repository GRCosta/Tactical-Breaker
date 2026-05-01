extends Node2D

@export var max_velocity: float = 800.0
@export var trajectory_dots: int = 20

var is_dragging: bool = false
var start_touch_pos: Vector2
var current_direction: Vector2


func _input(event: InputEvent) -> void:
	# Only allow aiming if the GameManager is ready
	if GameManager.current_state != GameManager.GameState.AIM:
		return
	if event is InputEventScreenTouch or event is InputEventMouseButton:
		if event.pressed:
			is_dragging = true
			start_touch_pos = event.position
		elif is_dragging:
			is_dragging = false
			launch_ball()
		if event is InputEventScreenDrag or event is InputEventMouseMotion:
			if is_dragging:
				update_trajectory(event.position)
				

func update_trajectory(touch_pos:Vector2):
	var drag_vec = start_touch_pos - touch_pos
	current_direction= drag_vec.normalized()
	queue_redraw()

func launch_ball():
	# Main scene spawn and fire the ball
	get_parent().get_parent().spawn_and_launch(current_direction)
	GameManager.change_state(GameManager.GameState.ACTION)
