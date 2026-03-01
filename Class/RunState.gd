extends State

@export var Speed = 5
@export var accel = 1
@export var decel = 10
var friction = 1
var cVelocity

var flipping = false
var currentFace
var rotationY = 0

var globalInputStrenght = 0

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	cVelocity = Entity.cVelocity

func exit() -> void:
	Entity.cVelocity = cVelocity
	Entity.velocity = Entity.velocity
	
func _update(_delta: float) -> void:
	Entity.position.z = 0
	DebugVariable.PlayerVelocity = cVelocity
	
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	globalInputStrenght = input_strenght
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jump")
	
	if cVelocity == 0:
		state_machine.change_state("idle")
		
func _physics_update(_delta: float) -> void:
	Entity.rotation.y = lerp_angle(Entity.rotation.y,rotationY,10 * _delta)
	
	var direction = IHandler.mov.x
	
	if flipping:
		flipDecelerate(_delta)
		return
		
	if globalInputStrenght == 0:
		decelerate(_delta)
	else:

		
		cVelocity += (accel * Speed) * _delta
		cVelocity = clamp(cVelocity,-99,Speed)
		
		if cVelocity > 3:
			if direction > 0.0001 and currentFace == "left":
					rotationY = PI
					currentFace="right"
					flipping = true
			elif direction < -0.0001  and currentFace == "right":
					rotationY = 0.1
					currentFace="left"
					flipping = true

		if direction > 0.0001:
				rotationY = PI
				currentFace="right"
		elif direction < -0.0001:
				rotationY = 0.1
				currentFace="left"
		var basis =  -Entity.global_basis.x
		Entity.velocity.x = round((cVelocity * basis.x) * 100) / 100.0

		Entity.move_and_slide()


func decelerate(_delta):
	cVelocity -= decel * _delta
	var basis =  -Entity.global_basis.x
	cVelocity = clamp(cVelocity,0,100)
	Entity.velocity.x = cVelocity * basis.x
	Entity.velocity.x = round(Entity.velocity.x * 100) / 100.0
	Entity.move_and_slide()

func flipDecelerate(_delta):
	cVelocity -= decel * _delta
	var basis =  -Entity.global_basis.x
	cVelocity = clamp(cVelocity,0,100)
	Entity.velocity.x = -(cVelocity) * basis.x
	Entity.velocity.x = round(Entity.velocity.x * 100) / 100.0
	if cVelocity == 0:
			flipping = false
			print("flipping: False")
	Entity.move_and_slide()

	
