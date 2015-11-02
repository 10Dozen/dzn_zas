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
#define	NOT_ZEUS(ID)	!(ID in dzn_zas_zeuses)
dzn_zas_zrpCreateRPMarker = {
	private["_mrk"];
	_mrk = createMarkerLocal ["mrk_zrp", getPosASL zrp];
	_mrk setMarkerShapeLocal "ICON";
	_mrk setMarkerTypeLocal "mil_flag";
	_mrk setMarkerColorLocal "ColorOrange";
	_mrk setMarkerTextLocal "zRallyPoint";
};

dzn_zas_zrpShowNotif = {
	// @Option call dzn_zas_zrpShowNotif
	private["_label","_type","_name"];
	_type = "";
	_name = "";
	if (typename _this == "ARRAY") then {
		_type = _this select 0;
		_name = _this select 1;
	} else {
		_type = _this;
	};
	
	_label = switch toLower(_type) do {
		case "deployall": { "All players were <t color='#AACC00'>deployed</t>" };
		case "undeployall": { "All players were <t color='#AACC00'>undeployed</t>" };
		case "deploysingle": { format["Player <t color='#AACC00'>%1</t> was <t color='#AACC00'>deployed</t>",_name] };
		case "undeploysingle": { format["Player <t color='#AACC00'>%1</t> was <t color='#AACC00'>undeployed</t>",_name] };
	};
	
	hint parseText format [
		"<t align='center' color='#AACC00' size='1.4'>Zeus RallyPoint</t><br /><br />%1!"
		, _label
	];		
};

dzn_zas_zrpDeployAllPlayers = {
	{
		if NOT_ZEUS(_x) then {_x call dzn_zas_zrpDeploy;};
	} forEach (call BIS_fnc_listPlayers);
	"deployall" call dzn_zas_zrpShowNotif;
};
dzn_zas_zrpUndeployAllPlayers = {
	{
		if NOT_ZEUS(_x) then {_x call dzn_zas_zrpUndeploy;};
	} forEach (call BIS_fnc_listPlayers);
	"undeployall" call dzn_zas_zrpShowNotif;
};

dzn_zas_zrpDeploySinglePlayer = {
	"Deploy" call dzn_zas_zrpConstrucPlayerMenu;
	showCommandingMenu "#USER:dzn_zas_zrpPlayersMenu";
};

dzn_zas_zrpUndeploySinglePlayer = {
	"Undeploy" call dzn_zas_zrpConstrucPlayerMenu;
	showCommandingMenu "#USER:dzn_zas_zrpPlayersMenu";
};

dzn_zas_zrpProcessUnit = {
	// [@PlayerName, @Deploy/Undeploy] call dzn_zas_zrpProcessUnit
	params["_name", "_opt"];
	private["_unit"];
	
	_unit = objNull;
	{
		if (name _x == _name) exitWith { _unit = _x };
	} forEach (call BIS_fnc_listPlayers);
	if (isNull _unit) exitWith {};
	
	if (toLower(_opt) == "deploy") then {
		_unit call dzn_zas_zrpDeploy;
	} else {
		_unit call dzn_zas_zrpUndeploy;
	};	
};

dzn_zas_zrpConstrucPlayerMenu = {
	// @Menu = @Option call dzn_zas_zrpConstrucPlayerMenu
	private["_menu","_label","_fnc","_notif"];
	
	_label = "";
	_fnc = "";
	_notif = "";
	if (toLower(_this) == "deploy") then { 
		_label = "Deploy player";
		_fnc = "deploy";
		_notif = "deploysingle";
	} else { 
		_label = "Undeploy player";
		_fnc = "undeploy";
		_notif = "undeploysingle";
	};
	dzn_zas_zrpPlayersMenu = [ [_label, false] ];
	{
		if NOT_ZEUS(_x) then {
			dzn_zas_zrpPlayersMenu pushBack [
				name _x
				, []
				, ""
				, -5
				,[
					[
						"expression"
						, format ["['%1','%2'] call dzn_zas_zrpProcessUnit; ['%3','%1'] call dzn_zas_zrpShowNotif", name _x, _fnc, _notif] 
					]
				]
				,"1"
				,"1"
			];
		};
	} forEach (call BIS_fnc_listPlayers);
	
	dzn_zas_zrpPlayersMenu
};

dzn_zas_zrpAddDiaryActions = {
	if NOT_ZEUS(player) exitWith {};
	call dzn_zas_zrpCreateRPMarker;
	player createDiaryRecord [
		"dzn_zas_page", 
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
