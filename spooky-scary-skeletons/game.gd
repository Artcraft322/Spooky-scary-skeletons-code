extends Node2D

var skeleton_there = false
var skeleton: Node2D
var can_look = false
var skeletons_found = 0
var getting_chased = false
var jumpscare = 0

#TODO finish skeleton behind detection system
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$camera.position.y = -3000
	$chasseskeleton.hide()
	$chasseskeleton.global_position.x = -800
	$Mainmusic.play()
	$"player/look text".hide()
	$camera/Jumpscare.hide()
	$player/Run.hide()
	$player/noskel.hide()
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
	$player/found1.hide()
	$player/found2.hide()
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$camera.global_position = $player.global_position
	var look_behind = Input.is_action_just_pressed("lookbehind")
	
	if look_behind:
		if can_look  && skeleton_there: 
			
			
			if skeletons_found == 0:
				skeleton.show()
				$player/found1.show()
				$camera.move_and_slide()
				await get_tree().create_timer(1).timeout
				$player/found1.hide()
				skeleton.global_position.x = -800
				skeletons_found += 1
				
			elif skeletons_found == 1:
				skeleton.show()
				$player/found2.show()
				$camera.move_and_slide()
				await get_tree().create_timer(1).timeout
				$player/found2.hide()
				skeleton.position.x = -800
				skeletons_found += 1
				
			elif skeletons_found == 2:
				skeleton.position.x = -800
				$Mainmusic.stop()
				$camera.move_and_slide()
				await  get_tree().create_timer(0.5).timeout
				$camera/Jumpscare.show()
				$Jumpscarsound.play()
				
				$player/Run.show()
				skeletons_found += 1
				getting_chased = true
				$chasseskeleton.show()
				$chasseskeleton.global_position.x = -300
		
		else:
				$player/noskel.show()
				$"player/look text".hide()
				$camera.move_and_slide()
				await get_tree().create_timer(0.5).timeout
				$player/noskel.hide()
		
	
	
	if getting_chased == true:
		$player.xspeed = 200
		chasse_skeleton()
		
	$camera.move_and_slide()


func hiding_spot_detection(player, show: bool):
	if player.is_in_group("player"):
		
		if show:
			$"player/look text".show()
			can_look = true
		else:
			$"player/look text".hide()
			can_look = false

func chasse_skeleton():
	$chasseskeleton.global_position.x += 4.2


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
	if body.is_in_group("player"):
		skeleton_there = true
		skeleton = $"spooky skeletons"


func _on_spooky_skeletons_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		skeleton_there = false

func _on_spooky_skeletons_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		skeleton_there = true
		skeleton = $"spooky skeletons2"


func _on_spooky_skeletons_2_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		skeleton_there = false

func _on_spooky_skeletons_3_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		skeleton_there = true
		skeleton = $"spooky skeletons3"


func _on_spooky_skeletons_3_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		skeleton_there = false


func _on_mainmusic_finished() -> void:
	$Mainmusic.play()


func _on_jumpscarsound_finished() -> void:
	if jumpscare == 0:
		$"Chass music".play()
		$camera/Jumpscare.hide()
		jumpscare += 1
	else:
		get_tree().quit()


func _on_chasseskeleton_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		$"Chass music".stop()
		$camera/Jumpscare.show()
		$Jumpscarsound.play()


func _on_sign_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player") && getting_chased:
		$camera.position.y = -2200
		$camera.position.x = 0
		get_tree().paused = true


func _on_start_pressed() -> void:
	$camera.position.y = 0 
	get_tree().paused = false
