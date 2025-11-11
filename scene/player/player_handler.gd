class_name PlayerHandler
extends Node

const HAND_DRAW_INTERVAL := 0.2
const HAND_DISCARD_INTERVAL := 0.2

@export var hand_ui: HandUI

var character_stats: CharacterStats

func _ready() -> void:
    Events.card_played.connect(_on_card_played)

func start_battle(new_character_stats: CharacterStats) -> void:
    character_stats = new_character_stats
    character_stats.draw_pile = character_stats.deck.duplicate()
    character_stats.discard = CardPile.new()

    start_turn()

func start_turn() -> void:
    character_stats.draw_pile.shuffle()

    character_stats.reset_mana()
    character_stats.block = 0

    draw_cards(character_stats.cards_per_turn)

func end_turn() -> void:
    hand_ui.disable_hand()
    discard_cards()

func discard_cards() -> void:
    var tween := create_tween()
    for card_ui in hand_ui.get_children():
        tween.tween_callback(character_stats.discard.add_card.bind(card_ui.card))
        tween.tween_callback(hand_ui.discard_card.bind(card_ui))
        tween.tween_interval(HAND_DISCARD_INTERVAL)

    await tween.finished

    Events.player_hand_discarded.emit()

func reshuffle_deck_from_discard() -> void:
    if not character_stats.draw_pile.is_empty():
        return

    character_stats.draw_pile = character_stats.discard.duplicate()
    character_stats.discard.clear()

    character_stats.draw_pile.shuffle()

func draw_card() -> void:
    if character_stats.draw_pile.is_empty() and character_stats.discard.is_empty():
        return

    reshuffle_deck_from_discard()
    hand_ui.add_card(character_stats.draw_pile.draw_card())
    reshuffle_deck_from_discard()

func draw_cards(amount: int) -> void:
    var tween := create_tween()
    for _i in range(amount):
        tween.tween_callback(draw_card).set_delay(HAND_DRAW_INTERVAL)

    await tween.finished

    Events.player_hand_drawn.emit()

func _on_card_played(card: Card) -> void:
    character_stats.discard.add_card(card)
