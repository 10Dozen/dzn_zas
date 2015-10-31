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
	if (!isNil { _this getVariable "dzn_zas_atRP" } && { !(_this getVariable "dzn_zas_atRP") }) then {
		_this setVariable ["dzn_zas_atRP", true, true];
	};
	hint "Do not leave Rally Point!\nZeus will move you to your squad";
	
	sleep 2;
	0 cutText ["", "WHITE IN", 1];
};

dzn_zas_zrpIsLeavingRP = {
	// @Boolean = @Unit call dzn_zas_zrpIsLeavingRP
	private["_dist"];
	_dist = _this distance zrp;
	if ( (_dist > dzn_zas_zrpRadius) && (_dist < dzn_zas_zrpReleaseRadiu) ) then { true } else { false }
};

dzn_zas_zrpDeploy = {
	// @Unit call dzn_zas_zrpDeploy
	_this setVariable ["dzn_zas_atRP", false, true];
};

