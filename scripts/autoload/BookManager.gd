extends Node

enum ResolutionType {
	UNRESOLVED = 0,
	RESTORED = 1,  # Восстановить канон
	REWRITTEN = 2, # Переписать судьбу
	ERASED = 3,    # Вычеркнуть проклятие
	UNFINISHED = 4 # Оставить незавершённой (оба мира сосуществуют)
}

# Словарь историй: story_id -> { "title": String, "resolution": ResolutionType, "line": String }
var stories: Dictionary = {
	"golden_fish": {
		"title": "Сказка о рыбаке и рыбке",
		"line": "«Не садися не в свои сани...»",
		"resolution": ResolutionType.UNRESOLVED
	},
	"saltan": {
		"title": "Сказка о царе Салтане",
		"line": "«Ветер по морю гуляет и кораблик подгоняет...»",
		"resolution": ResolutionType.UNRESOLVED
	},
	"dead_princess": {
		"title": "Сказка о мёртвой царевне и о семи богатырях",
		"line": "«Свет мой, зеркальце! скажи...»",
		"resolution": ResolutionType.UNRESOLVED
	},
	"golden_cockerel": {
		"title": "Сказка о золотом петушке",
		"line": "«Кири-ку-ку! Царствуй, лёжа на боку!»",
		"resolution": ResolutionType.UNRESOLVED
	},
	"chernomor": {
		"title": "Архив отвергнутых строк",
		"line": "«И тридцать витязей прекрасных...»",
		"resolution": ResolutionType.UNRESOLVED
	}
}

func resolve_story(story_id: String, resolution: ResolutionType) -> void:
	if stories.has(story_id):
		stories[story_id]["resolution"] = resolution
		EventBus.story_line_resolved.emit(story_id, int(resolution))
		_apply_resolution_effects(story_id, resolution)

func _apply_resolution_effects(story_id: String, resolution: ResolutionType) -> void:
	match resolution:
		ResolutionType.RESTORED:
			MoralityManager.add_order(2)
		ResolutionType.REWRITTEN:
			MoralityManager.add_will(2)
		ResolutionType.ERASED:
			MoralityManager.add_mercy(1)
			MoralityManager.add_will(1)
		ResolutionType.UNFINISHED:
			MoralityManager.add_mercy(2)
