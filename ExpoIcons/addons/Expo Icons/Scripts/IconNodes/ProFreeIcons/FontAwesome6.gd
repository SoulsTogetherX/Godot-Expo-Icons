@tool
class_name FontAwesome6 extends ProFreeIcons
## The node for all icons located in the FontAwesome6 [FontFile]s
##
## [b]NOTE[/b]: Some Icons are broken. This is due to a faulty meta file. I have no found a correct one on the internet yet.

const defaultIcon = "user" ## Default Icon
const fontFiles : Dictionary = {
	"brands": preload(_FONT_FOLDER + "FontAwesome6_Brands.ttf"),
	"regular": preload(_FONT_FOLDER + "FontAwesome6_Regular.ttf"),
	"solid": preload(_FONT_FOLDER + "FontAwesome6_Solid.ttf"),
} ## Used [FontFile]s
const glyphs : Dictionary = {
	ICON_STATE.Free: preload(
		_GLYPHMAPS_FOLDER + "FontAwesome6Free.json"
	).data,
	ICON_STATE.Pro: preload(
		_GLYPHMAPS_FOLDER + "FontAwesome6Pro.json"
	).data
} ## Used glyphs
const metas : Dictionary = {
	ICON_STATE.Free: preload(
		_GLYPHMAPS_FOLDER + "FontAwesome6Free_meta.json"
	).data,
	ICON_STATE.Pro: preload(
		_GLYPHMAPS_FOLDER + "FontAwesome6Pro_meta.json"
	).data
} ## Used metadatas

## When given an string [param icon_name], return the corresponding glyph index.
## Returns -1 if icon cannot be found within the curren glyphs
static func get_default_icon() -> String:
	return defaultIcon
func _get_glyphs() -> Dictionary:
	return glyphs[_icon_state]

## Returns the current FontFile in use, based on the current [member icon_state] value.
func get_current_fontFile() -> FontFile:
	var meta = metas[_icon_state]
	for type : String in fontFiles.keys():
		if meta[type].has(_icon_name):
			return fontFiles[type]
	return null

func _ready() -> void:
	if _icon_name == "":
		_current_icon = defaultIcon
		_icon_name = defaultIcon
		_icon_glyph = glyphs[_icon_state].keys().find(defaultIcon)
	else:
		_current_icon = _icon_name
func _draw() -> void:
	var fontFile : FontFile = get_current_fontFile()
	if fontFile:
		_draw_icon(fontFile, get_glyph_by_name(_icon_name))
