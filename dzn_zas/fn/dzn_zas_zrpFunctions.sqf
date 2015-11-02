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
	_this setVariable ["dzn_zas_isDeployed", false, true];
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


// Diary Controls
// allCurators
dzn_zas_zrpDeployOption = {
	// [@Action, @Option]  call dzn_zas_zrpDeployOption
	// 0:	"Deploy", "Undeploy"
	// 1:	"All", "Single"
	params["_action","_option"];
	
	
	if (toLower(_option) == "all") then {
		// Deploy All
		if (toLower(_action) == "deploy") then {
			{
				if !(_x in allCurators) then {_x spawn dzn_zas_zrpMoveToRP;};
			} forEach BIS_fnc_listPlayers;
		} else {
			{
				if !(_x in allCurators) then {_x call dzn_zas_zrpDeploy;};
			} forEach BIS_fnc_listPlayers;
		};
	} else {
		// Deploy single unit
	
	};
};

dzn_zas_zrpDeployAllPlayers = {
	["Deploy", "All"] call dzn_zas_zrpDeployOption;
};
dzn_zas_zrpUndeployAllPlayers = {
	["Undeploy", "All"] call dzn_zas_zrpDeployOption;
};

dzn_zas_zrpDeploySinglePlayer = {};
dzn_zas_zrpUndeploySinglePlayer = {};

dzn_zas_zrpAddDiaryActions = {
	if !(player in allCurators) exitWith {};
	player createDiaryRecord [
		"Diary", 
		[
			"Zeus RallyPoint", 
			"
			
			RallyPoint
			<br/>-----------
			<br/>Deploy All Players
			<br/>Deploy Single Player
			<br/>
			<br/>Move All Players To RallyPoint
			<br/>Move Single Player To RallyPoint
			
			
			
			<font color='#A0DB65'><execute expression='[] call dzn_fnc_addViewDistance;'>INCREASE VIEW DISTANCE</execute>
	<br /><br /><execute expression='[] call dzn_fnc_reduceViewDistance;'>DECREASE VIEW DISTANCE</execute></font>"
		]
	];
};
