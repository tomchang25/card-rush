class_name BattleUI
extends CanvasLayer

@export var char_stats: CharacterStats:
    set = _set_char_stats

@onready var hand_ui: HandUI = $HandUI
@onready var mana_ui: ManaUI = $ManaUI
@onready var end_turn_button: Button = $EndTurnButton


func _ready() -> void:
    Events.player_hand_drawn.connect(_on_player_hand_drawn)
    end_turn_button.pressed.connect(_on_end_turn_button_pressed)
    
    end_turn_button.disabled = true


func _set_char_stats(new_char_stats: CharacterStats) -> void:
    char_stats = new_char_stats
    mana_ui.character_stats = new_char_stats
    hand_ui.character_stats = new_char_stats

func _on_player_hand_drawn() -> void:
    end_turn_button.disabled = false

func _on_end_turn_button_pressed() -> void:
    end_turn_button.disabled = true
    Events.player_turn_ended.emit()
