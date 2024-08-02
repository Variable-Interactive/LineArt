extends Node

var item_id: int
var lineart_dialog: ImageEffect

# This script acts as a setup for the extension
func _enter_tree() -> void:
	var type = ExtensionsApi.menu.EFFECTS

	item_id = ExtensionsApi.menu.add_menu_item(type, "Make LineArt", self)
	# the 3rd argument (in this case "self") will try to call "menu_item_clicked"
	# (if it is present)

	lineart_dialog = preload(
		"res://src/Extensions/LineArt/Assets/Dialog/LineArtDialog.tscn"
	).instantiate()
	ExtensionsApi.dialog.get_dialogs_parent_node().add_child(lineart_dialog)



func menu_item_clicked():
	# Do some stuff
	lineart_dialog.popup_centered()


func _exit_tree() -> void:  # Extension is being uninstalled or disabled
	# remember to remove things that you added using this extension
	ExtensionsApi.menu.remove_menu_item(ExtensionsApi.menu.EFFECTS, item_id)
	lineart_dialog.queue_free()
