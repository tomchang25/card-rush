class_name HandUI extends HBoxContainer

@export var character_stats: CharacterStats

@onready var card_ui_scene: PackedScene = preload("res://scene/card_ui/card_ui.tscn")


var cards_play_this_turn := 0

func add_card(card: Card) -> void:
    var new_card_ui: CardUI = card_ui_scene.instantiate()
    add_child(new_card_ui)
    new_card_ui.card = card
    new_card_ui.char_stats = character_stats
    new_card_ui.parent = self
    new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)

func discard_card(card_ui: CardUI) -> void:
    card_ui.queue_free()

func disable_hand() -> void:
    for child in get_children():
        var card_ui: CardUI = child
        card_ui.disabled = true

func _ready() -> void:
    Events.card_played.connect(_on_card_played)

func _on_card_ui_reparent_requested(child: CardUI) -> void:
    child.reparent(self)
    print("reparented")

    var new_index := clampi(child.original_index - cards_play_this_turn, 0, get_child_count() - 1)
    move_child.call_deferred(child, new_index)

func _on_card_played(_card: Card) -> void:
    cards_play_this_turn += 1
