extends Node

@onready var people_scene: Node2D = $"../people scene"
@onready var animation_player_2: AnimationPlayer = $"../people scene/AnimationPlayer2"
@onready var spawner: Button = $spawner
@onready var game_time: Timer = $"Game time"
@onready var timetext: RichTextLabel = $"../timetext"
@onready var audience_count: RichTextLabel = $"../audience count"
@onready var button_spawner: Timer = $button_spawner

var rng = RandomNumberGenerator.new()
var game_over_menu = preload("res://scenes/game_over.tscn")
var timer_ext_button = preload("res://scenes/timer_ext_button.tscn")
var more_people_button = preload("res://scenes/ppl_mult_button.tscn")

const level_2 = 10
const level_3 = 50
const level_4 = 500
const level_5 = 1500

func _ready() -> void:
	button_spawner.start()
	Globals.audience_multiplier = 1
	Globals.audience = 0
	Globals.level = 1
	Globals.level_up.connect(expansion)
	Globals.end.connect(end_game)
	Globals.update_time.connect(reset_timer)

func _process(delta) -> void:
	audience_count.text = "Audience size: " + str(Globals.audience)
	Globals.time_left = int(game_time.get_time_left())
	timetext.text = "time left: " + str(Globals.time_left)

func expansion():
	Globals.level += 1
	var animation_name = "level_" + str(Globals.level)
	animation_player_2.play(animation_name)

func _on_spawner_pressed() -> void:
	Globals.spawn.emit()
	if Globals.level == 3 and Globals.audience >= level_4:
		Globals.level_up.emit()
	elif Globals.audience >= level_5:
		Globals.end.emit()
	else:
		if Globals.level == 2 and Globals.audience >= level_3:
			Globals.level_up.emit()
		else:
			if Globals.level == 1 and Globals.audience >= level_2:
				Globals.level_up.emit()

func _on_game_time_timeout() -> void:
	Globals.end.emit()

func end_game():
	add_child(game_over_menu.instantiate())
	get_tree().paused = true

func reset_timer(time_change = Globals.time_change):
	Globals.time_left += Globals.time_change
	print(Globals.time_left)
	game_time.start(Globals.time_left)
	game_time.get_time_left()

func _on_button_spawner_timeout() -> void:
	var button_num = rng.randi_range(1,2)
	if button_num == 1:
		var new_button = more_people_button.instantiate()
		new_button.position = Vector2(-550,0)
		add_child(new_button)
	if button_num == 2:
		var new_button = timer_ext_button.instantiate()
		new_button.position = Vector2(-550,0)
		add_child(new_button)
	button_spawner.start()
