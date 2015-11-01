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

kit_nato_ar =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam_tshirt","V_PlateCarrier2_rgr","","H_HelmetB_grass","G_Combat"],
	["<PRIMARY WEAPON >>  ","arifle_MX_SW_pointer_F","100Rnd_65x39_caseless_mag",["","acc_pointer_IR","","bipod_01_F_snd"]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["HANDGUN MAG",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",5],["HANDGUN MAG",1],["HandGrenade",2],["SmokeShell",1],["SmokeShellGreen",1],["Chemlight_green",2]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_nato_med =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam_tshirt","V_PlateCarrierSpec_rgr","B_AssaultPack_rgr_Medic","H_HelmetB_light_desert","G_Tactical_Black"],
	["<PRIMARY WEAPON >>  ","arifle_MX_pointer_F","30Rnd_65x39_caseless_mag",["","acc_pointer_IR","",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",3],["HANDGUN MAG",2],["SmokeShell",1],["SmokeShellGreen",1],["SmokeShellBlue",1],["SmokeShellOrange",1],["Chemlight_green",1]]],
	["<BACKPACK ITEMS >> ",[["Medikit",1],["FirstAidKit",10]]]
];

kit_nato_gr =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam","V_PlateCarrierGL_rgr","","H_HelmetSpecB_blk","G_Combat"],
	["<PRIMARY WEAPON >>  ","arifle_MX_GL_ACO_F","30Rnd_65x39_caseless_mag",["","","optic_Aco",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",3],["HANDGUN MAG",2],["1Rnd_HE_Grenade_shell",5],["HandGrenade",2],["MiniGrenade",2],["SmokeShell",1],["SmokeShellGreen",1],["Chemlight_green",1],["1Rnd_Smoke_Grenade_shell",2],["1Rnd_SmokeBlue_Grenade_shell",1],["1Rnd_SmokeGreen_Grenade_shell",1],["1Rnd_SmokeOrange_Grenade_shell",1]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_nato_at =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam","V_PlateCarrierSpec_rgr","B_AssaultPack_mcamo_AT","H_HelmetSpecB_paint1",""],
	["<PRIMARY WEAPON >>  ","arifle_MXC_Holo_pointer_F","30Rnd_65x39_caseless_mag",["","acc_pointer_IR","optic_Holosight",""]],
	["<LAUNCHER WEAPON >>  ","launch_B_Titan_short_F","Titan_AT",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",3],["HANDGUN MAG",2],["HandGrenade",2],["SmokeShell",1],["SmokeShellGreen",1],["Chemlight_green",1]]],
	["<BACKPACK ITEMS >> ",[["SECONDARY MAG",2],["Titan_AP",1]]]
];

kit_nato_r =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam","V_PlateCarrier1_rgr","","H_HelmetB","G_Combat"],
	["<PRIMARY WEAPON >>  ","arifle_MX_ACO_pointer_F","30Rnd_65x39_caseless_mag",["","acc_pointer_IR","optic_Aco",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",7],["HANDGUN MAG",2],["SmokeShell",1],["SmokeShellGreen",1],["Chemlight_green",1],["HandGrenade",2]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_nato_rat =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam","V_PlateCarrier2_rgr","B_AssaultPack_rgr_LAT","H_HelmetB_sand","G_Tactical_Clear"],
	["<PRIMARY WEAPON >>  ","arifle_MX_ACO_pointer_F","30Rnd_65x39_caseless_mag",["","acc_pointer_IR","optic_Aco",""]],
	["<LAUNCHER WEAPON >>  ","launch_NLAW_F","NLAW_F",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","NVGoggles"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",3],["HANDGUN MAG",2],["SmokeShell",1],["SmokeShellGreen",1],["Chemlight_green",1]]],
	["<BACKPACK ITEMS >> ",[["SECONDARY MAG",2]]]
];

kit_nato_sl =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam_vest","V_PlateCarrierGL_rgr","","H_HelmetB_desert","G_Combat"],
	["<PRIMARY WEAPON >>  ","arifle_MX_Hamr_pointer_F","30Rnd_65x39_caseless_mag",["","acc_pointer_IR","optic_Hamr",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles","Binocular"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",1],["30Rnd_65x39_caseless_mag_Tracer",2],["HANDGUN MAG",2],["HandGrenade",2],["B_IR_Grenade",2],["SmokeShell",1],["SmokeShellGreen",1],["SmokeShellBlue",1],["SmokeShellOrange",1],["Chemlight_green",1]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_nato_tl =
	[
	["<EQUIPEMENT >>  ","U_B_CombatUniform_mcam_vest","V_PlateCarrierGL_rgr","","H_HelmetSpecB","G_Tactical_Black"],
	["<PRIMARY WEAPON >>  ","arifle_MX_GL_Hamr_pointer_F","30Rnd_65x39_caseless_mag",["","acc_pointer_IR","optic_Hamr",""]],
	["<LAUNCHER WEAPON >>  ","","",["","","",""]],
	["<HANDGUN WEAPON >>  ","hgun_P07_F","16Rnd_9x21_Mag",["","","",""]],
	["<ASSIGNED ITEMS >>  ","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","NVGoggles","Binocular"],
	["<UNIFORM ITEMS >> ",[["FirstAidKit",1],["PRIMARY MAG",2],["Chemlight_green",1]]],
	["<VEST ITEMS >> ",[["PRIMARY MAG",1],["30Rnd_65x39_caseless_mag_Tracer",2],["HANDGUN MAG",2],["MiniGrenade",2],["1Rnd_HE_Grenade_shell",5],["SmokeShell",1],["SmokeShellGreen",1],["SmokeShellBlue",1],["SmokeShellOrange",1],["Chemlight_green",1],["1Rnd_Smoke_Grenade_shell",2],["1Rnd_SmokeBlue_Grenade_shell",1],["1Rnd_SmokeGreen_Grenade_shell",1],["1Rnd_SmokeOrange_Grenade_shell",1]]],
	["<BACKPACK ITEMS >> ",[]]
];

kit_defaultBox = [
	[["arifle_MXC_F",8],["arifle_MX_F",8],["hgun_P07_F",5],["launch_NLAW_F",1]],
	[["30Rnd_65x39_caseless_mag",50],["100Rnd_65x39_caseless_mag",20],["16Rnd_9x21_Mag",20],["1Rnd_HE_Grenade_shell",25],["1Rnd_SmokeBlue_Grenade_shell",2],["1Rnd_SmokeGreen_Grenade_shell",2],["1Rnd_SmokeOrange_Grenade_shell",2],["1Rnd_SmokePurple_Grenade_shell",2],["1Rnd_SmokeRed_Grenade_shell",2],["1Rnd_SmokeYellow_Grenade_shell",2],["1Rnd_Smoke_Grenade_shell",2],["DemoCharge_Remote_Mag",5],["HandGrenade",20],["MiniGrenade",24],["NLAW_F",8],["SatchelCharge_Remote_Mag",5],["SmokeShell",20],["SmokeShellBlue",2],["SmokeShellGreen",2],["SmokeShellOrange",2],["SmokeShellPurple",2],["SmokeShellRed",2],["SmokeShellYellow",2]],
	[["FirstAidKit",10],["ItemGPS",5],["Medikit",5],["ToolKit",5]],
	[]
];
