extends Node

enum Season { SPRING, SUMMER, AUTUMN, WINTER }

const MINUTES_PER_DAY: int = 1440 # 24 часа
const REAL_SECONDS_PER_DAY: float = 900.0 # 15 минут реалтайма = 1 день (62.5 сек = 1 час)
const DAYS_PER_SEASON: int = 28

var current_day: int = 1
var current_season: Season = Season.SPRING
var current_year: int = 1

var current_hour: int = 6
var current_minute: int = 0
var is_night: bool = false
var is_time_paused: bool = false

var _accumulated_seconds: float = 0.0

func _process(delta: float) -> void:
	if is_time_paused:
		return
		
	_accumulated_seconds += delta
	var time_ratio: float = _accumulated_seconds / REAL_SECONDS_PER_DAY
	var total_minutes: int = int(time_ratio * MINUTES_PER_DAY)
	
	var new_hour: int = (6 + (total_minutes / 60)) % 24
	var new_minute: int = total_minutes % 60
	
	if new_minute != current_minute:
		current_minute = new_minute
		current_hour = new_hour
		EventBus.time_tick.emit(current_hour, current_minute)
		_check_night_transition()
	
	if _accumulated_seconds >= REAL_SECONDS_PER_DAY:
		_accumulated_seconds -= REAL_SECONDS_PER_DAY
		advance_day()

func advance_day() -> void:
	current_day += 1
	if current_day > DAYS_PER_SEASON:
		current_day = 1
		current_season = Season.values()[(int(current_season) + 1) % Season.size()]
		if current_season == Season.SPRING:
			current_year += 1
			
	EventBus.day_advanced.emit(current_day, get_season_name(), current_year)

func _check_night_transition() -> void:
	var night_state: bool = (current_hour >= 20 or current_hour < 5)
	if night_state != is_night:
		is_night = night_state
		EventBus.phase_changed.emit(is_night)

func get_season_name() -> String:
	match current_season:
		Season.SPRING: return "Весна"
		Season.SUMMER: return "Лето"
		Season.AUTUMN: return "Осень"
		Season.WINTER: return "Зима"
		_: return "Весна"

func pause_time(paused: bool) -> void:
	is_time_paused = paused
