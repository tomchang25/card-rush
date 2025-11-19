class_name Run
extends Node

const BATTLE_SCENE = preload("res://scene/battle/battle.tscn")
const BATTLE_REWARD_SCENE = preload("res://scene/battle_reward/battle_reward.tscn")

const MAP_SCENE = preload("res://scene/map/map.tscn")
const SHOP_SCENE = preload("res://scene/shop/shop.tscn")
const TREASURE_ROOM_SCENE = preload("res://scene/treasure_room/treasure_room.tscn")
const CAMPFIRE_SCENE = preload("res://scene/campfire/campfire.tscn")

@onready var battle_button: Button = %BattleButton
@onready var battle_reward_button: Button = %BattleRewardButton
@onready var map_button: Button = %MapButton
@onready var shop_button: Button = %ShopButton
@onready var treasure_room_button: Button = %TreasureRoomButton
@onready var campfire_button: Button = %CampfireButton

@onready var current_view: Node = $CurrentView

var character: CharacterStats

func start_run() -> void:
    _setup_event_connections()
    print("TODO: procedurally generate map")

func change_scene(scene: PackedScene) -> void:
    for child in current_view.get_children():
        child.queue_free()

    get_tree().paused = false
    current_view.add_child(scene.instantiate())


func _ready() -> void:
    if DebugManager.is_debug_mode_active and not character:
        print("Run: using debug character")
        character = DebugManager.debug_character.create_instance()

    if not character:
        push_error("Run: character not set")
        return

    print("Run: starting run with character ", character.character_name)
    start_run()

func _setup_event_connections() -> void:
    battle_button.pressed.connect(change_scene.bind(BATTLE_SCENE))
    battle_reward_button.pressed.connect(change_scene.bind(BATTLE_REWARD_SCENE))
    map_button.pressed.connect(change_scene.bind(MAP_SCENE))
    shop_button.pressed.connect(change_scene.bind(SHOP_SCENE))
    treasure_room_button.pressed.connect(change_scene.bind(TREASURE_ROOM_SCENE))
    campfire_button.pressed.connect(change_scene.bind(CAMPFIRE_SCENE))

    Events.battle_won.connect(change_scene.bind(BATTLE_REWARD_SCENE))
    Events.battle_reward_exited.connect(change_scene.bind(MAP_SCENE))
    Events.shop_exited.connect(change_scene.bind(MAP_SCENE))
    Events.campfire_exited.connect(change_scene.bind(MAP_SCENE))
    Events.treasure_room_exited.connect(change_scene.bind(MAP_SCENE))

    Events.map_exited.connect(_on_map_exited)


func _on_map_exited() -> void:
    print("TODO: from the map, change view based on room type and copy over character stats")
