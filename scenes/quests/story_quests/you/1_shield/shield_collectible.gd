extends Node2D


func _on_interact_area_interaction_started(player: Player, from_right: bool) -> void:
	var item = InventoryItem.with_type(InventoryItem.ItemType.IMAGINATION)
	GameState.add_collected_item(item)
