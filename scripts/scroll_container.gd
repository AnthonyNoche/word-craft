extends ScrollContainer

@export var scroll_speed: int = 50
@export var scrollbar_width: int = 12
@export var scrollbar_color: Color = Color.ORANGE

func _ready():
	# Enable mouse input
	mouse_filter = Control.MOUSE_FILTER_PASS
	
	# Style the scrollbar to make it wider and colored
	setup_scrollbar_style()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			scroll_vertical = max(0, scroll_vertical - scroll_speed)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			# Add max limit to prevent over-scrolling
			var max_scroll = get_v_scroll_bar().max_value - get_v_scroll_bar().page
			scroll_vertical = min(max_scroll, scroll_vertical + scroll_speed)
			accept_event()

func setup_scrollbar_style():
	# Get the vertical scrollbar
	var vscroll = get_v_scroll_bar()
	
	# Create grabber style (the draggable part)
	var grabber_style = StyleBoxFlat.new()
	grabber_style.bg_color = scrollbar_color
	grabber_style.set_content_margin(SIDE_LEFT, scrollbar_width)
	grabber_style.set_content_margin(SIDE_RIGHT, scrollbar_width)
	grabber_style.set_content_margin(SIDE_TOP, 4)
	grabber_style.set_content_margin(SIDE_BOTTOM, 4)
	grabber_style.corner_radius_top_left = 3
	grabber_style.corner_radius_top_right = 3
	grabber_style.corner_radius_bottom_left = 3
	grabber_style.corner_radius_bottom_right = 3
	
	# Create grabber highlight style (when hovering)
	var grabber_highlight_style = StyleBoxFlat.new()
	grabber_highlight_style.bg_color = scrollbar_color.lightened(0.2)
	grabber_highlight_style.set_content_margin(SIDE_LEFT, scrollbar_width)
	grabber_highlight_style.set_content_margin(SIDE_RIGHT, scrollbar_width)
	grabber_highlight_style.set_content_margin(SIDE_TOP, 4)
	grabber_highlight_style.set_content_margin(SIDE_BOTTOM, 4)
	grabber_highlight_style.corner_radius_top_left = 3
	grabber_highlight_style.corner_radius_top_right = 3
	grabber_highlight_style.corner_radius_bottom_left = 3
	grabber_highlight_style.corner_radius_bottom_right = 3
	
	# Create grabber pressed style (when clicking)
	var grabber_pressed_style = StyleBoxFlat.new()
	grabber_pressed_style.bg_color = scrollbar_color.darkened(0.2)
	grabber_pressed_style.set_content_margin(SIDE_LEFT, scrollbar_width)
	grabber_pressed_style.set_content_margin(SIDE_RIGHT, scrollbar_width)
	grabber_pressed_style.set_content_margin(SIDE_TOP, 4)
	grabber_pressed_style.set_content_margin(SIDE_BOTTOM, 4)
	grabber_pressed_style.corner_radius_top_left = 3
	grabber_pressed_style.corner_radius_top_right = 3
	grabber_pressed_style.corner_radius_bottom_left = 3
	grabber_pressed_style.corner_radius_bottom_right = 3
	
	# Create scroll background style
	var scroll_style = StyleBoxFlat.new()
	scroll_style.bg_color = Color(0.2, 0.2, 0.3, 0.5)  # Semi-transparent dark blue
	scroll_style.set_content_margin(SIDE_LEFT, scrollbar_width + 2)
	scroll_style.set_content_margin(SIDE_RIGHT, scrollbar_width + 2)
	
	# Apply all styles to the scrollbar
	vscroll.add_theme_stylebox_override("grabber", grabber_style)
	vscroll.add_theme_stylebox_override("grabber_highlight", grabber_highlight_style)
	vscroll.add_theme_stylebox_override("grabber_pressed", grabber_pressed_style)
	vscroll.add_theme_stylebox_override("scroll", scroll_style)
	
	# Make sure scrollbar is always visible
	vertical_scroll_mode = ScrollContainer.SCROLL_MODE_SHOW_ALWAYS
