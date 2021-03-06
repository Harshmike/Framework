/*
    File: fn_keyManagement.sqf
    Author: Bryan "Tonic" Boardwine

    This file is for Nanou's HeadlessClient.

    Description:
    Keeps track of an array locally on the server of a players keys.
*/
private["_uid","_side","_input","_mode","_arr"];
params [
  ["_uid","",[""]],
  ["_side",sideUnknown,[sideUnknown]]
];
_mode = param [3,0,[0]];

if (_uid isEqualTo "" || _side isEqualTo sideUnknown) exitWith {}; //BAAAAAAAAADDDDDDDD

switch (_mode) do {
    case 0: {
        _input = param [2,[],[[]]];
        _arr = [];
        {
            if (!isNull _x && {!(_x isKindOf "House")}) then {
                _arr pushBack _x;
            };
        } forEach _input;

        _arr = _arr - [objNull];
        missionNamespace setVariable [format["%1_KEYS_%2",_uid,_side],_arr];
    };

    case 1: {
        _input = param [2,objNull,[objNull]];
        if (isNull _input || _input isKindOf "House") exitWith {};
        _arr = missionNamespace getVariable [format["%1_KEYS_%2",_uid,_side],[]];
        _arr pushBack _input;
        _arr = _arr - [objNull];
        missionNamespace setVariable [format["%1_KEYS_%2",_uid,_side],_arr];
    };

    case 2: {
        _arr = missionNamespace getVariable [format["%1_KEYS_%2",_uid,_side],[]];
        _arr = _arr - [objNull];
        missionNamespace setVariable [format["%1_KEYS_%2",_uid,_side],_arr];
    };
};
