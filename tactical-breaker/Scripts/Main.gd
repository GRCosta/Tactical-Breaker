extends Node2D

@onready var projectile_container = $PlayArea/ProjectileContainer
@onready var block_container = $PlayArea/BlockContainer
@onready var aim_controller = $PlayArea/AimController

@export var ball_scene: PackedScene

# Initial Center position (1080 / 2 = 540)
var next_launch_pos: Vector2 = Vector2(540, 1330)
var first_ball_landed: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Position the aim controller at the start
	aim_controller.global_position = next_launch_pos
	# Connecting to the Game Manager states
	GameManager.state_changed.connect(_on_state_changed)
	# Start the game in the Shop phase
	#GameManager.change_state(GameManager.GameState.SHOP)
	GameManager.change_state(GameManager.GameState.AIM)  # ___ REMOVE AFTER DEBUG ___ #

func _on_state_changed(new_state):
	if new_state == GameManager.GameState.RESOLUTION:
		_resolve_turn()

func _resolve_turn():
	# SEQUENCE
	# 1. Move the Blocks down
	# 2. Check for DeadZone breaches
	# 3. Spawn New row
	# 4. Return to SHOP  [TO BE COMPLETED]
	
	await get_tree().create_timer(1.0).timeout
	GameManager.change_state(GameManager.GameState.SHOP)
	
func spawn_and_launch(direction:Vector2):
	# 1. Safety Check: Make sure the ball.tscn is dragged into the Inspector
	if ball_scene == null:
		print("Critical Error: No ball_scene assigned to Main!!!")
		return
	# 2. Safety check: Is there any containers missing?
	if not projectile_container or not block_container or not aim_controller:
		print("Critical Error: Container not found!!")
		 
	# 3. Instantiate the ball
	first_ball_landed = false
	var new_ball = ball_scene.instantiate()
	projectile_container.add_child(new_ball)
	
	# 4. Set the ball to the current launch position
	new_ball.global_position = next_launch_pos
	
	# 5. Add it to the tree
	projectile_container.add_child(new_ball)
	print('Success! We got them balls!')
	
	# 6. Signal check
	if new_ball.has_signal("returned_to_base"):
		new_ball.returned_to_base.connect(_on_ball_returned)
		
	# 7. Fire ball (Dale!)
	new_ball.launch(direction)
	
func _on_ball_returned():
	# Only capture the location of the first ball to return
	if not first_ball_landed:
		next_launch_pos = landing_x_pos
		# Update the aim controller's position for the next turn
		aim_controller.global_position = next_launch_pos
		first_ball_landed = true
	if projectile_container.get_child_count() <= 1:
		GameManager.change_state(GameManager.GameState.RESOLUTION)
