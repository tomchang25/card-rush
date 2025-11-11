class_name DamageEffect
extends Effect

var amount = 0


func execute(targets: Array[Node]) -> void:
    print("damage ", amount, " to ", targets)
    for target in targets:
        if not target:
            continue

        if target is Enemy or target is Player:
            # print(target)
            target.take_damage(amount)
            SFXPlayer.play(sound)
