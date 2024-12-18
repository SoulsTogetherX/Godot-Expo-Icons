@tool
class_name EvilIcons extends IconBase
## The node for all icons located in the EvilIcons [FontFile]

const defaultIcon : String = "user" ## Default Icon
const fontFile : FontFile = preload(_FONT_FOLDER + "EvilIcons.ttf") ## Used [FontFile]
const glyphs : Dictionary = preload(_GLYPHMAPS_FOLDER + "EvilIcons.json").data ## Used glyphs

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
