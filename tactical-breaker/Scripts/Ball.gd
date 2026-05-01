extends RigidBody2D

signal returned_to_base

var is_active = false
var base_speed : int = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Locking the rotation since we don't need that for now.
	lock_rotation = true
	# Adding the collision signal to the own object
	body_entered.connect(_on_body_entered)
	
func launch(direction: Vector2):
	is_active = true
	apply_central_impulse(direction * base_speed)
	
func _physics_process(_delta: float) -> void:
	if is_active:
		linear_velocity = linear_velocity.normalized() * base_speed   # RigidBodies can lose speed due to floating point errors;

func _on_body_entered(body):
	if body.is_in_group("blocks"):
		body.take_damage(1)
		
	if body.name == "DeadZone":
		is_active = false
		linear_velocity = Vector2.ZERO
		returned_to_base.emit()
		queue_free()
