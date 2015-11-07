#define	DEBUG		false
#define	NOT_ZEUS(ID)	!(ID in dzn_zas_zeuses)

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
	
	// Add kit to Group Kits and Remove kit from Available Kit (if it there)
	if (_avId > -1) then {
		(call dzn_zas_kitGetGroupKits) pushBack _kit;
		(group player) setVariable [	
			"dzn_zas_groupKits"
			,(call dzn_zas_kitGetGroupKits)
			,true
		];		
		
		(call dzn_zas_kitGetAvailableKits) deleteAt _avId;	
		(group player) setVariable [
			"dzn_zas_availableKits"
			,(call dzn_zas_kitGetAvailableKits)
			,true
		];
	};
	
	// If player not own default, then 
	// need to return kit to available and remove from group kits
	if (_grpId > -1) then {
		(call dzn_zas_kitGetGroupKits) deleteAt _grpId;
		(group player) setVariable [
			"dzn_zas_groupKits"
			,(call dzn_zas_kitGetGroupKits)
			,true
		];

		(call dzn_zas_kitGetAvailableKits) pushBack _curKit;
		(group player) setVariable [
			"dzn_zas_availableKits"
			,(call dzn_zas_kitGetAvailableKits)
			,true
		];
	};	
};

// Need to rename to something like - kitAssignOnRespawn
dzn_zas_kitAssignOnRespawn = {
	// call dzn_zas_kitAssignOnRespawn
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
	// if (_this != dzn_zas_kitDefaultOnRespawn) then {
		_this call dzn_zas_kitUpdateKits;	
	// };
	player setVariable ["dzn_zas_kitAssigned", _this];
	[player, _this] spawn dzn_fnc_gear_assignKit;
};


// Diary functions
dzn_zas_kitShowNotif = {
	// @Type or [@Type, @Option] call dzn_zas_kitShowNotif
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
		case "removeall": { "All kits were <t color='#AACC00'>removed</t>" };
		case "defaultall": { "All players were <t color='#AACC00'>assigned to default kit</t>" };
		case "specificall": { "All player were <t color='#AACC00'>assigned to specific kit</t>" };
		case "specificsingle": { "Player was <t color='#AACC00'>assigned to specific kit</t>" };
		/*case "dirtyremoveall": { "All players were <t color='#AACC00'>undeployed</t>" };
		case "deploysingle": { format["Player <t color='#AACC00'>%1</t> was <t color='#AACC00'>deployed</t>",_name] };
		case "undeploysingle": { format["Player <t color='#AACC00'>%1</t> was <t color='#AACC00'>undeployed</t>",_name] };*/
	};
	
	hint parseText format [
		"<t align='center' color='#AACC00' size='1.4'>Zeus RallyPoint</t><br /><br />%1!"
		, _label
	];	
};

dzn_zas_kitShowKits = {
	private["_msg"];
	_msg = ["<t align='center' color='#AACC00' size='1.4'>Zeus Kits</t><br />"];
	{
		_msg pushBack format [
			"<br /><t align='left'>%2x</t><t color='#AACC00' align='right'>%1</t>"
			, _x select 0
			, _x select 2
		];
	} forEach dzn_zas_kitList;
	hint parseText str(composeText _msg);
};

// Remove All Kits
dzn_zas_kitRemoveAllKits = {
	/*
		Clear available pool for each group		
		Turn var TRUE -- Trigger Remove all kits on Clients
		Show notif	
	*/	
	{
		_x set [2, 0];
	} forEach dzn_zas_kitList;
	
	// For Players
	{
		if (leader (group _x) == _x) then {
			(group _x) setVariable ["dzn_zas_availableKits", nil, true];
		};
		_x setVariable ["dzn_zas_kitForceRemoveAllKits", true, true];
	} forEach ((call BIS_fnc_listPlayers) + dzn_zas_zeuses);	
	
	"removeall" call dzn_zas_kitShowNotif;
};

dzn_zas_kitRemoveAllKitsClient = {
	/*
		Clear all actions on boxes
		Turn var OFF
	*/
	{
		removeAllActions _x;
	} forEach dzn_zas_kitBoxes;
	
	call dzn_zas_kitInitList;
	call dzn_zas_kitSetActions;
	player setVariable ["dzn_zas_kitForceRemoveAllKits", false, true];
};

// Assign kit to all players
dzn_zas_kitAssignKitToAlllPlayers = {
	// @Kitname call dzn_zas_kitAssignKitToAlllPlayers
	private["_kit","_notif"];
	
	_kit = "";
	_notif = "";
	if (_this == "default") then { 
		_kit = dzn_zas_kitDefaultOnRespawn;
		_notif = "defaultall";
	} else { 
		_kit = _this;
		_notif = ["specificall", "Kitname"];
	};
	
	{
		if (leader (group _x) == _x) then {
			(group _x) setVariable ["dzn_zas_availableKits", nil, true];
		};
		_x setVariable ["dzn_zas_kitZeusAssigned", [_kit, false] , true];		
	} forEach (call BIS_fnc_listPlayers);
	
	_notif call dzn_zas_kitShowNotif;
};

dzn_zas_kitAssignKitClient = {
	// call dzn_zas_kitAssignKitClient
	private["_kit"];
	call dzn_zas_kitInitList;
	_kit = (player getVariable "dzn_zas_kitZeusAssigned") select 0;
	_isDirty = (player getVariable "dzn_zas_kitZeusAssigned") select 1;
	
	if (_isDirty) then {
		_kit spawn dzn_zas_kitAssign;
	} else {
		[player, _kit] spawn dzn_fnc_gear_assignKit;
		player setVariable ["dzn_zas_kitAssigned", _kit];
	};
	player setVariable ["dzn_zas_kitZeusAssigned", nil, true];
};

dzn_zas_kitAssignKitToSingle = {
	_this	call dzn_zas_kitConstructPlayerMenu;
	showCommandingMenu "#USER:dzn_zas_kitPlayersMenu";
};

dzn_zas_kitConstructPlayerMenu = {
	params["_kit","_label"];
	
	dzn_zas_kitPlayersMenu = [ [_label, false] ];
	{
		if NOT_ZEUS(_x) then {
			dzn_zas_kitPlayersMenu pushBack [
				name _x
				, []
				, ""
				, -5
				,[
					[
						"expression"
						, format [
							"['%1','%2'] call dzn_zas_kitProcessUnit; ['specificsingle', '%1'] call dzn_zas_kitShowNotif"
							, name _x
							, _kit
						] 
					]
				]
				,"1"
				,"1"
			];
		};
	} forEach (call BIS_fnc_listPlayers);
};

dzn_zas_kitProcessUnit = {
	// [@PlayerName, @Kitname] call dzn_zas_kitProcessUnit
	params["_name", "_kit"];
	private["_unit"];
	
	_unit = objNull;
	{
		if (name _x == _name) exitWith { _unit = _x };
	} forEach (call BIS_fnc_listPlayers);
	if (isNull _unit) exitWith {};
	
	_unit setVariable ["dzn_zas_kitZeusAssigned", [_kit, true], true];	
};

dzn_zas_kitAddDiaryActions = {
	if NOT_ZEUS(player) exitWith {};
	private["_record","_records"];
	
	_records = [
		"<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_kitShowKits;'>Show All Kits</execute></font>"
		,"<br />-------------------------------------"
		,"<br /><font color='#A0DB65'><execute expression='""default"" call dzn_zas_kitAssignKitToAlllPlayers;'>Assign Default Kit to All Player</execute></font>"
		,"<br /><font color='#A0DB65'><execute expression='[dzn_zas_kitDefaultOnRespawn, ""Default Kit""] call dzn_zas_kitAssignKitToSingle;'>Assign Default Kit to Specific Player</execute></font>"
		,"<br />-------------------------------------"
		,"<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_kitRemoveAllKits;'>Remove All Kits</execute></font>"
		,"<br />-------------------------------------"
	];
	
	{
		// [@Display, @Kit, @Count]
		_records pushBack format[
			"<br /><img image='%5' width='10' height='10'/>%3 kit [%1<execute expression='[""%4"", ""%3""] call dzn_zas_kitAssignKitToSingle'>Assign to</execute>%2] [%1<execute expression='""%4"" call dzn_zas_kitAssignKitToAlllPlayers;'>Assign To All</execute>%2]"
			, "<font color='#A0DB65'>"
			, "</font>"
			, _x select 0 /* 3: Display name */
			, _x select 1 /* 4: Kit name */
			, if (!isNil {_x select 3}) then { _x select 3 } else { dzn_zas_defaultKitIcon }
		];
	} forEach dzn_zas_kitList;
	
	_record = "";
	{
		_record = format["%1%2",_record,_x];
	} forEach _records;
	
	player createDiaryRecord ["dzn_zas_page", ["Zeus Kits", _record]];
};
