extends Node2D


var skeleton_there = false

#TODO finish skeleton behind detection system
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"player/look text".hide()
	var skeletons = get_tree().get_nodes_in_group("skeleton")
	for skeleton in skeletons:
		var hiding_spot = randi_range(1,6)
		match hiding_spot:
			1: skeleton.global_position = $tree1.global_position
			2: skeleton.global_position = $tree2.global_position
			3: skeleton.global_position = $tree3.global_position
			4: skeleton.global_position = $Tombstone.global_position
			5: skeleton.global_position = $Tombstone2.global_position
			6: skeleton.global_position = $Tombstone3.global_position
	
	$"spooky skeletons".hide()
	$"spooky skeletons2".hide()
	$"spooky skeletons3".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$camera.global_position = $player.global_position
	var look_behind = Input.is_action_pressed("lookbehind")
	
	
	if $"player/look text".hidden == false && look_behind:
		pass
	
	$camera.move_and_slide()


func hiding_spot_detection(player, show):
	if player.is_in_group("player"):
		if show:
			$"player/look text".show()
		else:
			$"player/look text".hide()



#hiding spot detection
func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, true)


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, false)


func _on_tree_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, true)


func _on_tree_2_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, false)


func _on_tree_3_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, true)


func _on_tree_3_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, false)

func _on_tombstone_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, true)


func _on_tombstone_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, false)


func _on_tombstone_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, true)


func _on_tombstone_2_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, false)


func _on_tombstone_3_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, true)


func _on_tombstone_3_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hiding_spot_detection(body, false)


func _on_spooky_skeletons_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
