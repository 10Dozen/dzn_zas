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