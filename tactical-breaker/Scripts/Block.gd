extends StaticBody2D

@export var max_health: int = 1
@export var coin_value: int = 10

var current_health: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health
	# Add to a group to help with collision detected
	add_to_group("blocks")
	
func take_damage(amount:int):
	current_health -= amount
	# Visual Feedback loop
	flash_white()
	
	if current_health <= 0:
		explode()
		
func flash_white():
	modulate = Color(10, 10, 10)
	await get_tree().create_timer(0.05).timeout
	modulate = Color(1,1,1)


func explode():
	GameManager.add_coins(coin_value)
	queue_free()
