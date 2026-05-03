extends Node2D

var is_dragging: bool = false
var current_dir: Vector2 = Vector2.UP

@onready var trajectory_line = $TrajectoryLine

func _input(event: InputEvent) -> void:
	if GameManager.current_state != GameManager.GameState.AIM:
		trajectory_line.visible = false
		return
	
	if event is InputEventMouseButton:
		if event.pressed:
			is_dragging = true
			trajectory_line.visible = true
			_update_aim(event.position)
		else:
			is_dragging = false
			trajectory_line.visible = false
			owner.spawn_and_launch(current_dir)
			GameManager.change_state(GameManager.GameState.ACTION)
			
	if event is InputEventMouseMotion and is_dragging:
		_update_aim(event.position)
		

func _update_aim(mouse_pos:Vector2):
	# Calculate the direction from the current node poisition to the mouse
	# Using global position to not rely on the actual node position
	var direction = (mouse_pos - global_position).normalized()
	
	# Constraint: Players should not be able to shoot directly sideways.
	if direction.y > -0.2:
		direction.y = -0.2
		direction = direction.normalized()
		
		current_dir = direction
		
		# Updating the visual line
		trajectory_line.clear_points()
		trajectory_line.add_point(Vector2.ZERO)
		trajectory_line.add_point(current_dir * 500)  # Long projection. Could be a option for update later?
