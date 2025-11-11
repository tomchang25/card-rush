class_name EnemyAction
extends Node

enum Type { CONDITION_BASED, CHANCE_BASED }

@export var intent: Intent
@export var type: Type
@export_range(0.0, 10.0) var chance_weight: float = 1.0

@export var sound: AudioStream
var enemy: Enemy
var target: Node2D


func is_performable() -> bool:
    return false


func perform_action() -> void:
    pass
