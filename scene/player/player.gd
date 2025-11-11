class_name Player
extends Node2D

const WHITE_SPRITE_MATERIAL = preload("res://art/white_sprite_material.tres")

@export var stats: CharacterStats:
    set = set_character_stats

@onready var sprite: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI

func set_character_stats(character_stats: CharacterStats) -> void:
    stats = character_stats

    if not stats.stats_changed.is_connected(update_stats):
        stats.stats_changed.connect(update_stats)

    update_player()


func update_player() -> void:
    if not stats is CharacterStats:
        return

    if not is_inside_tree():
        await ready

    sprite.texture = stats.art
    update_stats()

func update_stats() -> void:
    stats_ui.update_stats(stats)

func take_damage(amount: int) -> void:
    if stats.health <= 0:
        return
    sprite.material = WHITE_SPRITE_MATERIAL

    var tween := create_tween()
    tween.tween_callback(Shaker.shake.bind(self, 10, 0.1))
    tween.tween_callback(stats.take_damage.bind(amount))
    tween.tween_interval(0.1)
    
    await tween.finished
    
    sprite.material = null
    if stats.health <= 0:
        death()

func death() -> void:
    Events.player_died.emit()
