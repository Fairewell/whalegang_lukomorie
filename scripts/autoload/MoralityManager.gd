extends Node

var mercy: int = 0  # Милосердие: готовность сохранять жизнь и принимать слабость
var will: int = 0   # Воля: стремление нарушать предназначение и давать свободу
var order: int = 0  # Порядок: желание удержать мир через правила и традицию

func add_mercy(amount: int = 1) -> void:
	mercy += amount
	_notify()

func add_will(amount: int = 1) -> void:
	will += amount
	_notify()

func add_order(amount: int = 1) -> void:
	order += amount
	_notify()

func _notify() -> void:
	EventBus.morality_changed.emit(mercy, will, order)

func get_dominant_aspect() -> String:
	if mercy >= will and mercy >= order:
		return "Милосердие"
	elif will >= mercy and will >= order:
		return "Воля"
	else:
		return "Порядок"
