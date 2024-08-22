extends Node

var item_id: int
var lineart_dialog: ImageEffect
var api: Node

# This script acts as a setup for the extension
func _enter_tree() -> void:
	api = get_node_or_null("/root/ExtensionsApi")
	if api:
		var type = api.menu.EFFECTS

		item_id = api.menu.add_menu_item(type, "Make LineArt", self)
		# the 3rd argument (in this case "self") will try to call "menu_item_clicked"
		# (if it is present)

		lineart_dialog = preload(
			"res://src/Extensions/LineArt/Assets/Dialog/LineArtDialog.tscn"
		).instantiate()
		api.dialog.get_dialogs_parent_node().add_child(lineart_dialog)



func menu_item_clicked():
	# Do some stuff
	lineart_dialog.popup_centered()


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	if api:
		# remember to remove things that you added using this extension
		api.menu.remove_menu_item(ExtensionsApi.menu.EFFECTS, item_id)
		lineart_dialog.queue_free()
