class_name CardVisual extends Control

# Define constants for your styleboxes here or preload them in the scene
class CardStyleConstants:
    const BASE_STYLEBOX := preload("res://scene/card_ui/card_base_stylebox.tres")
    const HOVER_STYLEBOX := preload("res://scene/card_ui/card_hover_stylebox.tres")
    const DRAG_STYLEBOX := preload("res://scene/card_ui/card_dragging_stylebox.tres")

@export var card: Card: set = _set_card

@onready var cost_label: Label = $CostLabel # Adjust node names to match your scene
@onready var icon_texture: TextureRect = $IconTexture # Adjust node names to match your scene
@onready var style_panel: Panel = $StylePanel

func _set_card(new_card: Card) -> void:
    if not is_node_ready():
        await ready

    card = new_card

    if card:
        # Update the visuals based on the Card data
        icon_texture.texture = card.icon
        cost_label.text = str(card.cost)
    else:
        # Handle case where card is null if necessary
        icon_texture.texture = null
        cost_label.text = ""

func _set_stylebox(stylebox: StyleBox) -> void:
    style_panel.set("theme_override_styles/panel", stylebox)

func apply_base_style() -> void:
    _set_stylebox(CardStyleConstants.BASE_STYLEBOX)

func apply_hover_style() -> void:
    _set_stylebox(CardStyleConstants.HOVER_STYLEBOX)

func apply_drag_style() -> void:
    _set_stylebox(CardStyleConstants.DRAG_STYLEBOX)

func apply_playable_style() -> void:
    cost_label.remove_theme_color_override("font_color")
    icon_texture.modulate.a = 1

func apply_unplayable_style() -> void:
    cost_label.add_theme_color_override("font_color", Color.RED)
    icon_texture.modulate.a = 0.5

# func set_playable_state(playable: bool) -> void:
#     if not playable:
#         cost_label.add_theme_color_override("font_color", Color.RED)
#         icon_texture.modulate.a = 0.5
#     else:
#         cost_label.remove_theme_color_override("font_color")
#         icon_texture.modulate.a = 1
