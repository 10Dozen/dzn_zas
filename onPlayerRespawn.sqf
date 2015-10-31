if (player distance (getMarkerPos "respawn_west") < 5) then {
	// Dead
	if (!isNil "dzn_zas_zrpMoveToRP") then {	player spawn dzn_zas_zrpMoveToRP; };
	if (!isNil "dzn_zas_kitAssignDefault") then { call dzn_zas_kitAssignDefault; }; 
} else {
	// Revived
};