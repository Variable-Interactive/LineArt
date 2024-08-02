class_name ImageEffect
extends ConfirmationDialog
## Parent class for all image effects
## Methods that have "pass" are meant to be replaced by the inherited scripts

enum { SELECTED_CELS, FRAME, ALL_FRAMES, ALL_PROJECTS }

var affect: int = SELECTED_CELS
var selected_cels := Image.create(1, 1, false, Image.FORMAT_RGBA8)
var current_frame := Image.create(1, 1, false, Image.FORMAT_RGBA8)
var preview_image := Image.new()
var aspect_ratio_container: AspectRatioContainer
var preview: TextureRect
var live_checkbox: CheckBox
var wait_time_slider: ValueSlider
var wait_apply_timer: Timer
var selection_checkbox: CheckBox
var affect_option_button: OptionButton
var animate_panel: AnimatePanel
var commit_idx := -1  ## The current frame the image effect is being applied to
var has_been_confirmed := false
var live_preview := true
var _preview_idx := 0  ## The current frame being previewed


func _ready() -> void:
	return


func _about_to_popup() -> void:
	return


func update_preview(using_timer := false) -> void:
	return
