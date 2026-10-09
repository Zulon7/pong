extends RigidBody2D

var move_speed = 900;
var dash_speed = 1000
var max_move_speed = 700
var max_dash_speed = 800;

var max_speed = max_move_speed;





func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down");
	var move_force = input * move_speed * delta * 100;
	apply_force(move_force);
	if Input.is_action_just_pressed("dash_up") or Input.is_action_just_pressed("dash_down") or Input.is_action_just_pressed("dash_left") or Input.is_action_just_pressed("dash_right"):
		var dash_input = Input.get_vector("dash_left", "dash_right", "dash_up", "dash_down");
		var dash_impulse = dash_input * dash_speed;
		apply_impulse(dash_impulse);
		#allows dash to go past max_move_speed
		max_speed = max_dash_speed;
	#max_speed returns to normal
	max_speed = max_speed + (max_move_speed - max_speed) * delta * 3
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#speed limit
	state.linear_velocity = state.linear_velocity.limit_length(max_speed);
	#interpolate movement back to 0
	if !Input.is_action_pressed("space"):
		state.linear_velocity = state.linear_velocity.lerp(Vector2(0,0), state.step * 8);
	
	
	
