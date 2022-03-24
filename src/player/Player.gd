extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 500
const FRICTION = 500

enum {
	MOVE,
	ATTACK
}

var velocity = Vector2.ZERO
var state = MOVE

onready var animationPlayer = $AnimationPlayer
#onready var animationState = animationTree.get("parameters/playback")

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	#input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		move()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
func move():
	velocity = move_and_slide(velocity)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			pass
