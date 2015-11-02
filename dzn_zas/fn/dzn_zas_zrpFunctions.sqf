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
dzn_zas_zrpCreateRPMarker = {
	_mrk = createMarkerLocal ["mrk_zrp", getPosASL zrp];
	_mrk setMarkerShapeLocal 'ICON';
	_mrk setMarkerTypeLocal 'mil_flag';
	_mrk setMarkerColorLocal "ColorOrange";
	_mrk setMarkerText%1 "zRallyPoint";
};

dzn_zas_zrpDeployAllPlayers = {
	{
		if !(_x in allCurators) then {_x call dzn_zas_zrpDeploy;};
	} forEach BIS_fnc_listPlayers;
};
dzn_zas_zrpUndeployAllPlayers = {
	{
		if !(_x in allCurators) then {_x call dzn_zas_zrpUndeploy;};
	} forEach BIS_fnc_listPlayers;
};


dzn_zas_zrpDeploySinglePlayer = {};
dzn_zas_zrpUndeploySinglePlayer = {};


dzn_zas_zrpConstrucPlayerMenu = {
	// @Menu = @Option call dzn_zas_zrpConstrucPlayerMenu
	
	
	/*
	private["_cashToShare","_menu"];
	
	_cashToShare = _this;
	_menu = [ [format ["Share $%1", _cashToShare], false] ];
	{
		if (side player == side _x /*&& !(player == _x)*/) then {
			_playersList pushBack _x;
			_menu pushBack [
				name _x
				, []
				, ""
				, -5
				,[["expression", format ["[%1, %2] call dzn_fnc_market_shareCashMP;", _x, _cashToShare] ]]
				,"1"
				,"1"
			];
		};
	} forEach (call BIS_fnc_listPlayers);
	
	_menu
	*/
};

dzn_zas_zrpAddDiaryActions = {
	if !(player in allCurators) exitWith {};
	call dzn_zas_zrpCreateRPMarker;
	player createDiaryRecord [
		"Diary", 
		[
			"Zeus RallyPoint", 
			"<marker name='mrk_zrp'>RallyPoint</marker>
			<br />-----------
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpDeployAllPlayers;'>Deploy All Players</execute></font>
			<br />Deploy Single Player
			<br />
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpUndeployAllPlayers;'>Move All Players To RallyPoint</execute></font>
			<br />Move Single Player To RallyPoint
			"
		]
	];
};
