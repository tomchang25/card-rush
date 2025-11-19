# Game Manager
# Added as an AutoLoad (Singleton)
extends Node

const MAIN_MENU_SCENE = preload("res://scene/main_menu/main_menu_scene.tscn")
const CHARACTER_SELECTOR_SCENE = preload("res://scene/character_selector/character_selector_scene.tscn")
const RUN_SCENE = preload("res://scene/run/run_scene.tscn")

var current_scene: Node = null
var pause_menu_instance: Control = null

func load_character_selector() -> void:
    print("GameManager: Loaded Character Selector.")
    _change_main_scene(CHARACTER_SELECTOR_SCENE.instantiate())

func start_new_run(chosen_stats_resource: CharacterStats) -> void:
    var new_run: Run = RUN_SCENE.instantiate()
    new_run.character = chosen_stats_resource

    _change_main_scene(new_run)


    print("GameManager: Started NEW RUN.")

func load_saved_run() -> void:
    # TODO: Implement actual save loading here
    print("GameManager: Loading Saved Run... (Placeholder)")
    # For now, let's pretend we load a save and get the starting stats
    var loaded_stats = load("res://characters/warrior/warrior.tres") # Replace with actual save loading

    var new_run: Run = RUN_SCENE.instantiate()
    new_run.character = loaded_stats

    _change_main_scene(new_run)

    print("GameManager: Loaded CONTINUED RUN.")


func _change_main_scene(new_scene: Node) -> void:
    # 1. Free the old scene if it exists
    if is_instance_valid(current_scene):
        current_scene.queue_free()

    # 2. Add the new scene to the root
    get_tree().root.add_child(new_scene)
    current_scene = new_scene


func pause_game() -> void:
    if get_tree().paused: return # Already paused

    get_tree().paused = true

    # TODO: Load and display the Pause Menu scene here
    # Example: pause_menu_instance = PAUSE_MENU_SCENE.instantiate()
    # get_tree().root.add_child(pause_menu_instance)
    print("GameManager: Game Paused.")

func unpause_game() -> void:
    get_tree().paused = false
    # TODO: Remove the pause_menu_instance here
    print("GameManager: Game Unpaused.")
