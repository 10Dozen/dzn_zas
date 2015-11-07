dzn_zas_znAddViewDistance = {
	params [["_vdStep", 1000], ["_vodStep", 500]];

	if (viewDistance + _vdStep > 15000) then {
		setViewDistance 15000;
		setObjectViewDistance  [7500, getObjectViewDistance select 1];
	} else {
		setViewDistance (viewDistance + _vdStep);
		setObjectViewDistance [(getObjectViewDistance select 0) + _vodStep, getObjectViewDistance select 1];
	};

	hintSilent parseText format [
		"<t color='#86CC5E'>View distance:</t> %1 (%2) <t color='#86CC5E'>m</t>"
		, viewDistance
		, getObjectViewDistance select 0
	];
};

dzn_zas_znReduceViewDistance = {
	params [["_vdStep", 1000], ["_vodStep", 500]];
	if (viewDistance - _vdStep < 1000) then {
		setViewDistance 1000;
		setObjectViewDistance [900, getObjectViewDistance select 1];
	} else {
		setViewDistance (viewDistance - _vdStep);
		setObjectViewDistance [(getObjectViewDistance select 0) - _vodStep, getObjectViewDistance select 1];
	};

	hintSilent parseText format [
		"<t color='#86CC5E'>View distance:</t> %1 (%2) <t color='#86CC5E'>m</t>"
		, viewDistance
		, getObjectViewDistance select 0
	];
};

dzn_zas_znAddDiaryActions = {

	player createDiaryRecord [
		"dzn_zas_page", 
		[
			"Zeus Client Utils", 
			"<br />-------------------------------------
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_znAddViewDistance;'>Increase View Distance</execute></font>
			<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_znReduceViewDistance;'>Decrease View Distance</execute></font>
			"
		]
	];
};
