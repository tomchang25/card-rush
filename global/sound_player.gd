extends Node


func play(audio: AudioStream, single: bool = false) -> void:
    if not audio:
        return

    if single:
        stop()

    for player: AudioStreamPlayer in get_children():
        if not is_instance_valid(player):
            continue

        if not player.playing:
            player.stream = audio
            player.play()
            break


func stop() -> void:
    for player: AudioStreamPlayer in get_children():
        if not is_instance_valid(player):
            continue

        player.stop()
