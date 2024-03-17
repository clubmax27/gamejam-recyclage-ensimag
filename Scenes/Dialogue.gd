extends Control

var messages = [{
		"message" : "C'est une catastrophe ! A force de se faire vanner sur le fait qu'ils ont rien gagné aux OL'INP'iades, les Phelmas sont en train de se venger en attaquant l'ENSIMAG !",
		"character" : 0,
	},
	{
		"message" : "J'adore le JAVA",
		"character" : 1,
	},
	{
		"message" : "ah oeeeeeeeeeeeeeeeeeee",
		"character" : 0,
	}
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
	
	$Dialogue/TextBackground/MarginContainer/NextCharTimer.set_wait_time(typing_speed)
	$Dialogue/TextBackground/MarginContainer/NextCharTimer.start()
		
	if messages[current_message]["character"] == 0:
		$Dialogue/TextBackground/Maxence.set_visible(true)
		$Dialogue/TextBackground/Jacques.set_visible(false)
	else:
		$Dialogue/TextBackground/Jacques.set_visible(true)
		$Dialogue/TextBackground/Maxence.set_visible(false)

func stop_dialogue():
	set_visible(false)

func _input(_ev):
	if Input.is_action_just_released("ui_accept"):
		is_input_held = true
		if message_still_writing:
			message_still_writing = false
			finish_message()
			print("skipping")
		else:
			next_message()
			print("next message")
	
	
		
func _on_next_char_timer_timeout():
	if (current_char < len(messages[current_message]["message"])):
		message_still_writing = true
		
		var next_char = messages[current_message]["message"][current_char]
		display += next_char
		
		$Dialogue/TextBackground/MarginContainer/Message.text = display
		current_char += 1
	else:
		message_still_writing = false
		$Dialogue/TextBackground/MarginContainer/NextCharTimer.stop()

func finish_message():
	$Dialogue/TextBackground/MarginContainer/NextCharTimer.stop()
	$Dialogue/TextBackground/MarginContainer/Message.text = messages[current_message]["message"]

func next_message():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		current_message += 1
		display = ""
		current_char = 0
		
		if messages[current_message]["character"] == 0:
			$Dialogue/TextBackground/Maxence.set_visible(true)
			$Dialogue/TextBackground/Jacques.set_visible(false)
		else:
			$Dialogue/TextBackground/Jacques.set_visible(true)
			$Dialogue/TextBackground/Maxence.set_visible(false)
		
		$Dialogue/TextBackground/MarginContainer/NextCharTimer.start()

