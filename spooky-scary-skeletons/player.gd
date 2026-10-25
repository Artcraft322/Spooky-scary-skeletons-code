extends CharacterBody2D

@export var gravity = 10
@export var xspeed = 300
var yspeed = 0
var jump_height = -400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$left.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	
	
	
	velocity.y = yspeed
	
	if is_on_floor() == false:
		yspeed += gravity
	else:
		yspeed = 0
	if is_on_floor() && jump:
		yspeed = jump_height
	
	
	if right:
		velocity.x = xspeed
		$right.show()
		$left.hide()
	elif left:
		velocity.x = -xspeed
		$right.hide()
		$left.show()
	else:
		velocity.x = 0
	move_and_slide()
	
