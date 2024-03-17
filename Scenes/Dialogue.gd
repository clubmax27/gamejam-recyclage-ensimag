extends Control

var messages = [{
		"message" : "Human, I remember you're ...... neutral",
		"character" : 0,
	},
	{
		"message" : "My Second Message",
		"character" : 1,
	},
	{
		"message" : "My Third Message",
		"character" : 0,
	}
]

var typing_speed = .05
var read_time = 2

var current_message = 0
var display = ""
var current_char = 0

func _ready():
	start_dialogue()
	
func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	
	var character = messages[current_message]["character"]
	$Dialogue/TextBackground/MarginContainer/NextCharTimer.set_wait_time(typing_speed)
	$Dialogue/TextBackground/MarginContainer/NextCharTimer.start()
		
	if messages[current_message]["character"] == 0:
		$Dialogue/TextBackground/Maxence.set_visible(true)
		$Dialogue/TextBackground/Jacques.set_visible(false)
	else:
		$Dialogue/TextBackground/Jacques.set_visible(true)
		$Dialogue/TextBackground/Maxence.set_visible(false)

func stop_dialogue():
	# get_parent().remove_child(self)
	set_visible(false)

func _input(ev):
	if Input.is_key_pressed(KEY_ENTER) or (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		next_message()
		
func _on_next_char_timer_timeout():
	if (current_char < len(messages[current_message]["message"])):
		var next_char = messages[current_message]["message"][current_char]
		display += next_char
		
		$Dialogue/TextBackground/MarginContainer/Message.text = display
		current_char += 1
	else:
		$Dialogue/TextBackground/MarginContainer/NextCharTimer.stop()

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

