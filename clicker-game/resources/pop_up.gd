class_name pop_up_resource
extends Resource

@export var name: String

@export var time_change: int
@export var people_mult: int
@export var help: bool

func apply_changes():
	Globals.audience_multiplier *= people_mult
	Globals.time_change = time_change
	if time_change != 0:
		Globals.update_time.emit()
