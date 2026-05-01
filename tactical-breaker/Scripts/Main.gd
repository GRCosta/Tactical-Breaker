extends Node2D

@onready var projectile_container = $PlayArea/ProjectileContainer
@onready var block_container = $PlayArea/BlockContainer

@export var ball_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connecting to the Game Manager states
	GameManager.state_changed.connect(_on_state_changed)
	# Start the game in the Shop phase
	GameManager.change_state(GameManager.GameState.SHOP)

func _on_state_changed(new_state):
	if new_state == GameManager.GameState.RESOLUTION:
		_resolve_turn

func _resolve_turn():
	# SEQUENCE
	# 1. Move the Blocks down
	# 2. Check for DeadZone breaches
	# 3. Spawn New row
	# 4. Return to SHOP  [TO BE COMPLETED]
	
	await get_tree().create_timer(1.0).timeout
	GameManager.change_state(GameManager.GameState.SHOP)
	
func spawn_and_launch(direction:Vector2):
	if ball_scene == null:
		print("Error: No ball_scene assigned to Main!!!")
		return
		
		var new_ball = ball_scene.instantiate()
		projectile_container.add_child(new_ball)
		
		# Connecting the ball movement to states
		new_ball.returned_to_base.connect(_on_ball_returned)
		
		new_ball.launch(direction)
	
func _on_ball_returned():
	if projectile_container.get_child_count() <= 1:
		GameManager.change_state(GameManager.GameState.RESOLUTION)
