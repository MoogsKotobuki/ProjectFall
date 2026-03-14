class_name Fixer

# Called when the node enters the scene tree for the first time.
func MaxSpeedFix(entity:Entity,maxSpeed) -> void:
	if entity.velocity.x > maxSpeed:
		entity.velocity.x = maxSpeed
	elif entity.velocity.x <-maxSpeed:
		entity.velocity.x = -maxSpeed
