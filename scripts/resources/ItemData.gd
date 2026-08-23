class_name ItemData
extends Resource

enum ItemType { TOOL, SEED, CROP, MATERIAL, CONSUMABLE, TALE_LINE }

@export var id: String = ""
@export var name: String = ""
@export_multiline var description: String = ""
@export var item_type: ItemType = ItemType.MATERIAL
@export var icon: Texture2D
@export var max_stack: int = 99
@export var sell_price: int = 10
