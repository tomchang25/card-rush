class_name Enemy
extends Area2D

const ARROW_OFFSET := 10
const WHITE_SPRITE_MATERIAL = preload("res://art/white_sprite_material.tres")

@export var stats: EnemyStats:
    set = set_enemy_stats

@onready var sprite: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI
@onready var intent_ui: IntentUI = $IntentUI

@onready var arrow: Sprite2D = $Arrow

var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction: set = set_current_action

func set_current_action(value: EnemyAction) -> void:
    current_action = value
    if current_action:
        intent_ui.update_intent(current_action.intent)

func set_enemy_stats(enemy_stats: EnemyStats) -> void:
    stats = enemy_stats.create_instance()

    if not stats.stats_changed.is_connected(update_stats):
        stats.stats_changed.connect(update_stats)
        stats.stats_changed.connect(update_action)

    update_enemy()

func update_enemy() -> void:
    if not stats is Stats:
        return

    if not is_inside_tree():
        await ready

    sprite.texture = stats.art
    arrow.position = Vector2((sprite.get_rect().size.x / 2 + ARROW_OFFSET), 0 )

    setup_ai()
    update_stats()

func do_turn() -> void:
    stats.block = 0

    if not current_action:
        return

    current_action.perform_action()

func setup_ai() -> void:
    if enemy_action_picker:
        enemy_action_picker.queue_free()

    var new_action_picker: EnemyActionPicker = stats.ai.instantiate()
    add_child(new_action_picker)
    enemy_action_picker = new_action_picker
    enemy_action_picker.enemy = self

func update_action() -> void:
    if not enemy_action_picker:
        return

    if not current_action:
        current_action = enemy_action_picker.get_action()
        return

    var new_conditional_action := enemy_action_picker.get_first_conditional_action()
    if new_conditional_action and current_action != new_conditional_action:
        current_action = new_conditional_action


func update_stats() -> void:
    stats_ui.update_stats(stats)

func take_damage(amount: int) -> void:
    if stats.health <= 0:
        return

    sprite.material = WHITE_SPRITE_MATERIAL

    # stats.take_damage(amount)
    var tween := create_tween()
    tween.tween_callback(Shaker.shake.bind(self, 10, 0.1))
    tween.tween_callback(stats.take_damage.bind(amount))
    tween.tween_interval(0.2)
    
    await tween.finished
    
    sprite.material = null
    if stats.health <= 0:
        queue_free()
    

func _ready() -> void:
    area_entered.connect(_on_area_entered)
    area_exited.connect(_on_area_exited)


func _on_area_entered(_area: Area2D) -> void:
    arrow.show()

func _on_area_exited(_area: Area2D) -> void:
    arrow.hide()
