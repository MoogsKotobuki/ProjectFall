extends State
var cVelocity
var gravity

@onready var fixer:Fixer = Fixer.new()

var Speed:float
<<<<<<< Updated upstream
@export var accel = 5
@export var decel = 10
@export var maxJump = 1
=======
@export var accel:float = 5.0
@export var maxJump:int = 2
@export var friction:float = 0.5
>>>>>>> Stashed changes
var jumpLimit = 0

var frictionLand = 2.0
var friction = 1
var globalDirection = 0

var globalInputStrenght = 0
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	
	if Entity.velocity.y > 0:
		jumpLimit +=1
	
	Speed = Entity.previousMaxSpeed
func _update(_delta: float) -> void:
<<<<<<< Updated upstream
=======
	if Entity.velocity.y < 0.1 and doublejump == true:
			state_machine.change_state("jump")
			jumpLimit -=1
			doublejump = false
	
>>>>>>> Stashed changes
	var raw_input = Vector2(IHandler.mov.x,0)
	var input_strenght = raw_input.length()
	globalInputStrenght = input_strenght
	if input_strenght >0.75:
		Speed = Entity.runSpeed
	
func _physics_update(_delta: float) -> void:
	if !Entity.is_on_floor():
		Entity.velocity.y += (Entity.get_gravity().y * Entity.mass) * _delta
		midAirMovement(_delta)
		if Input.is_action_just_pressed("jump") and jumpLimit < maxJump:
			jumpLimit+= 1
			state_machine.change_state("jump")
			if globalInputStrenght == 0:
				Entity.velocity.x = 0
	else:
		jumpLimit = 0
		state_machine.change_state("idle")
		if globalInputStrenght == 0:
			Entity.velocity.x = Entity.velocity.x * 0.5
	Entity.move_and_slide()

func midAirMovement(_delta) -> void:
	var direction = IHandler.mov.x
	if direction:
		if direction > 0:
			globalDirection =1
		else:
			globalDirection = -1
			
		if Entity.velocity.x > 0:
				Entity.viewSides = PI
		elif Entity.velocity.x < 0:
				Entity.viewSides = 0
		fixer.MaxSpeedFix(Entity,Speed)
		Entity.velocity.x += (accel * _delta) * globalDirection
