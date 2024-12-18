@tool
class_name Entypo extends IconBase
## The node for all icons located in the Entypo [FontFile]

const defaultIcon : String = "user" ## Default Icon
const fontFile : FontFile = preload(_FONT_FOLDER + "Entypo.ttf") ## Used [FontFile]
const glyphs : Dictionary = preload(_GLYPHMAPS_FOLDER + "Entypo.json").data ## Used glyphs

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