class_name CropData
extends Resource

@export var crop_id: String = ""
@export var name: String = ""
@export var is_magical: bool = false
@export var days_to_grow: int = 4 # Общее кол-во дней
@export var stages_count: int = 4
@export var harvest_item_id: String = ""
@export var seed_item_id: String = ""
@export var regrows: bool = false
@export var regrow_days: int = 0
@export var preferred_season: TimeManager.Season = TimeManager.Season.SPRING
