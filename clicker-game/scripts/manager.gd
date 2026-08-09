extends Node

@onready var people_scene: Node2D = $"../people scene"
@onready var animation_player_2: AnimationPlayer = $"../people scene/AnimationPlayer2"
@onready var spawner: Button = $spawner
@onready var game_time: Timer = $"Game time"
@onready var timetext: RichTextLabel = $"../timetext"
var game_over_menu = preload("res://scenes/game_over.tscn")

const level_2 = 10
const level_3 = 20
const level_4 = 30
const level_5 = 50

func _ready() -> void:
	Globals.level_up.connect(expansion)
	Globals.end.connect(end_game)

func _process(delta) -> void:
	timetext.text = str(int(game_time.get_time_left()))

func expansion():
	Globals.level += 1
	var animation_name = "level_" + str(Globals.level)
	animation_player_2.play(animation_name)



func _on_spawner_pressed() -> void:
	Globals.spawn.emit()
	if Globals.audience == level_2 or Globals.audience == level_3 or Globals.audience == level_4:
		Globals.level_up.emit()
	elif Globals.audience == level_5:
		Globals.end.emit()

func _on_game_time_timeout() -> void:
	Globals.end.emit()

func end_game():
	add_child(game_over_menu.instantiate())
	get_tree().paused = true
