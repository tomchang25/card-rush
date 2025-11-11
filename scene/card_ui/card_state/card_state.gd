class_name CardState
extends Node

signal transition_requested(from: CardState, to: State)

enum State {BASE, CLICKED, SELECTED, DRAGGING, AIMING, RELEASED}

var state: State
var card_ui: CardUI

func enter() -> void:
    pass

func exit() -> void:
    pass

func process(_delta: float) -> void:
    pass

func physics_process(_delta: float) -> void:
    pass

func on_input(_event: InputEvent) -> void:
    pass

func on_gui_input(_event: InputEvent) -> void:
    pass

func on_mouse_entered() -> void:
    pass

func on_mouse_exited() -> void:
    pass
