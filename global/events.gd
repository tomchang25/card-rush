extends Node

@warning_ignore_start("unused_signal")
# Card related events
signal card_drag_started(card_ui: CardUI)
signal card_drag_ended(card_ui: CardUI)
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)

signal card_played(card: Card)
signal card_tooltip_requested(icon: Texture, description: String)
signal card_tooltip_hide_requested()

signal player_hand_drawn()
signal player_hand_discarded()
signal player_turn_ended()
signal player_hit()
signal player_died()


signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended()

signal battle_over_screen_requested(text: String, type: BattleOverPanel.Type)
