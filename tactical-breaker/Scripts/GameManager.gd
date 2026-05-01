extends Node

# --- Signals --- #
signal stats_changed
signal state_chaged(new_state)
signal game_over

# --- Enums --- #
enum GameState {SHOP, AIM, ACTION, RESOLUTION }

# --- Player Stats --- # 
var coins : int = 0:
	set(value):
		coins = value
		stats_chaged.emit()
		
var health : int = 3:
	set(value):
		health = max(0, value)
		stats_changed.emit()
		if health == 0:
			game_over.emit()
			

# --- Level State --- #
var current_state: GameState = GameState.SHOP
var current_wave : int = 1
var cards_in_hand: Array = [] 		# Stores the PowerUp Resources

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(" Tactical Breaker: GameManager Initialized")

# Game loop mechanic to change strate in each section of the game
func change_state(new_state: GameState):
	current_state = new_state
	state_chaged.emit(new_state)
	print("Game State changed to: ", GameState.keys()[new_state])

# Keeping the economy flowing
func add_coins(amount: int):
	coins += amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
