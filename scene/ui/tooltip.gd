class_name Tooltip
extends PanelContainer

@export var fade_seconds: float = 0.2
@export var delay_seconds: float = 0.4

@onready var texture_rect: TextureRect = %TextureRect
@onready var rich_text_label: RichTextLabel = %RichTextLabel

var tween: Tween
var is_showing: bool = false

func _ready() -> void:
    Events.card_tooltip_requested.connect(show_tooltip)
    Events.card_tooltip_hide_requested.connect(hide_tooltip)

    modulate = Color.TRANSPARENT
    hide()

func show_tooltip(icon: Texture, text: String) -> void:
    if tween:
        tween.kill()
        tween = null

    is_showing = true

    texture_rect.texture = icon
    rich_text_label.text = text

    modulate = Color.WHITE
    show()


func hide_tooltip() -> void:
    if tween:
        tween.kill()

    is_showing = false
    get_tree().create_timer(delay_seconds).timeout.connect(hide_animation)

func hide_animation() -> void:
    if is_showing:
        return

    tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_seconds)
    tween.tween_callback(hide)
