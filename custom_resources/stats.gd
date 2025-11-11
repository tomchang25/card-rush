class_name Stats
extends Resource

signal stats_changed

@export var max_health: int = 100
@export var art: Texture2D = null

var health: int: set = set_health
var block: int: set = set_block


func set_health(value: int) -> void:
    health = clampi(value, 0, max_health)
    stats_changed.emit()

func set_block(value: int) -> void:
    block = value
    stats_changed.emit()

func take_damage(amount: int) -> void:
    if amount <= 0:
        return

    var initial_damage = amount
    var damage = clampi(initial_damage - block, 0, initial_damage)
    block = clampi(block - initial_damage, 0, block)

    health -= damage

    print("health: ", health, " block: ", block, " damage: ", damage)

func heal(amount: int) -> void:
    if amount <= 0:
        return

    health += amount

func create_instance() -> Resource:
    var instance: Stats = duplicate()
    instance.health = max_health
    instance.block = 0
    return instance
