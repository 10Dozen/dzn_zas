// *********************************
// 	DZN Zeus Asset
// *********************************
// Run local on each client/server
//
//	Zeus Rally Point
// Stick players to Rally point object.
//
//	Zeus Kits
// Add Kits of gear as action of object
//
// *********************************

// ******************************
// Properties
// ******************************
dzn_zas_zeuses			=	[zeusUnit];	//list of playable curator units
dzn_zas_allowZeusRallyPoint 	=	true;
dzn_zas_allowZeusKits		=	true;
dzn_zas_allowZeusNotes		=	true;

#define ISALLOWED(X)	if (X) then {
#define ISALLOWEDCLOSE	};

ISALLOWED(dzn_zas_allowZeusRallyPoint)

waitUntil { !isNil "zrp" };
dzn_zas_zrp 			= zrp;	// object of rally point
dzn_zas_zrpRadius			= 20;		//m, max distance from RP where player able to move
dzn_zas_zrpReleaseRadius	= 100;	//m, distance where RP rules are not longer used

ISALLOWEDCLOSE

ISALLOWED(dzn_zas_allowZeusKits)

waitUntil { !isNil "dzn_gear_initialized" && { dzn_gear_initialized } };
dzn_zas_kitBoxes			= [zkit];	// objects for kits
dzn_zas_kitPerSquadRestricted	= true;	// e.g. true - only 1 MG per squad, false - anyone can pick MG kit
dzn_zas_kitDefaultOnRespawn	= "kit_defaultPlayer"; 	// Kit name to assign, "" - do not assign

ISALLOWEDCLOSE

ISALLOWED(dzn_zas_allowZeusNotes)

dzn_zas_znClientUtil		= true;
dzn_zas_znCAS			= true;
dzn_zas_znArtilleryControl	= true;

ISALLOWEDCLOSE

// ********************************
// Initializing
// ********************************
if (player in dzn_zas_zeuses || dzn_zas_allowZeusNotes) then {
	player createDiarySubject ["dzn_zas_page","ZAS"];
};

if (dzn_zas_allowZeusRallyPoint) then {
	call compile preProcessFileLineNumbers "dzn_zas\fn\dzn_zas_zrpFunctions.sqf";
	[] execFSM "dzn_zas\FSMs\dzn_zas_zrpLoop.fsm";
	
	call dzn_zas_zrpAddDiaryActions;
};

if (dzn_zas_allowZeusKits) then {
	call compile preProcessFileLineNumbers "dzn_zas\fn\dzn_zas_kitFunctions.sqf";
	call compile preProcessFileLineNumbers "dzn_zas\dzn_zas_kitList.sqf";
	call dzn_zas_kitInitList;
	call dzn_zas_kitSetActions;
	[] execFSM "dzn_zas\FSMs\dzn_zas_kitLoop.fsm";
	call dzn_zas_kitAddDiaryActions;
};

if (dzn_zas_allowZeusNotes) then {
	call compile preProcessFileLineNumbers "dzn_zas\fn\dzn_zas_znFunctions.sqf";
	call dzn_zas_znAddDiaryActions;
};

dzn_zas_initialized = true;
