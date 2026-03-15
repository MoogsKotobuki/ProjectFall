extends State

var Camera:Camera3D
var Target
var Offsets:Vector3 = Vector3(0.0,1.5,20.0)

var smoothingX = 0.0
var shift_amount = 1
var smooth_speed = 1
var smooth_return = 1.5
var maxShift = 3.0
func enter() -> void:
	Camera = state_machine.get_parent()
	var r = GetAlgo.new()
	r.getPlayerEntity(state_machine.get_parent())
	Target = r.value

func _physics_update(_delta: float) -> void:
	
	var dOffsets = Input.get_vector("mvLeft","mvRight","mvUp","mvDown")
	var direction = Target.velocity.x
	# Target shift based on movement direction
	var target_shift = direction * shift_amount
	target_shift = clamp(target_shift,-maxShift,maxShift)
	
	# Smooth interpolation
	if dOffsets:
		smoothingX = lerp(smoothingX, target_shift, smooth_speed * _delta)
	else:
		smoothingX = lerp(smoothingX, target_shift, smooth_return * _delta)

	
	# Apply to camera
	Camera.position.x = Target.position.x + smoothingX
	Camera.position.y = Target.position.y + Offsets.y
