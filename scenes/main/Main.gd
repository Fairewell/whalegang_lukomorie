extends Node2D

@onready var time_label: Label = $UI/HUD/TimeLabel
@onready var morality_label: Label = $UI/HUD/MoralityLabel

func _ready() -> void:
	EventBus.time_tick.connect(_on_time_tick)
	EventBus.day_advanced.connect(_on_day_advanced)
	EventBus.morality_changed.connect(_on_morality_changed)
	_update_time_display()
	_update_morality_display(MoralityManager.mercy, MoralityManager.will, MoralityManager.order)

func _on_time_tick(hour: int, minute: int) -> void:
	_update_time_display()

func _on_day_advanced(day: int, season: String, year: int) -> void:
	_update_time_display()

func _on_morality_changed(mercy: int, will: int, order: int) -> void:
	_update_morality_display(mercy, will, order)

func _update_time_display() -> void:
	if is_instance_valid(time_label):
		var time_str: String = "%02d:%02d" % [TimeManager.current_hour, TimeManager.current_minute]
		var phase_str: String = " (Ночь)" if TimeManager.is_night else " (День)"
		time_label.text = "День %d, %s%s | %s" % [TimeManager.current_day, TimeManager.get_season_name(), phase_str, time_str]

func _update_morality_display(mercy: int, will: int, order: int) -> void:
	if is_instance_valid(morality_label):
		morality_label.text = "Милосердие: %d | Воля: %d | Порядок: %d" % [mercy, will, order]
