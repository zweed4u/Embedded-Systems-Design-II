function RTW_Sid2UrlHash() {
	this.urlHashMap = new Array();
	/* <S1>/Gain */
	this.urlHashMap["pwm:8"] = "timesTwo.vhd:42";
	this.getUrlHash = function(sid) { return this.urlHashMap[sid];}
}
RTW_Sid2UrlHash.instance = new RTW_Sid2UrlHash();
function RTW_rtwnameSIDMap() {
	this.rtwnameHashMap = new Array();
	this.sidHashMap = new Array();
	this.rtwnameHashMap["<Root>"] = {sid: "pwm"};
	this.sidHashMap["pwm"] = {rtwname: "<Root>"};
	this.rtwnameHashMap["<S1>/In"] = {sid: "pwm:9"};
	this.sidHashMap["pwm:9"] = {rtwname: "<S1>/In"};
	this.rtwnameHashMap["<S1>/Gain"] = {sid: "pwm:8"};
	this.sidHashMap["pwm:8"] = {rtwname: "<S1>/Gain"};
	this.rtwnameHashMap["<S1>/out"] = {sid: "pwm:7"};
	this.sidHashMap["pwm:7"] = {rtwname: "<S1>/out"};
	this.getSID = function(rtwname) { return this.rtwnameHashMap[rtwname];}
	this.getRtwname = function(sid) { return this.sidHashMap[sid];}
}
RTW_rtwnameSIDMap.instance = new RTW_rtwnameSIDMap();
