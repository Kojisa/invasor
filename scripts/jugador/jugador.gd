extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var maxX = 600
export var maxY = 600
export var acel = 1400
export var freno = 800
export var maxVel = 500
export var vidas = 3
export var hp = 1
export var gravedad = Vector2(0,100)
export var deltaFreno = 1

var vel = Vector2(0,0)
var normalVel = Vector2(0,0)
var dirAnt = Vector2(0,0)
var arma = null
var tiempoSinMover = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var direccion = Vector2(0,0)
	if(Input.is_action_pressed("ui_down")):
		direccion += Vector2(0,1)
	if(Input.is_action_pressed("ui_up")):
		direccion += Vector2(0,-1)
	if(Input.is_action_pressed('ui_right')):
		direccion += Vector2(1,0)
	if(Input.is_action_pressed('ui_left')):
		direccion += Vector2(-1,0)
	
	$Sprite.rotation = (self.dirAnt + direccion).angle()
	self.dirAnt = (self.dirAnt + direccion).normalized()
	direccion *=  self.acel * delta
	self.vel +=  direccion
	if(direccion.length() == 0):
		self.tiempoSinMover += delta
		#if(self.tiempoSinMover >= self.tiempoHastaFrenarse):
		#self.vel += self.vel*(-1*self.freno*delta)
		
	#	#self.vel += (self.gravedad * delta) #modificar la gravedad o agregar un timer 
	#	                                     #para poder modificar bien la velocidad de bajada
	else:
		self.tiempoSinMover = 0
	
	
	self.vel = self.vel.clamped(self.maxVel)
	
	
	self.move_and_slide(self.vel)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
