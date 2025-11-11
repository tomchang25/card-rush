class_name Card
extends Resource

enum Type { ATTACK, SKILL, POWER }
enum Target { SELF, SINGLE_ENEMY, ALL_ENEMY, EVERYONE }

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var cost: int

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltip_text: String

@export var sound: AudioStream


func is_single_target() -> bool:
    return target == Target.SINGLE_ENEMY


func _get_target(targets: Array[Node]) -> Array[Node]:
    if not targets:
        return []

    var tree := targets[0].get_tree()

    # targets = targets.filter(func(t):
    #     return t.is_in_group("player") or t.is_in_group("enemy")
    # )

    match target:
        Target.SELF:
            return [tree.get_first_node_in_group("player")]
        Target.SINGLE_ENEMY:
            return targets
        Target.ALL_ENEMY:
            return tree.get_nodes_in_group("enemy")
        Target.EVERYONE:
            return tree.get_nodes_in_group("enemy") + tree.get_nodes_in_group("player")
        _:
            return []


func play(targets: Array[Node], char_stats: CharacterStats) -> void:
    Events.card_played.emit(self)
    char_stats.mana -= cost

    if is_single_target():
        apply_effects(targets)
        return

    apply_effects(_get_target(targets))


func apply_effects(_targets: Array[Node]) -> void:
    pass
