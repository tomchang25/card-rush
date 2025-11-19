extends Control

const ASSASSIN_STATS := preload("res://characters/assassin/assassin.tres")
const WARRIOR_STATS := preload("res://characters/warrior/warrior.tres")
const WIZARD_STATS := preload("res://characters/wizard/wizard.tres")

@onready var description: Label = %Description
@onready var title: Label = %Title
@onready var character_portrait: TextureRect = $CharacterPortrait

@onready var warrior_button: Button = $CharacterButtonGroup/WarriorButton
@onready var wizard_button: Button = $CharacterButtonGroup/WizardButton
@onready var assassin_button: Button = $CharacterButtonGroup/AssassinButton

@onready var start_button: Button = $StartButton

var current_character: CharacterStats: set = _set_current_character

func _ready() -> void:
    # Events.player_character_selected.connect(_set_current_character)
    warrior_button.pressed.connect(_on_warrior_button_pressed)
    wizard_button.pressed.connect(_on_wizard_button_pressed)
    assassin_button.pressed.connect(_on_assassin_button_pressed)

    _set_current_character(WARRIOR_STATS)
    warrior_button.button_pressed = true

    start_button.pressed.connect(_on_start_button_pressed)

func _set_current_character(new_character: CharacterStats) -> void:
    current_character = new_character
    character_portrait.texture = new_character.art
    title.text = new_character.character_name
    description.text = new_character.description

func _on_warrior_button_pressed() -> void:
    current_character = WARRIOR_STATS

func _on_wizard_button_pressed() -> void:
    current_character = WIZARD_STATS

func _on_assassin_button_pressed() -> void:
    current_character = ASSASSIN_STATS

func _on_start_button_pressed() -> void:
    print("Start Game: ", current_character.character_name)
    # Events.player_character_selected.emit(current_character)
    GameManager.start_new_run(current_character)
