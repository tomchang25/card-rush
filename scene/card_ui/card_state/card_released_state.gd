extends CardState

var played := false

func _init() -> void:
    state = CardState.State.RELEASED


func enter() -> void:
    # card_ui.color.color = Color.DARK_VIOLET
    # card_ui.state.text = "RELEASED"
    played = false
    if card_ui.targets.size() > 0:
        played = true
        # print("play card for target(s)", card_ui.targets)
        card_ui.play()
        Events.card_tooltip_hide_requested.emit()

func process(_delta: float) -> void:
    if not played:
        transition_requested.emit(self, CardState.State.BASE)