class_name ManaUI
extends Panel


@export var character_stats: CharacterStats: set = _set_character_stats
@onready var mana_label: Label = $ManaLabel

func _set_character_stats(new_stats: CharacterStats) -> void:
    character_stats = new_stats

    if not character_stats.stats_changed.is_connected(_on_stats_changed):
        character_stats.stats_changed.connect(_on_stats_changed)

    if not is_node_ready():
        await ready

    _on_stats_changed()

func _on_stats_changed() -> void:
    mana_label.text = "%s/%s" % [clampi(character_stats.mana, 0, character_stats.max_mana), character_stats.max_mana]
