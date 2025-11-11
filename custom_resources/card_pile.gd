class_name CardPile
extends Resource

signal card_pile_size_changed(card_amount: int)

@export var cards: Array[Card] = []

func is_empty() -> bool:
    return cards.size() == 0


func draw_card() -> Card:
    var card = cards.pop_front()
    card_pile_size_changed.emit(cards.size())
    return card


func add_card(card: Card) -> void:
    cards.append(card)
    card_pile_size_changed.emit(cards.size())

func shuffle() -> void:
    cards.shuffle()

func clear() -> void:
    cards.clear()
    card_pile_size_changed.emit(cards.size())

func _to_string() -> String:
    var card_names := []

    for i in range(cards.size()):
        card_names.append("(%s: %s)" % [i, cards[i].id])

    return "\n".join(card_names)
