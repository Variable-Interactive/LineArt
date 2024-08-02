extends ImageEffect

enum Animate { STRENGTH }
var shader: Shader = preload("res://src/Extensions/LineArt/Assets/LineArt.gdshader")

var _strength_slider: TextureProgressBar
var _color_button :ColorPickerButton


func _ready() -> void:
	super._ready()
	var sm := ShaderMaterial.new()
	sm.shader = shader
	preview.set_material(sm)
	# set as in enum
	_strength_slider = ExtensionsApi.general.create_value_slider()
	_strength_slider.custom_minimum_size.y = 24
	_strength_slider.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_strength_slider.value_changed.connect(_on_strength_value_changed)
	_strength_slider.min_value = 0
	_strength_slider.max_value = 1
	_strength_slider.step = 0.001
	_strength_slider.value = 0
	_strength_slider.prefix = "Strength:"
	_strength_slider.allow_greater = false
	_color_button = ColorPickerButton.new()
	_color_button.custom_minimum_size.y = 24
	var _reference_node = find_child("OptionsContainer")
	_color_button.color_changed.connect(_on_line_color_color_changed)
	_reference_node.get_parent().add_child(_color_button)
	_color_button.get_parent().move_child(_color_button, _reference_node.get_index())
	_reference_node.get_parent().add_child(_strength_slider)
	_strength_slider.get_parent().move_child(_strength_slider, _reference_node.get_index())
	animate_panel.add_float_property("Strength", _strength_slider)


func _about_to_popup() -> void:
	_reset()
	super._about_to_popup()


func commit_action(cel: Image, project: Project = ExtensionsApi.general.get_global().current_project) -> void:
	var strength = animate_panel.get_animated_value(commit_idx, Animate.STRENGTH)
	var color = _color_button.color
	var selection_tex: ImageTexture
	if selection_checkbox.button_pressed and project.has_selection:
		var selection: SelectionMap = project.selection_map.return_cropped_copy(project.size)
		selection_tex = ImageTexture.create_from_image(selection)

	var params := {"strength": strength, "color": color, "selection": selection_tex}
	if !has_been_confirmed:
		for param in params:
			preview.material.set_shader_parameter(param, params[param])
	else:
		var gen := ExtensionsApi.general.get_new_shader_image_effect()
		gen.generate_image(cel, shader, params, project.size)
		await gen.done


func _reset() -> void:
	_strength_slider.value = 0
	_color_button.color = Color.BLACK
	has_been_confirmed = false


func _on_line_color_color_changed(_color: Color) -> void:
	update_preview()


func _on_strength_value_changed(_value: float) -> void:
	update_preview()
