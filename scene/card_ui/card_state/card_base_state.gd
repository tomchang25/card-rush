extends CardState

func _init() -> void:
    state = CardState.State.BASE

func enter() -> void:
    if not card_ui.is_node_ready():
        await card_ui.ready

    if card_ui.tween and card_ui.tween.is_running():
        card_ui.tween.kill()

    card_ui.reparent_requested.emit(card_ui)
    card_ui.pivot_offset = Vector2.ZERO

    card_ui.card_visual.apply_base_style()

    Events.card_tooltip_hide_requested.emit()

    # card_ui.color.color = Color.WEB_GREEN
    # card_ui.state.text = "BASE"

func on_gui_input(event: InputEvent) -> void:
    if (not card_ui.disabled and card_ui.playable) and event.is_action_pressed("left_mouse"):
        card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
        transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_entered() -> void:
    if card_ui.disabled or not card_ui.playable:
        return

    card_ui.card_visual.apply_hover_style()

    Events.card_tooltip_requested.emit(card_ui.card.icon, card_ui.card.tooltip_text)

func on_mouse_exited() -> void:
    if card_ui.disabled or not card_ui.playable:
        return

    card_ui.card_visual.apply_base_style()

    Events.card_tooltip_hide_requested.emit()
