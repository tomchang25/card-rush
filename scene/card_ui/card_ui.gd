class_name CardUI extends Control

signal reparent_requested(which_card_ui: CardUI)


class CardStylebox:
    const BASE_STYLEBOX := preload("res://scene/card_ui/card_base_stylebox.tres")
    const HOVER_STYLEBOX := preload("res://scene/card_ui/card_hover_stylebox.tres")
    const DRAG_STYLEBOX := preload("res://scene/card_ui/card_dragging_stylebox.tres")

@export var card: Card: set = _set_card
@export var char_stats: CharacterStats: set = _set_char_stats

# @onready var color: ColorRect = $Color
# @onready var state: Label = $State
# @onready var panel: Panel = $Panel
# @onready var cost: Label = $Cost
# @onready var icon: TextureRect = $Icon
@onready var card_visual: CardVisual = $CardVisual

@onready var card_state_machine: CardStateMachine = $CardStateMachine
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var targets: Array[Node] = []

@onready var original_index := get_index()


var parent: Control
var tween: Tween

var playable: bool = true: set = set_playable
var disabled: bool = false

func _ready() -> void:
    card_state_machine.init(self)

    drop_point_detector.connect("area_entered", Callable(self, "_on_drop_point_detector_area_entered"))
    drop_point_detector.connect("area_exited", Callable(self, "_on_drop_point_detector_area_exited"))

func _process(delta: float) -> void:
    card_state_machine.process(delta)

func _physics_process(delta: float) -> void:
    card_state_machine.physics_process(delta)

func _input(event: InputEvent) -> void:
    card_state_machine.on_input(event)

func _gui_input(event: InputEvent) -> void:
    card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
    card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
    card_state_machine.on_mouse_exited()

func _on_drop_point_detector_area_entered(area: Area2D) -> void:
    if not targets.has(area):
        targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
    targets.erase(area)

func _on_char_stats_changed() -> void:
    playable = char_stats.can_play_card(card)

func _on_card_drag_or_aiming_started(used_card: CardUI) -> void:
    if used_card == self:
        return

    disabled = true

func _on_card_drag_or_aiming_ended() -> void:
    disabled = false
    playable = char_stats.can_play_card(card)

func _set_card(new_card: Card) -> void:
    if not is_node_ready():
        await ready

    card = new_card
    card_visual.card = card

func _set_char_stats(new_stats: CharacterStats) -> void:
    char_stats = new_stats
    char_stats.stats_changed.connect(_on_char_stats_changed)

func animate_to_position(new_position: Vector2, duration: float) -> void:
    tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "global_position", new_position, duration)

func set_stylebox(stylebox: StyleBox) -> void:
    card_visual.set_stylebox(stylebox)

func set_playable(new_playable: bool) -> void:
    playable = new_playable

    # Delegate the visual changes to the visuals node
    if playable:
        card_visual.apply_playable_style()
    else:
        card_visual.apply_unplayable_style()

# func set_playable(new_playable: bool) -> void:
#     playable = new_playable

#     if not playable:
#         cost.add_theme_color_override("font_color", Color.RED)
#         icon.modulate.a = 0.5
#     else:
#         cost.remove_theme_color_override("font_color")
#         icon.modulate.a = 1

func play() -> void:
    if not card:
        return

    card.play(targets, char_stats)
    queue_free()
