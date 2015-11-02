dzn_zas_zrpIsOnRP = {
	// @Unit call dzn_zas_zrpIsDeployedRP	
	!(_this getVariable ["dzn_zas_isDeployed", false])
};

dzn_zas_zrpMoveToRP = {
	// @unit spawn dzn_zas_zrpMoveToRP;
	
	0 cutText ["", "WHITE OUT", 0.1];
	
	_this allowDamage false;
	if (vehicle _this != _this) then {
		moveOut _this;
	};
	_this switchMove "";
	_this setVelocity [0,0,0];
	_this setPosASL (getPosASL zrp);
	_this allowDamage true;
	_this call dzn_zas_zrpUndeploy;
	
	hint "Do not leave Rally Point!\nZeus will move you to your squad";
	
	sleep 2;
	0 cutText ["", "WHITE IN", 1];
};

dzn_zas_zrpIsLeavingRP = {
	// @Boolean = @Unit call dzn_zas_zrpIsLeavingRP
	private["_dist"];
	_dist = _this distance zrp;
	if ( (_dist > dzn_zas_zrpRadius) && (_dist < dzn_zas_zrpReleaseRadius) ) then { true } else { false }
};

dzn_zas_zrpIsDeployedByZeus = {
	// @Unit call dzn_zas_zrpIsDeployedByZeus	
	if (_this distance zrp > dzn_zas_zrpReleaseRadius) then { true } else { false }
};

dzn_zas_zrpDeploy = {
	// @Unit call dzn_zas_zrpDeploy
	_this setVariable ["dzn_zas_isDeployed", true, true];
};

dzn_zas_zrpUndeploy = {
	// @unit call dzn_zas_zrpUndeploy
	_this setVariable ["dzn_zas_isDeployed", false, true];
};


// Diary Controls
#define	NOT_ZEUS	!(_x in allCurators)
dzn_zas_zrpCreateRPMarker = {
	private["_mrk"];
	_mrk = createMarkerLocal ["mrk_zrp", getPosASL zrp];
	_mrk setMarkerShapeLocal "ICON";
	_mrk setMarkerTypeLocal "mil_flag";
	_mrk setMarkerColorLocal "ColorOrange";
	_mrk setMarkerTextLocal "zRallyPoint";
};

dzn_zas_zrpDeployAllPlayers = {
	{
		if NOT_ZEUS then {_x call dzn_zas_zrpDeploy;};
	} forEach (call BIS_fnc_listPlayers);
};
dzn_zas_zrpUndeployAllPlayers = {
	{
		if NOT_ZEUS then {_x call dzn_zas_zrpUndeploy;};
	} forEach (call BIS_fnc_listPlayers);
};

dzn_zas_zrpDeploySinglePlayer = {
	"Deploy" call dzn_zas_zrpConstrucPlayerMenu;
	showCommandingMenu "#USER:dzn_zas_zrpPlayersMenu";
};
dzn_zas_zrpUndeploySinglePlayer = {
	"Undeploy" call dzn_zas_zrpConstrucPlayerMenu;
	showCommandingMenu "#USER:dzn_zas_zrpPlayersMenu";
};

dzn_zas_zrpConstrucPlayerMenu = {
	// @Menu = @Option call dzn_zas_zrpConstrucPlayerMenu
	private["_menu","_label","_fnc"];
	
	_label = "";
	_fnc = "";
	if (toLower(_this) == "deploy") then { 
		_label = "Deploy player";
		_fnc = "dzn_zas_zrpDeploy";
	} else { 
		_label = "Undeploy player";
		_fnc = "dzn_zas_zrpUndeploy";
	};
	dzn_zas_zrpPlayersMenu = [ [_label, false] ];
	{
		if NOT_ZEUS then {
			dzn_zas_zrpPlayersMenu pushBack [
				name _x
				, []
				, ""
				, -5
				,[["expression", format ["%1 call %2;", _x, dzn_zas_zrpUndeploy] ]]
				,"1"
				,"1"
			];
		};
	} forEach (call BIS_fnc_listPlayers);
	
	dzn_zas_zrpPlayersMenu
};

dzn_zas_zrpAddDiaryActions = {
	if !(player in allCurators) exitWith {};
	call dzn_zas_zrpCreateRPMarker;
	player createDiaryRecord [
		"Diary", 
		[
			"Zeus RallyPoint", 
			"<marker name='mrk_zrp'>RallyPoint</marker>
			<br />-------------------------------------
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpDeployAllPlayers;'>Deploy All Players</execute></font>
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpDeploySinglePlayer;'>Deploy Single Player</execute></font>
			<br />-------------------------------------
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpUndeployAllPlayers;'>Move All Players To RallyPoint</execute></font>
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpUndeploySinglePlayer;'>Move Single Player To RallyPoint</execute></font>
			"
		]
	];
};
