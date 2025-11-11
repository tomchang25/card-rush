extends CardState

func _init() -> void:
    state = CardState.State.AIMING

func enter() -> void:
    # card_ui.color.color = Color.WEB_PURPLE
    # card_ui.state.text = "AIMING"
    card_ui.targets = []

    var offset := Vector2(card_ui.parent.size.x / 2, -card_ui.size.y / 2)
    offset.x -= card_ui.size.x / 2
    card_ui.animate_to_position(card_ui.parent.global_position + offset, 0.2)
    card_ui.drop_point_detector.monitoring = false

    Events.card_aim_started.emit(card_ui)

func exit() -> void:
    Events.card_aim_ended.emit(card_ui)


func on_input(event: InputEvent) -> void:
    if event.is_action_pressed("cancel"):
        transition_requested.emit(self, CardState.State.BASE)
    elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
        transition_requested.emit(self, CardState.State.RELEASED)