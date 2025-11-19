# DebugManager
# Added as an AutoLoad (Singleton)

extends Node

signal debug_toggled(is_active)

const DEBUG_TOGGLE_ACTION = "toggle_debug"

@onready var debug_character = preload("res://characters/warrior/warrior.tres")

var is_debug_mode_active: bool = true


func _ready():
    pass

func _input(event):
    # Check if the debug key was pressed
    if event.is_action_pressed(DEBUG_TOGGLE_ACTION) and not event.is_echo():
        toggle_debug_mode()

func toggle_debug_mode():
    is_debug_mode_active = not is_debug_mode_active

    # Emit signal to notify HUD and other nodes
    debug_toggled.emit(is_debug_mode_active)

    # Optional: Print a message
    print("Debug Mode: ", "ON" if is_debug_mode_active else "OFF")
