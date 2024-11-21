@tool
class_name Entypo extends IconBase
## The node for all icons located in the Entypo [FontFile]

const defaultIcon : String = "user" ## Default Icon
static var fontFile : FontFile ## Used [FontFile]
static var glyphs : Dictionary ## Used glyphs

static var _ref_count : int = 0
func _enter_tree() -> void:
	_load_values()
func _exit_tree() -> void:
	_unload_values()
func _load_values() -> void:
	_ref_count += 1
	if _ref_count == 1:
		fontFile = load(_FONT_FOLDER + "Entypo.ttf")
		glyphs = load(_GLYPHMAPS_FOLDER + "Entypo.json").data
func _unload_values() -> void:
	_ref_count -= 1
	if _ref_count <= 0:
		fontFile = null
		glyphs.clear()

## When given an string [param icon_name], return the corresponding glyph index.
## Returns -1 if icon cannot be found within the curren glyphs
static func get_default_icon() -> String:
	return defaultIcon
## Returns the current FontFile in use.
##
## See [constant fontFile]
func get_fontFile() -> FontFile:
	return fontFile
func _get_glyphs() -> Dictionary:
	return glyphs
