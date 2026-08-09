extends CharacterBody2D

const start_speed = 100
var rng = RandomNumberGenerator.new()
func _ready():
	var x_dir = rng.randf_range(-1,1) * start_speed
	var y_dir = rng.randf_range(-1,1) * start_speed
	velocity = Vector2(x_dir, y_dir)

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider_id()
		velocity = velocity.bounce(collision_info.get_normal())
