extends TextureButton

@export var resource: Resource

func _on_timer_timeout() -> void:
	queue_free()

func _on_pressed() -> void:
	resource.apply_changes()
	queue_free()
