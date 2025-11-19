extends Control

# const CHARACTER_SELECTOR = preload("res://scene/ui/character_selector.tscn")

# @onready var continue_button: Button = %ContinueButton
# @onready var new_game_button: Button = %NewGameButton
# @onready var exit_button: Button = %ExitButton


# func _ready():
#     continue_button.pressed.connect(_on_continue_button_pressed)
#     new_game_button.pressed.connect(_on_new_game_button_pressed)
#     exit_button.pressed.connect(_on_exit_button_pressed)

#     continue_button.grab_focus()

#     get_tree().paused = false


# func _on_continue_button_pressed() -> void:
#     print("Continue")


# func _on_new_game_button_pressed() -> void:
#     get_tree().change_scene_to_packed(CHARACTER_SELECTOR)


# func _on_exit_button_pressed() -> void:
#     get_tree().quit()
#     return

@onready var continue_button: Button = %ContinueButton
@onready var new_game_button: Button = %NewGameButton
@onready var settings_button: Button = %SettingsButton
@onready var gallery_button: Button = %GalleryButton
@onready var exit_button: Button = %ExitButton

func _ready() -> void:
    new_game_button.pressed.connect(_on_new_game_button_pressed)
    continue_button.pressed.connect(_on_continue_button_pressed)
    settings_button.pressed.connect(_on_settings_button_pressed)
    gallery_button.pressed.connect(_on_gallery_button_pressed)
    exit_button.pressed.connect(_on_exit_button_pressed)

func _on_new_game_button_pressed() -> void:
    GameManager.load_character_selector()

func _on_continue_button_pressed() -> void:
    GameManager.load_saved_run()

func _on_settings_button_pressed() -> void:
    print("TODO: Load Settings Menu")

func _on_gallery_button_pressed() -> void:
    print("TODO: Load Gallery Scene")

func _on_exit_button_pressed() -> void:
    get_tree().quit()
