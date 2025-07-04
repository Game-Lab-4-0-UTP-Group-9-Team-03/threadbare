extends Node2D
@onready var portal: AudioStreamPlayer2D = $portal
@export var spawn_point_path: String
@export_file("*.tscn") var next_scene: String

func _on_interact_area_interaction_started(player: Player, from_right: bool) -> void:
	portal.play()
	var item1 = InventoryItem.with_type(InventoryItem.ItemType.IMAGINATION)
	var item2 = InventoryItem.with_type(InventoryItem.ItemType.MEMORY)
	var item3 = InventoryItem.with_type(InventoryItem.ItemType.SPIRIT)
	GameState.add_collected_item(item1)
	GameState.add_collected_item(item2)
	GameState.add_collected_item(item3)
	await portal.finished
	SceneSwitcher.change_to_file_with_transition(
				next_scene,
				spawn_point_path,
				Transition.Effect.FADE,
				Transition.Effect.FADE,
			)
