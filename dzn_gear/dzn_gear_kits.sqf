// ***********************************
// Gear Kits 
// ***********************************

// ******** USEFUL MACROSES *******
// Maros for Empty weapon
#define EMPTYKIT	[["","","","",""],["","","","",""],["","","","",""],["","","","",""],[],[["",0],["",0],["",0],["",0],["",0],["",0],["",0],["",0],["",0]],[["",0],["",0],["",0],["",0],["",0],["",0]],[]]
// Macros for Empty weapon
#define EMPTYWEAPON	["","","",""]
// Macros for the list of items to be chosen randomly
#define RANDOM_ITEM	["H_HelmetB_grass","H_HelmetB"]
// Macros to give the item only if daytime is in given inerval (e.g. to give NVGoggles only at night)
#define NIGHT_ITEM(X)	if (daytime < 9 || daytime > 18) then { X } else { "" }

kit_defaultPlayer =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam","V_PlateCarrier1_rgr","","H_HelmetB",""],
	["<PRIMARY WEAPON >>  ","arifle_MX_ACO_pointer_F","30Rnd_65x39_caseless_mag",["","acc_pointer_IR","optic_Aco",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",7],["HANDGUN MAG",2],["SmokeShell",1],["SmokeShellGreen",1],["Chemlight_green",1],["HandGrenade",2]]],
	["<BACKPACK ITEMS >> ",[]]
];


kit_defaultBox = [
	[["arifle_MXC_F",8],["arifle_MX_F",8],["hgun_P07_F",5],["launch_NLAW_F",1]],
	[["30Rnd_65x39_caseless_mag",50],["100Rnd_65x39_caseless_mag",20],["16Rnd_9x21_Mag",20],["1Rnd_HE_Grenade_shell",25],["1Rnd_SmokeBlue_Grenade_shell",2],["1Rnd_SmokeGreen_Grenade_shell",2],["1Rnd_SmokeOrange_Grenade_shell",2],["1Rnd_SmokePurple_Grenade_shell",2],["1Rnd_SmokeRed_Grenade_shell",2],["1Rnd_SmokeYellow_Grenade_shell",2],["1Rnd_Smoke_Grenade_shell",2],["DemoCharge_Remote_Mag",5],["HandGrenade",20],["MiniGrenade",24],["NLAW_F",8],["SatchelCharge_Remote_Mag",5],["SmokeShell",20],["SmokeShellBlue",2],["SmokeShellGreen",2],["SmokeShellOrange",2],["SmokeShellPurple",2],["SmokeShellRed",2],["SmokeShellYellow",2]],
	[["FirstAidKit",10],["ItemGPS",5],["Medikit",5],["ToolKit",5]],
	[]
];


// *************************************** //

#include "kits_nato.sqf"
#include "kits_fia.sqf"
#include "kits_aaf.sqf"
