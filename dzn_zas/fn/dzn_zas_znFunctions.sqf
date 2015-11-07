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

	if (dzn_zas_znClientUtil) then {
		player createDiaryRecord [
			"dzn_zas_page", 
			[
				"Client Utils", 
				"<br />-------------------------------------
				<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_znAddViewDistance;'>Increase View Distance</execute></font>
				<br /><font color='#A0DB65'><execute expression='[] call dzn_zas_znReduceViewDistance;'>Decrease View Distance</execute></font>
				"
			]
		];
	};

	if (dzn_zas_znCAS) then {
		player createDiaryRecord [
			"dzn_zas_page"
			, [
				"Requesting CAS (9-Liner)", 
				"<br /><font color='#12C4FF' size='14'>COLT-__(1 or 2) , this is HITMAN-1-1, TYPE ___(1,2,3) in effect, call when ready for 9-line</font>
				<br /><font color='#5E5E5E'>wait for pilot answer, then provide 9-liner</font>
				<br />
				<br />CONTROL > <font color='#9E9E9E'>1 (direct attack on position), 2 (find and attack in given area), 3 (find and attack any)</font>
				<br />1. IP/BP > <font color='#9E9E9E'>IP Eagle (North), IP Hawk (East), IP Crow (South), IP Raven (West)</font>
				<br />2. HEADING > <font color='#9E9E9E'>0...359 degrees (from IP to target)</font>
				<br />3. DISTANCE > <font color='#9E9E9E'>in meters (from IP to target)</font>
				<br />4. TARGET ELEVATION > <font color='#9E9E9E'>in meters</font>
				<br />5. TARGET DESCRIPTION > <font color='#9E9E9E'>(e.g. 'one APC', 'infantry squad')</font>
				<br />6. TARGET LOCATION > <font color='#9E9E9E'>XXXX YYYY (e.g. 0349 0120)</font>
				<br />7. TYPE MARKER > <font color='#9E9E9E'>None, Smoke, Laser</font>
				<br />8. FRIENDLIES > <font color='#9E9E9E'>Bearing and distance from target</font>
				<br />9. EGRESS > <font color='#9E9E9E'>Direction of leaving AO</font>
				<br />
				<br /><font color='#5E5E5E'>Do not transmit line numbers and headers (e.g. say '400 meters' instead of '3. Distance 400 meteres').
				</font>"
			]
		];
	};
	
	if (dzn_zas_znArtilleryControl) then {
		player createDiaryRecord [
			"dzn_zas_page"
			, [
				"Requesting Artillery Fire", 
				"<br /><font color='#12C4FF' size='14'>STEEL RAIN, this is HITMAN-1-1, Fire Mission. Over.</font>
				<br /><font color='#5E5E5E'>wait for artillery answer, then provide fire mission request</font>
				<br />
				<br /><font color='#12C4FF' size='14'>STEEL RAIN, this is HITMAN-1-1, target in (1) Grid X Y, (2) one tank, (3) 6 HE rounds. Over.</font>
				<br />1. TARGET POSITION > <font color='#9E9E9E'>XXXX YYYY (e.g. 0349 0120)</font>
				<br />2. TARGET DESCRIPTION > <font color='#9E9E9E'>(e.g. 'one APC', 'infantry squad')</font>
				<br />3. NUMBER AND TYPE OF ROUNDS > <font color='#9E9E9E'>(e.g. 10 HE, 2 SMOKE, 3 WP)</font>
				<br />
				<br /><font color='#5E5E5E'>wait for 1st round splash and make corrections</font>
				<br /><font color='#12C4FF' size='14'>STEEL RAIN, this is HITMAN-1-1, Correction, (4) 200 (5) FAR. Over.</font>
				<br />4. CORRECTION DISTANCE > <font color='#9E9E9E'>in meters (from splash)</font>
				<br />5. CORRECTION DIRECTION > <font color='#9E9E9E'>left, right, far (behind target), short (in front of target)</font>
				<br />
				<br /><font color='#5E5E5E'>proceed with correction until accurate shot, then call fire for effect</font>
				<br /><font color='#12C4FF' size='14'>STEEL RAIN, this is HITMAN-1-1, FIRE FOR EFFECT. Over.</font>
				"
			]
		];	
	};
};
