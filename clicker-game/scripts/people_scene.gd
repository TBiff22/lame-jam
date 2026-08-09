extends Node2D

@onready var static_body_2d: StaticBody2D = $StaticBody2D
@onready var camera_2d: Camera2D = $StaticBody2D/Camera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var rng = RandomNumberGenerator.new()
var people_preload = preload("res://scenes/audience.tscn")
var level_mult = 1

func _ready():
	level_mult = 1
	Globals.level_up.connect(expand)
	Globals.spawn.connect(spawner)

func spawner():
	for n in range(0, Globals.audience_multiplier):
		var audience_spawn = people_preload.instantiate()
		var position_spawn = Vector2(rng.randf_range(500,1000), rng.randf_range(50,500))*level_mult
		audience_spawn.position = position_spawn 
		add_child(audience_spawn)
		Globals.audience += 1

func expand():
	var animation_name = "level_" + str(Globals.level) + "_move"
	animation_player.play(animation_name)
	level_mult *= 2
