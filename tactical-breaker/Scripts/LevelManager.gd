extends Node2D

@export var block_scene: PackedScene
@export var grid_width: int = 7
@export var cell_size: Vector2 = Vector2(150, 60)

func spawn_row():
	# Shifting the rows down
	for block in get_tree().get_nodes_in_group("blocks"):
		block.position.y += cell_size.y
		
		# Spawn a new row at the top
	for i in range(grid_width):
		if randf() > 0.3: # &70% chace of spawning a block. Might need fine tuning later
			var new_block = block_scene.instantiate()
			add_child(new_block)
			new_block.position = Vector2(i * cell_size.x, 0)
