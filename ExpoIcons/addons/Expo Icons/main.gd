@tool
extends EditorPlugin

const ICON_SCRIPT_FOLDER := "res://addons/Expo Icons/Scripts/IconNodes/"
const ICON_ICON_FOLDER := "res://addons/Expo Icons/assets/icons/"

func _enter_tree() -> void:
	add_custom_type(
		"IconBase",
		"Control",
		load("res://addons/Expo Icons/Scripts/icon.gd"), 
		load(ICON_ICON_FOLDER + "IconBase.svg")
	)
	
	add_custom_type(
		"AntDesign",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "AntDesign.gd"),
		load(ICON_ICON_FOLDER + "AntDesign.svg")
	)
	add_custom_type(
		"Entypo",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "Entypo.gd"),
		load(ICON_ICON_FOLDER + "Entypo.svg")
	)
	add_custom_type(
		"EvilIcons",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "EvilIcons.gd"),
		load(ICON_ICON_FOLDER + "EvilIcons.svg")
	)
	add_custom_type(
		"Feather",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "Feather.gd"),
		load(ICON_ICON_FOLDER + "Feather.svg")
	)
	add_custom_type(
		"FontAwesome5",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "ProFreeIcons/FontAwesome5.gd"),
		load(ICON_ICON_FOLDER + "FontAwesome5.svg")
	)
	add_custom_type(
		"FontAwesome6",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "ProFreeIcons/FontAwesome6.gd"),
		load(ICON_ICON_FOLDER + "FontAwesome6.svg")
	)
	add_custom_type(
		"FontAwesome",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "FontAwesome.gd"),
		load(ICON_ICON_FOLDER + "FontAwesome.svg")
	)
	add_custom_type(
		"Fontisto",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "Fontisto.gd"),
		load(ICON_ICON_FOLDER + "Fontisto.svg")
	)
	add_custom_type(
		"Foundation",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "Foundation.gd"),
		load(ICON_ICON_FOLDER + "Foundation.svg")
	)
	add_custom_type(
		"Ionicons",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "Ionicons.gd"),
		load(ICON_ICON_FOLDER + "Ionicons.svg")
	)
	add_custom_type(
		"MaterialCommunityIcons",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "MaterialCommunityIcons.gd"),
		load(ICON_ICON_FOLDER + "MaterialCommunityIcons.svg")
	)
	add_custom_type(
		"MaterialIcons",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "MaterialIcons.gd"),
		load(ICON_ICON_FOLDER + "MaterialIcons.svg")
	)
	add_custom_type(
		"Octicons",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "Octicons.gd"),
		load(ICON_ICON_FOLDER + "Octicons.svg")
	)
	add_custom_type(
		"SimpleLineIcons",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "SimpleLineIcons.gd"),
		load(ICON_ICON_FOLDER + "SimpleLineIcons.svg")
	)
	add_custom_type(
		"Zocial",
		"IconBase",
		load(ICON_SCRIPT_FOLDER + "Zocial.gd"),
		load(ICON_ICON_FOLDER + "Zocial.svg")
	)

func _exit_tree() -> void:
	remove_custom_type("Zocial")
	remove_custom_type("SimpleLineIcons")
	remove_custom_type("Octicons")
	remove_custom_type("MaterialIcons")
	remove_custom_type("MaterialCommunityIcons")
	remove_custom_type("Foundation")
	remove_custom_type("Fontisto")
	remove_custom_type("FontAwesome")
	remove_custom_type("FontAwesome6")
	remove_custom_type("FontAwesome5")
	remove_custom_type("Feather")
	remove_custom_type("EvilIcons")
	remove_custom_type("Entypo")
	remove_custom_type("AntDesign")
	
	remove_custom_type("IconBase")
