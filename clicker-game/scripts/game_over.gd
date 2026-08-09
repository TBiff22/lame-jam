extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_replay_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	pass # Replace with function body.
