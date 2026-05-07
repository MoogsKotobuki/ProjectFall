extends State
@export var decel = 50
@export var friction = 1
var rayD:RayCast3D
func enter() -> void:
	var r = ReadyState.new()
	r.Ready(self,state_machine,1)
	if rayD == null:
		r.addRay(Entity,"duckDetection",Vector3(0,1.0,0),self,Vector3(0,1.0,0))
	Entity.specialStates = "Duck"

func _update(_delta: float) -> void:
	var input = IHandler.mov
	
	if input.y < 0.1 and !rayD.is_colliding():
		state_machine.change_state("idle")
	elif Input.is_action_just_pressed("jump") and !rayD.is_colliding():
		state_machine.change_state("jump")

func _physics_update(_delta: float) -> void:
	if Entity.velocity.x != 0 :
		if Entity.velocity.x > 0:
			Entity.velocity.x -= decel * _delta
			Entity.velocity.x = clamp(Entity.velocity.x,0,99)
		if Entity.velocity.x < 0:
			Entity.velocity.x += decel * _delta
			Entity.velocity.x = clamp(Entity.velocity.x,-99,0)
		
