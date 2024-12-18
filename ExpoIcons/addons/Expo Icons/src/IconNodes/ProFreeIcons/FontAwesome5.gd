@tool
class_name FontAwesome5 extends ProFreeIcons
## The node for all icons located in the FontAwesome5 [FontFile]s
##
## [b]NOTE[/b]: Some Icons are broken. This is due to a faulty meta file. I have no found a correct one on the internet yet.

const defaultIcon = "user" ## Default Icon
const fontFiles : Dictionary = {
			"brands": preload(_FONT_FOLDER + "FontAwesome5_Brands.ttf"),
			"regular": preload(_FONT_FOLDER + "FontAwesome5_Regular.ttf"),
			"solid": preload(_FONT_FOLDER + "FontAwesome5_Solid.ttf"),
		} ## Used [FontFile]s
const glyphs : Dictionary = {
			ICON_STATE.Free: preload(
				_GLYPHMAPS_FOLDER + "FontAwesome5Free.json"
			).data,
			ICON_STATE.Pro: preload(
				_GLYPHMAPS_FOLDER + "FontAwesome5Pro.json"
			).data
		} ## Used glyphs
const metas : Dictionary = {
			ICON_STATE.Free: preload(
				_GLYPHMAPS_FOLDER + "FontAwesome5Free_meta.json"
			).data,
			ICON_STATE.Pro: preload(
				_GLYPHMAPS_FOLDER + "FontAwesome5Pro_meta.json"
			).data
		} ## Used metadatas

## When given an string [param icon_name], return the corresponding glyph index.
## Returns -1 if icon cannot be found within the curren glyphs
static func get_default_icon() -> String:
	return defaultIcon
func _get_glyphs() -> Dictionary:
	if glyphs.has(_icon_state):
		return glyphs[_icon_state]
	return {}
## Returns the current FontFile in use, based on the current [member icon_state] value.
func get_fontFile() -> FontFile:
	if metas.has(_icon_state):
		var meta = metas[_icon_state]
		for type : String in fontFiles.keys():
			if meta[type].has(_icon_name):
				return fontFiles[type]
	return null
