extends CharacterBody2D

# Kecepatan dinaikkan dari 100 ke 250 agar tidak terasa slow-mo
@export var speed: float = 70

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Menyimpan arah terakhir karakter agar saat berhenti (idle), dia menghadap arah yang benar
var last_direction: String = "down"

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	# 1. Membaca Input Tombol Panah
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
		
	# 2. Pergerakan Karakter
	velocity = input_vector.normalized() * speed
	move_and_slide()
	
	# 3. Logika Pemutaran Animasi
	update_animation(input_vector)

func update_animation(input_vector: Vector2) -> void:
	if input_vector != Vector2.ZERO:
		# Jika karakter BERGERAK:
		if input_vector.x > 0:
			last_direction = "right"
			sprite.play("walk_right")
			sprite.flip_h = false
		elif input_vector.x < 0:
			last_direction = "left"
			sprite.play("walk_left")
		elif input_vector.y > 0:
			last_direction = "down"
			sprite.play("walk_down")
		elif input_vector.y < 0:
			last_direction = "up"
			sprite.play("walk_up")
	else:
		# Jika karakter DIAM (Idle): putar animasi idle sesuai arah terakhir
		if last_direction == "right":
			sprite.play("idle_right")
			sprite.flip_h = false
		elif last_direction == "left":
			sprite.play("idle_left")
		elif last_direction == "down":
			sprite.play("idle_down")
		elif last_direction == "up":
			sprite.play("idle_up")
