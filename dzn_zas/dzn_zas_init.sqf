// *********************************
// 	DZN Zeus Asset
// *********************************
// Run local on each client/server
// *********************************

// ******************************
// Properties
// ******************************
dzn_zas_allowZeusRallyPoint 	=	true;
dzn_zas_allowZeusKits		=	false;

#define ISALLOWED(X)	if (X) then {
#define ISALLOWEDCLOSE	};

ISALLOWED(dzn_zas_allowZeusRallyPoint)

waitUntil { !isNil "zrp" };
dzn_zas_zrp 			= zrp; 	// object of rally point
dzn_zas_zrpRadius		= 20;	//m, max distance from RP where player able to move
dzn_zas_zrpReleaseRadius	= 100;	//m, distance where RP rules are not longer used

ISALLOWEDCLOSE

ISALLOWED(dzn_zas_allowZeusKits)
waitUntil { !isNil "dzn_gear_initialized" && { dzn_gear_initialized } };

dzn_zas_kitPerSquadRestricted	= true	// e.g. true - only 1 MG per squad, false - anyone can pick MG kit
dzn_zas_kitDefaultOnRespawn	= ""; 	// Kit name to assign, "" - do not assign

ISALLOWEDCLOSE

// ********************************
// Initializing
// ********************************
if (dzn_zas_allowZeusRallyPoint) then {
	call compile preProcessFileLineNumbers "dzn_zas\dzn_zas_zrpFunctions.sqf";
	// [] spawn FUNCTION
};

if (dzn_zas_allowZeusKits) then {
	call compile preProcessFileLineNumbers "dzn_zas\dzn_zas_kitFunctions.sqf";
	call compile preProcessFileLineNumbers "dzn_zas\dzn_zas_kitList.sqf";
	// [] spawn FUNCTION
};

dzn_zas_initialized = true;

