extends Control

var messages = [{
		"message" : "C'est une catastrophe ! A force de se faire vanner sur le fait qu'ils ont rien gagné aux OL'INP'iades, les Phelmas sont en train de se venger en attaquant l'ENSIMAG !",
		"character" : 1,
	},
	{
		"message" : "Il faut à tout prix les arrêter ! On va construire des tourelles pour leur éclater la gueule !",
		"character" : 0,
	},
	{
		"message" : "Mais on aura jamais assez de resources pour tous les arreter ???? T'as cablé Maxence.",
		"character" : 1,
	},
	{
		"message" : "Bien sûr que si, t'as rien écouté à la semaine kaléidoscope de transition écologique toi.",
		"character" : 0,
	},
	{
		"message" : "Si mais j'avais coding dojo :)",
		"character" : 1,
	},
	{
		"message" : "Ouais bah moi j'avais écologie toute la semaine enfoiré.",
		"character" : 0,
	},
	{
		"message" : "Mais bref, il existe une tour en bois qui permet de recycler ce qu'on trouve sur le cadavre des Phelmas pour le transformer en resources pour construire des tours.",
		"character" : 0,
	},
	{
		"message" : "Mais du coup il faut forcément placer des tours en bois à coté du combat, sinon on aura jamais de quoi les repousser ...",
		"character" : 0,
	},
	{
		"message" : "Mmh, ok, je vois. Allons foutre une raclée au Phelmas, comme d'habitude.",
		"character" : 1,
	},
]

var typing_speed = .05
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0

var message_still_writing = true
var is_input_held = false

func _ready():
	start_dialogue()
	
func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	print(get_name())
	$Control/TextBackground/MarginContainer/NextCharTimer.set_wait_time(typing_speed)
	$Control/TextBackground/MarginContainer/NextCharTimer.start()
		
	if messages[current_message]["character"] == 0:
		$Control/TextBackground/Maxence.set_visible(true)
		$Control/TextBackground/Jacques.set_visible(false)
	else:
		$Control/TextBackground/Jacques.set_visible(true)
		$Control/TextBackground/Maxence.set_visible(false)

func stop_dialogue():
	set_visible(false)

func _input(_ev):
	if Input.is_action_just_released("ui_accept"):
		is_input_held = true
		if message_still_writing:
			message_still_writing = false
			finish_message()
		else:
			next_message()
	
	
		
func _on_next_char_timer_timeout():
	if (current_char < len(messages[current_message]["message"])):
		message_still_writing = true
		
		var next_char = messages[current_message]["message"][current_char]
		display += next_char
		
		$Control/TextBackground/MarginContainer/Message.text = display
		current_char += 1
	else:
		message_still_writing = false
		$Control/TextBackground/MarginContainer/NextCharTimer.stop()

func finish_message():
	$Control/TextBackground/MarginContainer/NextCharTimer.stop()
	$Control/TextBackground/MarginContainer/Message.text = messages[current_message]["message"]

func next_message():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		
		if messages[current_message]["character"] == 0:
			$Control/TextBackground/Maxence.set_visible(true)
			$Control/TextBackground/Jacques.set_visible(false)
		else:
			$Control/TextBackground/Jacques.set_visible(true)
			$Control/TextBackground/Maxence.set_visible(false)
		
		$Control/TextBackground/MarginContainer/NextCharTimer.start()

