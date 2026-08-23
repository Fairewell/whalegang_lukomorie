extends Node

# Сигналы времени и календаря
signal day_advanced(day_number: int, season: String, year: int)
signal time_tick(hour: int, minute: int)
signal phase_changed(is_night: bool)

# Сигналы боевой системы и игрока
signal player_health_changed(current: float, max_val: float)
signal player_stamina_changed(current: float, max_val: float)
signal player_defeated(position: Vector2)
signal unfinished_line_recovered(ash_amount: int)

# Сигналы фермы и инвентаря
signal crop_planted(cell: Vector2i, crop_id: String)
signal crop_harvested(cell: Vector2i, crop_id: String)
signal soil_tilled(cell: Vector2i)
signal soil_watered(cell: Vector2i)
signal item_collected(item_id: String, count: int)

# Сигналы Великой Книги и Морали
signal story_line_found(story_id: String, line_text: String)
signal story_line_resolved(story_id: String, resolution_type: int)
signal morality_changed(mercy: int, will: int, order: int)

# Сигналы интерфейса и диалогов
signal dialogue_started(speaker_name: String)
signal dialogue_ended()
signal prompt_interact(text: String, show: bool)
