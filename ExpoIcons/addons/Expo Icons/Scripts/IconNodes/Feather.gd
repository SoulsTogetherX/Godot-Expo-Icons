@tool
class_name Feather extends IconBase
## The node for all icons located in the Feather [FontFile]

const defaultIcon : String = "user" ## Default Icon
const fontFile : FontFile = preload(_FONT_FOLDER + "Feather.ttf") ## Used [FontFile]
const glyphs : Dictionary = preload(_GLYPHMAPS_FOLDER + "Feather.json").data ## Used glyphs

## When given an string [param icon_name], return the corresponding glyph index.
## Returns -1 if icon cannot be found within the curren glyphs
static func get_default_icon() -> String:
	return defaultIcon
func _get_glyphs() -> Dictionary:
	return glyphs

func _ready() -> void:
	if _icon_name == "":
		_current_icon = defaultIcon
		_icon_name = defaultIcon
		_icon_glyph = glyphs.keys().find(defaultIcon)
	else:
		_current_icon = _icon_name
func _draw() -> void:
	_draw_icon(fontFile, get_glyph_by_name(_icon_name))
