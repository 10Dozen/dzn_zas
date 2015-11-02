#define	DEBUG		false

dzn_zas_kitInitList = {
	// call dzn_zas_kitInitList
	private["_grp"];
	
	_grp = group player;	
	if (
		isNil { _grp getVariable "dzn_zas_availableKits" } 
		&& player == leader _grp
	) then {	
		dzn_zas_kitAvailableGroupsList = [];
		dzn_zas_kitUsedGroupsList = [];		
		
		{
			if (_x select 2 > 0) then {
				for "_i" from 1 to (_x select 2) do {
					dzn_zas_kitAvailableGroupsList pushBack (_x select 1);
				};		
			};			
		} forEach dzn_zas_kitList;
		
		_grp setVariable ["dzn_zas_availableKits", dzn_zas_kitAvailableGroupsList,true];
		_grp setVariable ["dzn_zas_groupKits", dzn_zas_kitUsedGroupsList,true];	
	};	
};

dzn_zas_kitSetActions = {
	private["_box","_kitDName","_kitName","_kitIcon"];
	
	{
		_box = _x;
		[_box,"kit_defaultBox",true] spawn dzn_fnc_gear_assignKit;
		{
			_kitDName = _x select 0;
			_kitName = _x select 1;
			_kitIcon = if (isNil {_x select 3}) then { dzn_zas_defaultKitIcon } else { _x select 3 };			
			
			_box addAction [
				format ["<t color='#AACC00'><img image='%2'/>Kit: %1</t>", _kitDName, _kitIcon]
				, {
					private["_kitName","_kitDName"];
					_kitName = (_this select 3) select 1;
					_kitDName = (_this select 3) select 0;
					if (DEBUG) then { player sideChat format["Action: %1 - %2", _kitDName, _kitName]; };
					_kitName call dzn_zas_kitAssign;
					hint  parseText format ["<t color='#AACC00'>%1</t> kit is assigned.", _kitDName];
				}
				, [_kitDName, _kitName], 6, true, true, ""
				, format ["'%1' call dzn_zas_kitIsAvailable", _kitName]		
			];
		} forEach dzn_zas_kitList;
	} forEach dzn_zas_kitBoxes;
};

dzn_zas_kitIsAvailable = {
	// @Kitname call dzn_zas_kitIsAvailable
	
	if (_this in ( call dzn_zas_kitGetAvailableKits )) then {
		true
	} else {
		false
	}
};

dzn_zas_kitGetGroupKits = {
	// all dzn_zas_kitGetGroupKits
	(group player) getVariable "dzn_zas_groupKits"
};

dzn_zas_kitGetAvailableKits = {
	// call dzn_zas_kitGetAvailableKits
	(group player) getVariable "dzn_zas_availableKits"
};

dzn_zas_kitUpdateKits = {
	// @Kit call dzn_zas_kitUpdateAvailableKits
	params["_kit", "_type"];
	private["_curKit","_grpId","_avId"];
	_curKit = player getVariable ["dzn_zas_kitAssigned", dzn_zas_kitDefaultOnRespawn];
	
	_grpId = (call dzn_zas_kitGetGroupKits) find _curKit;
	_avId = (call dzn_zas_kitGetAvailableKits) find _kit;		
	
	// Add kit to Group Kits	
	(call dzn_zas_kitGetGroupKits) pushBack _kit;
	(group player) setVariable [	
		"dzn_zas_groupKits"
		,(call dzn_zas_kitGetGroupKits)
		,true
	];

	// Remove kit from Available Kit
	(call dzn_zas_kitGetAvailableKits) deleteAt _avId;	
	(group player) setVariable [
		"dzn_zas_availableKits"
		,(call dzn_zas_kitGetAvailableKits)
		,true
	];
	
	// If player not own default, then 
	// need to return kit to available and remove from group kits
	if (_curKit != dzn_zas_kitDefaultOnRespawn) then {	
		// Remove from group kits
		(call dzn_zas_kitGetGroupKits) deleteAt _grpId;
		(group player) setVariable [
			"dzn_zas_groupKits"
			,(call dzn_zas_kitGetGroupKits)
			,true
		];
	
		// Add to available kits
		(call dzn_zas_kitGetAvailableKits) pushBack _curKit;
		(group player) setVariable [
			"dzn_zas_availableKits"
			,(call dzn_zas_kitGetAvailableKits)
			,true
		];
	};
};

dzn_zas_kitAssignDefault = {
	// call dzn_zas_kitAssignDefault
	private["_kit"];
	
	_kit = if (isNil {player getVariable "dzn_zas_kitAssigned"}) then {
		dzn_zas_kitDefaultOnRespawn
	} else {
		player getVariable "dzn_zas_kitAssigned"
	};
	
	[player, _kit] spawn dzn_fnc_gear_assignKit;
	player setVariable ["dzn_zas_kitAssigned", _kit];
};

dzn_zas_kitAssign = {
	// @kit spawn dzn_zas_assignKit	
	if (_this != dzn_zas_kitDefaultOnRespawn) then {
		_this call dzn_zas_kitUpdateKits;	
	};
	player setVariable ["dzn_zas_kitAssigned", _this];
	[player, _this] spawn dzn_fnc_gear_assignKit;
};


// Diary functions
#define	NOT_ZEUS(ID)	!(ID in allCurators)

dzn_zas_kitAddDiaryActions = {


};

/*
dzn_zas_zrpAddDiaryActions = {
	if NOT_ZEUS(player) exitWith {};
	call dzn_zas_zrpCreateRPMarker;
	player createDiaryRecord [
		"Diary", 
		[
			"Zeus Kits", 
			"<font color='#A0DB65'><execute expression='[] call dzn_zas_zrpDeployAllPlayers;'>Show kits availability</execute></font>
			<br />-------------------------------------
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpDeployAllPlayers;'>Show kits availability</execute></font>
			
			
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpDeployAllPlayers;'>Remove All Kits</execute></font>
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpDeploySinglePlayer;'>Set Default Kit for All Players</execute></font>
			<br />-------------------------------------
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpUndeployAllPlayers;'>Move All Players To RallyPoint</execute></font>
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_zrpUndeploySinglePlayer;'>Move Single Player To RallyPoint</execute></font>
			"
		]
	];
};
*/
